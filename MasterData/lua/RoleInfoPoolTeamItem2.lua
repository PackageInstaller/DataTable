function SetIndex(_index)
    index = _index
end

function Awake()
    txtMove = ComUtil.GetCom(ImageName, "TextMove")
end

function Refresh(cfgID, childCfg)
    cfgID = RoleTool.GetCorrectID(cfgID)
    local cardCfg = Cfgs.CardData:GetByID(cfgID)
    local cfgModel = Cfgs.character:GetByID(cardCfg.model)
    txtMove:SetText(cardCfg.name)
    ResUtil.RoleCard:Load(icon, cfgModel.icon)
    -- zw
    local b = false
    if (childCfg.pWeapon and childCfg.pWeapon[index] > 0) then
        b = true
        local lv = childCfg.pWeapon[index]
        CSAPI.SetGOActive(objWeaponLv, lv > 1)
        if (lv > 1) then
            CSAPI.SetText(txtWeaponLv, lv .. "")
        end
        --
        -- local cfg = Cfgs.CfgCardWeapon:GetByID(cfgID)
        -- local childCfg = cfg.infos[lv + 1]
        -- ResUtil.RoleWeapon:Load(imgWeapon, childCfg.icon)
    end
    CSAPI.SetGOActive(objWeapon, b)
end
