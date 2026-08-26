-- chunkname: @modules/logic/guide/controller/action/impl/GuideActionShowToast.lua

module("modules.logic.guide.controller.action.impl.GuideActionShowToast", package.seeall)

local GuideActionShowToast = class("GuideActionShowToast", BaseGuideAction)

function GuideActionShowToast:ctor(guideId, stepId, actionParam)
	GuideActionShowToast.super.ctor(self, guideId, stepId, actionParam)

	self._toastId = tonumber(actionParam)
end

function GuideActionShowToast:onStart(context)
	GuideActionShowToast.super.onStart(self, context)

	if self._toastId then
		GameFacade.showToast(self._toastId)
	else
		logError("指引飘字失败，没配飘字id")
	end

	self:onDone(true)
end

return GuideActionShowToast
