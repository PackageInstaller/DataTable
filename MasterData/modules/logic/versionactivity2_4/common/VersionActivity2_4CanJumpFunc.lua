-- chunkname: @modules/logic/versionactivity2_4/common/VersionActivity2_4CanJumpFunc.lua

module("modules.logic.versionactivity2_4.common.VersionActivity2_4CanJumpFunc", package.seeall)

local VersionActivity2_4CanJumpFunc = class("VersionActivity2_4CanJumpFunc")

function VersionActivity2_4CanJumpFunc:canJumpTo12402(jumpParamArray)
	local status, toastId, toastParamList = ActivityHelper.getActivityStatusAndToast(VersionActivity2_4Enum.ActivityId.EnterView)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		return false, toastId, toastParamList
	end

	local actId = VersionActivity2_4Enum.ActivityId.Dungeon
	local actStatus, actToastId, actToastParamList = ActivityHelper.getActivityStatusAndToast(actId)

	if actStatus ~= ActivityEnum.ActivityStatus.Normal then
		return false, actToastId, actToastParamList
	end

	local episodeId = jumpParamArray[3]

	if episodeId then
		local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)

		if not episodeCo then
			logError("not found episode : " .. episodeId)

			return false, ToastEnum.EpisodeNotExist, JumpController.DefaultToastParam
		end

		local activityDungeonConfig = ActivityConfig.instance:getActivityDungeonConfig(actId)

		if activityDungeonConfig and activityDungeonConfig.hardChapterId and episodeCo.chapterId == activityDungeonConfig.hardChapterId and not VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(actId) then
			return false, ToastEnum.ActivityHardDugeonLockedWithOpenTime, JumpController.DefaultToastParam
		end

		local episodeInfo = DungeonModel.instance:getEpisodeInfo(episodeId)

		if not episodeInfo then
			return false, ToastEnum.WarmUpGotoOrder, JumpController.DefaultToastParam
		end
	end

	return true, JumpController.DefaultToastId, JumpController.DefaultToastParam
end

function VersionActivity2_4CanJumpFunc:canJumpTo11804(jumpParamArray)
	local status, toastId, toastParamList = ActivityHelper.getActivityStatusAndToast(VersionActivity2_4Enum.ActivityId.EnterView)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		return false, toastId, toastParamList
	end

	local actId = VersionActivity2_4Enum.ActivityId.Reactivity
	local actStatus, actToastId, actToastParamList = ActivityHelper.getActivityStatusAndToast(actId)

	if actStatus ~= ActivityEnum.ActivityStatus.Normal then
		return false, actToastId, actToastParamList
	end

	local episodeId = jumpParamArray[3]

	if episodeId then
		local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)

		if not episodeCo then
			logError("not found episode : " .. episodeId)

			return false, ToastEnum.EpisodeNotExist, JumpController.DefaultToastParam
		end

		local activityDungeonConfig = ActivityConfig.instance:getActivityDungeonConfig(actId)

		if activityDungeonConfig and activityDungeonConfig.hardChapterId and episodeCo.chapterId == activityDungeonConfig.hardChapterId and not VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(actId) then
			return false, ToastEnum.ActivityHardDugeonLockedWithOpenTime, JumpController.DefaultToastParam
		end

		local episodeInfo = DungeonModel.instance:getEpisodeInfo(episodeId)

		if not episodeInfo then
			return false, ToastEnum.WarmUpGotoOrder, JumpController.DefaultToastParam
		end

		local elementIdList
		local listStr = episodeCo.elementList

		if not string.nilorempty(listStr) then
			elementIdList = string.splitToNumber(listStr, "#")
		end

		if elementIdList then
			for _, elementId in ipairs(elementIdList) do
				if not DungeonMapModel.instance:elementIsFinished(elementId) then
					return false, ToastEnum.WarmUpGotoOrder, JumpController.DefaultToastParam
				end
			end
		end
	end

	return true, JumpController.DefaultToastId, JumpController.DefaultToastParam
end

function VersionActivity2_4CanJumpFunc:canJumpTo11815(jumpParamArray)
	local status, toastId, toastParamList = ActivityHelper.getActivityStatusAndToast(VersionActivity1_8Enum.ActivityId.DungeonReturnToWork)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		return false, toastId, toastParamList
	end

	local isOpenFactoryBlueprint = jumpParamArray and jumpParamArray[3] == 2
	local isAct157UnlockEntrance = Activity157Model.instance:getIsUnlockEntrance()

	if not isAct157UnlockEntrance then
		return false, ToastEnum.V1a8Activity157NotUnlock
	end

	if isOpenFactoryBlueprint then
		local isUnlockFactoryBlueprint = Activity157Model.instance:getIsUnlockFactoryBlueprint()

		if not isUnlockFactoryBlueprint then
			return false, ToastEnum.V1a8Activity157LockedFactoryEntrance
		end
	end

	return true, JumpController.DefaultToastId, JumpController.DefaultToastParam
end

return VersionActivity2_4CanJumpFunc
