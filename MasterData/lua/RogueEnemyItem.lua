function SetIndex(_index)

end

function SetClickCB(_cb)
    cb = _cb
end

-- {怪物id，预警等级}
function Refresh(data)
    local monsterCfg =Cfgs.MonsterData:GetByID(data.id)
    local cfg = Cfgs.character:GetByID(monsterCfg.model)
    -- icon
    local iconName = cfg.icon
    CSAPI.SetGOActive(icon, iconName ~= nil)
    if (iconName) then
        ResUtil.RoleCard:Load(icon, iconName)
    end
    -- lv 
    CSAPI.SetText(txtLv, data.level .. "")
    -- objGN
    CSAPI.SetGOActive(objGN, data.isBoss)
end

function OnClick()
    cb()
end
