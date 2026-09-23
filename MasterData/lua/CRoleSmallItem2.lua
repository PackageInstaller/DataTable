function Refresh(lv, id)
    -- lv
    --SAPI.SetText(txtLv2, lv .. "")
    -- icon 
    local modelCfg = Cfgs.character:GetByID(id)
    if (modelCfg and modelCfg.icon) then
        ResUtil.RoleCard:Load(icon, modelCfg.icon)
    end
end
