function SetIndex(_index)
    index = _index
end
function Refresh(data,poolID)
    if (data[3] == 0) then
        return
    end

    CSAPI.SetAnchor(gameObject, data[1], data[2])
    cfgID = data[3]
    cardData = RoleMgr:GetMaxFakeData(cfgID)
    -- 
    CSAPI.SetText(txtName, cardData:GetName())

    local isFirstS = CreateMgr:CheckISSelectCard(poolID, cfgID)
    CSAPI.SetGOActive(objGet, isFirstS)
    if (isFirstS) then
        local goodsCfg = Cfgs.ItemInfo:GetByID(10053)
        ResUtil.IconGoods:Load(imgGoods, goodsCfg.icon)
    end
    -- 
    -- local _cfg = Cfgs.CfgCardPoolTeam:GetByID(cfgID)
    -- CSAPI.SetGOActive(objTips, _cfg ~= nil)
end

function OnClick()
    CSAPI.OpenView("RoleInfo", cardData)
end
