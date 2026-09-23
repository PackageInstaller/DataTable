function Refresh(_ids)
    ids = _ids

    -- title
    cfg = Cfgs.CfgFurniture:GetByID(ids[1])
    local all = Cfgs.CfgFurnitureEnum:GetAll()
    for k, v in pairs(all) do
        if (v.id == (cfg.sType + 1)) then
            CSAPI.SetText(txtTitle, v.sName)
            break
        end
    end
    -- items
    items = items or {}
    ItemUtil.AddItems("Dorm2/DormShopRItem", items, ids, grids, nil, 1, nil, AddCB)
end

function AddCB()
    local index = 0
    for k, v in ipairs(items) do
        if (v.gameObject.activeSelf) then
            UIUtil:SetObjFade(v.gameObject, 0, 1, nil, 200, 60 * index, 0)
            index = index + 1
        end
    end
end
