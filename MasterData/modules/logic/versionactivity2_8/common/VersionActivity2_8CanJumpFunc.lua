-- chunkname: @modules/logic/versionactivity2_8/common/VersionActivity2_8CanJumpFunc.lua

module("modules.logic.versionactivity2_8.common.VersionActivity2_8CanJumpFunc", package.seeall)

local VersionActivity2_8CanJumpFunc = class("VersionActivity2_8CanJumpFunc")

function VersionActivity2_8CanJumpFunc:canJumpTo12810(jumpParamArray)
	local status, toastId, toastParamList = ActivityHelper.getActivityStatusAndToast(VersionActivity2_8Enum.ActivityId.EnterView)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		return false, toastId, toastParamList
	end

	local actId = VersionActivity2_8Enum.ActivityId.NuoDiKa
	local actStatus, actToastId, actToastParamList = ActivityHelper.getActivityStatusAndToast(actId)

	if actStatus ~= ActivityEnum.ActivityStatus.Normal then
		return false, actToastId, actToastParamList
	end

	local episodeId = jumpParamArray[3]

	if episodeId then
		local episodeCo = NuoDiKaConfig.instance:getEpisodeCo(actId, episodeId)

		if not episodeCo then
			return false, ToastEnum.EpisodeNotExist, JumpController.DefaultToastParam
		end

		if episodeId ~= 0 and episodeCo.preEpisode and episodeCo.preEpisode ~= 0 and not NuoDiKaModel.instance:isEpisodePass(episodeCo.preEpisode) then
			return false, ToastEnum.Act194EpisodeLock, JumpController.DefaultToastParam
		end
	end

	return true, JumpController.DefaultToastId, JumpController.DefaultToastParam
end

function VersionActivity2_8CanJumpFunc:canJumpTo12811(jumpParamArray)
	local status, toastId, toastParamList = ActivityHelper.getActivityStatusAndToast(VersionActivity2_8Enum.ActivityId.EnterView)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		return false, toastId, toastParamList
	end

	local actId = VersionActivity2_8Enum.ActivityId.MoLiDeEr
	local actStatus, actToastId, actToastParamList = ActivityHelper.getActivityStatusAndToast(actId)

	if actStatus ~= ActivityEnum.ActivityStatus.Normal then
		return false, actToastId, actToastParamList
	end

	local episodeId = jumpParamArray[3]

	if episodeId then
		local episodeCo = MoLiDeErConfig.instance:getEpisodeConfig(actId, episodeId)

		if not episodeCo then
			logError("not found episode : " .. episodeId)

			return false, ToastEnum.EpisodeNotExist, JumpController.DefaultToastParam
		end

		if episodeId ~= 0 and episodeCo.preEpisodeId and episodeCo.preEpisodeId ~= 0 and not MoLiDeErModel.instance:isEpisodeFinish(actId, episodeCo.preEpisodeId) then
			return false, ToastEnum.Act194EpisodeLock, JumpController.DefaultToastParam
		end
	end

	return true, JumpController.DefaultToastId, JumpController.DefaultToastParam
end

return VersionActivity2_8CanJumpFunc
