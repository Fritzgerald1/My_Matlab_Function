function [x,y]=fig_data(Axes)
%% 抓取坐标区的数据
% 输入: Axes对象
% 输出: x = x轴坐标信息【向量】；y = y轴坐标信息【元胞】
%%
obj = get(Axes,'children');
y = cell(length(obj),1);

x=get(obj(1), 'xdata');
for i = 1:length(obj)
	y{i}=get(obj(i), 'ydata');
end