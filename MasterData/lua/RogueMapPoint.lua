local list = nil
local pointItems = {}
local lineItems = {}
local ground = nil

function Init(_ground)
    ground = _ground
end

function Refresh(_list)
    SetList(_list)
    ShowPoints()
end

function SetList(_list)
    if _list and #_list > 1 then
        list = {}
        for i = 1, #_list do
            table.insert(list, _list[i])
        end
    else
        list = nil
    end
end

function ShowPoints()
    for i = 1, 20 do
        if not IsNil(pointItems[i]) then
            CSAPI.SetGOActive(pointItems[i], false)
        end
    end
    if list and #list > 1 then
        local grid1 = nil
        local x1, y1, z1 = 0, 0, 0
        local grid2 = nil
        local x2, y2, z2 = 0, 0, 0
        for i = 1, #list do
            if ground and i + 1 <= #list then
                grid1 = ground.GetGrid(list[i])
                grid2 = ground.GetGrid(list[i + 1])
                if grid1 and not IsNil(grid1.gameObject) and grid2 and not IsNil(grid2.gameObject) then
                    x1, y1, z1 = CSAPI.GetLocalPos(grid1.gameObject)
                    x2, y2, z2 = CSAPI.GetLocalPos(grid2.gameObject)
                    if (x1 ~= x2 and z1 ~= z2) then
                        LogError("存在对角相邻格子！！！" .. list[i] .. "|" .. list[i + 1])
                    elseif (x1 == x2 and z1 == z2) then
                        LogError("存在重合位置格子！！！" .. list[i] .. "|" .. list[i + 1])
                    elseif x1 ~= x2 then
                        local go = CreatePoint(i, (x2 + x1) / 2, 0, z1)
                        CSAPI.SetAngle(go,0,x2 - x1 > 0 and 0 or 180,0)
                    elseif z1 ~= z2 then
                        local go = CreatePoint(i, x1, 0, (z2 + z1) / 2)
                        CSAPI.SetAngle(go,0,z2 - z1 > 0 and -90 or 90,0)
                    end
                end
            end
        end
    end
end

function CreatePoint(index, x, y, z)
    local go = pointItems[index]
    if go == nil then
        go = CSAPI.CreateGO("RogueMap/point/point1", x, y, z, pointParent)
        pointItems[index] = go
    else
        CSAPI.SetLocalPos(go, x, y, z)
    end
    CSAPI.SetGOActive(go, true)
    return go
end