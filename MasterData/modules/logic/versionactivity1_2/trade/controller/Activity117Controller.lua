-- chunkname: @modules/logic/versionactivity1_2/trade/controller/Activity117Controller.lua

module("modules.logic.versionactivity1_2.trade.controller.Activity117Controller", package.seeall)

local Activity117Controller = class("Activity117Controller", BaseController)

function Activity117Controller:onInit()
	return
end

function Activity117Controller:reInit()
	return
end

function Activity117Controller:openView(actId, tabId)
	local status, toastId, toastParamList = ActivityHelper.getActivityStatusAndToast(actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		if toastId then
			GameFacade.showToastWithTableParam(toastId, toastParamList)
		end

		return
	end

	self:initAct(actId)

	local param = {
		actId = actId,
		tabIndex = tabId
	}

	self:openTradeBargainView(param)
end

function Activity117Controller:initAct(actId)
	Activity117Model.instance:initAct(actId)
	Activity117Rpc.instance:sendAct117InfoRequest(actId)
end

function Activity117Controller:openTradeBargainView(param)
	ViewMgr.instance:openView(ViewName.ActivityTradeBargain, param)
end

function Activity117Controller:openTradeSuccessView(param)
	ViewMgr.instance:openView(ViewName.ActivityTradeSuccessView, param)
end

Activity117Controller.instance = Activity117Controller.New()

LuaEventSystem.addEventMechanism(Activity117Controller.instance)

return Activity117Controller
