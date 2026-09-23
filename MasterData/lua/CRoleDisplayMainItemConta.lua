-- CRoleDisplayData
function Refresh(_data, isAnim)
    data = _data

    -- items 
    ids = data:GetIDs()
    items = items or {}
    ItemUtil.AddItems("CRoleDisplay/CRoleDisplayMainItem", items, ids, grids, ItemClickCB, 1, data, function()
        if (data:IsTwoRole() and isAnim) then
            UIUtil:SetPObjMove(items[1].clickNode, -100, 0, 0, 0, 0, 0, nil, 400, 120)
            UIUtil:SetPObjMove(items[2].clickNode, 100, 0, 0, 0, 0, 0, nil, 400, 120)
            UIUtil:SetObjFade(items[1].clickNode, 0, 1, nil, 200, 120, 0)
            UIUtil:SetObjFade(items[2].clickNode, 0, 1, nil, 200, 120, 0)
            UIUtil:SetObjFade(btnSelect, 0, 1, nil, 300, 120, 0)
        end
    end)
    -- 
    CSAPI.SetText(txtIndex, data:GetIndex() .. "")
    -- btn
    local isShow = data:CheckIsEntity()
    CSAPI.SetGOActive(btnSelect, isShow)
    if (isShow) then
        isUsing = CRoleDisplayMgr:GetCopyUsing() == data:GetIndex()
        CSAPI.SetGOActive(objSelect1, not isUsing)
        CSAPI.SetGOActive(objSelect2, isUsing)
    end
    local x = data:IsTwoRole() and 115 or 0
    CSAPI.SetAnchor(btnSelect, x, -314, 0)
end

function ItemClickCB(index, num)
    if (num == 2) then
        -- 移除
        data.sNewPanel.ids[index] = 0
        data:InitTop()
        Refresh(data)
        return
    end
    CSAPI.OpenView("CRoleDisplay", data, index)
end

function OnClickSelect()
    if (not isUsing) then
        CRoleDisplayMgr:SetCopyUsing(data:GetIndex())
        EventMgr.Dispatch(EventType.CRoleDisplayMain_Refresh)
    end
end
