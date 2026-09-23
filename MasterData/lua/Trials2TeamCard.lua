local data = nil
local card = nil

function SetIndex(idx)
    index = idx
end

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_data)
    data = _data
    card = data.isEmpty and {} or data:GetCard()
    SetAssist()
    SetItem()
end

function SetAssist()
    if not data.isEmpty and index == 6 then
        local islimit = FormationUtil.CheckAssitCardIsLimit(data)
        CSAPI.SetGOActive(assistImg,not islimit)
        CSAPI.SetGOActive(assistImg2,islimit)
    else
        CSAPI.SetGOActive(assistImg,false)
        CSAPI.SetGOActive(assistImg2,false)
    end
end

function SetItem()
    if item == nil then
        ResUtil:CreateUIGOAsync("RoleLittleCard/RoleSmallCard",itemParent,function (go)
            item= ComUtil.GetLuaTable(go)
            item.SetClickCB(OnItemClickCB)
            item.Refresh(card)
        end)
    else
        item.Refresh(card)
    end
end

function OnItemClickCB()
    OnClick()
end

function OnClick()
    if cb then
        cb(this)
    end
end