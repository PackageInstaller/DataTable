local item = nil

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_data, _elseData)
    data = _data
    scale = _elseData and _elseData.scale or 1
    isFinish = _elseData and _elseData.isFinish
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
    CSAPI.SetScale(limitObj, 1 / scale, 1 / scale, 1)
    CSAPI.SetScale(limitImg, 1 / scale, 1 / scale, 1)
    CSAPI.SetGOActive(limitObj, false)
    CSAPI.SetGOActive(limitImg, false)
    CSAPI.SetGOAlpha(node, isFinish and 0.5 or 1)
end

function ShowLimit(isNothing)
    CSAPI.SetGOActive(limitObj, true)
    CSAPI.SetGOActive(limitImg, true)
    CSAPI.SetGOActive(goodsFinish, isNothing)
end
