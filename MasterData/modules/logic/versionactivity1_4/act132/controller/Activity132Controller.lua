-- chunkname: @modules/logic/versionactivity1_4/act132/controller/Activity132Controller.lua

module("modules.logic.versionactivity1_4.act132.controller.Activity132Controller", package.seeall)

local Activity132Controller = class("Activity132Controller", BaseController)

function Activity132Controller:onInit()
	return
end

function Activity132Controller:reInit()
	return
end

function Activity132Controller:initAct(actId)
	Activity132Rpc.instance:sendGet132InfosRequest(actId)
end

function Activity132Controller:openCollectView(actId)
	Activity132Rpc.instance:sendGet132InfosRequest(actId, function()
		ViewMgr.instance:openView(ViewName.Activity132CollectView, {
			actId = actId
		})
	end)
end

Activity132Controller.instance = Activity132Controller.New()

return Activity132Controller
