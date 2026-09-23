local grid=nil;
local goods=nil;

function Refresh(_goods)
    goods=_goods;
    if goods then
        if grid then
            grid.Refresh(goods);
            grid.SetClickCB(OnClickGrid);
        else
            ResUtil:CreateUIGOAsync("Grid/GridItem",node,function(go)
                grid=ComUtil.GetLuaTable(go);
                grid.Refresh(goods);
                grid.SetClickCB(OnClickGrid);
            end)
        end
    end
end

function OnClickGrid()
    if goods then
        UIUtil:OpenGoodsInfo(goods, 3);
    end
end
