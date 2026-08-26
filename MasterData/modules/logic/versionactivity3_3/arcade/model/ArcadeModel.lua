-- chunkname: @modules/logic/versionactivity3_3/arcade/model/ArcadeModel.lua

module("modules.logic.versionactivity3_3.arcade.model.ArcadeModel", package.seeall)

local ArcadeModel = class("ArcadeModel", BaseModel)

function ArcadeModel:onInit()
	return
end

function ArcadeModel:reInit()
	return
end

function ArcadeModel:getAct222Id()
	return VersionActivity3_7Enum.ActivityId.ArcadeV3a7
end

function ArcadeModel:isAct222Open(isToast)
	local actId = self:getAct222Id()
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

ArcadeModel.instance = ArcadeModel.New()

return ArcadeModel
