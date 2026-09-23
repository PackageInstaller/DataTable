function Refresh(skillID)
    local cfgDesc = Cfgs.CfgSkillDesc:GetByID(skillID)
    CSAPI.SetText(txtName, cfgDesc.name)
    CSAPI.SetText(txtDesc, cfgDesc.desc)
end
