-- chunkname: @modules/logic/act236/controller/Act236Controller.lua

module("modules.logic.act236.controller.Act236Controller", package.seeall)

local Act236Controller = class("Act236Controller", BaseController)

function Act236Controller:onInit()
	return
end

function Act236Controller:onInitFinish()
	return
end

function Act236Controller:addConstEvents()
	return
end

function Act236Controller:reInit()
	return
end

function Act236Controller:gainReward(actId, showToast, rewardIdList)
	if not ActivityModel.instance:isActOnLine(actId) then
		if showToast then
			GameFacade.showToast(ToastEnum.ActivityNotOpen)
		end

		return
	end

	Act236Rpc.instance:sendAct236GetAutoGainRewardRequest(actId, rewardIdList)
end

function Act236Controller:getActInfo(actId, callback, callbackObj)
	Act236Rpc.instance:sendGetAct236InfoRequest(actId, callback, callbackObj)
end

function Act236Controller:openMainView(actId)
	self._tempActId = actId

	self.getActInfo(self, actId, self.realOpenMainView, self)
end

function Act236Controller:realOpenMainView()
	local param = {}

	param.actId = self._tempActId

	ViewMgr.instance:openView(ViewName.Act236MainView, param)
end

Act236Controller.instance = Act236Controller.New()

return Act236Controller
