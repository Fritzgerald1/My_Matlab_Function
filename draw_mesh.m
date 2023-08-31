function draw_mesh(Ielement,Coordinate)
%% 绘制网格，并标注节点编号
% 输入: Ielement = 单元节点编号； Coordinate = 节点坐标信息
%%
num = 1:size(Coordinate,1); % 绘制的单元编号
% num = 1:2; % 绘制的单元编号
t = 0.02; % 动画时间

for i = 1:length(num)
	draw(num(i),t,Ielement,Coordinate)
end

axis padded
axis([0 15e-3 -.5e-3 .5e-3])
hold off

end
%%
function draw(num,t,Ielement,Coordinate)
% global Ielement Coordinate
ele1 = Ielement(num,:);
for i = 1:length(ele1)
	plot(Coordinate(ele1(i),1),Coordinate(ele1(i),2),'.','MarkerSize',10)
	xlim([min(Coordinate(ele1(:),1)),max(Coordinate(ele1(:),1))])
	ylim([min(Coordinate(ele1(:),2)),max(Coordinate(ele1(:),2))])
	
	text(Coordinate(ele1(i),1),Coordinate(ele1(i),2),num2str(ele1(i)))
	hold on
% 	pause(t)
end
end