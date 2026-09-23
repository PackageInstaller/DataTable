local ground = nil
local items1 = {}
local items2 = {}
local lastGrid = nil

function Awake()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.RogueMap_Battle_GridEvent_Trigger, OnGridEventTrigger)
    eventMgr:AddListener(EventType.RogueMap_Battle_Mist_Refresh,RefreshGrids)
    eventMgr:AddListener(EventType.RogueMap_Boss_Grid_State_Update,OnBossGridUpdate)
    eventMgr:AddListener(EventType.RogueMap_Boss_UI_State_Update, OnSpecBossUpdate)
end

function OnGridEventTrigger(info)
    if not info then
        return
    end

    if info.type == eRogueMapPosType.Buff then
        OnBuffShow(info.id)   
    elseif RogueMapBattleMgr:IsBattleGrid(info.id) then
        OnBattleTrigger(info.id)
    else
        OnGameObjectRemove(info.id)
    end
end

function OnBuffShow(gridId)
    if not gridId or not items1[gridId] then
        return
    end
    items1[gridId].ShowEffect()
    items1[gridId].Hide()
end

function OnGameObjectRemove(gridId)
    if not gridId or not items1[gridId] then
        return
    end
    items1[gridId].Hide()
end

function OnBattleTrigger(gridId)
    if not gridId or not items1[gridId] then
        return
    end
    items1[gridId].ShowBattle()
end

function OnBossGridUpdate(info)
    if not info or not info.gridId or not items1[info.gridId] then --当前格
        return
    end
    items1[info.gridId].UpdateBossPos(info.gridId,info.isMoving)
    if not info.lastGridId or not items1[info.lastGridId] then --上一个格子
        return
    end
    items1[info.lastGridId].UpdateBossPos()
end

function OnSpecBossUpdate()
    local dis = RogueMapBattleMgr:GetMistDis()
    if dis then
        for k, v in pairs(dis) do
            if v.type == eRogueMapPosType.SpecialBoss and v.state == eDungeonCharState.Active and v.specTime then
                if v.specTime <= TimeUtil:GetTime() and items1 and items1[v.id] then
                    items1[v.id].Hide()
                    break
                end
            end
        end
    end
end

function OnDestroy()
    eventMgr:ClearListener()
end

function Init(_ground)
    ground = _ground
    RefreshGrids()
end

function RefreshGrids()
    local subMaps = ground and ground.GetSubMaps()
    local dis = RogueMapBattleMgr:GetMistDis()
    if subMaps and dis then
        local x, y, z = 0, 0, 0
        local playerGridID = RogueMapBattleMgr:GetMyCharacterGridId() or 0
        for _, luaSubMap in pairs(subMaps) do
            local _grids = luaSubMap.GetAllGrids()
            if _grids then
                for _, grid in pairs(_grids) do
                    if grid.GetValidState() then
                        x, y, z = CSAPI.GetLocalPos(grid.gameObject)
                        if items1[grid:GetID()] then
                            items1[grid:GetID()].Refresh(dis[grid:GetID()],{isPlayer = playerGridID == grid:GetID()})
                            items1[grid:GetID()].SetBossPos(playerGridID == grid:GetID())
                            if dis[grid:GetID()] then
                                UpdateGridInfo(dis[grid:GetID()], x, z)
                            end
                        else
                            local go = CSAPI.CreateGO("RogueMap/RogueMapBattleGrid", x, y, z, itemParent)
                            go.name = tostring(grid:GetID())
                            local lua = ComUtil.GetLuaTable(go)
                            lua.Init(dis[grid:GetID()],{isPlayer = playerGridID == grid:GetID()})
                            lua.SetBossPos(playerGridID == grid:GetID())
                            items1[grid:GetID()] = lua
                            if dis[grid:GetID()] then
                                UpdateGridInfo(dis[grid:GetID()], x, z)
                            end
                        end
                    end
                end
            end
        end
    end
end

function UpdateGridInfo(v, x, y)
    if v.type ~= eRogueMapPosType.Boss and v.type ~= eRogueMapPosType.SpecialBoss then
        return
    end
    if v.state == eDungeonCharState.Death then
        if items1 and items1[v.id] then
            items1[v.id].Hide()
        end
        return
    end
    if not v.isUnLock then
        return
    end
    if items2[v.id] then
        CSAPI.SetLocalPos(items2[v.id].gameObject, x, 0, y)
        items2[v.id].Refresh(v)
    else
        local go = ResUtil:CreateUIGO("RogueMapBattle/RogueMapBattleGridInfo", itemCanvas.transform, x, 0, y)
        CSAPI.SetScale(go, 0.01, 0.01, 1)
        CSAPI.SetAngle(go,90,0,0)
        go.name = tostring(v.id)
        local lua = ComUtil.GetLuaTable(go)
        lua.Refresh(v)
        items2[v.id] = lua
    end
end

function Refresh(gridId)
    if not gridId or not items1[gridId] then
        return
    end
    if lastGrid then
        lastGrid.Show()
    end
    lastGrid = items1[gridId]
    items1[gridId].Show(true)
end

