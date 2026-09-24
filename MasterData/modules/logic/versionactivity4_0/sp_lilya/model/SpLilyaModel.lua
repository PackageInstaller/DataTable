-- chunkname: @modules/logic/versionactivity4_0/sp_lilya/model/SpLilyaModel.lua

module("modules.logic.versionactivity4_0.sp_lilya.model.SpLilyaModel", package.seeall)

local SpLilyaModel = class("SpLilyaModel", BaseModel)

function SpLilyaModel:onInit()
	return
end

function SpLilyaModel:reInit()
	return
end

function SpLilyaModel:getActId()
	return VersionActivity4_0Enum.ActivityId.SpLilya
end

function SpLilyaModel:isActOpen(isToast)
	local actId = self:getActId()
	local status, toastId, toastParam
	local actInfoMo = ActivityModel.instance:getActMO(actId)

	if actInfoMo then
		status, toastId, toastParam = ActivityHelper.getActivityStatusAndToast(actId)
	else
		toastId = ToastEnum.ActivityEnd
	end

	if isToast and toastId then
		GameFacade.showToast(toastId, toastParam)
	end

	return status == ActivityEnum.ActivityStatus.Normal
end

SpLilyaModel.instance = SpLilyaModel.New()

return SpLilyaModel
