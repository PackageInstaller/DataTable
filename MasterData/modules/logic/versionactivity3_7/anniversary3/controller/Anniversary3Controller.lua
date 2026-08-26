-- chunkname: @modules/logic/versionactivity3_7/anniversary3/controller/Anniversary3Controller.lua

module("modules.logic.versionactivity3_7.anniversary3.controller.Anniversary3Controller", package.seeall)

local Anniversary3Controller = class("Anniversary3Controller", BaseController)

function Anniversary3Controller:onInit()
	return
end

function Anniversary3Controller:reInit()
	return
end

function Anniversary3Controller:onInitFinish()
	return
end

function Anniversary3Controller:addConstEvents()
	return
end

function Anniversary3Controller:openAnniversary3MainView()
	ViewMgr.instance:openView(ViewName.Anniversary3MainView)
end

function Anniversary3Controller:openAnniversary3MailView()
	ViewMgr.instance:openView(ViewName.Anniversary3MailView)
end

function Anniversary3Controller:openAnniversary3SignView()
	local actId = VersionActivity3_7Enum.ActivityId.Anniversary3Sign

	if ActivityType101Model.instance:isOpen(actId) then
		Activity101Rpc.instance:sendGet101InfosRequest(actId, self._onReceiveGet101InfosReply, self)
	end
end

function Anniversary3Controller:_onReceiveGet101InfosReply(_, resultCode)
	if resultCode ~= 0 then
		return
	end

	ViewMgr.instance:openView(ViewName.Anniversary3SignView)
end

function Anniversary3Controller:openAnniversary3SignRoleTalkView(param)
	ViewMgr.instance:openView(ViewName.Anniversary3SignRoleTalkView, param)
end

function Anniversary3Controller:openAnniversary3ActBpView()
	ViewMgr.instance:openView(ViewName.Anniversary3ActBpView)
end

function Anniversary3Controller:openGuessGameMainView()
	ViewMgr.instance:openView(ViewName.GuessGameMainView)
end

Anniversary3Controller.instance = Anniversary3Controller.New()

return Anniversary3Controller
