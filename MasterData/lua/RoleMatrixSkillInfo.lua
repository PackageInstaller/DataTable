function Refresh(cRoleData)
    local cfg = cRoleData:GetAbilityCfg()
    local curCfg = cRoleData:GetAbilityCurCfg()
    -- icon 
    ResUtil.CRoleSkill:Load(icon, cfg.icon)
    -- name 
    CSAPI.SetText(txtName, cfg.sName)
    -- lv 
    local lvStr = LanguageMgr:GetByID(1033) or "LV."
    CSAPI.SetText(txtLv, string.format(lvStr.."<color=#ffc146>%s</color>", curCfg.index))
    -- desc 
    CSAPI.SetText(content, curCfg.desc)
end

function OnClickMask()
    CSAPI.RemoveGO(gameObject)
end
