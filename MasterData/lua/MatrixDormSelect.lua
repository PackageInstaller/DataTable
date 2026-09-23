-- data 好友id
function OnOpen()
    local curRoomData = DormMgr:GetCurRoomData()
    local cfgID, index = curRoomData:GetCfgIDIndex()
    -- 
    arr = {}
    local isSelect = false
    local cfgs = Cfgs.CfgDorm:GetAll()
    for k, v in ipairs(cfgs) do
        for p, q in ipairs(v.infos) do
            isSelect = false
            if (cfgID == v.id and index == p) then
                isSelect = true
            end
            table.insert(arr, {v.id, q, isSelect,data})
        end
    end
    -- 
    items = items or {}
    ItemUtil.AddItems("Matrix/MatrixDormSelectItem", items, arr, bg, ItemClickCB, 1, nil, function()
        ItemAnims()
    end)
end

function ItemAnims()
    if (isFirst) then
        return
    end
    isFirst = 1
    for i, v in ipairs(items) do
        local delay = (i - 1) * 20
        local item = items[#items - (i - 1)]
        UIUtil:SetObjFade(item.gameObject, 0, 1, nil, 300, delay)
    end
    --UIUtil:SetRedPoint(parent, isRed, 110.8, 31.5, 0)
end

function ItemClickCB(index)
    local _data = arr[index]
    local roomID = GCalHelp:GetDormId(_data[1], 1)
    -- 好友房间不一定存在
    if(data~=nil) then 
        local roomData = DormMgr:GetRoomData(roomID,data)
        if(not roomData) then 
            LanguageMgr:ShowTips(21037)
            return 
        end 
    end 
    -- 
    CSAPI.OpenView("DormRoom", data, roomID)
    OnClickMask()
end

function OnClickMask()
    view:Close()
end
