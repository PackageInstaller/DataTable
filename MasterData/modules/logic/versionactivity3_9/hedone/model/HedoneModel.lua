-- chunkname: @modules/logic/versionactivity3_9/hedone/model/HedoneModel.lua

module("modules.logic.versionactivity3_9.hedone.model.HedoneModel", package.seeall)

local HedoneModel = class("HedoneModel", BaseModel)

function HedoneModel:onInit()
	return
end

function HedoneModel:reInit()
	return
end

function HedoneModel:getActId()
	return VersionActivity3_9Enum.ActivityId.Hedone
end

function HedoneModel:isActOpen(isToast)
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

HedoneModel.instance = HedoneModel.New()

return HedoneModel
