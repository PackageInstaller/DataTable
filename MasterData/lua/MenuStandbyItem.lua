function Refresh(_id)
    id = _id
    local cfg = Cfgs.CfgStandbyTips:GetByID(id)
    -- icon 
    CSAPI.LoadImg(icon,"UIs/MenuStandby/" .. cfg.icon .. ".png", true, nil, true)
    -- desc
    LanguageMgr:SetText(txtDesc, cfg.language)
end
