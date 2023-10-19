function [nNode,nElement,Coordinate,Ielement,n] = import_mesh_mphtxt(fileName,bnd)
% [nNode,nElement,Coordinate,Ielement,n] = import_mesh(fileName,bnd)
%
% 输入:
%	fileName = .mphtxt的文件名前缀;
%	bnd = 各边界的名字.
% 输出:
%	nNode = 节点总数;
%	nElement = 单元总数;
%	Coordinate = 节点坐标;
%	Ielement = 单元信息;
%	n = 各边界的节点编号[struct].

% n=struct; % n.边界=边界节点编号
%% 网格信息
fileNameMPHTXT = [fileName '.mphtxt'];
mesh_info = importMphtxt(fileNameMPHTXT);

[nNode, nElement, Coordinate, Ielement, nCentroid,n] =read_mesh_info(mesh_info,bnd);

% 将左右边界节点排序
minY = min(Coordinate(:,2));
refPoint = [0;minY-1]; % 参考点
n.left = order_bnd(refPoint,Coordinate, n.left);
n.right = order_bnd(refPoint,Coordinate, n.right);

% 节点编号重排（左边界-中间-右边界）
[Coordinate, Ielement, n.left, n.mid, n.right] = change_node_order(Coordinate, Ielement, n.left, n.right, nCentroid);
end
%% 子函数
function mesh = importMphtxt(filename, dataLines)
%% 输入处理
% 如果不指定 dataLines，请定义默认范围
if nargin < 2
	dataLines = [1, Inf];
end
%% 设置导入选项并导入数据
opts = delimitedTextImportOptions("NumVariables", 3);
% 指定范围和分隔符
opts.DataLines = dataLines;
opts.Delimiter = "#";
% 指定列名称和类型
opts.VariableNames = ["VarName1", "CreatedByCOMSOLMultiphysics", "VarName3"];
opts.VariableTypes = ["string", "string", "string"];
% 指定文件级属性
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% 指定变量属性
opts = setvaropts(opts, ["VarName1", "CreatedByCOMSOLMultiphysics", "VarName3"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["VarName1", "CreatedByCOMSOLMultiphysics", "VarName3"], "EmptyFieldRule", "auto");
% 导入数据
mesh = readmatrix(filename, opts);
mesh(ismissing(mesh)) ="";
end