-- RewardInfo2 的某 index
function Refresh(data, _clickNum)
    clickNum = _clickNum
    cfg = data:GetCfg()

    local cardCfg = Cfgs.CardData:GetByID(cfg.id)
    -- bg
    LoadFrame(cardCfg.quality)
    -- icon
    local modelCfg = Cfgs.character:GetByID(cardCfg.model)
    LoadIcon(modelCfg.icon)
    -- imgStar
    -- local num = 6 - cardCfg.quality
    -- local starName = string.format("img_12_0%s.png", num)
    -- CSAPI.LoadImg(imgStar, "UIs/Grid/" .. starName, true, nil, true)
    ResUtil.RoleCard_BG:Load(imgStar, "img_01_0" .. cardCfg.quality)
end

-- 加载框
function LoadFrame(lvQuality)
    lvQuality = lvQuality or 1
    local frame = "img_01_0" .. lvQuality
    ResUtil.CardBorder:Load(bg, frame)
end

-- 加载图标
function LoadIcon(iconName)
    CSAPI.SetGOActive(icon, iconName ~= nil);
    if (iconName) then
        ResUtil.RoleCard:Load(icon, iconName .. "")
        CSAPI.SetScale(icon, 0.9, 0.9, 1)
    end
end

--clickNum :  10隐藏总退键  11：不隐藏
function OnClick()
    if (clickNum) then
        local cardData = RoleMgr:GetMaxFakeData(cfg.id)
        CSAPI.OpenView("RoleInfo", cardData, clickNum)
    end
end
