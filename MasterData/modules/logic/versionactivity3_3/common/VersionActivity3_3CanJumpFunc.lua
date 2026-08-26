-- chunkname: @modules/logic/versionactivity3_3/common/VersionActivity3_3CanJumpFunc.lua

module("modules.logic.versionactivity3_3.common.VersionActivity3_3CanJumpFunc", package.seeall)

local VersionActivity3_3CanJumpFunc = class("VersionActivity3_3CanJumpFunc")

function VersionActivity3_3CanJumpFunc:canJumpTo13306(jumpParamArray)
	local status, toastId, toastParamList = ActivityHelper.getActivityStatusAndToast(VersionActivity3_3Enum.ActivityId.EnterView)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		return false, toastId, toastParamList
	end

	local actId = VersionActivity3_3Enum.ActivityId.Dungeon
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

function VersionActivity3_3CanJumpFunc:canJumpTo13309(jumpParamArray)
	local status, toastId, toastParamList = ActivityHelper.getActivityStatusAndToast(VersionActivity3_3Enum.ActivityId.Arcade)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		return false, toastId, toastParamList
	end

	return true, JumpController.DefaultToastId, JumpController.DefaultToastParam
end

return VersionActivity3_3CanJumpFunc
