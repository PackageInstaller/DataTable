local curItem = nil

function SetIndex(_index)
    index = _index
end

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_data, _oldID)
    data = _data
    toID = _oldID
    SetNode1()
    SetNode2()
end

function SetNode1()
    CSAPI.SetGOActive(node1, index > 1)
    if (index > 1) then
        local isLine2, lineDatas = data:GetLineDatas()
        CSAPI.SetGOActive(lines1, not isLine2)
        CSAPI.SetGOActive(lines2, isLine2)
        if (isLine2) then
            for k, v in ipairs(lineDatas) do
                CSAPI.SetGOActive(this["line" .. k], v == 1)
            end
        end
    end
end

function SetNode2()
    local childDatas = data:GetChildDatas()
    items = items or {}
    ItemUtil.AddItems("Colosseum/ColosseumMItem2", items, childDatas, itemsParent, ItemClickCB, 1, toID, function()
        -- 位置
        if (#childDatas == 1) then
            CSAPI.SetAnchor(items[1].gameObject, 0, 0, 0)
        else
            for k, v in pairs(items) do
                local y = (2 - k) * 229
                CSAPI.SetAnchor(v.gameObject, 0, y, 0)
            end
        end
    end)
end
function ItemClickCB(childItem)
    local dungeonData = DungeonMgr:GetDungeonData(childItem.cfg.id)
    if (data:GetSelectType()==2 and dungeonData and dungeonData:IsPass()) then
        return
    end
    if (cb) then
        cb(childItem)
    end
end
