local ud = 1 -- 0：完全收起来  1：显示一个 2：显示所有

function Refresh(id)
    cfg = Cfgs.CfgCardPoolTeam:GetByID(id)
    CSAPI.SetGOActive(btnDown, #cfg.item > 1)
    RefreshPanel()
end

function RefreshPanel()
    SetItems()
    SetArrow()
end

function SetItems()
    CSAPI.SetGOActive(node1, ud == 0)
    CSAPI.SetGOActive(node2, ud ~= 0)
    CSAPI.SetGOActive(line, ud ~= 0)
    if (ud == 0) then
        return
    end
    items = items or {}
    local arr = {}
    local num = ud == 1 and 1 or #cfg.item
    for k, v in ipairs(cfg.item) do
        if (k <= num) then
            table.insert(arr, v)
        end
    end
    ItemUtil.AddItems("Role/RoleInfoPoolTeamItem", items, arr, node2)
end

function SetArrow()
    local z = ud == 1 and 0 or 180
    CSAPI.SetAngle(arrow, 0, 0, z)
end

function OnClickDown()
    ud = ud == 1 and 2 or 1
    RefreshPanel()
end

function OnClickL()
    ud = 1
    RefreshPanel()
end

function OnClickR()
    ud = 0
    RefreshPanel()
end
