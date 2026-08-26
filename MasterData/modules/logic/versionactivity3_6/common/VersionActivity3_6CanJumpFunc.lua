-- chunkname: @modules/logic/versionactivity3_6/common/VersionActivity3_6CanJumpFunc.lua

module("modules.logic.versionactivity3_6.common.VersionActivity3_6CanJumpFunc", package.seeall)

local VersionActivity3_6CanJumpFunc = class("VersionActivity3_6CanJumpFunc")

function VersionActivity3_6CanJumpFunc:canJumpTo13604(jumpParamArray)
	local status, toastId, toastParamList = ActivityHelper.getActivityStatusAndToast(VersionActivity3_6Enum.ActivityId.EnterView)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		return false, toastId, toastParamList
	end

	local actId = VersionActivity3_6Enum.ActivityId.Dungeon
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

function VersionActivity3_6CanJumpFunc:canJumpTo13608(jumpParamArray)
	local status, toastId, toastParamList = ActivityHelper.getActivityStatusAndToast(VersionActivity3_6Enum.ActivityId.EnterView)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		return false, toastId, toastParamList
	end

	local actId = VersionActivity3_6Enum.ActivityId.YaMi
	local actStatus, actToastId, actToastParamList = ActivityHelper.getActivityStatusAndToast(actId)

	if actStatus ~= ActivityEnum.ActivityStatus.Normal then
		local actCo = ActivityConfig.instance:getActivityCo(actId)

		if actCo and not string.nilorempty(actCo.joinCondition) then
			local episodeId = string.gsub(actCo.joinCondition, "EpisodeFinish=", "")

			if episodeId then
				episodeId = tonumber(episodeId)

				if episodeId and not DungeonModel.instance:hasPassLevel(episodeId) then
					local episodeCfg = DungeonConfig.instance:getEpisodeCO(episodeId)
					local name = string.format("%s %s", DungeonController.getEpisodeName(episodeCfg), episodeCfg.name)

					return false, ToastEnum.PassDungeonUnlock, {
						name
					}
				end
			end
		end

		return false, actToastId, actToastParamList
	end

	return true, JumpController.DefaultToastId, JumpController.DefaultToastParam
end

return VersionActivity3_6CanJumpFunc
