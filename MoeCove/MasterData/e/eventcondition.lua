---@class EventManager
local EventCondition = require "EventManager"
local BattleCore = require "BattleCore"
local CommonLogic = require "CommonLogic"


--事件触发条件方法注册
function EventCondition:registerBattleEventCondition()

    --回合数达到某回合后触发
    local function doConditionCheckNowCount(param)
        local battleManager = BattleCore:getBattleMgr()
        local nowCountdown = battleManager:getCurrentRound()
        BattleCore.ds("^^^^^^^nowCountdown^^^^^^^^", nowCountdown)
        if nowCountdown == param.num then
            return true
        end
        return false
    end

    --角色进入(离开)指定位置(范围)触发
    local function doConditionCheckCharPosition(param)
        local blockId = param.tileKey
        local length = param.length or 1
        local width = param.width or 1
        local needCamp = param.targettype
        local moveMode = param.movetype
        local outsideTurn = param.outsideTurn
        local battleManager = BattleCore:getBattleMgr()
        local battleRoleManager = BattleCore:getBattleRoleMgr()
        local battleRoleList = nil
        if needCamp == 5 then
            battleRoleList = battleRoleManager:getRolesList()
        else
            battleRoleList = battleRoleManager:getRolesByCamp(needCamp)
        end
        local battleMap = battleManager:getMap()
        local idList = battleMap:selectRangeByBlockIdAndTrain(blockId, width, length)
        for _, battleRole in pairs(battleRoleList) do
            --根据配置判断是否只在角色本回合触发
            if battleRole._isMyTurn or outsideTurn then
                local posList = battleRole:getWaypointList()
                --LuaLogger.ds("^^^^^^^posList^^^^^^^^", tablex.dump(posList))
                local nowPos
                if moveMode == 1 then--进入位置
                    nowPos = battleManager:getBlockById(posList[#posList])
                else--离开位置
                    nowPos = battleManager:getBlockById(posList[#posList - 1])
                end
                --判断是否在范围内
                for _, id in pairs(idList) do
                    if nowPos.id == id then
                        return true
                    end
                end
            end
        end
        return false
    end

    --击败指定怪物(组)后触发
    local function doConditionDefeatEnemy(param)
        local defeatType = param.type
        local cidGroup = param.id
        local needNum = param.num
        -- local saveId = self.nowEventConfig.id
        -- if not self.eventSaveData[saveId] then
        --     self.eventSaveData[saveId] = 0
        -- end
        local battleManager = BattleCore:getBattleMgr()
        local battleRoleManager = battleManager:getRoleManager()
        local allRole = battleRoleManager:getDefeatRolesList()
        local passNum = 0
        for _, battleRole in ipairs(allRole) do
            local isAlive = battleRole:getIsAlive()
            if defeatType == 1 then     --任意怪物
                if not isAlive and battleRole.camp == GE.BattleCampType.Enemy then
                    passNum = passNum + 1
                end
            elseif defeatType == 2 then     --指定角色
                if not isAlive and tablex.find(cidGroup, battleRole.cid) then
                    passNum = passNum + 1
                end
            end
        end
        if passNum >= needNum then
            return true
        else
            return false
        end
    end

    --对应单位生命值大于(小于，等于)指定百分比时触发
    local function doConditionCheckHpPercentByID(param)
        local unitCid = param.id
        local configType = param.comparetype
        local neenPercent = param.per
        local battleManager = BattleCore:getBattleMgr()
        local battleRoleManager = BattleCore:getBattleRoleMgr()
        local nowActionUnit = battleManager:getCureentTurnActionRoleId()
        for id, _ in pairs(nowActionUnit) do
            local battleRole = battleRoleManager:getRole(id, true)
            if battleRole and battleRole.cid == unitCid then
                BattleCore.ds(">>>>IsAlive<<<", battleRole:getIsAlive())
                -- local nowHp = battleRole:getAttrib(GE.AttribType.Hp)
                -- local maxHp = battleRole:getAttrib(GE.AttribType.MaxHp)
                local nowPercent = battleRole:GetCurHPPrecent()
                return CommonLogic.CompareTwoValue(nowPercent, neenPercent, configType)
            end
        end
    end

    --我方上阵人数达到特定人数后触发
    local function doConditionCheckFormationCharCount(param)
        local configNum = param.num
        local configType = param.comparetype
        local battleRoleManager = BattleCore:getBattleRoleMgr()
        local roleCount = battleRoleManager:getFormationRolesCount()
        BattleCore.ds("^^^^^^^roleCount^^^^^^^^", roleCount)
        return CommonLogic.CompareTwoValue(roleCount, configNum, configType)
    end

    --我方阵亡单位达到对应人数时触发
    local function doConditionCheckDefeatChar(param)
        local needNum = param.num   --人数
        local compareType = param.comparetype
        local battleRoleManager = BattleCore:getBattleRoleMgr()
        local defeatCharNum = #battleRoleManager:getDefeatRolesByCamp(1)

        BattleCore.ds("^^^^^^^defeatNum^^^^^^^^", defeatCharNum)

        return CommonLogic.CompareTwoValue(defeatCharNum, needNum, compareType)
    end

    --根据id查找存储数据,满足条件触发
    local function doConditionCheckDataById(param)
        local checkId = param.id
        local checkNum = param.num
        local compareType = param.comparetype
        local saveNum = self.eventSaveData[checkId] or 0
        return CommonLogic.CompareTwoValue(saveNum, checkNum, compareType)
    end

    --每回合(或对应节点)检测并计数,达到配置次数触发
    local function doConditionEveryFewRounds(param)
        local eventConfig = self.nowEventConfig
        local timingPoint = eventConfig.timingPoint
        local eventData = self.battleEventList[timingPoint][eventConfig.id]
        if not eventData.nowRound then
            eventData.nowRound = 1
            eventData.interval = param.num
        else
            eventData.nowRound = eventData.nowRound + 1
        end

        if eventData.nowRound == eventData.interval then
            eventData.nowRound = 0
            return true
        end
        return false
    end

    local function doConditionCheckPlayAVGId(param)
        local battleMgr = BattleCore:getBattleMgr()
        if battleMgr:isVerifyMode() or battleMgr:IsLocalBattle() then
            return true
        end
        local avgId = param.num
        local storyMgr = BattleCore:getBattleStoryManager()
        return avgId == storyMgr:getNowStoryId()
    end

    --无条件立即触发
    local function doConditionTrueImmediately(param)
        return true
    end

    --1 回合数达到某回合后触发
    self.conditionFunc[GE.EventCondition.DoConditionCheckNowCount] = doConditionCheckNowCount
    --2 角色进入(离开)指定位置(范围)触发
    self.conditionFunc[GE.EventCondition.DoConditionCheckCharPosition] = doConditionCheckCharPosition
    --3 击败指定怪物(组)后触发
    self.conditionFunc[GE.EventCondition.DoConditionDefeatEnemy] = doConditionDefeatEnemy
    --4 生命值大于(小于，等于)指定百分比时触发
    self.conditionFunc[GE.EventCondition.DoConditionCheckHpPercentByID] = doConditionCheckHpPercentByID
    --5 我方上阵人数达到特定人数后触发
    self.conditionFunc[GE.EventCondition.DoConditionCheckFormationCharCount] = doConditionCheckFormationCharCount
    --6 我方阵亡单位达到对应人数时触发
    self.conditionFunc[GE.EventCondition.DoConditionCheckDefeatChar] = doConditionCheckDefeatChar
    --7 根据id查找存储数据,满足条件触发
    self.conditionFunc[GE.EventCondition.DoConditionCheckDataById] = doConditionCheckDataById
    --8 每回合(或对应节点)检测并计数,达到配置次数触发
    self.conditionFunc[GE.EventCondition.DoConditionEveryFewRounds] = doConditionEveryFewRounds
    --9 根据剧情id触发
    self.conditionFunc[GE.EventCondition.DoConditionCheckPlayAVGId] = doConditionCheckPlayAVGId
    --100 无条件立即触发
    self.conditionFunc[GE.EventCondition.DoConditionTrueImmediately] = doConditionTrueImmediately
end

return EventCondition