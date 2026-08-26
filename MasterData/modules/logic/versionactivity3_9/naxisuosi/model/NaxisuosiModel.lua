-- chunkname: @modules/logic/versionactivity3_9/naxisuosi/model/NaxisuosiModel.lua

module("modules.logic.versionactivity3_9.naxisuosi.model.NaxisuosiModel", package.seeall)

local NaxisuosiModel = class("NaxisuosiModel", BaseModel)

function NaxisuosiModel:onInit()
	return
end

function NaxisuosiModel:reInit()
	return
end

function NaxisuosiModel:getActId()
	return VersionActivity3_9Enum.ActivityId.Naxisuosi
end

function NaxisuosiModel:isActOpen(isToast)
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

NaxisuosiModel.instance = NaxisuosiModel.New()

return NaxisuosiModel
