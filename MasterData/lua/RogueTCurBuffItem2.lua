function Refresh(id)
    cfg = Cfgs.CfgRogueTBuff:GetByID(id)
    -- bg 
    ResUtil.RogueBuff:Load(iconBg, cfg.quality)
    -- icon 
    ResUtil.RogueBuff:Load(icon, cfg.icon)
    -- name 
    CSAPI.SetText(txtName, cfg.name)
    -- desc 
    CSAPI.SetText(txtDesc, cfg.desc)
end