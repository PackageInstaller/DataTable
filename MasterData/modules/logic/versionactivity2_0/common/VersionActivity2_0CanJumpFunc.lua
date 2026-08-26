-- chunkname: @modules/logic/versionactivity2_0/common/VersionActivity2_0CanJumpFunc.lua

module("modules.logic.versionactivity2_0.common.VersionActivity2_0CanJumpFunc", package.seeall)

local VersionActivity2_0CanJumpFunc = class("VersionActivity2_0CanJumpFunc")

function VersionActivity2_0CanJumpFunc:canJumpTo12003(jumpParamArray)
	local status, toastId, toastParamList = ActivityHelper.getActivityStatusAndToast(VersionActivity2_0Enum.ActivityId.EnterView)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		return false, toastId, toastParamList
	end

	local actId = VersionActivity2_0Enum.ActivityId.Dungeon
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

function VersionActivity2_0CanJumpFunc:canJumpTo12005(jumpParamArray)
	local status, toastId, toastParamList = ActivityHelper.getActivityStatusAndToast(VersionActivity2_0Enum.ActivityId.DungeonGraffiti)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		return false, toastId, toastParamList
	end

	local isAct161UnlockEntrance = VersionActivity2_0DungeonModel.instance:getGraffitiEntranceUnlockState()

	if not isAct161UnlockEntrance then
		return false, ToastEnum.GraffitiLock
	end

	return true, JumpController.DefaultToastId, JumpController.DefaultToastParam
end

return VersionActivity2_0CanJumpFunc
