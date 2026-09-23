-- data 不存在时，则是由宿舍进来的
function OnOpen()
    arr = MatrixMgr:GetBuildingDatasArr()
    local index = nil
    for k, v in ipairs(arr) do
        if (data) then
            if (data:GetId() == v:GetId()) then
                index = k
                break
            end
        else
            if (v:GetCfgId() == Dorm_CfgID) then
                index = k
                break
            end
        end
    end
    items = items or {}
    ItemUtil.AddItems("Matrix/MatrixBuildingSelectItem", items, arr, bg, ItemClickCB, 1, index, function()
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
end

function ItemClickCB(index)
    local _data = arr[index]
    if (_data:GetCfgId() ~= Dorm_CfgID) then
        EventMgr.Dispatch(EventType.Matrix_Indoor_Change, {"MatrixBuilding", _data})
    else
        -- local roomID = GCalHelp:GetDormId(1, 1) -- 默认打开101房
        -- DormMgr:SetCurOpenData({roomID, nil})
        -- EventMgr.Dispatch(EventType.Matrix_Indoor_Change, {"Dorm"})
        CSAPI.OpenView("DormRoom")
    end
    OnClickMask()
end

function OnClickMask()
    view:Close()
end
