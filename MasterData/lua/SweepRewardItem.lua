local item = nil
local rewardInfo = nil

function Awake()
    CSAPI.SetGOActive(img, false)
end

function SetIndex(idx)
    index = idx
end

function Refresh(_Info)
    rewardInfo = _Info
    if rewardInfo then
        SetTag()
        local goodsData = rewardInfo.goodsData;
        local type = goodsData.cfg.type
        local clickCB = type ~= nil and OpenInfoSimple or GridClickFunc.EquipDetails;
        if not item then
            item = ResUtil:CreateRewardByData(goodsData, itemNode.transform);
        else
            item.Refresh(goodsData)
        end
        item.SetCount();
        item.SetClickCB(clickCB);
    end
end

function SetTag()
    CSAPI.SetGOActive(img, rewardInfo.tag ~= nil)
    CSAPI.SetText(txt, rewardInfo.tag and RewardUtil.GetTips(rewardInfo.tag) or "")
    local tag = rewardInfo.tag or ITEM_TAG.None
    CSAPI.LoadImg(img,"UIs/Sweep/img_02_"..(tag == ITEM_TAG.TimeLimit and 2 or 1)..".png",true,nil,true)
end

function OpenInfoSimple(tab)
    if tab.data ~= nil then
        CSAPI.OpenView("GoodsFullInfo",{data = tab.data} , 3);
    end
end
