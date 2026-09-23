local data = nil
local item = nil

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_data,_isGet)
    data = _data
    if data then
        CSAPI.SetGOActive(getObj,_isGet)
        if item == nil then
            ResUtil:CreateUIGOAsync("Grid/GridItem", parent, function(go)
                local lua = ComUtil.GetLuaTable(go)
                lua.Refresh(data)
                lua.SetClickCB(cb)
                item = lua
            end)
        else
            item.Refresh(data)
        end
    end
end
