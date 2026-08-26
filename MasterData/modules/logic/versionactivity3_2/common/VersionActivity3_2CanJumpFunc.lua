-- chunkname: @modules/logic/versionactivity3_2/common/VersionActivity3_2CanJumpFunc.lua

module("modules.logic.versionactivity3_2.common.VersionActivity3_2CanJumpFunc", package.seeall)

local VersionActivity3_2CanJumpFunc = class("VersionActivity3_2CanJumpFunc")

function VersionActivity3_2CanJumpFunc:canJumpTo13223(jumpParamArray)
	local status, toastId, toastParamList = ActivityHelper.getActivityStatusAndToast(VersionActivity3_9Enum.ActivityId.EnterView)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		return false, toastId, toastParamList
	end

	local actId = VersionActivity3_2Enum.ActivityId.Dungeon
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

function VersionActivity3_2CanJumpFunc:canJumpTo13209(jumpParamArray)
	local versionEnum = VersionActivityFixedHelper.getVersionActivityEnum()
	local activityIdMap = versionEnum and versionEnum.ActivityId
	local enterViewId = activityIdMap and activityIdMap.EnterView
	local status, toastId, toastParamList = ActivityHelper.getActivityStatusAndToast(enterViewId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		return false, toastId, toastParamList
	end

	local actId = VersionActivity3_2Enum.ActivityId.Rouge2
	local actStatus, actToastId, actToastParamList = ActivityHelper.getActivityStatusAndToast(actId)

	if actStatus ~= ActivityEnum.ActivityStatus.Normal then
		return false, actToastId, actToastParamList
	end

	return true, JumpController.DefaultToastId, JumpController.DefaultToastParam
end

return VersionActivity3_2CanJumpFunc
