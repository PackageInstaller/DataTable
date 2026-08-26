-- chunkname: @modules/logic/autochess/act182/controller/Activity182Controller.lua

module("modules.logic.autochess.act182.controller.Activity182Controller", package.seeall)

local Activity182Controller = class("Activity182Controller", BaseController)

function Activity182Controller:addConstEvents()
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivity, self)
end

function Activity182Controller:getCrazyActId()
	for _, actId in pairs(Activity182Enum.CrazyActId) do
		if ActivityModel.instance:isActOnLine(actId) then
			return actId
		end
	end
end

function Activity182Controller:onRefreshActivity(actId)
	if actId then
		local mainActId = Activity182Model.instance:getCurActId()

		if not mainActId then
			return
		end

		local isCrazy = false

		for _, id in pairs(Activity182Enum.CrazyActId) do
			if actId == id then
				isCrazy = true

				break
			end
		end

		if isCrazy then
			if not ActivityModel.instance:isActOnLine(actId) and AutoChessModel.instance.actId == actId then
				GameFacade.showMessageBox(MessageBoxIdDefine.AutoChessCrazyEnd, MsgBoxEnum.BoxType.Yes, self.yesCallback, nil, nil, self)
			end

			Activity182Rpc.instance:sendGetAct182InfoRequest(mainActId)
		end
	end
end

function Activity182Controller:yesCallback()
	AutoChessModel.instance:clearData()
	ViewMgr.instance:closeView(ViewName.AutoChessForcePickView)
	ViewMgr.instance:closeView(ViewName.AutoChessMallView)
	ViewMgr.instance:closeView(ViewName.AutoChessGameView)
	AutoChessGameModel.instance:setUsingLeaderSkill(false, nil, true)
end

Activity182Controller.instance = Activity182Controller.New()

return Activity182Controller
