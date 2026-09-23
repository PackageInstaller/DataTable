function Refresh(data)
    CSAPI.SetAnchor(gameObject, data[1], data[2])
    cfgID = data[3]
    -- 
    -- local _cfg = Cfgs.CfgCardPoolTeam:GetByID(cfgID)
    -- CSAPI.SetGOActive(objTips, _cfg ~= nil)
end

function OnClick()
    local cardData = RoleMgr:GetMaxFakeData(cfgID)
    CSAPI.OpenView("RoleInfo", cardData)
end
