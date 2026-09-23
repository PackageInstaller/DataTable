function Refresh(cfgID)
    cfgID = RoleTool.GetCorrectID(cfgID)
    local cardCfg = Cfgs.CardData:GetByID(cfgID)
    local cfgModel = Cfgs.character:GetByID(cardCfg.model)
    ResUtil.RoleCard:Load(icon, cfgModel.icon)
end
