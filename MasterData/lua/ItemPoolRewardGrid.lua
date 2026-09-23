--道具池奖励格子
local gridItem=nil;
function Awake()
    local go = ResUtil:CreateUIGO("Grid/GridItem", gridNode.transform)
	gridItem = ComUtil.GetLuaTable(go)
end

function Refresh(itemPoolGoodsInfo,isCurrNum)
    if itemPoolGoodsInfo~=nil then
        if gridItem~=nil then
            gridItem.Refresh(itemPoolGoodsInfo:GetGoodInfo());
            gridItem.SetClickCB(GridClickFunc.OpenInfoSmiple);
        end
        if isCurrNum then
            CSAPI.SetText(txtNum,"X"..tostring(itemPoolGoodsInfo:GetCurrRewardNum()));
        else
            CSAPI.SetText(txtNum,"X"..tostring(itemPoolGoodsInfo:GetRewardNum()));
        end
    else
        Clean();
    end
end

function Clean()
    if gridItem~=nil then
        gridItem.Clean();
    end
    CSAPI.SetText(txtNum,"0");
end