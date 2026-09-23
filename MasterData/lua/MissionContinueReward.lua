local item = nil

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_data)
    data = _data
    if data then
        if item == nil then
            ResUtil:CreateUIGOAsync("Grid/GridItem", gridParent, function(go)
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
