function Refresh(id)
    cfg = Cfgs.CfgRogueBuff:GetByID(id)
    -- bg 
    ResUtil.RogueBuff:Load(iconBg, cfg.quality)
    -- icon 
    ResUtil.RogueBuff:Load(icon, cfg.icon)
    -- name 
    CSAPI.SetText(txtName, cfg.name)
    -- desc 
    CSAPI.SetText(txtDesc, cfg.desc)
end

function SetSpecialName()
    -- name 
    CSAPI.SetText(txtName, cfg.name .. LanguageMgr:GetByID(50020))
end
