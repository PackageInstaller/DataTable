local item = nil
function Refresh(_data,_elseData)
    local goodsData = _data
    if goodsData then
        if item then
            item.Refresh(goodsData)
        else
            ResUtil:CreateUIGOAsync("Grid/GridItem",itemParent,function (go)
                local lua = ComUtil.GetLuaTable(go)
                lua.SetClickCB(GridClickFunc.OpenInfoSmiple)
                lua.Refresh(goodsData)
                item = lua
            end)
        end
    end
    CSAPI.SetGOActive(getImg,_elseData and _elseData.isGet)
end