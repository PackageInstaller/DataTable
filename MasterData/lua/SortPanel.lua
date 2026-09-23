local id, sortData
local clickSortId = nil

function Awake()
    CSAPI.SetGOActive(bg2, false)
    CSAPI.SetGOActive(mask2, false)
end
function OnOpen()
    id = data.GetID()
    sortData = SortMgr:GetData(id)
    local cfg = Cfgs.CfgSortFilter:GetByID(id)

    -- items 
    items = items or {}
    ItemUtil.AddItems("Sort/SortPanelItem1", items, cfg.sort_view, bg1, ItemClickCB, 1, sortData.SortId, function()
        mask2.transform:SetAsLastSibling()
    end)
    -- pos 
    local x, y, z = CSAPI.GetPos(data.btnL)
    CSAPI.SetPos(node , x, y, z)
end

function ItemClickCB(sortId)
    clickSortId = sortId

    local cfg = Cfgs.CfgSortInfo:GetByID(sortId)
    if (cfg.rolePro) then
        SetBg2(cfg.rolePro)
    else
        -- 选中 
        SortMgr:SelectSort(id, sortId)
        Close()
    end
end

function SetBg2(rolePro)
    CSAPI.SetGOActive(mask2, true)
    CSAPI.SetGOActive(bg2, true)

    items2 = items2 or {}
    ItemUtil.AddItems("Sort/SortPanelItem2", items2, rolePro, bg2, ItemClickCB2, 1, sortData.RolePro)
end

function ItemClickCB2(roleProId)
    -- 选中子项
    SortMgr:SelectSort(id, clickSortId, roleProId)
    Close()
end

function OnClickMask()
    if (mask2.activeSelf) then
        CSAPI.SetGOActive(mask2, false)
        CSAPI.SetGOActive(bg2, false)
    else
        view:Close()
    end
end

function Close()
    data.SelectCB()
    view:Close()
end

