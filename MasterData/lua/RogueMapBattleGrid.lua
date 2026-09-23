local data = nil
local type = 0
local level = nil
local currGO = nil
local showGO = nil -- 迷雾去除物体
local showPlayerGo = nil -- 迷雾去除物体(亮)
local isPlayer = false
local state = 0

function OnEnable()
    CSAPI.SetGOActive(buffEffect, false)
end

function OnDisable()
    ClearAll()
end

function Init(_data, _elseData)
    SetInfo(_data, _elseData)
    if type > 0 and state ~= 2 then
        currGO = CreateGrid(type, 0, 0, 0, level)
        if type == eRogueMapPosType.Boss or type == eRogueMapPosType.SpecialBoss or type == eRogueMapPosType.Monster then
            if not IsNil(currGO) then
                CSAPI.SetGOActive(currGO.transform:GetChild(0).gameObject,IsUnLock() and state ~= 1) --已解锁已触发
                CSAPI.SetGOActive(currGO.transform:GetChild(1).gameObject,(not IsUnLock() or state == 1) )
                if currGO.transform.childCount > 2 then
                    CSAPI.SetGOActive(currGO.transform:GetChild(2).gameObject,isPlayer)
                end
            end
            if data.specTime and data.specTime < TimeUtil:GetTime() then
                Hide()
            end
        end
    end
    if IsUnLock() then
        ShowNolEffect()
    end
end

function SetInfo(_data,_elseData)
    data = _data
    isPlayer = _elseData and _elseData.isPlayer
    type = (data and data.type) and data.type or 0
    level = data and data.level
    state = (data and data.state) or 1
end

function CreateGrid(type, x, y, z, level)
    local res = "nolLow"
    if type then
        if type == eRogueMapPosType.Boss then
            level = level or 1
            res = "boss_" .. level
        elseif type == eRogueMapPosType.Monster then
            res = "monster"
        elseif type == eRogueMapPosType.Reward then
            -- res = "reward"
            res = "buff"
        elseif type == eRogueMapPosType.SpecialBoss then
            res = "specialBoss"
        elseif type == eRogueMapPosType.Prop then
            res = "item"
        elseif type == eRogueMapPosType.Action then
            res = "action"
        elseif type == eRogueMapPosType.Buff then
            res = "buff"
        elseif type == 99 then
            res = "nol"
        end
    end
    local go = CSAPI.CreateGO("RogueMap/grid/" .. res, x, y, z, itemParent)
    return go
end

function Show(_isPlayer)
    if isPlayer == _isPlayer then
        return
    end
    isPlayer = _isPlayer
    ShowNolEffect()
end

function Hide()
    if not IsNil(currGO) then
        CSAPI.RemoveGO(currGO)
        currGO = nil
    end
end

function ShowEffect()
    if type == eRogueMapPosType.Buff then
        CSAPI.SetGOActive(buffEffect, true)
    end
end

function ShowBattle()
    if not IsNil(currGO) then
        CSAPI.SetGOActive(currGO.transform:GetChild(0).gameObject,true)
        CSAPI.SetGOActive(currGO.transform:GetChild(1).gameObject,false)
    end
end

function Refresh(_data, _elseData)
    data = _data
    if isPlayer ~= (_elseData and _elseData.isPlayer) and IsUnLock() then
        isPlayer = (_elseData and _elseData.isPlayer)
        ShowNolEffect()
    end
    if data.specTime and data.specTime < TimeUtil:GetTime() then
        Hide()
    end
end

function ShowNolEffect()
    if isPlayer then
        if IsNil(showPlayerGo) then
            showPlayerGo = CreateGrid(99, 0, 0, 0, level)
        end
        CSAPI.SetGOActive(showPlayerGo, true)
        if not IsNil(showGO) then
            CSAPI.SetGOActive(showGO, false)
        end
    else
        if IsNil(showGO) then
            showGO = CreateGrid(0, 0, 0, 0, level)
        end
        CSAPI.SetGOActive(showGO, true)
        if not IsNil(showPlayerGo) then
            CSAPI.SetGOActive(showPlayerGo, false)
        end
    end
end

function ClearAll()
    gameObject.name = "RogueMapBattleGrid"
    data = nil
    type = 0
    level = nil
    if not IsNil(currGO) then
        -- if type == eRogueMapPosType.Boss or type == eRogueMapPosType.SpecialBoss or type == eRogueMapPosType.Monster then
        --     if currGO.transform.childCount > 0 then
        --         for i = 0, currGO.transform.childCount - 1 do
        --             CSAPI.SetGOActive(currGO.transform:GetChild(i).gameObject,false)
        --         end
        --     end
        -- end
        CSAPI.RemoveGO(currGO)
    end
    currGO = nil
    if not IsNil(showGO) then
        CSAPI.RemoveGO(showGO)
    end
    showGO = nil
    if not IsNil(showPlayerGo) then
        CSAPI.RemoveGO(showPlayerGo)
    end
    showPlayerGo = nil
    isPlayer = false

    
end

--设置boss位置
function SetBossPos(isPlayer)
    if type == eRogueMapPosType.Boss or type == eRogueMapPosType.SpecialBoss then
        if not IsNil(currGO) and IsUnLock() then
            local z = RogueMapBattleMgr:HasTimeShow(data and data.id) and 0.25 or 0
            local x = isPlayer and 0.35 or 0
            CSAPI.SetLocalPos(currGO.transform:GetChild(0).gameObject,x,0.6,z)
            CSAPI.SetGOActive(currGO.transform:GetChild(2).gameObject,isPlayer)
        end
    end
end

--更新boss位置
function UpdateBossPos(gridId,isMoving)
    if type == eRogueMapPosType.Boss or type == eRogueMapPosType.SpecialBoss then
        if not IsNil(currGO) and GetState() == eDungeonCharState.Active then
            if isMoving then
                CSAPI.SetGOActive(currGO.transform:GetChild(0).gameObject,false)
            else
                CSAPI.SetGOActive(currGO.transform:GetChild(0).gameObject,true)
                local playerGridID = RogueMapBattleMgr:GetMyCharacterGridId() or 0
                local z = RogueMapBattleMgr:HasTimeShow(data and data.id) and 0.25 or 0
                local x = playerGridID == gridId and 0.35 or 0
                CSAPI.SetLocalPos(currGO.transform:GetChild(0).gameObject,x,0.6,z)
                CSAPI.SetGOActive(currGO.transform:GetChild(2).gameObject,playerGridID == gridId)
            end
        end
    end
end

function IsUnLock()
    return data and data.isUnLock
end

function GetState()
    return data and data.state or 1
end


