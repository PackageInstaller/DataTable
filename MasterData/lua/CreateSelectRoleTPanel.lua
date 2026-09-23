local curIDs = {}

function Awake()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Update_Everyday, OnClickMask)
end

function OnDestroy()
    eventMgr:ClearListener()
end

-- {index,当前选择的卡牌数据,可选卡牌表数据,poolID,cb}
function OnOpen()
    for k, v in ipairs(data[2]) do
        if (v.data) then
            curIDs[v:GetCfgID()] = 1
        end
    end
    --
    local cfgs1, cfgs2 = {}, {} -- 未获得，已获得
    for k, v in ipairs(data[3]) do
        if (RoleMgr:CheckCfgIdExist(v.id)) then
            table.insert(cfgs2, v)
        else
            table.insert(cfgs1, v)
        end
    end
    --
    CSAPI.SetGOActive(vlg1, #cfgs1 > 0)
    if (#cfgs1 > 0) then
        items1 = items1 or {}
        ItemUtil.AddItems("RoleLittleCard/CreateProItem2", items, cfgs1, grid1, ItemClickCB, 1, {curIDs, data[4]})
    end
    CSAPI.SetGOActive(vlg2, #cfgs2 > 0)
    if (#cfgs2 > 0) then
        items2 = items2 or {}
        ItemUtil.AddItems("RoleLittleCard/CreateProItem2", items, cfgs2, grid2, ItemClickCB, 1, {curIDs, data[4]})
    end
end

function ItemClickCB(cfgID)
    if (curIDs[cfgID] == nil) then
        data[5](data[1], cfgID)
        view:Close()
    end
end

function OnClickMask()
    view:Close()
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    view:Close()
end
