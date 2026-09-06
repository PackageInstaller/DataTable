-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goldendten/controller/GoldendTenController.lua

module("logic.extensions.goldendten.controller.GoldendTenController", package.seeall)

local GoldendTenController = class("GoldendTenController", BaseController)

function GoldendTenController:ctor()
	return
end

function GoldendTenController:getInfo(activityId)
	GoldendTenAgent.instance:sendPM_GoldenTenGetInfoReq(activityId)
end

function GoldendTenController:handleGetInfo(msg)
	GoldendTenModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.GoldendTenUpdateInfo)
end

function GoldendTenController:becomeLeader(activityId, code)
	GoldendTenAgent.instance:sendPM_GoldenTenBecomeLeaderReq(activityId, code)
end

function GoldendTenController:handleBecomeLeader(msg)
	GoldendTenModel.instance:onBecomeLeader(msg)
	GlobalDispatcher:dispatch(GlobalNotify.GoldendTenBecomeSuc)
end

function GoldendTenController:becomeFollower(activityId, code)
	GoldendTenAgent.instance:sendPM_GoldenTenBecomeFollowerReq(activityId, code)
end

function GoldendTenController:handleBecomeMember()
	GlobalDispatcher:dispatch(GlobalNotify.GoldendTenBecomeSuc)
end

function GoldendTenController:gainPrize(activityId, prizeId, anotherPrize)
	GoldendTenAgent.instance:sendPM_GoldenTenGainPrizeReq(activityId, prizeId, anotherPrize)
end

function GoldendTenController:handleGainPrize(msg)
	GoldendTenModel.instance:onGainPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.GoldendTenUpdatePrizeInfo)
end

GoldendTenController.instance = GoldendTenController.New()

return GoldendTenController
