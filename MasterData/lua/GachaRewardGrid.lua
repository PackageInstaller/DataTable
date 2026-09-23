local goods=nil;
function Refresh(itemPoolGoodsInfo)
    if itemPoolGoodsInfo then
        goods=itemPoolGoodsInfo:GetGoodInfo();
        if goods then
            goods:GetIconLoader():Load(icon, goods:GetIcon());
        end
        CSAPI.SetGOActive(overObj,itemPoolGoodsInfo:GetCurrRewardNum()==0)
    end
end

function OnClickGrid()
    if goods then
        UIUtil:OpenGoodsInfo(goods, 3);
    end
end