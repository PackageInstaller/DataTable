-- chunkname: @modules/logic/versionactivity3_5/lamona/model/LamonaModel.lua

module("modules.logic.versionactivity3_5.lamona.model.LamonaModel", package.seeall)

local LamonaModel = class("LamonaModel", BaseModel)

function LamonaModel:onInit()
	return
end

function LamonaModel:reInit()
	return
end

function LamonaModel:getActId()
	return VersionActivity3_5Enum.ActivityId.Lamona
end

function LamonaModel:isActOpen(isToast)
	local actId = self:getActId()
	local status, toastId, toastParam
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]

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

LamonaModel.instance = LamonaModel.New()

return LamonaModel
