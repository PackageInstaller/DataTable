-- Desc: 玩家任务相关逻辑
---@class Player
local Player = require "Player"
local DataLogMgr
if GV.IsServer then
    DataLogMgr = require "DataLogMgr"
end

local MissionHandlers = {
    -- 通用计数类型
    [GE.MissionFinishType.ClearLevelTypeCount] = { type = "count", field = "count" },
    [GE.MissionFinishType.KillEnemyCount] = { type = "count", field = "count" },
    [GE.MissionFinishType.MakeWeapon] = { type = "count", field = "count" },
    [GE.MissionFinishType.UseTicket] = { type = "count", field = "count" },
    [GE.MissionFinishType.RoleLevelUp] = { type = "count", field = "count" },
    [GE.MissionFinishType.WeaponLevel] = { type = "count", field = "count" },
    [GE.MissionFinishType.EquipLevel] = { type = "count", field = "count" },
    [GE.MissionFinishType.EquipStarUp] = { type = "count", field = "count" },
    [GE.MissionFinishType.GetRole] = { type = "count", field = "count" },
    [GE.MissionFinishType.ClearTaskCount] = { type = "count", field = "count" },
    [GE.MissionFinishType.DrawCardCount] = { type = "count", field = "count" },
    [GE.MissionFinishType.FinishHomeEventCount] = { type = "count", field = "count" },
    [GE.MissionFinishType.FinishDispatchCount] = { type = "count", field = "count" },
    [GE.MissionFinishType.CurrentActionPointReachValue] = { type = "count", field = "count" },
    [GE.MissionFinishType.TowerJoinCount] = { type = "count", field = "count" },
    [GE.MissionFinishType.FirstCharge] = { type = "count", field = "count" },
    [GE.MissionFinishType.SyncTrainingCount] = { type = "count", field = "count" },
    [GE.MissionFinishType.ChatWithHomeRole] = { type = "count", field = "count" },


    -- ID匹配类型
    [GE.MissionFinishType.ClearLevelType] = { type = "id_match", data_field = "levelId", condition_check = "checkLevelType", count_field = "count" },
    [GE.MissionFinishType.KillEnemyTypeCount] = { type = "id_match", data_field = "enemyId" },
    [GE.MissionFinishType.FinishHomeEventById] = { type = "id_match", data_field = "eventId" },
    [GE.MissionFinishType.FinishDispatchById] = { type = "id_match", data_field = "dispatchId" },
    [GE.MissionFinishType.SelectHomeEventOptionById] = { type = "id_match", data_field = {"eventId","optionId"} },
    [GE.MissionFinishType.TowerReachLevel] = { type = "id_match", data_field = "floorId" },

    -- ID计数类型
    [GE.MissionFinishType.ClearLevelCount] = { type = "id_count", data_field = "levelId", count_field = "count" },
    [GE.MissionFinishType.GetItemCountById] = { type = "id_count", data_field = "itemId", count_field = "count" },
    [GE.MissionFinishType.CollectSpecificResourceCount] = { type = "id_count", data_field = "resourceId", count_field = "count" },
    [GE.MissionFinishType.ConsumeItemCountById] = { type = "id_count", data_field = "itemId", count_field = "count" },
    -- [GE.MissionFinishType.ConsumeItem] = { type = "id_count", data_field = "itemId", count_field = "count" },

    -- 直接值设置类型
    [GE.MissionFinishType.UserLevel] = { type = "direct_value", data_field = "newLevel" },
    [GE.MissionFinishType.AchieveLevel] = { type = "direct_value", value_getter = "getAchieveLevel" },
    [GE.MissionFinishType.LoginDayCount] = { type = "direct_value", data_field = "count" },
    [GE.MissionFinishType.LoginDayCountAfterUnlock] = { type = "unlock_day_count", data_field = "count" },

    -- 条件组检查类型
    [GE.MissionFinishType.ClearTask] = { 
        type = "condition_group", 
        condition_check = "checkMissionClear",
        unlock_type = GE.MissionUnLockType.ClearTask
    },
    [GE.MissionFinishType.ClearLevel] = { 
        type = "condition_group", 
        condition_check = "checkLevelClear",
        unlock_type = GE.MissionUnLockType.ClearLevel
    },

    -- 角色相关类型
    [GE.MissionFinishType.RoleLevel] = { type = "role_threshold", data_field = {1, 2}, threshold_field = 2, cross_check = true },
    [GE.MissionFinishType.RoleSkillTree] = { type = "role_threshold", data_field = {1, 2}, threshold_field = 1, cross_check = true },
    [GE.MissionFinishType.AssignHeroReachLevel] = { type = "role_specific", data_field = "roleId", attr_check = "level" },
    [GE.MissionFinishType.AssignHeroReachAffectionLevel] = { type = "role_specific", data_field = "roleId", attr_check = "affectionLevel" },
    [GE.MissionFinishType.AssignHeroReachStar] = { type = "role_specific", data_field = "roleId", attr_check = "star" },
    [GE.MissionFinishType.AssignHeroReachSpecificLevel] = { type = "role_level_up", data_field = {"roleId", "oldLevel", "newLevel"} },

    -- 科技树相关类型
    [GE.MissionFinishType.TechTreeActivateNodeCount] = { type = "tech_tree_threshold", data_field = {1, 2}, threshold_field = 1 },
    [GE.MissionFinishType.RoleCountReachStar] = { type = "role_star_count", data_field = "star" },

    -- 角色计数类型
    [GE.MissionFinishType.SpecifiedRoleCountWithAffectionLevel] = { type = "role_count", data_field = "roleId", attr_check = "affectionLevel" },
    [GE.MissionFinishType.SpecifiedRoleCountWithRankReachStar] = { type = "role_count", data_field = "roleId", attr_check = "star", rank_check = true },
    [GE.MissionFinishType.GetRoleWithRankCount] = { type = "role_count", data_field = "roleId", rank_check = true },
    [GE.MissionFinishType.RoleCountFinishTalentStage] = { type = "role_count", data_field = "stage", talent_check = true },

    -- 建筑和装备类型
    [GE.MissionFinishType.UpgradeHomeBuildingToLevel] = { type = "building_level", data_field = "buildingId", level_field = "level" },
    [GE.MissionFinishType.MultiHomeBuildingReachLevel] = { type = "building_multi_level" },
    [GE.MissionFinishType.OwnEquipCountByLevelPartRank] = { type = "equip_condition", data_field = {"level", "part", "rank"} },
    [GE.MissionFinishType.SupportEquipReachLevel] = { type = "support_equip_level", data_field = "level" },
    [GE.MissionFinishType.AttackWeaponReachLevel] = { type = "attack_weapon_level", data_field = "level" },

    -- 礼物类型
    [GE.MissionFinishType.GiveAssignGiftToRoleCount] = { type = "gift_count", data_field = {"roleId", "giftId"}, count_field = "count" },
    [GE.MissionFinishType.GiveGiftToRoleCount] = { type = "gift_count", data_field = "roleId", count_field = "count" },

    -- 商店类型
    [GE.MissionFinishType.BuyItemCountByShopType] = { type = "shop_buy_count", data_field = "shopType" },
    [GE.MissionFinishType.RefreshShop] = { type = "shop_refresh_count", data_field = "shopId", count_field = "count" },

    -- BOSS战类型
    [GE.MissionFinishType.BossLevelReachPoint] = { type = "boss_score", data_field = {"bossId", "score"} },
    [GE.MissionFinishType.BossLevelClearDifficult] = { type = "boss_difficulty", data_field = {"bossId", "difficulty"} },
    [GE.MissionFinishType.BossLevelGetPointInRound] = { type = "boss_round_score", data_field = {"bossId", "roundCount", "score"} },
    [GE.MissionFinishType.BossLevelClearAnyDifficult] = { type = "boss_difficulty_any", data_field = "difficulty" },

    -- 特殊类型
    [GE.MissionFinishType.GetPoint] = { type = "special", handler = "handleGetPoint" },
    [GE.MissionFinishType.SevenDayTaskAllComplete] = { type = "special", handler = "handleSevenDayTaskAllComplete" },

    -- 繁荣度类型
    [GE.MissionFinishType.Prosperity] = { type = "direct_value", data_field = "value" },
    [GE.MissionFinishType.ProsperityReachLevel] = { type = "direct_value", data_field = "level" },
}


--获取任务列表
---@return table<integer, MissionInfo> 任务列表
function Player:getMissionList()
    return self.missionList
end

--获取任务触发器列表
---@return table<integer, integer[]> 任务触发器列表
function Player:getTriggerList()
    if not self.triggerList then
        self.triggerList = {}
    end
    return self.triggerList
end

--获取指定类型任务触发器列表
---@param Type MissionFinishType 任务触发类型 GE.MissionFinishType
---@return integer[] 任务ID列表
function Player:getTriggerListByType(Type)
    local triggerList = self:getTriggerList()
    return triggerList[Type] or {}
end

---根据ID获取任务信息
---@param id integer 任务ID
---@return MissionInfo? 任务信息数据 包含id(任务id)、state(任务状态)、progress(当前进度)字段 未找到返回nil、type（系统类型标识） 默认为1
function Player:getMissionListById(id)
    local missionList = self:getMissionList()
    if not missionList or not missionList[id] then
        return nil
    end
    return missionList[id]
end

--获取解锁条件列表
function Player:getLockList()
    if not self.LockList then
        self.LockList = {}
    end
    return self.LockList
end

---获取解锁条件列表
---@param unLockType integer 解锁条件类型 GE.MissionUnLockType
---@return integer[] 解锁条件列表
function Player:getLockListByType(unLockType)
    local lockList = self:getLockList()
    if not lockList[unLockType] then
        return {}
    end
    return lockList[unLockType]
end


---初始化任务列表
---遍历任务配置表,初始化成就和普通任务数据,并添加到解锁条件和触发器列表中
---@param userinfo UserInfo 用户信息数据,用于初始化任务数据
function Player:missionInit(userinfo)
    self.triggerList = {}
    self.LockList = {}
    local missionConfig = Config.GetAllConfig("TaskTable")

    if not missionConfig then
        LuaLogger.es("Task configuration table not found:")
    else
        for id, taskCfg in pairs(missionConfig) do
            --成就、普通任务的初始化
            if taskCfg.taskType == GE.MissionType.Achieve
                or taskCfg.taskType == GE.MissionType.EveryDay
                or taskCfg.taskType == GE.MissionType.EveryWeek
                or taskCfg.taskType == GE.MissionType.AchieveLevel
                or taskCfg.taskType == GE.MissionType.BossTask
                or taskCfg.taskType == GE.MissionType.SevenDayTask
                or taskCfg.taskType == GE.MissionType.HomeLandEvent
                or taskCfg.taskType == GE.MissionType.ActivityTask
                or taskCfg.taskType == GE.MissionType.Prosperity then
                    self:addNewTask(taskCfg, userinfo)
            end
            --解锁条件列表初始化
            self:addUnLockList(taskCfg)
            --触发器列表初始化
            self:addTriggerList(taskCfg)
        end
    end
end

--开启活动任务
---@param MissionType integer 任务类型 GE.MissionType
---@param TaskGroupList table 任务组列表
function Player:OpenActiveMission(MissionType, TaskGroupList, proto)
	for _, taskGroup in pairs(TaskGroupList) do
		self:openMissionTypeTask(MissionType, taskGroup, proto)
	end
end

--关闭活动任务
---@param MissionType integer 任务类型 GE.MissionType
---@param TaskGroupList table 任务组列表
function Player:CloseActiveMission(MissionType, TaskGroupList, proto)
	for _, taskGroup in pairs(TaskGroupList) do
		self:closeMissionTypeTask(MissionType, taskGroup, proto)
	end
end

--检查活动任务是否已全部完成
---@param MissionType integer 任务类型 GE.MissionType
---@param TaskGroupList table 任务组列表
function Player:checkActiveMissionIsCompleted(MissionType, TaskGroupList)
	for _, taskGroup in pairs(TaskGroupList) do
		if not self:checkMissionTypeTaskIsCompleted(MissionType, taskGroup) then
			return false
		end
	end
	return true
end

--检查某类型的某组任务是否已全部完成
---@param MissionType integer 任务类型 GE.MissionType
---@param taskGroup integer 任务组列表
function Player:checkMissionTypeTaskIsCompleted(MissionType, taskGroup)
	local taskCfgList = Config.GetTaskInfoByTaskTypeAndGroup(MissionType, taskGroup)
	for _, taskCfg in pairs(taskCfgList) do
		local taskInfo = self:getMissionListById(taskCfg.id)
		if not taskInfo or taskInfo.state ~= GE.MissionState.Received then
			return false
		end
	end
	return true
end

--打开某类型的某组任务
---@param MissionType integer 任务类型 GE.MissionType
---@param taskGroup integer 任务组列表
---@param proto table 任务数据
function Player:openMissionTypeTask(MissionType, taskGroup, proto)
    local taskCfgList = Config.GetTaskInfoByTaskTypeAndGroup(MissionType, taskGroup)
    for _, taskCfg in pairs(taskCfgList) do
        self:addNewTask(taskCfg, proto)
        --解锁条件列表初始化
        self:addUnLockList(taskCfg)
        --触发器列表初始化
        self:addTriggerList(taskCfg)
    end
end

--关闭某类型的某组任务
---@param MissionType integer 任务类型 GE.MissionType
---@param taskGroup integer 任务组列表
---@param proto table 任务数据
function Player:closeMissionTypeTask(MissionType, taskGroup, proto)
    local taskCfgList = Config.GetTaskInfoByTaskTypeAndGroup(MissionType, taskGroup)
    for _, taskCfg in pairs(taskCfgList) do
        local taskInfo = self:getMissionListById(taskCfg.id)
        if taskInfo then
            taskInfo.state = GE.MissionState.Closed
            if proto then
                if proto.missionList == nil then
                    proto.missionList = {}
                end
                proto.missionList[taskCfg.id] = taskInfo
            end
            --日志
            self:taskLog(taskCfg.id)
        end
    end
end

---将任务添加到解锁条件集合中
---根据任务的解锁条件类型,将任务ID添加到对应的解锁条件列表中
---只有处于锁定状态的任务才会被添加到解锁列表
---@param taskCfg TaskTable 任务配置数据,包含id和condition字段
---@return nil 如果有内部错误，直接打印错误日志，不返回任何值
function Player:addUnLockList(taskCfg)
    if not taskCfg then
        LuaLogger.es("Task configuration table not found")
        return
    end

    local taskId = taskCfg.id
    --已经解锁了的任务，就不需要进解锁列表了
    local taskInfo = self:getMissionListById(taskId)
    if taskInfo and taskInfo.state ~= GE.MissionState.Lock then
        return
    end

    ---@type integer 解锁条件类型
    local unLockType = taskCfg.condition[1]
    if not unLockType then
        return
    end

    local lockList = self:getLockList()
    if not lockList[unLockType] then
        lockList[unLockType] = {}
    end

    --任务已经在解锁列表中
    if tablex.find(lockList[unLockType], taskId) then
        return
    end

    --任务添加到解锁列表
    table.insert(lockList[unLockType], taskId)
end

-- 增加任务（其他模块增加单个任务）
---@param taskId integer 任务ID
---@param functionType integer 任务类型 GE.MissionSystemType
---@param userinfo UserInfo 用户信息数据
---@return ActionFailReason
function Player:addTaskFormOther(taskId, functionType, userinfo)
    if not taskId or not functionType then
        LuaLogger.es("not taskId or not functionType", taskId, functionType)
        return ActionFailReason.LackParameter
    end

    local taskCfg = nil
    if functionType == GE.MissionSystemType.affection then
        taskCfg = Config.GetHomeEventInfo(taskId)
    elseif functionType == GE.MissionSystemType.task then
        taskCfg = Config.GetTaskTableInfo(taskId)
    else
        LuaLogger.es("functionType error", functionType)
        return ActionFailReason.ParameterInvalid
    end

    if not taskCfg then
        LuaLogger.es("not taskCfg", taskId)
        return ActionFailReason.CfgNotFind
    end

    if not taskCfg.complete or next(taskCfg.complete) == nil then
        -- LuaLogger.es("任务配置表没有完成条件", taskId)
        return ActionFailReason.CfgNotFind
    end

    local newTaskInfo = {
        id = taskId,
        state = GE.MissionState.Progress,
        progress = 0,
        type = functionType,
        conditionProgress = {},
    }

    -- 如果是多条件任务，初始化每个子条件的进度
    if taskCfg.complete[1] == GE.MissionFinishType.MultiEvent then
        for _, v in pairs(taskCfg.complete[3]) do
            local initProgress = self:taskProgressInit(v)
            newTaskInfo.conditionProgress[v[1]] = initProgress
        end
    end

    -- 初始化任务总进度（检测是否已经满足条件）
    newTaskInfo.progress = self:taskProgressInit(taskCfg.complete)

    -- 检查任务是否已经完成
    local taskProgressTarget = self:getTaskProgressTarget(taskId, functionType)
    if newTaskInfo.progress >= taskProgressTarget then
        newTaskInfo.state = GE.MissionState.Unclaimed
    end

    --添加进触发器列表
    local missionList = self:getMissionList()
    missionList[taskId] = newTaskInfo

    --将好感度委托添加进任务系统的触发器列表中
    -- 如果任务已经完成，就不需要添加触发器了
    if newTaskInfo.state ~= GE.MissionState.Unclaimed then
        local ret = self:addTriggerList(taskCfg)
        if ret ~= ActionFailReason.None then
            return ret
        end
    end

    if userinfo then
        if userinfo.missionList == nil then
            userinfo.missionList = {}
        end
        userinfo.missionList[taskId] = newTaskInfo
    end

    --日志
    self:taskLog(taskId)

    return ActionFailReason.None
end

---将任务添加到触发器列表中（支持普通任务和好感度任务）
---@param taskCfg table 任务配置数据
---@return ActionFailReason
function Player:addTriggerList(taskCfg)
    if not taskCfg then
        return ActionFailReason.CfgNotFind
    end

    local taskId = taskCfg.id
    local taskInfo = self:getMissionListById(taskId)

    if not taskInfo then
        return ActionFailReason.CfgNotFind
    else
        if taskInfo.state == GE.MissionState.Unclaimed
            or taskInfo.state == GE.MissionState.Received
            or taskInfo.state == GE.MissionState.Closed then
            --任务已完成或关闭，不添加触发器
            return ActionFailReason.None
        end
    end

    -- 根据类型选择完成条件
    local FinishType = taskCfg.complete[1]
    local triggerList = self:getTriggerList()
    if taskCfg.complete and next(taskCfg.complete) then
        if not triggerList[FinishType] then
            triggerList[FinishType] = {}
        end
    else
        return ActionFailReason.CfgNotFind
    end

    if FinishType == GE.MissionFinishType.MultiEvent then
        for _, v in pairs(taskCfg.complete[3]) do
            if not triggerList[v[1]] then
                triggerList[v[1]] = {}
            end
            if not tablex.find(triggerList[v[1]], taskId) then
                tablex.insertproxy(triggerList[v[1]], taskId)
            end
        end
    else
        if not tablex.find(triggerList[FinishType], taskId) then
            tablex.insertproxy(triggerList[FinishType], taskId)
        end
    end

    return ActionFailReason.None
end

---更新某类型任务
---将指定类型的所有任务重置为进行中状态,并重新加入触发器和解锁列表
---@param MissionType integer 任务类型
---@param proto table? 协议数据,可选参数,用于同步任务状态
---@return nil 如果有内部错误，直接打印错误日志，不返回任何值
function Player:refreshMissionTypeTask(MissionType, proto)
    local missionList = self:getMissionList()
    for id, info in pairs(missionList) do
        --获取任务配置信息
        local taskCfg = Config.GetTaskTableInfo(id)
        if taskCfg and taskCfg.refreshType == MissionType then
            -- 检查解锁条件是否满足，未满足则重置为锁定状态
            local canUnlock = self:checkMissionState(taskCfg)
            if canUnlock then
                info.state = GE.MissionState.Progress
            else
                info.state = GE.MissionState.Lock
                -- 重新加入解锁等待列表
                self:addUnLockList(taskCfg)
            end
            info.progress = 0

            --日志
            self:taskLog(id)

            --重新加入触发器（仅进行中状态才需要监听触发器）
            if info.state == GE.MissionState.Progress then
                self:addTriggerList(taskCfg)
            end

            if proto then
                if not proto.missionList then
                    proto.missionList = {}
                end
                proto.missionList[id] = info
            end
        end
    end
end

---更新任务锁定状态
---检查所有锁定任务的前置条件是否满足，如果满足则解锁该任务
function Player:missionLockUpdate(unLockType, proto)
    --LuaLogger.e("missionLockUpdate:"..unLockType)
    local LockList = self:getLockListByType(unLockType)
    local pendingIds = {}
    for i = 1, #LockList do
        pendingIds[i] = LockList[i]
    end
    for i = #pendingIds, 1, -1 do
        local missionId = pendingIds[i]
        local configData = Config.GetTaskTableInfo(missionId)
        if configData then
            local canUnlock = self:checkMissionState(configData)
            if canUnlock then
                --任务解锁，增加任务
                self:addNewTask(configData, proto)
                self:addTriggerList(configData)
                --从解锁列表中移除
                for j = #LockList, 1, -1 do
                    if LockList[j] == missionId then
                        table.remove(LockList, j)
                        break
                    end
                end
            end
        end
    end
end

---新建任务
---@param taskCfg table 任务配置信息
---@param userinfo table? 用户信息,可选参数
---@return nil
function Player:addNewTask(taskCfg, userinfo)
    local taskInfo = self:getMissionListById(taskCfg.id)
    if taskInfo and taskInfo.state ~= GE.MissionState.Closed and taskInfo.state ~= GE.MissionState.Lock then
        return
    end

    local CanUnlock = self:checkMissionState(taskCfg)
    if not CanUnlock then
        -- 锁定时计数：commonState=LockCount 的任务在锁定期间也需要记录进度，提前创建 Lock 状态条目
        if taskCfg.commonState == GE.MissionCommonState.LockCount and not taskInfo then
            local lockTrackInfo = {
                id = taskCfg.id,
                state = GE.MissionState.Lock,
                progress = 0,
                type = GE.MissionSystemType.task,
                conditionProgress = {},
            }
            self.missionList[taskCfg.id] = lockTrackInfo
            if userinfo then
                if userinfo.missionList == nil then
                    userinfo.missionList = {}
                end
                userinfo.missionList[taskCfg.id] = lockTrackInfo
            end
        end
        return
    end
    --LuaLogger.e("addNewTask:"..taskCfg.id)
    local newTaskInfo = {
        id = taskCfg.id,
        state = GE.MissionState.Lock,
        progress = 0,
        type = GE.MissionSystemType.task, --默认值
        conditionProgress = {}, --条件进度
    }

    -- 锁定时计数任务解锁时，直接继承已积累的进度，不重新快照
    if taskInfo and taskInfo.state == GE.MissionState.Lock and taskCfg.commonState == GE.MissionCommonState.LockCount then
        newTaskInfo.progress = taskInfo.progress
        newTaskInfo.conditionProgress = taskInfo.conditionProgress
    else
        if taskCfg.complete[1] == GE.MissionFinishType.MultiEvent then
            --多条件任务，初始化每个子条件的进度
            for _, v in pairs(taskCfg.complete[3]) do
                local initProgress = self:taskProgressInit(v)
                newTaskInfo.conditionProgress[v[1]] = initProgress
            end
        end
        --初始化任务总完成进度
        newTaskInfo.progress = self:taskProgressInit(taskCfg.complete)
    end

    -- 如果是解锁后登录天数任务，记录解锁时的登录天数
    if taskCfg.complete[1] == GE.MissionFinishType.LoginDayCountAfterUnlock then
        newTaskInfo.unlockLoginDay = self:getUserData().LoginDay or 0
    end

    -- 如果是指定角色提升指定等级任务，记录解锁时该角色的等级
    if taskCfg.complete[1] == GE.MissionFinishType.AssignHeroReachSpecificLevel then
        local targetRoleId = taskCfg.complete[2]
        local heroData = self:getPlayerHero(targetRoleId)
        newTaskInfo.unlockRoleLevel = heroData and heroData.level or 0
    end

    local taskProgressTarget = self:getTaskProgressTarget(taskCfg.id, GE.MissionSystemType.task)
    if newTaskInfo.progress >= taskProgressTarget and CanUnlock then
        newTaskInfo.state = GE.MissionState.Unclaimed
    else
        newTaskInfo.state = CanUnlock and GE.MissionState.Progress or GE.MissionState.Lock
    end

    self.missionList[taskCfg.id] = newTaskInfo
    if userinfo then
        if userinfo.missionList == nil then
            userinfo.missionList = {}
        end
        userinfo.missionList[taskCfg.id] = newTaskInfo
    end

    --日志
    self:taskLog(taskCfg.id)

    -- 锁定时计数任务解锁时若进度已满，补触发完成副作用（后置任务联动解锁、成就等）
    if newTaskInfo.state == GE.MissionState.Unclaimed
        and taskCfg.commonState == GE.MissionCommonState.LockCount
        and userinfo then
        self:clearMission(newTaskInfo, userinfo, true)
    end
end


---初始化任务已完成进度
---@param taskCfg table 任务配置信息
---@return number 任务当前进度
function Player:taskProgressInit(completeData)
    if completeData[1] == GE.MissionFinishType.UserLevel then
        return self:getUserLevel()
    elseif completeData[1] == GE.MissionFinishType.AchieveLevel then
        return self:getAchieveLevel()
    elseif completeData[1] == GE.MissionFinishType.RoleLevel then
        local level = completeData[2][2]
        return self:getRoleLevelUpNum(level)
    elseif completeData[1] == GE.MissionFinishType.RoleSkillTree then
        local level = completeData[2][2]
        return self:getRoleSkillTreeNum(level)
    elseif completeData[1] == GE.MissionFinishType.TechTreeActivateNodeCount then
        -- 激活指定科技基盘的指定数量节点
        local pageId = completeData[2]
        local currentNodeCount = self:getTechTreeActivateNodeCount(pageId)
        return currentNodeCount
    elseif completeData[1] == GE.MissionFinishType.RoleCountReachStar then
        -- 指定数量角色达到指定星级
        -- 数据结构: {59, 星级, 数量}
        -- completeData[2] = 目标星级
        -- completeData[3] = 目标数量(由getTaskProgressTarget返回)
        local targetStar = completeData[2]
        local currentCount = self:getRoleStarCount(targetStar)
        return currentCount
    elseif completeData[1] == GE.MissionFinishType.GetRole then
        return tablex.size(self:getHeroList())
    elseif completeData[1] == GE.MissionFinishType.LoginDayCount then
        return self:getUserData().LoginDay or 0
    elseif completeData[1] == GE.MissionFinishType.FirstCharge then
        return self:getPayAllMoney()
    elseif completeData[1] == GE.MissionFinishType.AssignHeroReachLevel then
        -- 指定角色达到指定等级
        local roleId = completeData[2]
        local targetLevel = completeData[3]
        local heroData = self:getPlayerHero(roleId)
        if heroData and heroData.level >= targetLevel then
            return 1
        end
        return 0
    elseif completeData[1] == GE.MissionFinishType.AssignHeroReachAffectionLevel then
        -- 指定角色达到指定好感度等级
        local roleId = completeData[2]
        local targetAffectionLevel = completeData[3]
        local heroData = self:getPlayerHero(roleId)
        if heroData and heroData.affectionLevel >= targetAffectionLevel then
            return 1
        end
        return 0
    elseif completeData[1] == GE.MissionFinishType.AssignHeroReachStar then
        -- 指定角色达到指定星级
        local roleId = completeData[2]
        local targetStar = completeData[3]
        local heroData = self:getPlayerHero(roleId)
        if heroData and heroData.star >= targetStar then
            return 1
        end
        return 0
    elseif completeData[1] == GE.MissionFinishType.MultiEvent then
        -- 多条件任务（任意条件满足即可）
        -- completeData格式: {41, 1, {{21, roleId, level}, {47, roleId, affectionLevel}}}
        local requiredCount = completeData[2] or 1
        local conditions = completeData[3]
        if conditions then
            local completedCount = 0
            for _, condition in pairs(conditions) do
                -- 递归检查每个子条件是否满足
                local conditionMet = self:taskProgressInit(condition)
                if conditionMet > 0 then
                    completedCount = completedCount + 1
                    if completedCount >= requiredCount then
                        return requiredCount -- 满足所需数量的条件
                    end
                end
            end
            return completedCount
        end
        return 0
    elseif completeData[1] == GE.MissionFinishType.ClearTask then
        -- 完成指定任务（condition_group类型）
        -- 兼容两种结构：
        -- 1) {1, {taskId1, taskId2, ...}}
        -- 2) {1, 1, {taskId1, taskId2, ...}}
        local conditions = nil
        if type(completeData[2]) == "table" then
            conditions = completeData[2]
        elseif type(completeData[3]) == "table" then
            conditions = completeData[3]
        end
        if type(conditions) == "table" then
            local requiredCount = tablex.size(conditions)
            local clearCount = 0
            for _, taskId in pairs(conditions) do
                if self:checkMissionClear(taskId) then
                    clearCount = clearCount + 1
                end
            end
            if clearCount >= requiredCount then
                return 1
            end
        end
        return 0
    elseif completeData[1] == GE.MissionFinishType.ClearLevel then
        -- 完成指定关卡（condition_group类型）
        local conditions = completeData[3]
        if conditions then
            for _, condition in pairs(conditions) do
                -- 检查每个关卡是否完成
                if self:checkLevelClear(condition) then
                    return 1 -- 任意一个关卡完成即可
                end
            end
        end
        return 0
    elseif completeData[1] == GE.MissionFinishType.SupportEquipReachLevel then
        -- 指定数量的支援舰装强化至指定等级
        -- completeData格式: {56, 等级, 数量}
        local targetLevel = completeData[2]
        local count = 0
        local equipMap = self:getAllEquipData()
        for _, equipData in pairs(equipMap) do
            local equipConfig = Config.GetEquipmentInfo(equipData.cid)
            -- 检查是否是支援舰装(equipType=1)且等级达到目标
            if equipConfig and equipConfig.equipType == GE.EquipType.equip and equipData.level >= targetLevel then
                count = count + 1
            end
        end
        return count
    elseif completeData[1] == GE.MissionFinishType.AttackWeaponReachLevel then
        -- 指定数量的攻击舰装强化至指定等级
        -- completeData格式: {57, 等级, 数量}
        local targetLevel = completeData[2]
        local count = 0
        local weaponMap = self:getAllWeaponData()
        for _, weaponData in pairs(weaponMap) do
            -- 检查武器等级是否达到目标
            if weaponData.level >= targetLevel then
                count = count + 1
            end
        end
        return count
    elseif completeData[1] == GE.MissionFinishType.UpgradeHomeBuildingToLevel then
        -- 家园建筑升到指定等级
        -- completeData格式: {34, 建筑id, 等级}
        local buildingId = completeData[2]
        local targetLevel = completeData[3]
        local currentLevel = self:getBuildingLevel(buildingId)
        -- 如果当前等级已达到或超过目标等级，返回目标等级作为进度
        if currentLevel >= targetLevel then
            return targetLevel
        end
        return 0
    elseif completeData[1] == GE.MissionFinishType.MultiHomeBuildingReachLevel then
        -- 指定多个建筑均达到指定等级
        -- completeData格式: {65, {{建筑id,等级},{建筑id,等级}...}}
        local conditionList = completeData[2] or {}
        local reachedCount = 0
        for _, condition in pairs(conditionList) do
            local buildingId = condition and condition[1]
            local targetLevel = condition and condition[2]
            if buildingId and targetLevel and self:getBuildingLevel(buildingId) >= targetLevel then
                reachedCount = reachedCount + 1
            end
        end
        return reachedCount
    elseif completeData[1] == GE.MissionFinishType.Prosperity then
        -- 繁荣度累计值
        -- completeData格式: {64, 目标值}
        local prosperityInfo = self:getProsperityInfo()
        return prosperityInfo.globalConditionProgress[GE.MissionFinishType.Prosperity] or 0
    elseif completeData[1] == GE.MissionFinishType.ProsperityReachLevel then
        -- 繁荣等级达到指定等级
        -- completeData格式: {66, 繁荣等级}
        local prosperityInfo = self:getProsperityInfo()
        return prosperityInfo.currentLevel or 0
    end
    return 0
end

--获得任务总进度
---@param taskId integer 任务id
---@param taskType MissionSystemType 任务类型 GE.MissionSystemType
---@param finishType? MissionFinishType 完成类型 GE.MissionFinishType
---@return number 任务总进度
function Player:getTaskProgressTarget(taskId, taskType, finishType)
    --判断类型
    local taskCfg = nil
    local function getCompleteType(completeData)
        if completeData[1] == GE.MissionFinishType.ClearTask 
            or completeData[1] == GE.MissionFinishType.ClearLevel 
            or completeData[1] == GE.MissionFinishType.AssignHeroReachLevel 
            or completeData[1] == GE.MissionFinishType.AssignHeroReachAffectionLevel
            or completeData[1] == GE.MissionFinishType.AssignHeroReachStar
            or completeData[1] == GE.MissionFinishType.FinishHomeEventById
            or completeData[1] == GE.MissionFinishType.FinishDispatchById
            or completeData[1] == GE.MissionFinishType.SelectHomeEventOptionById
            or completeData[1] == GE.MissionFinishType.TowerReachLevel
            or completeData[1] == GE.MissionFinishType.BossLevelClearDifficult
            or completeData[1] == GE.MissionFinishType.BossLevelClearAnyDifficult
            or completeData[1] == GE.MissionFinishType.SevenDayTaskAllComplete then
                return 1
        elseif completeData[1] == GE.MissionFinishType.GiveAssignGiftToRoleCount then
                -- 兼容 {42, roleId, giftId, count} / {42, {roleId, giftId}, count}
                return completeData[4] or completeData[3]
        elseif completeData[1] == GE.MissionFinishType.SpecifiedRoleCountWithRankReachStar then
                -- 兼容 {24, rank, star, count} / {24, {rank, star}, count}
                return completeData[4] or completeData[3]
        elseif completeData[1] == GE.MissionFinishType.MultiHomeBuildingReachLevel then
                -- {65, {{建筑id,等级},{建筑id,等级}...}}
                local conditionList = completeData[2]
                if type(conditionList) ~= "table" then
                    return 0
                end
                return tablex.size(conditionList)
        elseif completeData[1] == GE.MissionFinishType.ClearLevelType 
            or completeData[1] == GE.MissionFinishType.ClearLevelCount 
            or completeData[1] == GE.MissionFinishType.KillEnemyTypeCount
            or completeData[1] == GE.MissionFinishType.SpecifiedRoleCountWithAffectionLevel
            or completeData[1] == GE.MissionFinishType.GetRoleWithRankCount
            or completeData[1] == GE.MissionFinishType.GetItemCountById
            or completeData[1] == GE.MissionFinishType.CollectSpecificResourceCount
            or completeData[1] == GE.MissionFinishType.ConsumeItemCountById
            or completeData[1] == GE.MissionFinishType.UpgradeHomeBuildingToLevel
            or completeData[1] == GE.MissionFinishType.OwnEquipCountByLevelPartRank
            or completeData[1] == GE.MissionFinishType.SupportEquipReachLevel
            or completeData[1] == GE.MissionFinishType.AttackWeaponReachLevel
            or completeData[1] == GE.MissionFinishType.RoleCountFinishTalentStage
            or completeData[1] == GE.MissionFinishType.GiveGiftToRoleCount
            or completeData[1] == GE.MissionFinishType.AssignHeroReachSpecificLevel
            or completeData[1] == GE.MissionFinishType.BuyItemCountByShopType
            or completeData[1] == GE.MissionFinishType.RefreshShop
            or completeData[1] == GE.MissionFinishType.BossLevelReachPoint
            or completeData[1] == GE.MissionFinishType.ConsumeItem
            or completeData[1] == GE.MissionFinishType.TechTreeActivateNodeCount
            or completeData[1] == GE.MissionFinishType.RoleCountReachStar then
                return completeData[3]
        elseif completeData[1] == GE.MissionFinishType.RoleLevel 
            or completeData[1] == GE.MissionFinishType.RoleSkillTree then
                return completeData[2][1]
        elseif completeData[1] == GE.MissionFinishType.BossLevelGetPointInRound then
            return completeData[4]
        end
        return completeData[2]
    end

    if taskType == GE.MissionSystemType.affection then
        taskCfg = Config.GetHomeEventInfo(taskId)
    elseif taskType == GE.MissionSystemType.task then
        taskCfg = Config.GetTaskTableInfo(taskId)
    end

    if not taskCfg then
        LuaLogger.es("Task configuration table not found", taskId)
        return 0
    end

    if taskCfg.complete[1] == GE.MissionFinishType.MultiEvent then
        for _, v in pairs(taskCfg.complete[3]) do
            if v[1] == finishType then
                return getCompleteType(v)
            end
        end
    end

    return getCompleteType(taskCfg.complete)
end

---确认任务状态
---@param misCfg table 任务配置信息
---@return boolean 是否满足解锁条件
function Player:checkMissionState(misCfg)
    local CanUnlock = false
    
    if misCfg.condition[1] == GE.MissionUnLockType.ClearTask then           --完成指定任务
        CanUnlock = self:getMissionIsClear(misCfg.condition[2])
    elseif misCfg.condition[1] == GE.MissionUnLockType.ClearLevel then      --完成关卡
        CanUnlock = self:getLevelIsClear(misCfg.condition[2])
    elseif misCfg.condition[1] == GE.MissionUnLockType.UserLevel then       --玩家等级达到
        CanUnlock = self:getArrivalUserLevel(misCfg.condition[2])
    elseif misCfg.condition[1] == GE.MissionUnLockType.DayCount then        --注册天数达到
        CanUnlock = self:getRegisteredDays() >= misCfg.condition[2]
    elseif misCfg.condition[1] == GE.MissionUnLockType.HomeLandBuildLevel then  --家园指定建筑达到指定等级
        CanUnlock = self:getArrivalHomeBuildingLevel(misCfg.condition[2], misCfg.condition[3])
    elseif misCfg.condition[1] == nil then
        CanUnlock = true
    end

    return CanUnlock
end

---根据任务id移除对应注册
---@param Type number 任务触发类型 GE.MissionFinishType
---@param ID number 任务id
function Player:desTriggerListById(Type, ID)
    local triggerList = self:getTriggerList()
    if triggerList[Type] and next(triggerList[Type]) then
        for k, v in pairs(triggerList[Type]) do
            if ID == v then
                table.remove(triggerList[Type], k)
                break
            end
        end
    end
end

--任务类型与功能开放模块映射
local MissionTypeFunctionOpenMap = {
    [GE.MissionType.EveryDay] = GE.FunctionOpenModule.Task,
    [GE.MissionType.EveryWeek] = GE.FunctionOpenModule.Task,
    [GE.MissionType.Achieve] = GE.FunctionOpenModule.Task,
    [GE.MissionType.AchieveLevel] = GE.FunctionOpenModule.Task,
    [GE.MissionType.SevenDayTask] = GE.FunctionOpenModule.SevenDayTask,
}

---检查任务类型对应功能是否已开放
---@param taskType integer
---@return boolean
function Player:checkMissionFunctionOpen(taskType)
    local functionId = MissionTypeFunctionOpenMap[taskType]
    if not functionId then
        return true
    end
    local isOpen = self:getFunctionOpenStateById(functionId)
    return isOpen ~= GE.FunctionOpenState.Lock
end

---获取任务奖励
---@param idList integer[] 任务id列表
---@param proto UserInfo 要返回的玩家数据
---@return integer 成功返回ActionFailReason.None/失败返回失败码
---@return integer[][]? 成功返回奖励数据/失败返回nil
function Player:getMissionReward(idList, proto)
    if idList == nil or tablex.next(idList) == nil then
        return ActionFailReason.ParameterInvalid
    end

    local list = {}
    if not proto.missionList then
        proto.missionList = {}
    end
    local rewardList = {}
    --检测任务是否完成
    for _, v in pairs(idList) do
        local misData = self:getMissionListById(v)
        if not misData then
            return ActionFailReason.TaskNoFind
        end

        local configData = self:cheackConfigType(misData)
        if not configData then
            LuaLogger.es("Task configuration table not found", misData.id)
            return ActionFailReason.CfgNotFind
        end

        --功能开启检测
        if not self:checkMissionFunctionOpen(configData.taskType) then
            return ActionFailReason.FunctionOpenNotOpen
        end

        if misData.state ~= GE.MissionState.Unclaimed then
            return ActionFailReason.TaskNoFinish
        end

        --重复过滤
        if not list[misData.id] then
            list[misData.id] = true
        else
            LuaLogger.ds("Repeat‌", misData.id, self.uid)
        end
        --简易通行证类型的特殊判断
        if configData.taskType == GE.MissionType.CommanderRank then--成长奖励
            if configData.type == 2 and not self:isMiniPassExtraRewardOpen(GE.MissionActivityId[GE.MissionType.CommanderRank]) then
                return ActionFailReason.TaskNoFinish
            end
        end
    end
    --完成任务
    for id, _ in pairs(list) do
        local misData = self:getMissionListById(id)
        if not misData then
            return ActionFailReason.TaskNoFind
        end
        local configData = self:cheackConfigType(misData)
        if not configData then
            LuaLogger.es("Task configuration table not found", misData.id)
            return ActionFailReason.CfgNotFind
        end
        --这里判断是不是成就，是就给玩家身上的成就加经验值
        if configData.taskType == GE.MissionType.Achieve then
            self:addAchieveExp(configData.extraScore , proto)
            self:missionTrigger(GE.MissionFinishType.AchieveLevel, {}, proto)
        end

        --七日任务普通任务完成后，增加积分到积分任务
        if configData.taskType == GE.MissionType.SevenDayTask 
            and configData.type == GE.SevenDayTaskType.SevenDayCommon 
            and configData.extraScore and configData.extraScore > 0 then
            -- 触发积分任务的进度更新
            local temp1 = {}
            if temp1 and next(temp1) then
                local reward = self:addRewardList(temp1, proto, GE.EventItemType.Task, id)
                for _, v in pairs(reward) do
                    table.insert(rewardList, v)
                end
            end
        end

        misData.state = GE.MissionState.Received
		--日志
        self:taskLog(misData.id)

        --积分任务
        local temp1 = {}
        self:missionTrigger(GE.MissionFinishType.GetPoint, {misId = misData.id}, proto, temp1)

        if temp1 and next(temp1) then
            local reward = self:addRewardList(temp1, proto, GE.EventItemType.Task, id)
            for _, v in pairs(reward) do
                table.insert(rewardList, v)
            end
        end
        proto.missionList[misData.id] = misData 
        local reward = self:addRewardList(configData.Award, proto, GE.EventItemType.Task, id)
        for _, v in pairs(reward) do
            table.insert(rewardList, v)
        end

        -- 繁荣度等级任务领取奖励后才正式升级
        if configData.taskType == GE.MissionType.Prosperity and configData.taskGroup == 2 then
            self:onProsperityLevelUpClaimed(configData, proto)
        end

        -- 七日任务完成后，检查是否所有七日任务都已完成
        if configData.taskType == GE.MissionType.SevenDayTask then
            local temp2 = {}
            self:missionTrigger(GE.MissionFinishType.SevenDayTaskAllComplete, {}, proto, temp2)
            if temp2 and next(temp2) then
                local reward2 = self:addRewardList(temp2, proto, GE.EventItemType.Task, id)
                for _, v in pairs(reward2) do
                    table.insert(rewardList, v)
                end
            end
        end

    end
    self:missionLockUpdate(GE.MissionUnLockType.ClearTask, proto)

    --添加奖励合并
    rewardList = self:mergeRewardList(rewardList)
    return ActionFailReason.None, rewardList
end

--提交领取任务奖励
---@param idList integer[] 任务id列表
---@param proto UserInfo 要返回的玩家数据
---@return integer 成功返回ActionFailReason.None/失败返回失败码
---@return integer[][]? 成功返回奖励数据/返回nil
function Player:submitClaimMissionReward(idList, proto)
    if not idList or not tablex.next(idList) then
        return ActionFailReason.ParameterInvalid
    end

    --消耗道具列表
    local costList = {}
    local tempList = {}

    --检测任务是否完成
    for _, v in pairs(idList) do
        if not tempList[v] then
            tempList[v] = true
        else
            return ActionFailReason.ParameterInvalid
        end
        local misData = self:getMissionListById(v)
        if not misData then
            return ActionFailReason.TaskNoFind
        end
        if misData.state ~= GE.MissionState.Progress then
            return ActionFailReason.TaskAlreadyFinish
        end
        local cfgData = self:cheackConfigType(misData)
        if not cfgData or cfgData.complete[1] ~= GE.MissionFinishType.ConsumeItem then
            return ActionFailReason.CfgNotFind
        end

        --功能开启检测
        if not self:checkMissionFunctionOpen(cfgData.taskType) then
            return ActionFailReason.FunctionOpenNotOpen
        end

        if not costList[cfgData.complete[2]] then
            costList[cfgData.complete[2]] = 0
        end
        costList[cfgData.complete[2]] = costList[cfgData.complete[2]] + cfgData.complete[3]
    end

    --检测消耗道具是否足够
    for id, num in pairs(costList) do
        local ret = self:checkItemEnough2({id, num})
        if not ret then
            return ActionFailReason.ItemNoEnough
        end
    end

    --提交领取任务奖励
    for _, id in pairs(idList) do
        local misData = self:getMissionListById(id)
        if not misData then
            return ActionFailReason.TaskNoFind
        end
        local cfg = self:cheackConfigType(misData)
        if not cfg or cfg.complete[1] ~= GE.MissionFinishType.ConsumeItem then
            return ActionFailReason.CfgNotFind
        end
        --扣除道具
        local ret1 = self:useItem(cfg.complete[2], cfg.complete[3], proto, GE.EventItemType.Task, id)
        if ret1 ~= ActionFailReason.None then
            return ret1
        end

        -- 完成任务
        misData.progress = cfg.complete[3]

        --任务完成最后处理
        self:clearMission(misData, proto, false)

        -- 因为指定了任务id，通用逻辑不适合，所以不使用通用逻辑
        -- self:missionTrigger(GE.MissionFinishType.ConsumeItem, {itemId = id, count = cfg.complete[3]}, proto)
        --日志
        self:taskLog(id)
    end

    return self:getMissionReward(idList, proto)
end

---任务触发 分发事件
---@param Type MissionFinishType 任务触发类型 GE.MissionFinishType
---@param Data table 触发参数
---@param proto table 要返回的玩家数据
---@param rewardList table? 要返回的奖励数据
function Player:missionTrigger(Type, Data, proto, rewardList)
    local triggerList = self:getTriggerListByType(Type)
    -- 倒序遍历，避免克隆开销，同时安全处理可能的触发器移除
    for i = #triggerList, 1, -1 do
        local id = triggerList[i]
        local misData = self:getMissionListById(id)
        if misData then
            self:updateMissionProgress(misData, Type, Data, proto, rewardList)
        end
    end
end

-------------------------------任务状态判断-------------------------------------------------

--任务完成最后处理
---@param misData MissionInfo 任务数据,包含state(任务状态)、id(任务id)、progress(当前进度)字段、type(系统类型标识)字段
---@param proto table 协议数据,用于同步任务状态
---@param isDel boolean 是否删除触发器
---@return nil
function Player:clearMission(misData, proto, isDel)
    local configData = self:cheackConfigType(misData)
    if not configData then
        LuaLogger.es("Task configuration table not found", misData.id)
        return
    end

    local is_change = false
    local function taskSystemClear()
        local taskProgressTarget = self:getTaskProgressTarget(misData.id, GE.MissionSystemType.task)
        if misData.progress >= taskProgressTarget then
            -- 锁定时计数：任务仍处于锁定状态时只封顶进度，不触发完成流程，待解锁后再处理
            if misData.state == GE.MissionState.Lock then
                misData.progress = taskProgressTarget
                is_change = true
                return
            end
            misData.state = GE.MissionState.Unclaimed
            is_change = true
			--日志
        	self:taskLog(misData.id)
            misData.progress = taskProgressTarget
            if configData.taskType == GE.MissionType.Achieve then
                --self:addAchieveExp(configData.extraScore , proto)
                self:missionTrigger(GE.MissionFinishType.AchieveLevel, {}, proto)
            --elseif configData.taskType == GE.MissionType.AchieveLevel then
                --misData.state = GE.MissionState.Received
            elseif (configData.taskType == GE.MissionType.EveryDay or configData.taskType == GE.MissionType.EveryWeek)
                and (configData.type == GE.DayTaskType.DayPoint or configData.type == GE.WeekTaskType.WeekPoint) then
                    misData.state = GE.MissionState.Received
					--日志
        			self:taskLog(misData.id)
            elseif configData.taskType == GE.MissionType.SevenDayTask
                and configData.taskGroup == GE.SevenDayTaskType.SevenDayPoint then
                    -- 七日任务积分任务：只标记为待领取，不自动领取，不下发奖励
            end
            --完成指定任务（组）
            self:missionTrigger(GE.MissionFinishType.ClearTask, {}, proto)
            self:missionTrigger(GE.MissionFinishType.ClearTaskCount, {count = 1}, proto)
            --任务变为待领取时，立即解锁以该任务完成为解锁条件的锁定任务并推送给前端
            self:missionLockUpdate(GE.MissionUnLockType.ClearTask, proto)
            if not isDel then
                self:desTriggerListById(configData.complete[1], misData.id)
            end
        end
    end

    -- 好感度任务完成处理
    local function affectionSystemClear()
        --根据完成后效果判断是否需要移除该任务全部信息
        local taskProgressTarget = self:getTaskProgressTarget(misData.id, GE.MissionSystemType.affection)
        if misData.progress >= taskProgressTarget then
            misData.state = GE.MissionState.Unclaimed
            misData.progress = taskProgressTarget
            is_change = true
			--日志
			self:taskLog(misData.id)
        end
        if not isDel then
            self:desTriggerListById(configData.complete[1], misData.id)
        end
    end

    local taskSystemType = misData.type
    if taskSystemType ~= nil then
        if taskSystemType == GE.MissionSystemType.task then
            taskSystemClear()
        elseif taskSystemType == GE.MissionSystemType.affection then
            affectionSystemClear()
        end
    else
        taskSystemType = GE.MissionSystemType.task
        taskSystemClear()
    end

    if proto and is_change then
        if proto.missionList == nil then
            proto.missionList = {}
        end
        proto.missionList[misData.id] = misData
    end
end

--获取任务是否已完成
---@param id integer 任务id
---@return boolean 任务是否已完成
function Player:getMissionIsClear(id)
    local info = self:getMissionListById(id)
    if not info then
        return false
    end

    if info.state == GE.MissionState.Unclaimed or info.state == GE.MissionState.Received then
        return true
    end

    return false
end

--获取是否完成关卡
---@param levelId integer 关卡id
---@return boolean 是否完成关卡
function Player:getLevelIsClear(levelId)
    -- 需要获取新的关卡信息
    local levelData = self:getLevelDataByid(levelId)
    if not levelData then
        return false
    end

    if levelData.state == GE.LevelStateType.Finish then
        return true
    end

    return false
end

--获取玩家是否到达等级
---@param level integer 等级阈值
---@return boolean 玩家是否达到指定等级
function Player:getArrivalUserLevel(level)
    local userLevel = self:getUserLevel()
    if userLevel >= level then
        return true
    end
    return false
end

--获取指定家园建筑是否到达等级
---@param constructionId integer 建筑id
---@param level integer 等级阈值
---@return boolean 是否达到指定等级
function Player:getArrivalHomeBuildingLevel(constructionId, level)
    if not constructionId or not level then
        return false
    end
    return self:getBuildingLevel(constructionId) >= level
end

--获取玩家注册后经过的天数
---@return integer 从注册到现在经过的天数
function Player:getRegisteredDays()
    -- borntime 是玩家注册时的时间戳（秒）
    local borntime = self.borntime or 0
    if borntime == 0 then
        return 0
    end

    local currentTime = os.time()
    local diffSeconds = currentTime - borntime
    -- 计算天数（86400秒 = 1天）
    local days = math.floor(diffSeconds / 86400)
    return days
end

----------------------------------任务完成实现--------------------------------------------------

--确认任务类型查找对应的配置表
---@param misData table 任务数据,包含id(任务id)、type(任务类型)字段
---@return table? 配置数据
function Player:cheackConfigType(misData)
    local configData = nil
    local taskType = misData.type
    if taskType == GE.MissionSystemType.task then
        --获取任务配置信息
        configData = Config.GetTaskTableInfo(misData.id)
        if not configData then
            --LuaLogger.es("Task configuration table not found", misData.id)
            return
        end
    elseif taskType == GE.MissionSystemType.affection then
        --获取任务配置信息
        configData = Config.GetHomeEventInfo(misData.id)
        if not configData then
            --LuaLogger.es("affection configuration table not found", misData.id)
            return
        end
    end
    return configData
end

---统一任务进度处理器
---@param misData table 任务数据
---@param finishType MissionFinishType 任务完成类型
---@param data table 触发参数
---@param proto table 协议数据
---@param rewardList table 奖励数据
---@return nil 如果有内部错误，直接打印错误日志，不返回任何值
function Player:updateMissionProgress(misData, finishType, data, proto, rewardList)
    -- 基础检查
    if not misData or misData.state == GE.MissionState.Unclaimed or misData.state == GE.MissionState.Received then
        return
    end

    local configData = self:cheackConfigType(misData)
    if not configData then
        LuaLogger.es("Task configuration table not found", misData.id)
        return
    end

    -- 获取处理器配置
    local handlerConfig = MissionHandlers[finishType]
    if not handlerConfig then
        LuaLogger.es("No handler for mission type:", finishType)
        return
    end

    -- 统一处理逻辑
    local progressUpdated = false
    if handlerConfig.type == "special" and handlerConfig.handler == "handleGetPoint" then
        progressUpdated = self:handleGetPoint(misData, configData, finishType, data, proto, rewardList)
    elseif handlerConfig.type == "special" and handlerConfig.handler == "handleSevenDayTaskAllComplete" then
        progressUpdated = self:handleSevenDayTaskAllComplete(misData, configData, finishType, data, proto, rewardList)
        -- LuaLogger.ds("progressUpdated=========================", progressUpdated)
    else
        progressUpdated = self:processByHandlerType(misData, configData, finishType, data, handlerConfig, proto, rewardList)
    end

    -- 进度更新后的处理
    if progressUpdated then
        self:clearMission(misData, proto, false)

        -- 解锁更新
        if handlerConfig.unlock_type then
            self:missionLockUpdate(handlerConfig.unlock_type, proto)
        end
    end
    if not proto.missionList then
        proto.missionList = {}
    end
    proto.missionList[misData.id] = misData
end

---根据处理器类型处理任务
---@param misData table 任务数据
---@param configData table 任务配置数据
---@param finishType MissionFinishType 任务完成类型
---@param data table 触发参数
---@param handlerConfig table 处理器配置
---@param proto table 协议数据
---@param rewardList table 奖励数据
---@return boolean 任务进度是否更新
function Player:processByHandlerType(misData, configData, finishType, data, handlerConfig, proto, rewardList)
    local handlerType = handlerConfig.type
    local isMultiEvent = configData.complete[1] == GE.MissionFinishType.MultiEvent

    if handlerType == "count" then
        return self:handleCountType(misData, configData, finishType, data, handlerConfig, isMultiEvent)
    elseif handlerType == "id_match" then
        return self:handleIdMatchType(misData, configData, finishType, data, handlerConfig, isMultiEvent)
    elseif handlerType == "id_count" then
        return self:handleIdCountType(misData, configData, finishType, data, handlerConfig, isMultiEvent)
    elseif handlerType == "direct_value" then
        return self:handleDirectValueType(misData, configData, finishType, data, handlerConfig, isMultiEvent)
    elseif handlerType == "unlock_day_count" then
        return self:handleUnlockDayCountType(misData, configData, finishType, data, handlerConfig, isMultiEvent)
    elseif handlerType == "condition_group" then
        return self:handleConditionGroupType(misData, configData, finishType, data, handlerConfig, isMultiEvent)
    elseif handlerType == "role_threshold" then
        return self:handleRoleThresholdType(misData, configData, finishType, data, handlerConfig, isMultiEvent)
    elseif handlerType == "role_specific" then
        return self:handleRoleSpecificType(misData, configData, finishType, data, handlerConfig, isMultiEvent)
    elseif handlerType == "role_count" then
        return self:handleRoleCountType(misData, configData, finishType, data, handlerConfig, isMultiEvent)
    elseif handlerType == "role_level_up" then
        return self:handleRoleLevelUpType(misData, configData, finishType, data, handlerConfig, isMultiEvent)
    elseif handlerType == "shop_buy_count" then
        return self:handleShopBuyCountType(misData, configData, finishType, data, handlerConfig, isMultiEvent)
    elseif handlerType == "shop_refresh_count" then
        return self:handleShopRefreshCountType(misData, configData, finishType, data, handlerConfig, isMultiEvent)
    elseif handlerType == "boss_score" then
        return self:handleBossScoreType(misData, configData, finishType, data, handlerConfig, isMultiEvent)
    elseif handlerType == "boss_difficulty" then
        return self:handleBossDifficultyType(misData, configData, finishType, data, handlerConfig, isMultiEvent)
    elseif handlerType == "boss_difficulty_any" then
        return self:handleBossDifficultyAnyType(misData, configData, finishType, data, handlerConfig, isMultiEvent)
    elseif handlerType == "boss_round_score" then
        return self:handleBossRoundScoreType(misData, configData, finishType, data, handlerConfig, isMultiEvent)
    elseif handlerType == "building_level" then
        return self:handleBuildingLevelType(misData, configData, finishType, data, handlerConfig, isMultiEvent)
    elseif handlerType == "building_multi_level" then
        return self:handleBuildingMultiLevelType(misData, configData, finishType, data, handlerConfig, isMultiEvent)
    elseif handlerType == "equip_condition" then
        return self:handleEquipConditionType(misData, configData, finishType, data, handlerConfig, isMultiEvent)
    elseif handlerType == "support_equip_level" then
        return self:handleSupportEquipLevelType(misData, configData, finishType, data, handlerConfig, isMultiEvent)
    elseif handlerType == "attack_weapon_level" then
        return self:handleAttackWeaponLevelType(misData, configData, finishType, data, handlerConfig, isMultiEvent)
    elseif handlerType == "tech_tree_threshold" then
        return self:handleTechTreeThresholdType(misData, configData, finishType, data, handlerConfig, isMultiEvent)
    elseif handlerType == "role_star_count" then
        return self:handleRoleStarCountType(misData, configData, finishType, data, handlerConfig, isMultiEvent)
    elseif handlerType == "gift_count" then
        return self:handleGiftCountType(misData, configData, finishType, data, handlerConfig, isMultiEvent)
    elseif handlerType == "special" then
        local handlerFunc = self[handlerConfig.handler]
        if handlerFunc then
            -- 修正：传递所有必要参数，包括 proto 和 rewardList
            return handlerFunc(self, misData, configData, finishType, data, proto, rewardList)
        end
    end

    return false
end

-- ========== 具体处理器实现 ==========

---处理计数类型任务
---@param misData table 任务数据
---@param configData table 任务配置数据
---@param finishType MissionFinishType 任务完成类型
---@param data table 触发参数
---@param handlerConfig table 处理器配置
---@param isMultiEvent boolean 是否为多条件任务
---@return boolean 任务进度是否更新
function Player:handleCountType(misData, configData, finishType, data, handlerConfig, isMultiEvent)
    local count = data[handlerConfig.field] or 1
    if isMultiEvent then
        self:addMultiEventProgress(misData, finishType, count)
    else
        misData.progress = misData.progress + count
    end
    return true
end

---处理ID匹配类型任务
---@param misData table 任务数据
---@param configData table 任务配置数据
---@param finishType MissionFinishType 任务完成类型
---@param data table 触发参数
---@param handlerConfig table 处理器配置
---@param isMultiEvent boolean 是否为多条件任务
---@return boolean 任务进度是否更新
function Player:handleIdMatchType(misData, configData, finishType, data, handlerConfig, isMultiEvent)
    -- 支持单字段和多字段（data_field 为 string 或 table）
    if type(handlerConfig.data_field) == "table" then
        -- 从触发数据中按顺序读取目标值
        local targets = {}
        for _, key in ipairs(handlerConfig.data_field) do
            local v = data[key]
            if v == nil then return false end
            table.insert(targets, v)
        end

        -- 获取配置条件
        local condition = self:getTaskCondition(configData, finishType, isMultiEvent)
        if not condition then return false end

        -- 提取条件参数（MultiEvent：condition[2] 通常是参数表；普通：从 index=2 开始为参数）
        local condParams = {}
        if isMultiEvent then
            condParams = condition[2] or {}
        else
            for i = 2, #condition do
                table.insert(condParams, condition[i])
            end
        end

        -- 条目数不足则不匹配
        if #condParams < #targets then
            return false
        end

        -- 逐项完全匹配
        for i, tv in ipairs(targets) do
            if condParams[i] ~= tv then
                return false
            end
        end

        -- 匹配成功，更新进度
        if isMultiEvent then
            self:addMultiEventProgress(misData, finishType, 1)
        else
            misData.progress = misData.progress + 1
        end
        return true
    end

    -- 原单字段逻辑（保留现有特殊检查）
    local targetId = data[handlerConfig.data_field]
    if not targetId then return false end

    local condition = self:getTaskCondition(configData, finishType, isMultiEvent)
    local matched = self:checkIdMatch(condition, targetId, handlerConfig.condition_check)

    if matched then
        local count = (handlerConfig.count_field and data[handlerConfig.count_field]) or 1
        if isMultiEvent then
            self:addMultiEventProgress(misData, finishType, count)
        else
            misData.progress = misData.progress + count
        end
        return true
    end

    return false
end

---处理ID计数类型任务
---@param misData table 任务数据
---@param configData table 任务配置数据
---@param finishType MissionFinishType 任务完成类型
---@param data table 触发参数
---@param handlerConfig table 处理器配置
---@param isMultiEvent boolean 是否为多条件任务
---@return boolean 任务进度是否更新
function Player:handleIdCountType(misData, configData, finishType, data, handlerConfig, isMultiEvent)
    local targetId = data[handlerConfig.data_field]
    local count = data[handlerConfig.count_field] or 1
    if not targetId then return false end

    local condition = self:getTaskCondition(configData, finishType, isMultiEvent)

    -- 提取目标ID：MultiEvent时从condition[2]获取，普通任务从condition[2]获取
    local condTargetId = isMultiEvent and condition[2] or condition[2]

    if condTargetId == targetId then
        if isMultiEvent then
            self:addMultiEventProgress(misData, finishType, count)
        else
            misData.progress = misData.progress + count
        end
        return true
    end

    return false
end

---处理直接值类型任务
---@param misData table 任务数据
---@param configData table 任务配置数据
---@param finishType MissionFinishType 任务完成类型
---@param data table 触发参数
---@param handlerConfig table 处理器配置
---@param isMultiEvent boolean 是否为多条件任务
---@return boolean 任务进度是否更新
function Player:handleDirectValueType(misData, configData, finishType, data, handlerConfig, isMultiEvent)
    local value
    if handlerConfig.value_getter then
        value = self[handlerConfig.value_getter](self)
    else
        value = data[handlerConfig.data_field]
    end

    if not value then return false end

    if isMultiEvent then
        self:setMultiEventProgress(misData, finishType, value)
    else
        misData.progress = value
    end
    return true
end

---处理解锁后登录天数类型任务
---@param misData table 任务数据
---@param configData table 任务配置数据
---@param finishType MissionFinishType 任务完成类型
---@param data table 触发参数
---@param handlerConfig table 处理器配置
---@param isMultiEvent boolean 是否为多条件任务
---@return boolean 任务进度是否更新
function Player:handleUnlockDayCountType(misData, configData, finishType, data, handlerConfig, isMultiEvent)
    -- 获取当前总登录天数
    local currentLoginDay = data[handlerConfig.data_field]
    if not currentLoginDay then return false end

    -- 获取任务解锁时的登录天数
    local unlockLoginDay = misData.unlockLoginDay or 0

    -- 计算解锁后的登录天数
    local daysSinceUnlock = currentLoginDay - unlockLoginDay
    if daysSinceUnlock < 0 then
        daysSinceUnlock = 0
    end

    if isMultiEvent then
        self:setMultiEventProgress(misData, finishType, daysSinceUnlock)
    else
        misData.progress = daysSinceUnlock
    end
    return true
end

---处理条件组类型任务
---@param misData table 任务数据
---@param configData table 任务配置数据
---@param finishType MissionFinishType 任务完成类型
---@param data table 触发参数
---@param handlerConfig table 处理器配置
---@param isMultiEvent boolean 是否为多条件任务
---@return boolean 任务进度是否更新
function Player:handleConditionGroupType(misData, configData, finishType, data, handlerConfig, isMultiEvent)
    local condition = self:getTaskCondition(configData, finishType, isMultiEvent)
    local checkFunc = self[handlerConfig.condition_check]

    if not checkFunc or not condition then return false end

    -- 兼容两种结构：
    -- 1) {finishType, {id1,id2,...}}
    -- 2) {finishType, requiredCount, {id1,id2,...}}
    local conditionList = nil
    if type(condition[2]) == "table" then
        conditionList = condition[2]
    elseif type(condition[3]) == "table" then
        conditionList = condition[3]
    end
    if type(conditionList) ~= "table" then
        return false
    end

    local requiredCount = tablex.size(conditionList)

    local clearCount = 0
    for _, value in pairs(conditionList) do
        if checkFunc(self, value) then
            clearCount = clearCount + 1
        end
    end
    if clearCount >= requiredCount then
        if isMultiEvent then
            self:addMultiEventProgress(misData, finishType, 1)
        else
            misData.progress = misData.progress + 1
        end
        return true
    end

    return false
end

---处理角色阈值类型任务
---@param misData table 任务数据
---@param configData table 任务配置数据
---@param finishType MissionFinishType 任务完成类型
---@param data table 触发参数
---@param handlerConfig table 处理器配置
---@param isMultiEvent boolean 是否为多条件任务
---@return boolean 任务进度是否更新
function Player:handleRoleThresholdType(misData, configData, finishType, data, handlerConfig, isMultiEvent)
    local oldValue, newValue = data[handlerConfig.data_field[1]], data[handlerConfig.data_field[2]]
    if not newValue then return false end

    local condition = self:getTaskCondition(configData, finishType, isMultiEvent)

    -- 数据结构: {finishType, {数量, 等级/节点数}}
    -- condition[2][1] = 需要达到的角色数量
    -- condition[2][2] = 等级/节点数阈值
    local targetCount, targetThreshold
    if isMultiEvent then
        targetCount = condition[2] and condition[2][1] or 0
        targetThreshold = condition[2] and condition[2][2] or 0
    else
        targetCount = condition[2] and condition[2][1] or 0
        targetThreshold = condition[2] and condition[2][2] or 0
    end

    -- 统计达到阈值的角色数量
    local currentCount = 0
    if finishType == GE.MissionFinishType.RoleLevel then
        -- 统计达到目标等级的角色数量
        for k, v in pairs(self:getHeroList()) do
            if v.level >= targetThreshold then
                currentCount = currentCount + 1
            end
        end
    elseif finishType == GE.MissionFinishType.RoleSkillTree then
        -- 统计技能树达到目标节点数的角色数量
        for k, v in pairs(self:getHeroList()) do
            if tablex.size(v.talentTreeList) >= targetThreshold then
                currentCount = currentCount + 1
            end
        end
    end

    -- 更新进度为实际达到阈值的角色数量
    local oldProgress
    if isMultiEvent then
        if not misData.conditionProgress then
            misData.conditionProgress = {}
        end
        oldProgress = misData.conditionProgress[finishType] or 0
        self:setMultiEventProgress(misData, finishType, currentCount)
    else
        oldProgress = misData.progress
        misData.progress = currentCount
    end

    -- 如果进度发生变化，返回true
    return currentCount ~= oldProgress
end

---处理科技树阈值类型任务
---@param misData table 任务数据
---@param configData table 任务配置数据
---@param finishType MissionFinishType 任务完成类型
---@param data table 触发参数 {激活的节点数, 科技基盘类型}
---@param handlerConfig table 处理器配置
---@param isMultiEvent boolean 是否为多条件任务
---@return boolean 任务进度是否更新
function Player:handleTechTreeThresholdType(misData, configData, finishType, data, handlerConfig, isMultiEvent)
    local pageId = data[handlerConfig.data_field[2]]
    if not pageId then return false end

    local condition = self:getTaskCondition(configData, finishType, isMultiEvent)
    -- LuaLogger.ds("condition", tablex.dump(condition))
    -- 数据结构: {finishType, 科技基盘类型, 激活节点数量}
    -- condition[2] = 科技基盘类型
    -- condition[3] = 目标激活节点数量
    local targetPageId, targetNodeCount
    targetPageId = condition[2] and condition[2] or 0
    targetNodeCount = condition[3] and condition[3] or 0

    -- 检查是否为目标科技基盘
    if pageId ~= targetPageId then
        return false
    end

    -- 获取当前科技基盘已激活的节点数量
    local currentNodeCount = self:getTechTreeActivateNodeCount(pageId)

    -- 更新进度为实际激活的节点数量
    local oldProgress
    if isMultiEvent then
        if not misData.conditionProgress then
            misData.conditionProgress = {}
        end
        oldProgress = misData.conditionProgress[finishType] or 0
        self:setMultiEventProgress(misData, finishType, currentNodeCount)
    else
        oldProgress = misData.progress
        misData.progress = currentNodeCount
    end

    -- 如果进度发生变化，返回true
    return currentNodeCount ~= oldProgress
end

---处理角色星级计数类型任务
---@param misData table 任务数据
---@param configData table 任务配置数据
---@param finishType MissionFinishType 任务完成类型
---@param data table 触发参数 {star = 星级, roleId = 角色id}
---@param handlerConfig table 处理器配置
---@param isMultiEvent boolean 是否为多条件任务
---@return boolean 任务进度是否更新
function Player:handleRoleStarCountType(misData, configData, finishType, data, handlerConfig, isMultiEvent)
    local star = data[handlerConfig.data_field]
    if not star then return false end

    local condition = self:getTaskCondition(configData, finishType, isMultiEvent)

    -- 数据结构: {finishType, 星级, 数量}
    -- condition[2] = 目标星级
    -- condition[3] = 目标数量(由getTaskProgressTarget返回作为总目标)
    local targetStar = isMultiEvent and condition[2] or condition[2]
    if not targetStar then
        targetStar = 0
    end

    -- 统计达到目标星级的角色数量
    local currentCount = self:getRoleStarCount(targetStar)

    -- 更新进度
    local oldProgress
    if isMultiEvent then
        if not misData.conditionProgress then
            misData.conditionProgress = {}
        end
        oldProgress = misData.conditionProgress[finishType] or 0
        self:setMultiEventProgress(misData, finishType, currentCount)
    else
        oldProgress = misData.progress
        misData.progress = currentCount
    end

    -- 如果进度发生变化，返回true
    return currentCount ~= oldProgress
end

---处理特定角色类型任务
---@param misData table 任务数据
---@param configData table 任务配置数据
---@param finishType MissionFinishType 任务完成类型
---@param data table 触发参数
---@param handlerConfig table 处理器配置
---@param isMultiEvent boolean 是否为多条件任务
---@return boolean 任务进度是否更新
function Player:handleRoleSpecificType(misData, configData, finishType, data, handlerConfig, isMultiEvent)
    local roleId = data[handlerConfig.data_field]
    if not roleId then return false end
    local condition = self:getTaskCondition(configData, finishType, isMultiEvent)
    -- 检查角色ID是否匹配
    local targetRoleId, targetValue
    if isMultiEvent then
        -- 多条件任务：condition 是子条件数组，如 {finishType, {roleId, targetValue}}
        targetRoleId = condition[2]  -- 获取角色ID
        targetValue = condition[3] -- 获取目标值
    else
        targetRoleId = condition[2]
        targetValue = condition[3]
    end
    if roleId ~= targetRoleId then
        return false
    end

    -- 检查角色属性
    local heroData = self:getPlayerHero(roleId)
    if not heroData then return false end

    local currentValue = heroData[handlerConfig.attr_check]
    if currentValue >= targetValue then
        if isMultiEvent then
            self:addMultiEventProgress(misData, finishType, 1)
        else
            misData.progress = misData.progress + 1
        end
        return true
    end

    return false
end

---处理角色计数类型任务
---@param misData table 任务数据
---@param configData table 任务配置数据
---@param finishType MissionFinishType 任务完成类型
---@param data table 触发参数
---@param handlerConfig table 处理器配置
---@param isMultiEvent boolean 是否为多条件任务
---@return boolean 任务进度是否更新
function Player:handleRoleCountType(misData, configData, finishType, data, handlerConfig, isMultiEvent)
    local condition = self:getTaskCondition(configData, finishType, isMultiEvent)

    if handlerConfig.talent_check then
        -- 天赋阶段检查
        local stage = data[handlerConfig.data_field]
        if stage == condition then
            if isMultiEvent then
                self:addMultiEventProgress(misData, finishType, 1)
            else
                misData.progress = misData.progress + 1
            end
            return true
        end
    end

    -- 这三类“指定数量角色”任务使用总量进度，触发时重算当前满足人数
    local function setCountProgress(currentCount)
        local oldProgress
        if isMultiEvent then
            if not misData.conditionProgress then
                misData.conditionProgress = {}
            end
            oldProgress = misData.conditionProgress[finishType] or 0
            self:setMultiEventProgress(misData, finishType, currentCount)
        else
            oldProgress = misData.progress
            misData.progress = currentCount
        end
        return currentCount ~= oldProgress
    end

    local heroList = self:getHeroList() or {}

    if finishType == GE.MissionFinishType.SpecifiedRoleCountWithAffectionLevel then
        local targetAffectionLevel = condition[2]
        if type(targetAffectionLevel) == "table" then
            targetAffectionLevel = targetAffectionLevel[2]
        end
        if not targetAffectionLevel then
            return false
        end

        local count = 0
        for _, heroData in pairs(heroList) do
            if heroData.affectionLevel >= targetAffectionLevel then
                count = count + 1
            end
        end
        return setCountProgress(count)
    end

    if finishType == GE.MissionFinishType.SpecifiedRoleCountWithRankReachStar then
        local targetRank, targetStar
        if type(condition[2]) == "table" then
            targetRank = condition[2][1]
            targetStar = condition[2][2]
        else
            targetRank = condition[2]
            targetStar = condition[3]
        end
        if not targetRank or not targetStar then
            return false
        end

        local count = 0
        for roleId, heroData in pairs(heroList) do
            local roleConfig = Config.GetCharacterInfo(roleId)
            if roleConfig and roleConfig.rank == targetRank and heroData.star >= targetStar then
                count = count + 1
            end
        end
        return setCountProgress(count)
    end

    if finishType == GE.MissionFinishType.GetRoleWithRankCount then
        local targetRank = condition[2]
        if type(targetRank) == "table" then
            targetRank = targetRank[1]
        end
        if not targetRank then
            return false
        end

        local count = 0
        for roleId, _ in pairs(heroList) do
            local roleConfig = Config.GetCharacterInfo(roleId)
            if roleConfig and roleConfig.rank == targetRank then
                count = count + 1
            end
        end
        return setCountProgress(count)
    end

    return false
end

---处理角色升级类型任务（指定角色提升指定等级）
---@param misData table 任务数据
---@param configData table 任务配置数据
---@param finishType MissionFinishType 任务完成类型
---@param data table 触发参数
---@param handlerConfig table 处理器配置
---@param isMultiEvent boolean 是否为多条件任务
---@return boolean 任务进度是否更新
function Player:handleRoleLevelUpType(misData, configData, finishType, data, handlerConfig, isMultiEvent)
    local roleId = data[handlerConfig.data_field[1]]
    local oldLevel = data[handlerConfig.data_field[2]]
    local newLevel = data[handlerConfig.data_field[3]]

    if not roleId or not newLevel then return false end

    local condition = self:getTaskCondition(configData, finishType, isMultiEvent)

    -- 提取目标角色ID
    local targetRoleId = isMultiEvent and condition[2] or condition[2]
    if roleId ~= targetRoleId then
        return false
    end

    -- 获取任务解锁时该角色的等级
    local unlockRoleLevel = misData.unlockRoleLevel or 0

    -- 计算相对于解锁时的累计提升等级
    local levelUpSinceUnlock = newLevel - unlockRoleLevel
    if levelUpSinceUnlock < 0 then
        levelUpSinceUnlock = 0
    end

    if isMultiEvent then
        self:setMultiEventProgress(misData, finishType, levelUpSinceUnlock)
    else
        misData.progress = levelUpSinceUnlock
    end
    return true
end

---处理商店购买计数类型任务
---@param misData table 任务数据
---@param configData table 任务配置数据
---@param finishType MissionFinishType 任务完成类型
---@param data table 触发参数 {shopType}
---@param handlerConfig table 处理器配置
---@param isMultiEvent boolean 是否为多条件任务
---@return boolean 任务进度是否更新
function Player:handleShopBuyCountType(misData, configData, finishType, data, handlerConfig, isMultiEvent)
    local shopType = data.shopType

    if not shopType then
        return false
    end

    -- 获取任务条件
    local condition = isMultiEvent and configData.complete[finishType] or configData.complete
    local shopTypeList = condition[2]  -- 商店类型列表

    -- 检查购买的商店类型是否在目标列表中
    if type(shopTypeList) == "table" then
        -- 如果是数组，检查是否包含当前商店类型
        local found = false
        for _, targetShopType in ipairs(shopTypeList) do
            if targetShopType == shopType then
                found = true
                break
            end
        end

        if not found then
            return false
        end
    else
        -- 如果是单个值，直接比较
        if shopTypeList ~= shopType then
            return false
        end
    end

    -- 累计购买次数
    if isMultiEvent then
        self:addMultiEventProgress(misData, finishType, 1)
    else
        misData.progress = misData.progress + 1
    end

    return true
end

---处理商店刷新计数类型任务
---@param misData table 任务数据
---@param configData table 任务配置数据
---@param finishType MissionFinishType 任务完成类型
---@param data table 触发参数 {shopId, count}
---@param handlerConfig table 处理器配置
---@param isMultiEvent boolean 是否为多条件任务
---@return boolean 任务进度是否更新
function Player:handleShopRefreshCountType(misData, configData, finishType, data, handlerConfig, isMultiEvent)
    local shopId = data[handlerConfig.data_field]
    local count = data[handlerConfig.count_field] or 1

    if not shopId then
        return false
    end

    -- 获取任务条件
    local condition = self:getTaskCondition(configData, finishType, isMultiEvent)

    -- 提取目标商店ID：MultiEvent时从condition[2]获取，普通任务从condition[2]获取
    local condShopId = isMultiEvent and condition[2] or condition[2]

    if shopId == condShopId then
        if isMultiEvent then
            self:addMultiEventProgress(misData, finishType, count)
        else
            misData.progress = misData.progress + count
        end
        return true
    end

    return false
end

---处理BOSS战积分类型任务
---@param misData table 任务数据
---@param configData table 任务配置数据
---@param finishType MissionFinishType 任务完成类型
---@param data table 触发参数 {bossId, score}
---@param handlerConfig table 处理器配置
---@param isMultiEvent boolean 是否为多条件任务
---@return boolean 任务进度是否更新
function Player:handleBossScoreType(misData, configData, finishType, data, handlerConfig, isMultiEvent)
    local bossId = data.bossId
    local currentScore = data.score

    if not bossId or not currentScore then
        return false
    end

    -- 获取任务条件
    local condition = isMultiEvent and configData.complete[finishType] or configData.complete
    local targetBossId = condition[2]
    local targetScore = condition[4]

    -- 检查是否是目标BOSS
    if targetBossId ~= bossId then
        return false
    end

    -- 分数会记录
    if isMultiEvent then
        misData.conditionProgress[finishType] = currentScore
        return true
    else
        misData.progress = currentScore
        return true
    end

    return false
end

---处理BOSS战难度类型任务
---@param misData table 任务数据
---@param configData table 任务配置数据
---@param finishType MissionFinishType 任务完成类型
---@param data table 触发参数 {bossId, difficulty}
---@param handlerConfig table 处理器配置
---@param isMultiEvent boolean 是否为多条件任务
---@return boolean 任务进度是否更新
function Player:handleBossDifficultyType(misData, configData, finishType, data, handlerConfig, isMultiEvent)
    local bossId = data.bossId
    local currentDifficulty = data.difficulty

    if not bossId or not currentDifficulty then
        return false
    end

    -- 获取任务条件
    local condition = isMultiEvent and configData.complete[finishType] or configData.complete
    local targetBossId = condition[2]
    local targetDifficulty = condition[3]

    -- 检查是否是目标BOSS
    if targetBossId ~= bossId then
        return false
    end

    -- 检查是否通关了目标难度（当前通关难度大于等于目标难度即可）
    if currentDifficulty >= targetDifficulty then
        if isMultiEvent then
            misData.conditionProgress[finishType] = 1
        else
            misData.progress = 1
        end
        return true
    end

    return false
end

---处理BOSS战任意指定难度类型任务（不限定boss）
---@param misData table 任务数据
---@param configData table 任务配置数据
---@param finishType MissionFinishType 任务完成类型
---@param data table 触发参数 {bossId, difficulty}
---@param handlerConfig table 处理器配置
---@param isMultiEvent boolean 是否为多条件任务
---@return boolean 任务进度是否更新
function Player:handleBossDifficultyAnyType(misData, configData, finishType, data, handlerConfig, isMultiEvent)
    local currentDifficulty = data.difficulty

    if not currentDifficulty then
        return false
    end

    -- 获取任务条件
    local condition = isMultiEvent and configData.complete[finishType] or configData.complete
    local targetDifficulty = condition[2]

    -- 检查是否通关了目标难度（当前通关难度大于等于目标难度即可）
    if currentDifficulty >= targetDifficulty then
        if isMultiEvent then
            misData.conditionProgress[finishType] = 1
        else
            misData.progress = 1
        end
        return true
    end

    return false
end

---处理BOSS战回合积分类型任务
---@param misData table 任务数据
---@param configData table 任务配置数据
---@param finishType MissionFinishType 任务完成类型
---@param data table 触发参数 {bossId, roundCount, score}
---@param handlerConfig table 处理器配置
---@param isMultiEvent boolean 是否为多条件任务
---@return boolean 任务进度是否更新
function Player:handleBossRoundScoreType(misData, configData, finishType, data, handlerConfig, isMultiEvent)
    local bossId = data.bossId
    local roundCount = data.roundCount
    local score = data.score

    if not bossId or not roundCount or not score then
        return false
    end

    -- 获取任务条件
    local condition = isMultiEvent and configData.complete[finishType] or configData.complete
    local targetBossId = condition[2]
    local targetRoundCount = condition[3]
    local targetScore = condition[4]

    -- 检查是否是目标BOSS
    if targetBossId ~= bossId then
        return false
    end

    -- 检查回合数是否满足要求（小于等于目标回合数）并且分数达到目标
    if roundCount <= targetRoundCount and score >= targetScore then
        if isMultiEvent then
            misData.conditionProgress[finishType] = score
        else
            misData.progress = score
        end
        return true
    end

    return false
end

-- 其他处理器实现------------------------------------------

---处理建筑等级类型任务
---@param misData table 任务数据
---@param configData table 任务配置数据
---@param finishType MissionFinishType 任务完成类型
---@param data table 触发参数
---@param handlerConfig table 处理器配置
---@param isMultiEvent boolean 是否为多条件任务
---@return boolean 任务进度是否更新
function Player:handleBuildingLevelType(misData, configData, finishType, data, handlerConfig, isMultiEvent)
    -- 建筑等级处理
    local buildingId = data[handlerConfig.data_field]
    local level = data[handlerConfig.level_field]

    if not buildingId or not level then return false end

    local condition = self:getTaskCondition(configData, finishType, isMultiEvent)

    -- 提取目标建筑ID和目标等级
    local condBuildingId = isMultiEvent and condition[2] or condition[2]
    local targetLevel = condition[3]

    -- 修复：判断建筑ID匹配且等级达到或超过目标等级
    if buildingId == condBuildingId and level >= targetLevel then
        if isMultiEvent then
            self:setMultiEventProgress(misData, finishType, targetLevel)
        else
            misData.progress = targetLevel
        end
        return true
    end

    return false
end

---处理多个建筑等级类型任务
---@param misData table 任务数据
---@param configData table 任务配置数据
---@param finishType MissionFinishType 任务完成类型
---@param data table 触发参数
---@param handlerConfig table 处理器配置
---@param isMultiEvent boolean 是否为多条件任务
---@return boolean 任务进度是否更新
function Player:handleBuildingMultiLevelType(misData, configData, finishType, data, handlerConfig, isMultiEvent)
    local condition = self:getTaskCondition(configData, finishType, isMultiEvent)
    local conditionList = condition and condition[2]
    if type(conditionList) ~= "table" then
        return false
    end

    local reachedCount = 0
    for _, v in pairs(conditionList) do
        local buildingId = v and v[1]
        local targetLevel = v and v[2]
        if buildingId and targetLevel and self:getBuildingLevel(buildingId) >= targetLevel then
            reachedCount = reachedCount + 1
        end
    end

    local oldProgress
    if isMultiEvent then
        if not misData.conditionProgress then
            misData.conditionProgress = {}
        end
        oldProgress = misData.conditionProgress[finishType] or 0
        self:setMultiEventProgress(misData, finishType, reachedCount)
    else
        oldProgress = misData.progress
        misData.progress = reachedCount
    end
    return reachedCount ~= oldProgress
end

---处理装备条件类型任务
---@param misData table 任务数据
---@param configData table 任务配置数据
---@param finishType MissionFinishType 任务完成类型
---@param data table 触发参数
---@param handlerConfig table 处理器配置
---@param isMultiEvent boolean 是否为多条件任务
---@return boolean 任务进度是否更新
function Player:handleEquipConditionType(misData, configData, finishType, data, handlerConfig, isMultiEvent)
    -- 装备条件处理
    local level, part, rank = data[handlerConfig.data_field[1]], data[handlerConfig.data_field[2]], data[handlerConfig.data_field[3]]
    if not level or not part or not rank then return false end

    local condition = self:getTaskCondition(configData, finishType, isMultiEvent)

    if level == condition[1] and part == condition[2] and rank == condition[3] then
        if isMultiEvent then
            self:addMultiEventProgress(misData, finishType, 1)
        else
            misData.progress = misData.progress + 1
        end
        return true
    end

    return false
end

---处理支援舰装等级类型任务
---@param misData table 任务数据
---@param configData table 任务配置数据
---@param finishType MissionFinishType 任务完成类型
---@param data table 触发参数 {level}
---@param handlerConfig table 处理器配置
---@param isMultiEvent boolean 是否为多条件任务
---@return boolean 任务进度是否更新
function Player:handleSupportEquipLevelType(misData, configData, finishType, data, handlerConfig, isMultiEvent)
    -- 支援舰装等级处理 - 统计达到指定等级的支援舰装数量
    local condition = self:getTaskCondition(configData, finishType, isMultiEvent)

    -- 提取目标等级：MultiEvent时从condition[2]获取，普通任务从condition[2]获取
    local targetLevel = isMultiEvent and condition[2] or condition[2]

    -- 统计达到目标等级的支援舰装数量
    local count = 0
    local equipMap = self:getAllEquipData()
    for _, equipData in pairs(equipMap) do
        local equipConfig = Config.GetEquipmentInfo(equipData.cid)
        -- 检查是否是支援舰装(equipType=1)且等级达到目标
        if equipConfig and equipConfig.equipType == GE.EquipType.equip and equipData.level >= targetLevel then
            count = count + 1
        end
    end

    -- 更新进度
    local oldProgress
    if isMultiEvent then
        -- 多条件任务：从 conditionProgress 中获取旧进度
        if not misData.conditionProgress then
            misData.conditionProgress = {}
        end
        oldProgress = misData.conditionProgress[finishType] or 0
        self:setMultiEventProgress(misData, finishType, count)
    else
        oldProgress = misData.progress
        misData.progress = count
    end

    -- 如果进度发生变化，返回true
    return count ~= oldProgress
end

---处理攻击舰装等级类型任务
---@param misData table 任务数据
---@param configData table 任务配置数据
---@param finishType MissionFinishType 任务完成类型
---@param data table 触发参数 {level}
---@param handlerConfig table 处理器配置
---@param isMultiEvent boolean 是否为多条件任务
---@return boolean 任务进度是否更新
function Player:handleAttackWeaponLevelType(misData, configData, finishType, data, handlerConfig, isMultiEvent)
    -- 攻击舰装（武器）等级处理 - 统计达到指定等级的武器数量
    local condition = self:getTaskCondition(configData, finishType, isMultiEvent)

    -- 提取目标等级：MultiEvent时从condition[2]获取，普通任务从condition[2]获取
    local targetLevel = isMultiEvent and condition[2] or condition[2]

    -- 统计达到目标等级的武器数量
    local count = 0
    local weaponMap = self:getAllWeaponData()
    for _, weaponData in pairs(weaponMap) do
        -- 检查武器等级是否达到目标
        if weaponData.level >= targetLevel then
            count = count + 1
        end
    end

    -- 更新进度
    local oldProgress
    if isMultiEvent then
        -- 多条件任务：从 conditionProgress 中获取旧进度
        if not misData.conditionProgress then
            misData.conditionProgress = {}
        end
        oldProgress = misData.conditionProgress[finishType] or 0
        self:setMultiEventProgress(misData, finishType, count)
    else
        oldProgress = misData.progress
        misData.progress = count
    end

    -- 如果进度发生变化，返回true
    return count ~= oldProgress
end

---处理礼物计数类型任务
---@param misData table 任务数据
---@param configData table 任务配置数据
---@param finishType MissionFinishType 任务完成类型
---@param data table 触发参数
---@param handlerConfig table 处理器配置
---@param isMultiEvent boolean 是否为多条件任务
---@return boolean 任务进度是否更新
function Player:handleGiftCountType(misData, configData, finishType, data, handlerConfig, isMultiEvent)
    -- 礼物计数处理
    local roleId, giftId, count
    if type(handlerConfig.data_field) == "table" then
        roleId, giftId = data[handlerConfig.data_field[1]], data[handlerConfig.data_field[2]]
    else
        roleId = data[handlerConfig.data_field]
    end
    count = data[handlerConfig.count_field] or 1

    if not roleId then return false end

    local condition = self:getTaskCondition(configData, finishType, isMultiEvent)

    -- 检查角色ID是否匹配（兼容 condition[2] 为 table 或 scalar）
    local targetRoleId
    if type(condition[2]) == "table" then
        targetRoleId = condition[2][1]
    else
        targetRoleId = condition[2] or condition[1]
    end
    if roleId ~= targetRoleId then
        return false
    end

    -- 检查礼物ID是否匹配（如果有）
    if giftId then
        local targetGiftId
        if type(condition[2]) == "table" then
            targetGiftId = condition[2][2]
        else
            targetGiftId = condition[3]
        end
        if giftId ~= targetGiftId then
            return false
        end
    end

    if isMultiEvent then
        self:addMultiEventProgress(misData, finishType, count)
    else
        misData.progress = misData.progress + count
    end
    return true
end

---处理积分任务
---@param misData table 任务数据
---@param configData table 任务配置数据
---@param finishType MissionFinishType 任务完成类型
---@param data table 触发参数
---@param proto table 协议数据
---@param rewardList table 奖励数据
---@return boolean 任务进度是否更新
function Player:handleGetPoint(misData, configData, finishType, data, proto, rewardList)
    -- 积分任务特殊处理（保持原有逻辑）
    local pointData = Config.GetTaskTableInfo(data.misId)
    if not pointData then return false end
    rewardList = rewardList or {}
    if configData.taskType == pointData.taskType and pointData.extraScore ~= 0 then
        misData.progress = misData.progress + pointData.extraScore

        -- 同步到proto，推送给前端（无论是否达到目标值都要同步）
        if proto then
            if not proto.missionList then
                proto.missionList = {}
            end
            proto.missionList[misData.id] = misData
        end

        -- 七日任务积分任务：只增加积分，不下发奖励
        local isSevenDayPoint = configData.taskType == GE.MissionType.SevenDayTask
            and configData.taskGroup == GE.SevenDayTaskType.SevenDayPoint
        if not isSevenDayPoint then
            local taskProgressTarget = self:getTaskProgressTarget(misData.id, GE.MissionSystemType.task)
            if misData.progress >= taskProgressTarget then
                for _, value in pairs(configData.Award) do
                    table.insert(rewardList, value)
                end
            end
        end

        return true
    end

    return false
end

---处理七日任务所有任务完成
---@param misData table 任务数据
---@param configData table 任务配置数据
---@param finishType MissionFinishType 任务完成类型
---@param data table 触发参数
---@param proto table 协议数据
---@param rewardList table 奖励数据
---@return boolean 任务进度是否更新
function Player:handleSevenDayTaskAllComplete(misData, configData, finishType, data, proto, rewardList)
    -- 检查所有七日任务是否都已完成
    rewardList = rewardList or {}

    -- 获取所有七日任务
    local allSevenDayTasks = Config.GetTaskInfoByTaskType(GE.MissionType.SevenDayTask)
    if not allSevenDayTasks then return false end

    -- 检查是否所有七日任务都已完成（状态为Unclaimed或Received）
    local allCompleted = true
    for _, taskConfig in pairs(allSevenDayTasks) do
        local taskData = self:getMissionListById(taskConfig.id)
        if taskData then
            -- 任务存在，检查状态
            if taskData.state ~= GE.MissionState.Unclaimed and taskData.state ~= GE.MissionState.Received then
                allCompleted = false
                break
            end
        else
            -- 任务不存在，说明还未完成
            allCompleted = false
            break
        end
    end

    -- 如果所有七日任务都完成了，更新进度
    if allCompleted then
        misData.progress = 1

        -- 同步到proto，推送给前端
        if proto then
            if not proto.missionList then
                proto.missionList = {}
            end
            proto.missionList[misData.id] = misData
        end

        -- 检查是否达到目标值（目标值应该是1）
        local taskProgressTarget = self:getTaskProgressTarget(misData.id, GE.MissionSystemType.task)
        if misData.progress >= taskProgressTarget then
            for _, value in pairs(configData.Award) do
                table.insert(rewardList, value)
            end
        end
        return true
    end

    return false
end

-- ========== 辅助函数 ==========

---获取任务条件
---@param configData table 任务配置数据
---@param finishType MissionFinishType 任务完成类型
---@param isMultiEvent boolean 是否为多条件任务
---@return table 任务条件
function Player:getTaskCondition(configData, finishType, isMultiEvent)
    if isMultiEvent then
        for _, value in pairs(configData.complete[3]) do
            if value[1] == finishType then
                return value
            end
        end
    else
        return configData.complete
    end
end

---检查ID匹配
---@param condition table 任务条件
---@param targetId integer 目标ID
---@param specialCheck string? 特殊检查标识
---@return boolean 是否匹配
function Player:checkIdMatch(condition, targetId, specialCheck)
    --LuaLogger.ds("condition", tablex.dump(condition), " targetId:", targetId, " specialCheck:", specialCheck)
    if specialCheck == "checkLevelType" then
        -- 特殊处理：关卡类型检查
        local levelData = Config.GetPveLevelInfo(targetId)
        if not levelData then return false end
        return condition[2][1] == levelData.typemain and condition[2][2] == levelData.type
    else
        -- 普通ID匹配
        if type(condition) == "table" then
            for _, condId in pairs(condition) do
                if condId == targetId then
                    return true
                end
            end
            return false
        else
            return condition == targetId
        end
    end
end

---检查任务是否完成
---@param taskId integer 任务id
---@return boolean 任务是否完成
function Player:checkMissionClear(taskId)
    return self:getMissionIsClear(taskId)
end

---检查关卡是否完成
---@param levelId integer 关卡id
---@return boolean 关卡是否完成
function Player:checkLevelClear(levelId)
    return self:getLevelIsClear(levelId)
end

---多条件任务进度增加
function Player:addMultiEventProgress(misData, finishType, count)
    -- 防御性编程：确保conditionProgress存在
    if not misData.conditionProgress then
        misData.conditionProgress = {}
    end
    if not misData.conditionProgress[finishType] then
        misData.conditionProgress[finishType] = 0
    end

    local conditionProgress = misData.conditionProgress[finishType]
    local progressTarget = self:getTaskProgressTarget(misData.id, misData.type, finishType)
    if conditionProgress >= progressTarget then
        return
    end

    conditionProgress = conditionProgress + count
    misData.conditionProgress[finishType] = conditionProgress

    if conditionProgress >= progressTarget then
        misData.progress = misData.progress + 1
    end
end

---多条件任务进度设置
function Player:setMultiEventProgress(misData, finishType, value)
    -- 防御性编程：确保conditionProgress存在
    if not misData.conditionProgress then
        misData.conditionProgress = {}
    end
    if not misData.conditionProgress[finishType] then
        misData.conditionProgress[finishType] = 0
    end

    local conditionProgress = misData.conditionProgress[finishType]
    local progressTarget = self:getTaskProgressTarget(misData.id, misData.type, finishType)

    if conditionProgress >= progressTarget then
        return
    end

    conditionProgress = value
    misData.conditionProgress[finishType] = conditionProgress

    if conditionProgress >= progressTarget then
        misData.progress = misData.progress + 1
    end
end



---------------------------------成就相关--------------------------------------------

--获取成就等级
function Player:getAchieveLevel()
    return self:getUserData().AchieveLevel
end

--获取成就经验值
function Player:getAchieveExp()
    return self:getUserData().AchieveExp
end

---增加成就经验值
---@param expCount integer 要增加的经验值数量
---@param proto table 协议数据,用于同步更新后的等级和经验值
---@return integer 如果等级已满返回错误码
function Player:addAchieveExp(expCount, proto)
    if not expCount or expCount < 1 then
        return ActionFailReason.ParameterInvalid
    end

    local userData = self:getUserData()

    --得到配置的等级信息
    local nowLevelData = Config.GetLevelconfigInfoByTypeLevel(GE.LevelDataType.achieve, userData.AchieveLevel)
    if not nowLevelData then
        LuaLogger.es("configuration table not found", userData.AchieveLevel)
        return ActionFailReason.CfgNotFind
    end

    --等级已满
    if userData.AchieveLevel == nowLevelData.max_level and userData.AchieveExp == nowLevelData.exp_sum then
        return ActionFailReason.AchieveLevelMax       --等级已满无法获得经验
    end

    --增加经验
    userData.AchieveExp = userData.AchieveExp + expCount

    self:updateAchieveLevel(proto)
    return ActionFailReason.None
end

---更新玩家成就等级
---根据当前成就经验值更新玩家成就等级,并同步到proto中
---@param proto table 协议数据,用于同步更新后的等级和经验值
function Player:updateAchieveLevel(proto)
    ---@type LevelconfigTable[] 等级配置表
    local levelDataList = Config.GetLevelconfigInfoByType(GE.LevelDataType.achieve)
    local userData = self:getUserData()
    local newLevel = userData.AchieveLevel
    --找到当前经验值对应的最高等级
    for _, v in pairs(levelDataList) do
        if v.level > newLevel and userData.AchieveExp >= v.exp_sum then
            newLevel = v.level
        end
    end

    --升级
    if newLevel > userData.AchieveLevel then
        userData.AchieveLevel = newLevel
    end
    if proto.userData == nil then
        proto.userData = {}
    end
    proto.userData.AchieveLevel = userData.AchieveLevel
    proto.userData.AchieveExp = userData.AchieveExp
end

---增加登陆天数并刷新每日任务
---@param userinfo table 用户信息数据,用于刷新任务
---@return nil
function Player:setLoginDay(userinfo)
    --刷新每日任务
    self:refreshMissionTypeTask(GE.MissionRefreshType.Daily, userinfo)
    local userData = self:getUserData()
    userData.LoginDay = userData.LoginDay + 1
    -- 触发累计登录天数任务
    self:missionTrigger(GE.MissionFinishType.LoginDayCount, {count = userData.LoginDay}, userinfo)
    -- 触发解锁后累计登录天数任务
    self:missionTrigger(GE.MissionFinishType.LoginDayCountAfterUnlock, {count = userData.LoginDay}, userinfo)
    -- self:missionTrigger(GE.MissionFinishType.ActivityLogin, {Count = 1}, userinfo)

    --检查基于注册天数的任务解锁
    self:missionLockUpdate(GE.MissionUnLockType.DayCount, userinfo)
end

---获取已经到达指定等级的角色数量
---@param level number 角色等级阈值
---@return number 达到或超过指定等级的角色数量
function Player:getRoleLevelUpNum(level)
    local num = 0
    for k,v in pairs(self:getHeroList()) do
        if v.level >= level then
            num = num + 1
        end
    end
    return num
end

---获取已经开启的技能树数量
---@param level number 技能树等级阈值
---@return number 达到或超过指定等级的角色数量
function Player:getRoleSkillTreeNum(level)
    local num = 0
    for k,v in pairs(self:getHeroList()) do
        if tablex.size(v.talentTreeList) >= level then
            num = num + 1
        end
    end
    return num
end

---获取指定科技基盘已激活的节点数量
---@param pageId TechnologyTreeType 科技基盘类型
---@return number 已激活的节点数量
function Player:getTechTreeActivateNodeCount(pageId)
    if not pageId then
        return 0
    end
    local count = 0
    local treeNodeMap = self:getTechTreeNodeMap()
    local pointCfgList = Config.GetTechnologyTreePointInfoByPage(pageId)
    if not pointCfgList then
        return 0
    end
    for _, cfg in pairs(pointCfgList) do
        if treeNodeMap[cfg.id] and treeNodeMap[cfg.id] > 0 then
            count = count + 1
        end
    end
    return count
end

---获取达到指定星级的角色数量
---@param star number 星级阈值
---@return number 达到或超过指定星级的角色数量
function Player:getRoleStarCount(star)
    local num = 0
    for k, v in pairs(self:getHeroList()) do
        if v.star >= star then
            num = num + 1
        end
    end
    return num
end

-- GM完成指定任务
---@param taskId integer 任务ID
---@param proto UserInfo 玩家信息差量更新结构
---@return ActionFailReason 错误码
function Player:gmFinishTask(taskId, proto)
    if not taskId then
        return ActionFailReason.ParameterInvalid
    end

    local taskData = self:getMissionListById(taskId)
    if not taskData then
        return ActionFailReason.TaskNoFind
    end

    if taskData.state == GE.MissionState.Finished then
        return ActionFailReason.TaskAlreadyFinish
    end

    taskData.state = GE.MissionState.Unclaimed
	self:taskLog(taskData.id)
    self:clearMission(taskData, proto, false)

    return ActionFailReason.None
end

--任务日志
function Player:taskLog(taskId)
    local taskInfo = self:getMissionListById(taskId)
    if not taskInfo then
        LuaLogger.es("Task data not found", taskId)
        return
    end

    local taskCfg
    if taskInfo.type == GE.MissionSystemType.task then
        taskCfg = Config.GetTaskTableInfo(taskId)
    end

    if DataLogMgr then
        DataLogMgr.LogTask(
            {
                taskId = taskId,
                functionType = taskInfo.type,
                taskType = taskCfg and taskCfg.taskType,
                state = taskInfo.state,
            }, self)
    end
end

return Player