local packQualitys2 = {"img_16_04", "img_16_04", "img_16_03", "img_16_02", "img_16_01", "img_16_05"}

-- 如 [10040,30,2]
function Refresh(_reward)
    reward = _reward
    local cfg = Cfgs.ItemInfo:GetByID(reward[1])
    -- bg 
    ResUtil.Commodity:Load(border, packQualitys2[cfg.quality])
    -- icon 
    local goods=BagMgr:GetFakeData(reward[1])
    if goods~=nil then
         goods:GetIconLoader():Load(icon, goods:GetIcon())
    end
    -- ResUtil.IconGoods:Load(icon, cfg.icon)
    -- 
    CSAPI.SetText(txtNum, reward[2] .. "")
end

function OnClick()
    local itemData = BagMgr:GetFakeData(reward[1], reward[2])
    GridRewardGridFunc({
        data = itemData
    })
end
