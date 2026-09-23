function SetIndex(_index)
    index = _index
end

-- RewardInfo的item的单条数据
function Refresh(_reward)
    reward = _reward
    local itemCfg = Cfgs.ItemInfo:GetByID(reward[1])
    -- icon
    ResUtil.IconGoods:Load(icon, itemCfg.icon)
    -- num 
    CSAPI.SetText(txt_count, reward[2] .. "")
end

function OnClick()
    local itemData = BagMgr:GetFakeData(reward[1], reward[2])
    GridRewardGridFunc({
        data = itemData
    })
end
