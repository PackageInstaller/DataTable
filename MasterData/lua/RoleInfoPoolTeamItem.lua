function Refresh(childCfg)
    local typeCfg = Cfgs.CfgCardPoolTeamEnum:GetByID(childCfg.nType)
    CSAPI.SetText(txtTitle, typeCfg.sName)
    items = items or {}
    ItemUtil.AddItems("Role/RoleInfoPoolTeamItem2", items, childCfg.team, glg,nil,1,childCfg)
end
