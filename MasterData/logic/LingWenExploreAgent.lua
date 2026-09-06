-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripeexplore/agent/LingWenExploreAgent.lua

module("logic.extensions.lingwenexplore.agent.LingWenExploreAgent", package.seeall)

local LingWenExploreAgent = class("LingWenExploreAgent", BaseAgent)

function LingWenExploreAgent:sendPM_LWExploreGetInfoReq()
	local req = LingWenExploreExtension_pb.PM_LWExploreGetInfoReq()

	self:sendMsg(req)
end

function LingWenExploreAgent:handlePM_LWExploreGetInfoRes(status, msg)
	if status == 0 then
		HolyStripeExploreController.instance:handleGetInfo(msg)
	end
end

function LingWenExploreAgent:sendPM_LWExploreStartGameReq(clientKey)
	local req = LingWenExploreExtension_pb.PM_LWExploreStartGameReq()

	req.clientKey = clientKey

	self:sendMsg(req)
end

function LingWenExploreAgent:handlePM_LWExploreStartGameRes(status, msg)
	if status == 0 then
		HolyStripeExploreController.instance:handleStartGame(msg)
	end
end

function LingWenExploreAgent:sendPM_LWExploreEndGameReq(step, encryptedKey)
	local req = LingWenExploreExtension_pb.PM_LWExploreEndGameReq()

	req.step = step
	req.encryptedKey = encryptedKey

	self:sendMsg(req)
end

function LingWenExploreAgent:handlePM_LWExploreEndGameRes(status, msg)
	if status == 0 then
		HolyStripeExploreController.instance:handleGameMove(msg)
	end
end

function LingWenExploreAgent:sendPM_LWExploreBuyCountReq()
	local req = LingWenExploreExtension_pb.PM_LWExploreBuyCountReq()

	self:sendMsg(req)
end

function LingWenExploreAgent:handlePM_LWExploreBuyCountRes(status, msg)
	if status == 0 then
		HolyStripeExploreController.instance:handleBuyGameTime(msg)
	end
end

function LingWenExploreAgent:handlePM_LWExploreNotifyExplore(status, msg)
	if status == 0 then
		HolyStripeExploreController.instance:handleNotifyExplore(msg)
	end
end

function LingWenExploreAgent:sendPM_LWExploreOneKeyReq()
	local req = LingWenExploreExtension_pb.PM_LWExploreOneKeyReq()

	self:sendMsg(req)
end

function LingWenExploreAgent:handlePM_LWExploreOneKeyRes(status, msg)
	if status == 0 then
		HolyStripeExploreController.instance:handlePM_LWExploreOneKeyRes(msg)
	end
end

LingWenExploreAgent.instance = LingWenExploreAgent.New()

return LingWenExploreAgent
