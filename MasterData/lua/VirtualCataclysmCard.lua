local data = nil
local items = nil

function Refresh(_data)
    data = _data
    if data then
        CSAPI.SetGOActive(empty,data.isEmpty)
        CSAPI.SetGOActive(itemParent,not data.isEmpty)
        if not data.isEmpty then
            SetItems()
        end
    end
end

function SetItems()
    items = items or {}
    ItemUtil.AddItems("RoleLittleCard/RoleLittleCard2",items,{data},itemParent)
end