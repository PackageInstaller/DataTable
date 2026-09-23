local item = nil
function Refresh(_data,_elseData)
    local reward = _data
    if reward then
        local goodsData = GridUtil.RandRewardConvertToGridObjectData(reward)
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
    CSAPI.SetGOActive(getObj,_elseData and _elseData.isGet)
end