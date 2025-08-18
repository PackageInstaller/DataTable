-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/System\\ConditionLimitManager.lua

local RedDotManager = require("UI/RedDotManager")
local ResConditionLimit = require("ClientData/ResConditionLimit")
local ResGamePlayNotice = require("ClientData/ResGamePlayNotice")
local ResCountCondition = require("ClientData/ResCountCondition")
local EventConst = require("EventConst")
local ConditionLimitManager = {}

GLDeclare("ConditionLimitManager", ConditionLimitManager)

local self = ConditionLimitManager

self.unlockNotifyMap = {}

local UNLOCK_TYPE_ACHIEVE = 1
local UNLOCK_TYPE_TASK = 2

function ConditionLimitManager.initPlayerData()
	self.systemMap = {}
	self.extraCondMap = {}
	self.levelConditions = {}
	self.stageConditions = {}
	self.taskConditions = {}
	self.achieveConditions = {}
	self.resultCache = {}
	self.houseLevelConditions = {}
	self.crystalLevelConditions = {}
	self.crystalSecondLevelConditions = {}
	self.vipLevelConditions = {}

	local level = CurAvatar:getLevel()
	local houseLevel = CurAvatar:getRearHouseLevel()
	local crystalLevel = CurAvatar:getCrystalMaxLevel()
	local crystalSecondLevel = CurAvatar.crystalNewLevel

	for limitId, limitInfo in pairs(ResConditionLimit) do
		if limitInfo.unlock_level then
			self.systemMap[limitId] = level < limitInfo.unlock_level
			self.levelConditions[limitId] = limitInfo.unlock_level
		elseif limitInfo.unlock_stage then
			self.systemMap[limitId] = not CurAvatar:mainStageStatePassed(limitInfo.unlock_stage[1], limitInfo.unlock_stage[2], limitInfo.unlock_stage[3])
			self.stageConditions[limitId] = limitInfo.unlock_stage
		elseif limitInfo.unlock_task then
			local taskType = limitInfo.unlock_task[1]
			local id = limitInfo.unlock_task[2]
			local condition = limitInfo.unlock_task[3]

			self.systemMap[limitId] = self._checkTaskLocked(taskType, id, condition)

			if taskType == UNLOCK_TYPE_ACHIEVE then
				self.achieveConditions[id] = {
					limitId = limitId,
					condition = condition
				}
			elseif taskType == UNLOCK_TYPE_TASK then
				self.taskConditions[id] = {
					limitId = limitId,
					condition = condition
				}
			end
		elseif limitInfo.unlock_house_level then
			self.systemMap[limitId] = houseLevel < limitInfo.unlock_house_level
			self.houseLevelConditions[limitId] = limitInfo.unlock_house_level
		elseif limitInfo.unlock_crystal_level then
			self.systemMap[limitId] = crystalLevel < limitInfo.unlock_crystal_level
			self.crystalLevelConditions[limitId] = limitInfo.unlock_crystal_level
		elseif limitInfo.unlock_second_crystal_level then
			self.systemMap[limitId] = crystalSecondLevel < limitInfo.unlock_second_crystal_level
			self.crystalSecondLevelConditions[limitId] = limitInfo.unlock_second_crystal_level
		elseif limitInfo.VIP_level then
			self.vipLevelConditions[limitId] = limitInfo.VIP_level
		end

		if limitInfo.VIP_level or limitInfo.regday or limitInfo.hero_star or limitInfo.client_const_key or limitInfo.close_act_id or limitInfo.count or limitInfo.season_need_level then
			self.extraCondMap[limitId] = limitInfo
		end
	end
end

function ConditionLimitManager._checkTaskLocked(unlockType, id, condition)
	local isLocked = true

	if unlockType == UNLOCK_TYPE_ACHIEVE then
		if condition == Const.CONDITION_TASK_QUALIFY_UNLOCK then
			isLocked = not CurAvatar.achieveQualify[id]
		elseif condition == Const.CONDITION_TASK_GOT_UNLOCK then
			isLocked = not CurAvatar.achieveAwardGot[id]
		end
	elseif unlockType == UNLOCK_TYPE_TASK then
		local taskStatus = CurAvatar:getTaskStatus(id)

		if condition == Const.CONDITION_TASK_QUALIFY_UNLOCK then
			isLocked = taskStatus ~= Const.TASK_STATUS.COMPLETE and taskStatus ~= Const.TASK_STATUS.AWARD_GOT
		elseif condition == Const.CONDITION_TASK_GOT_UNLOCK then
			isLocked = taskStatus ~= Const.TASK_STATUS.AWARD_GOT
		end
	end

	return isLocked
end

function ConditionLimitManager.inLimitState(limitId)
	if self.extraCondMap and self.extraCondMap[limitId] then
		return self.systemMap and self.systemMap[limitId] or self.extraCondMapLocked(self.extraCondMap[limitId])
	else
		return self.systemMap and self.systemMap[limitId]
	end
end

function ConditionLimitManager.extraCondMapLocked(limitInfo)
	if limitInfo.client_const_key and not Const[limitInfo.client_const_key] then
		return true
	end

	if limitInfo.VIP_level then
		return CurAvatar.vipLevel < limitInfo.VIP_level
	end

	if limitInfo.regday then
		return ClientUtils.getServerTime() > CurAvatar.roleCreateTick + limitInfo.regday * Const.TIME_ONE_DAY
	end

	if limitInfo.hero_star then
		return CurAvatar:getHeroMaxStarEver(limitInfo.hero_id) < limitInfo.hero_star
	end

	if limitInfo.close_act_id then
		return CurAvatar:isActivityOpen(limitInfo.close_act_id)
	end

	if limitInfo.season_need_level then
		return CurAvatar:checkOpenSeasonLevel(limitInfo.season_need_level)
	end

	if limitInfo.count then
		local resData = ResCountCondition[limitInfo.count]

		if resData then
			local num = resData.number
			local checkNum = CurAvatar:getCumulativeCountDataByType(resData.type)

			return not checkNum or checkNum < num
		end
	end
end

function ConditionLimitManager.inGamePlayLimitState(gamePlayerId)
	if ResGamePlayNotice[gamePlayerId] then
		return self.inLimitState(ResGamePlayNotice[gamePlayerId].condition_id)
	end
end

function ConditionLimitManager.getLimitUnlockDesc(limitId, isButton)
	local unlock_desc = ""

	if ResConditionLimit[limitId] then
		if isButton then
			unlock_desc = ResConditionLimit[limitId].unlock_button_desc or ""
		else
			unlock_desc = ResConditionLimit[limitId].unlock_desc or ""
		end
	end

	return unlock_desc
end

function ConditionLimitManager.triggerLevelCondition(level)
	for limitId, limitLv in pairs(self.levelConditions) do
		if self.inLimitState(limitId) and limitLv <= level then
			self._limitUnlock(limitId)
		end
	end

	self.scheduleUnlockNotify()
end

function ConditionLimitManager.triggerHouseLevelCondition(level)
	for limitId, limitLv in pairs(self.houseLevelConditions) do
		if self.inLimitState(limitId) and limitLv <= level then
			self._limitUnlock(limitId)
		end
	end

	self.scheduleUnlockNotify()
end

function ConditionLimitManager.triggerCrystalLevelCondition(level)
	for limitId, limitLv in pairs(self.crystalLevelConditions) do
		if self.inLimitState(limitId) and limitLv <= level then
			self._limitUnlock(limitId)
		end
	end

	self.scheduleUnlockNotify()
end

function ConditionLimitManager.triggerCrystalSecondLevelCondition(level)
	for limitId, limitLv in pairs(self.crystalSecondLevelConditions) do
		if self.inLimitState(limitId) and limitLv <= level then
			self._limitUnlock(limitId)
		end
	end

	self.scheduleUnlockNotify()
end

function ConditionLimitManager.triggerStageUnlock(season, chapter, level)
	for limitId, unlockStage in pairs(self.stageConditions) do
		if self.inLimitState(limitId) and CurAvatar:mainStageStatePassed(unlockStage[1], unlockStage[2], unlockStage[3]) then
			self._limitUnlock(limitId)
		end
	end

	self.scheduleUnlockNotify()
end

function ConditionLimitManager.triggerVipLevelUnlock(level)
	for limitId, vipLevel in pairs(self.vipLevelConditions) do
		if level == vipLevel then
			EventCenter.sendEvent(EventConst.CONDITION_LOCK_CHANGED, limitId)
			self._checkRD(limitId)
		end
	end

	self.scheduleUnlockNotify()
end

function ConditionLimitManager.triggerTaskUnlock(taskId, opt)
	local unlockInfo = self.taskConditions[taskId]

	if not unlockInfo then
		return
	end

	local limitId = unlockInfo.limitId
	local condition = unlockInfo.condition

	if self.inLimitState(limitId) and condition == opt then
		self._limitUnlock(limitId)
		self.scheduleUnlockNotify()
	end
end

function ConditionLimitManager.triggerAchieveUnlock(achieveId, opt)
	local unlockInfo = self.achieveConditions[achieveId]

	if not unlockInfo then
		return
	end

	local limitId = unlockInfo.limitId
	local condition = unlockInfo.condition

	if self.inLimitState(limitId) and condition == opt then
		self._limitUnlock(limitId)
		self.scheduleUnlockNotify()
	end
end

function ConditionLimitManager._limitUnlock(limitId)
	self.resultCache[limitId] = true
	self.systemMap[limitId] = nil

	EventCenter.sendEvent(EventConst.CONDITION_LOCK_CHANGED, limitId)
	self._checkRD(limitId)
end

function ConditionLimitManager._checkRD(limitId)
	if UIConst.CONDITION_RD_MAP[limitId] then
		RedDotManager.updateDotsByKey(UIConst.CONDITION_RD_MAP[limitId])
	end
end

function ConditionLimitManager.scheduleUnlockNotify()
	return
end

function ConditionLimitManager.registerUnlockEvent(limitId, callback)
	if not self.unlockNotifyMap[limitId] then
		self.unlockNotifyMap[limitId] = {}
	end

	table.insert(self.unlockNotifyMap[limitId], callback)
end

function ConditionLimitManager.unlockAllCondition(...)
	for limitId, _ in pairs(self.systemMap) do
		self._limitUnlock(limitId)
	end
end

return ConditionLimitManager
