local grid=nil;
local goods=nil;

function Refresh(itemPoolGoodsInfo)
    if itemPoolGoodsInfo then
        goods=itemPoolGoodsInfo:GetGoodInfo();
        if grid then
            grid.Refresh(goods);
            grid.LoadFrame(itemPoolGoodsInfo:GetQuality())
            grid.SetCount2(tostring(goods:GetCount()))
            grid.SetClickCB(OnClickGrid);
        else
            ResUtil:CreateUIGOAsync("Grid/GridItem",gridNode,function(go)
                grid=ComUtil.GetLuaTable(go);
                grid.Refresh(goods);
                grid.LoadFrame(itemPoolGoodsInfo:GetQuality())
                grid.SetCount2(tostring(goods:GetCount()))
                grid.SetClickCB(OnClickGrid);
            end)
        end
        CSAPI.SetGOActive(mask,itemPoolGoodsInfo:GetCurrRewardNum()==0)
    end
end

function OnClickGrid()
    if goods then
        UIUtil:OpenGoodsInfo(goods, 3);
    end
end