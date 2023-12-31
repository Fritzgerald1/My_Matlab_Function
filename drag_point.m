function drag_point(x,y)
%% 对图形用鼠标取点并拖动修改
% 输入: x = x轴坐标信息【向量】；y = y轴坐标信息【元胞】
%% 
    hl = line(x,y);
    for i = numel(x):-1:1
        hp(i) = patch('xdata',x(i),'ydata',y(i),...
            'linestyle','none','facecolor','none',...
            'marker','o','markerEdgecolor','k',...
            'buttonDownFcn',@drag,'userdata',i);
    end
    ax = gca;
    xl = get(ax,'xlim');
    yl = get(ax,'ylim');
    idx = [];
    of = [];
    function drag(src,~)
        idx = get(src,'userdata');
        of = get(gcbf,{'WindowButtonMotionFcn','WindowButtonUpFcn'});
        set(gcbf,'WindowButtonMotionFcn',@move,'WindowButtonUpFcn',@drop);
    end
    function move(~,~)
        cp = get(ax,'currentPoint');
        xn = min(max(cp(1),xl(1)),xl(2));
        yn = min(max(cp(3),yl(1)),yl(2));
        set(hp(idx),'xdata',xn,'ydata',yn)
        hl.XData(idx) = xn;
        hl.YData(idx) = yn;
    end
    function drop(src,~)
        set(src,'WindowButtonMotionFcn',of{1},'WindowButtonUpFcn',of{2});
    end
end