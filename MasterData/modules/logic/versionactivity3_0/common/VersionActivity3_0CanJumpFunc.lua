-- chunkname: @modules/logic/versionactivity3_0/common/VersionActivity3_0CanJumpFunc.lua

module("modules.logic.versionactivity3_0.common.VersionActivity3_0CanJumpFunc", package.seeall)

local VersionActivity3_0CanJumpFunc = class("VersionActivity3_0CanJumpFunc")

function VersionActivity3_0CanJumpFunc:canJumpTo12102(jumpParamArray)
	local status, toastId, toastParamList = ActivityHelper.getActivityStatusAndToast(VersionActivity3_0Enum.ActivityId.EnterView)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		return false, toastId, toastParamList
	end

	local actId = VersionActivity3_0Enum.ActivityId.Reactivity
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

function VersionActivity3_0CanJumpFunc:canJumpTo12104(jumpParamArray)
	local status, toastId, toastParamList = ActivityHelper.getActivityStatusAndToast(VersionActivity3_0Enum.ActivityId.StoryDeduction)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		return false, toastId, toastParamList
	end

	if not Activity165Model.instance:hasUnlockStory() then
		return false, ToastEnum.Act165StoryLock, JumpController.DefaultToastParam
	end

	return true, JumpController.DefaultToastId, JumpController.DefaultToastParam
end

return VersionActivity3_0CanJumpFunc
