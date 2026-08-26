-- chunkname: @modules/logic/versionactivity1_8/dungeon/model/Activity157Model.lua

module("modules.logic.versionactivity1_8.dungeon.model.Activity157Model", package.seeall)

local Activity157Model = class("Activity157Model", BaseModel)
local NOT_PLAYED_ANIM_VALUE = 0
local PLAYED_ANIM_VALUE = 1

function Activity157Model:onInit()
	self:setIsUnlockEntrance(false, true)
	self:setIsSideMissionUnlocked(false, true)
	self:setUnlockComponentByList(nil, true)
	self:setHasGotRewardComponentByList(nil, true)
	self:setProductionInfo(nil, nil, true)
	self:setMissionInfoByList(nil, true)
	self:setInProgressMissionGroup(nil, true)
	self:setHasPlayedAnim()

	self._hasPlayedAnimDict = nil
end

function Activity157Model:reInit()
	self:onInit()
end

function Activity157Model:setActivityInfo(msg)
	local serverActId = msg and msg.activityId
	local actId = self:getActId()

	if not serverActId or serverActId ~= actId then
		return
	end

	self:setIsUnlockEntrance(msg.haveMap)
	self:setIsSideMissionUnlocked(msg.isSideMissionUnlocked)
	self:setUnlockComponentByList(msg.unlockedComponents)
	self:setHasGotRewardComponentByList(msg.gainRewardComponents)

	local productionNum = msg.productionInfo.productionMaterial.quantity
	local nextRecoverTime = msg.productionInfo.nextRecoverTime

	self:setProductionInfo(productionNum, nextRecoverTime)
	self:setMissionInfoByList(msg.missionInfos)
	self:setInProgressMissionGroup(msg.inProgressSideMissionGroupId)
	self:setSideMissionUnlockTime(msg.sideMissionUnlockTime)
	Activity157Controller.instance:dispatchEvent(Activity157Event.Act157UpdateInfo)
end

function Activity157Model:setIsUnlockEntrance(serverIsUnlock, notDispatchEvent)
	self._isUnlockEntrance = serverIsUnlock

	if notDispatchEvent then
		return
	end

	Activity157Controller.instance:dispatchEvent(Activity157Event.Act157RefreshEntrance)
end

function Activity157Model:setIsSideMissionUnlocked(serverIsUnlock, notDispatchEvent)
	self._isSideMissionUnlocked = serverIsUnlock

	if notDispatchEvent then
		return
	end

	Activity157Controller.instance:dispatchEvent(Activity157Event.Act157RefreshSideMission)
end

function Activity157Model:setUnlockComponentByList(serverUnlockedComponents, notDispatchEvent)
	self._unlockComponentDict = {}

	if serverUnlockedComponents then
		for _, componentId in ipairs(serverUnlockedComponents) do
			self:setComponentUnlock(componentId, true)
		end
	end

	if notDispatchEvent then
		return
	end

	Activity157Controller.instance:dispatchEvent(Activity157Event.Act157RepairComponent)
end

function Activity157Model:setComponentUnlock(componentId, notDispatchEvent)
	self._unlockComponentDict = self._unlockComponentDict or {}

	if not componentId then
		return
	end

	self._unlockComponentDict[componentId] = true

	if notDispatchEvent then
		return
	end

	Activity157Controller.instance:dispatchEvent(Activity157Event.Act157RepairComponent, componentId)
end

function Activity157Model:setHasGotRewardComponentByList(gainRewardComponents, notDispatchEvent)
	self._hasGotRewardComponentDict = {}

	if gainRewardComponents then
		for _, componentId in ipairs(gainRewardComponents) do
			self:addHasGotRewardComponent(componentId, true)
		end
	end

	if notDispatchEvent then
		return
	end

	Activity157Controller.instance:dispatchEvent(Activity157Event.Act157GetComponentReward)
end

function Activity157Model:addHasGotRewardComponent(componentId, notDispatchEvent)
	self._hasGotRewardComponentDict = self._hasGotRewardComponentDict or {}

	if not componentId then
		return
	end

	self._hasGotRewardComponentDict[componentId] = true

	if notDispatchEvent then
		return
	end

	Activity157Controller.instance:dispatchEvent(Activity157Event.Act157GetComponentReward)
end

function Activity157Model:setProductionInfo(productionNum, nextRecoverTime, notDispatchEvent)
	self._productionNum = productionNum
	self._nextRecoverTime = nextRecoverTime

	if notDispatchEvent then
		return
	end

	Activity157Controller.instance:dispatchEvent(Activity157Event.Act157RefreshFactoryProduction)
end

function Activity157Model:setMissionInfoByList(serverMissionInfos, notDispatchEvent)
	self._missionGroupId2FinishMissions = {}

	if not serverMissionInfos then
		return
	end

	for _, missionInfo in ipairs(serverMissionInfos) do
		local missionGroupId = missionInfo.missionGroup

		for _, finishMissionId in ipairs(missionInfo.finishedMissionIds) do
			self:addFinishedMission(finishMissionId, missionGroupId, true)
		end
	end

	if notDispatchEvent then
		return
	end

	Activity157Controller.instance:dispatchEvent(Activity157Event.Act157FinishMission)
end

function Activity157Model:setInProgressMissionGroup(missionGroupId, notDispatchEvent)
	self._inProcessMissionGroup = missionGroupId

	if notDispatchEvent then
		return
	end

	Activity157Controller.instance:dispatchEvent(Activity157Event.Act157ChangeInProgressMissionGroup)
end

function Activity157Model:addFinishedMission(missionId, argsMissionGroupId, notDispatchEvent)
	self._missionGroupId2FinishMissions = self._missionGroupId2FinishMissions or {}

	if not missionId then
		return
	end

	local actId = self:getActId()

	if not argsMissionGroupId then
		::label_13_0::

		local missionGroupId = Activity157Config.instance:getMissionGroup(actId, missionId)

		if not missionGroupId then
			return
		end

		local finishMissionDict = self._missionGroupId2FinishMissions[missionGroupId]

		if not finishMissionDict then
			finishMissionDict = {}
			self._missionGroupId2FinishMissions[missionGroupId] = finishMissionDict
		end

		finishMissionDict[missionId] = true

		if notDispatchEvent then
			return
		end

		Activity157Controller.instance:dispatchEvent(Activity157Event.Act157FinishMission)
	end
end

function Activity157Model:setSideMissionUnlockTime(unlockTime)
	self._sideMissionUnlockTime = unlockTime
end

function Activity157Model:getActId()
	return VersionActivity1_8Enum.ActivityId.DungeonReturnToWork
end

function Activity157Model:getIsUnlockEntrance()
	return self._isUnlockEntrance
end

function Activity157Model:getIsSideMissionUnlocked()
	return self._isSideMissionUnlocked
end

function Activity157Model:getIsUnlockFactoryBlueprint()
	local actId = self:getActId()
	local result = false
	local isRepaired = self:getIsFirstComponentRepair()

	if isRepaired then
		result = true
	else
		local firstComponentId = Activity157Config.instance:getAct157Const(actId, Activity157Enum.ConstId.FirstFactoryComponent)

		result = self:isCanRepairComponent(firstComponentId)
	end

	return result
end

function Activity157Model:getIsNeedPlayMissionUnlockAnim(missionId)
	local result = false

	if not missionId then
		return result
	end

	local actId = self:getActId()
	local isSideMission = Activity157Config.instance:isSideMission(actId, missionId)
	local isRoot = Activity157Config.instance:isRootMission(actId, missionId)

	if not isRoot or isRoot and isSideMission then
		local isUnlockMission = self:getIsUnlockMission(missionId)

		if isUnlockMission then
			local prefsKey = VersionActivity1_8DungeonEnum.PlayerPrefsKey.IsPlayedMissionNodeUnlocked .. missionId

			result = not self:getHasPlayedAnim(prefsKey)
		end
	end

	return result
end

function Activity157Model:getHasPlayedAnim(prefsKey)
	self._hasPlayedAnimDict = self._hasPlayedAnimDict or {}

	if not prefsKey then
		return
	end

	self._hasPlayedAnimDict[prefsKey] = self._hasPlayedAnimDict[prefsKey] or VersionActivity1_8DungeonController.instance:getPlayerPrefs(prefsKey, NOT_PLAYED_ANIM_VALUE)

	return self._hasPlayedAnimDict[prefsKey] ~= NOT_PLAYED_ANIM_VALUE
end

function Activity157Model:setHasPlayedAnim(prefsKey)
	if not prefsKey then
		return
	end

	self._hasPlayedAnimDict[prefsKey] = PLAYED_ANIM_VALUE

	VersionActivity1_8DungeonController.instance:savePlayerPrefs(prefsKey, self._hasPlayedAnimDict[prefsKey])
end

function Activity157Model:getFactoryProductionNum()
	return self._productionNum or 0
end

function Activity157Model:getFactoryNextRecoverCountdown()
	local result = ""

	if self._nextRecoverTime and self._nextRecoverTime ~= 0 then
		local curRecoverSec = math.max(self._nextRecoverTime / 1000 - ServerTime.now(), 0)

		result = TimeUtil.second2TimeString(curRecoverSec, true)
	end

	return result
end

function Activity157Model:getSideMissionUnlockTime()
	local result = ""
	local isTimeEnd = true

	if self._sideMissionUnlockTime and self._sideMissionUnlockTime ~= 0 then
		local curRecoverSec = math.max(self._sideMissionUnlockTime / 1000 - ServerTime.now(), 0)

		result = TimeUtil.second2TimeString(curRecoverSec, true)
		isTimeEnd = curRecoverSec <= 0
	end

	return result, isTimeEnd
end

function Activity157Model:isRepairComponent(componentId)
	local numComponentId = tonumber(componentId)

	return (numComponentId and self._unlockComponentDict or nil) and (self._unlockComponentDict[numComponentId] or false)
end

function Activity157Model:getIsFirstComponentRepair()
	local actId = self:getActId()
	local firstComponentId = Activity157Config.instance:getAct157Const(actId, Activity157Enum.ConstId.FirstFactoryComponent)

	return (self:isRepairComponent(firstComponentId))
end

function Activity157Model:isCanRepairComponent(componentId)
	local result = false
	local actId = self:getActId()
	local isPreComponentRepaired = self:isPreComponentRepaired(componentId)

	if isPreComponentRepaired then
		local type, id, quantity = Activity157Config.instance:getComponentUnlockCondition(actId, componentId)
		local curQuantity = ItemModel.instance:getItemQuantity(type, id)

		if quantity then
			result = quantity <= curQuantity
		end
	end

	return result
end

function Activity157Model:isPreComponentRepaired(argsComponentId)
	local actId = self:getActId()
	local preComponentId = Activity157Config.instance:getPreComponentId(actId, argsComponentId)

	return (preComponentId and preComponentId ~= 0 or nil) and self:isRepairComponent(preComponentId)
end

function Activity157Model:getLastWillBeRepairedComponent()
	local result
	local actId = self:getActId()
	local componentIdList = Activity157Config.instance:getComponentIdList(actId)

	for _, componentId in ipairs(componentIdList) do
		local isRepaired = self:isRepairComponent(componentId)

		if not isRepaired then
			result = componentId

			break
		end
	end

	return result
end

function Activity157Model:getComponentRepairProgress()
	local result = 0
	local isUnlockFactoryBlueprint = self:getIsUnlockFactoryBlueprint()

	if isUnlockFactoryBlueprint then
		local actId = self:getActId()
		local repairCount = 0
		local componentIdList = Activity157Config.instance:getComponentIdList(actId)

		for _, componentId in ipairs(componentIdList) do
			local isRepaired = self:isRepairComponent(componentId)

			if isRepaired then
				repairCount = repairCount + 1
			end
		end

		result = repairCount / #componentIdList
	end

	return result
end

function Activity157Model:isAllComponentRepair()
	local repairProgress = self:getComponentRepairProgress()

	return repairProgress >= 1
end

function Activity157Model:hasComponentGotReward(componentId)
	return (componentId and self._hasGotRewardComponentDict or nil) and (self._hasGotRewardComponentDict[componentId] or false)
end

function Activity157Model:getLastHasGotRewardComponent()
	local result
	local actId = self:getActId()
	local componentIdList = Activity157Config.instance:getComponentIdList(actId)

	for _, componentId in ipairs(componentIdList) do
		local hasGotReward = self:hasComponentGotReward(componentId)

		if not hasGotReward then
			break
		end

		result = componentId
	end

	return result
end

function Activity157Model:getLastArchiveRewardComponent()
	local result
	local actId = self:getActId()
	local componentIdList = Activity157Config.instance:getComponentIdList(actId)

	for _, componentId in ipairs(componentIdList) do
		local isRepaired = self:isRepairComponent(componentId)

		if not isRepaired then
			break
		end

		local hasGotReward = self:hasComponentGotReward(componentId)

		if not hasGotReward then
			result = componentId
		end
	end

	return result
end

function Activity157Model:isFinishMission(missionGroupId, missionId)
	local result = false

	if missionGroupId and missionId then
		result = ((self._missionGroupId2FinishMissions or nil) and (self._missionGroupId2FinishMissions[missionGroupId] or {}))[missionId] or false
	end

	return result
end

function Activity157Model:isFinishAllMission(missionGroupId)
	local result = true
	local actId = self:getActId()
	local missionList = Activity157Config.instance:getAct157MissionList(actId, missionGroupId)

	for _, missionId in ipairs(missionList) do
		local isFinish = self:isFinishMission(missionGroupId, missionId)

		if not isFinish then
			result = false

			break
		end
	end

	return result
end

function Activity157Model:getAllActiveNodeGroupList()
	local result = {}
	local actId = self:getActId()
	local allMissionGroupIdList = Activity157Config.instance:getAllMissionGroupIdList(actId)
	local isRepairedFirstComponent = self:getIsFirstComponentRepair()

	for _, missionGroupId in ipairs(allMissionGroupIdList) do
		local isSideMissionGroup = Activity157Config.instance:isSideMissionGroup(actId, missionGroupId)

		if not isSideMissionGroup or isSideMissionGroup and isRepairedFirstComponent then
			result[#result + 1] = missionGroupId
		end
	end

	return result
end

function Activity157Model:getShowMissionIdList(missionGroupId)
	local result = {}
	local actId = self:getActId()
	local missionList = Activity157Config.instance:getAct157MissionList(actId, missionGroupId)
	local isSideMissionGroup = Activity157Config.instance:isSideMissionGroup(actId, missionGroupId)

	if not isSideMissionGroup then
		for _, missionId in ipairs(missionList) do
			local parentMissionId = Activity157Config.instance:getAct157ParentMissionId(actId, missionId)
			local isUnlockMission = self:getIsUnlockMission(missionId)

			if isUnlockMission or (parentMissionId or nil) and self:isFinishMission(missionGroupId, parentMissionId) then
				result[#result + 1] = missionId
			end
		end
	else
		for _, missionId in ipairs(missionList) do
			local isUnlockMission = self:getIsUnlockMission(missionId)
			local isRoot = Activity157Config.instance:isRootMission(actId, missionId)

			if isUnlockMission or isRoot then
				result[#result + 1] = missionId
			end
		end
	end

	return result
end

function Activity157Model:getMissionStatus(missionGroupId, missionId)
	local actId = self:getActId()
	local elementId = Activity157Config.instance:getMissionElementId(actId, missionId)

	if not elementId then
		logError(string.format("Activity157Model:getMissionStatus error, elementId is nil, actId:%s missionId:%s", actId, missionId))

		return Activity157Enum.MissionStatus.Locked
	end

	local isFinish = self:isFinishMission(missionGroupId, missionId)

	if isFinish then
		return Activity157Enum.MissionStatus.Finish
	end

	local elementData = DungeonMapModel.instance:getElementById(elementId)

	if not elementData then
		return Activity157Enum.MissionStatus.Locked
	end

	local isDispatchElement = DungeonConfig.instance:isDispatchElement(elementId)

	if isDispatchElement then
		local dispatchStatus = DispatchModel.instance:getDispatchStatus(elementId)

		if dispatchStatus == DispatchEnum.DispatchStatus.Finished then
			return Activity157Enum.MissionStatus.DispatchFinish
		elseif dispatchStatus == DispatchEnum.DispatchStatus.Dispatching then
			return Activity157Enum.MissionStatus.Dispatching
		end
	end

	return Activity157Enum.MissionStatus.Normal
end

function Activity157Model:getIsUnlockMission(missionId)
	local result = false
	local actId = self:getActId()
	local isSideMission = Activity157Config.instance:isSideMission(actId, missionId)
	local isUnlockedSideMission = self:getIsSideMissionUnlocked()

	if not isUnlockedSideMission and isSideMission then
		return result
	end

	local missionGroupId = Activity157Config.instance:getMissionGroup(actId, missionId)
	local isFinish = self:isFinishMission(missionGroupId, missionId)
	local elementId = Activity157Config.instance:getMissionElementId(actId, missionId)

	if elementId then
		::label_40_0::

		local elementData = DungeonMapModel.instance:getElementById(elementId)

		result = (isFinish or elementData) and true

		return (isFinish or elementData) and true
	end
end

function Activity157Model:getMissionUnlockToastId(missionId, elementId)
	local actId = self:getActId()
	local isSideMission = Activity157Config.instance:isSideMission(actId, missionId)

	if isSideMission then
		local isUnlockedSideMission = self:getIsSideMissionUnlocked()

		if not isUnlockedSideMission then
			return ToastEnum.V1a8Activity157NotUnlockSideMission
		end
	end

	if elementId then
		::label_41_0::

		local elementCo = DungeonConfig.instance:getChapterMapElement(elementId)
		local condition = elementCo and elementCo.condition

		if string.nilorempty(condition) then
			return
		end

		local _, strPreElementId = string.match(condition, "(ChapterMapElement=)(%d+)")
		local preElementId = strPreElementId and tonumber(strPreElementId)

		if preElementId then
			::label_41_1::

			local isFinishPreElement = DungeonMapModel.instance:elementIsFinished(preElementId)

			if preElementId and not isFinishPreElement then
				return ToastEnum.V1a8Activity157MissionLockedByPreMission
			end

			local _, shouldFinishEpisodeId = string.match(condition, "(EpisodeFinish=)(%d+)")

			shouldFinishEpisodeId = tonumber(shouldFinishEpisodeId)

			if shouldFinishEpisodeId then
				::label_41_2::

				local isFinishEpisode = DungeonModel.instance:hasPassLevelAndStory(shouldFinishEpisodeId)

				if shouldFinishEpisodeId and not isFinishEpisode then
					return ToastEnum.V1a8Activity157MissionLockedByStory
				end

				local _, showRepairComponentId = string.match(condition, "(Act157ComponentUnlock=)(%d+)")
				local isRepair = showRepairComponentId and self:isRepairComponent(showRepairComponentId)

				if showRepairComponentId and not isRepair then
					return ToastEnum.V1a8Activity157NotRepairComponent
				end

				return ToastEnum.ConditionLock
			end
		end
	end
end

function Activity157Model:getInProgressMissionGroup()
	return self._inProcessMissionGroup
end

function Activity157Model:isInProgressOtherMissionGroup(missionGroupId)
	local inProgressMissionGroup = self:getInProgressMissionGroup()

	return (inProgressMissionGroup and inProgressMissionGroup ~= 0 or nil) and inProgressMissionGroup ~= missionGroupId
end

function Activity157Model:isInProgressOtherMissionGroupByElementId(elementId)
	local result = false
	local actId = self:getActId()
	local act157MissionId = Activity157Config.instance:getMissionIdByElementId(actId, elementId)

	if act157MissionId then
		local act157MissionGroupId = Activity157Config.instance:getMissionGroup(actId, act157MissionId)

		result = self:isInProgressOtherMissionGroup(act157MissionGroupId)
	end

	return result
end

Activity157Model.instance = Activity157Model.New()

return Activity157Model
