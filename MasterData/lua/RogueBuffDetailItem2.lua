

function Refresh(id)
    local cfg = Cfgs.CfgRogueBuff:GetByID(id)
    -- desc 
    CSAPI.SetText(txtDesc, cfg.desc)
end