function OnOpen()
    sort = data[1]
    isDetail = data[2]
    cb = data[3]

    -- pos 
    SetBgPos()
    -- items 
    SetItems()

    MoveIn()
end

function SetBgPos()
    local posY = 510
    if (isDetail) then
        posY = 654
    end
    CSAPI.SetAnchor(bg, 653, posY, 0)
end

function SetItems()
    items = items or {}
    local cfgs = Cfgs.CfgFurniturePosEnum:GetAll()
    ItemUtil.AddItems("Dorm2/DormLayoutSortItem", items, cfgs, sortGrid, ItemClickCB, 1, sort)
end

function ItemClickCB(_sort)
    if (isClose) then
        return
    end
    sort = _sort
    SetItems()
    if (cb) then
        cb(sort)
    end
end

function OnClickMask()
    MoveOut()
end

function MoveIn()
    local y = isDetail and 261 or -261
    UIUtil:SetPObjMove(point, 0, 0, y, 0, 0, 0, nil, 300, 1)
end

function MoveOut()
    if (not isClose) then
        isClose = 1
        local y = isDetail and 261 or -261
        UIUtil:SetPObjMove(point, 0, 0, 0, y, 0, 0, function()
            view:Close()
        end, 300, 1)
    end
end
