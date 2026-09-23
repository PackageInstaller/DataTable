function Refresh(_cfg)
    cfg = _cfg

    -- name 
    CSAPI.SetText(txtName1, cfg.name)
    CSAPI.SetText(txtName2, cfg.enName)
    -- icon 
    ResUtil.Coffee:Load(icon, cfg.listIcon)
end
