local packQualitys2 = {"img_16_04", "img_16_04", "img_16_03", "img_16_02", "img_16_01", "img_16_05"}

-- 如 [10040,30,2]
function Refresh(_reward)
    reward = _reward
    local itemData = BagMgr:GetFakeData(reward.id, reward.num)
    -- bg 
    ResUtil.Commodity:Load(border, packQualitys2[itemData:GetQuality()] or "img_16_01")
    -- icon 
    itemData:GetIconLoader():Load(icon, itemData:GetIcon())
    -- 
    CSAPI.SetText(txtNum, tostring(reward.num))
end

function OnClick()
    local itemData = BagMgr:GetFakeData(reward.id, reward.num)
    GridRewardGridFunc({
        data = itemData
    })
end