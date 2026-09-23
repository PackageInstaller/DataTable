function SetIndex(_index)
    index = _index
end

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(teamData, elseData)
    LanguageMgr:SetText(txtIndex, 90005 + index)
    SetTeams(teamData)
    CSAPI.SetGOActive(btns, elseData[1])
    if (elseData[1]) then
        local isSelect = elseData[2] == index
        CSAPI.SetGOActive(btnSelect1, not isSelect)
        CSAPI.SetGOActive(btnSelect2, isSelect)
    end
end

function SetTeams(teamData)
    local itemDatas = {}
    for k = 1, 5 do
        local _data = teamData:GetItemByIndex(k)
        table.insert(itemDatas, _data ~= nil and _data:GetCard() or {})
    end
    teamItems = teamItems or {}
    ItemUtil.AddItems("RoleLittleCard/RoleSmallCard", teamItems, itemDatas, dGrid)
end

function OnClickSelect1()
    cb(index)
end

