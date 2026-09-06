-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/StarGodPlusExchange/agent/StarGodPlusExchangeAgent.lua

module("logic.extensions.stargodplusexchange.agent.StarGodPlusExchangeAgent", package.seeall)

local StarGodPlusExchangeAgent = class("StarGodPlusExchangeAgent", BaseAgent)

function StarGodPlusExchangeAgent:sendPM_StarGodPlusExchangeInfoReq()
	local req = StarGodPlusExchangeExtension_pb.PM_StarGodPlusExchangeInfoReq()

	self:sendMsg(req)
end

function StarGodPlusExchangeAgent:handlePM_StarGodPlusExchangeInfoRes(status, msg)
	if status == 0 then
		local cd = msg.cd
		local times = msg.times

		StarGodPlusExchangModel.instance:setCD(cd)
		StarGodPlusExchangModel.instance:setTimes(times)
		GlobalDispatcher:dispatch(GlobalNotify.StarGodPlusExchangeInfo)
	end
end

function StarGodPlusExchangeAgent:sendPM_StarGodPlusExchangeReq(costIds)
	local req = StarGodPlusExchangeExtension_pb.PM_StarGodPlusExchangeReq()

	for k, v in pairs(costIds) do
		req.costIds:append(v)
	end

	self:sendMsg(req)
end

function StarGodPlusExchangeAgent:handlePM_StarGodPlusExchangeRes(status, msg)
	if status == 0 then
		local times = StarGodPlusExchangModel.instance:getTimes()

		StarGodPlusExchangModel.instance:setTimes(times + 1)

		local day = checknumber(StarGodPlusExchangeConfig.instance:getCommonCfg("CD"))
		local newCd = ServerTime.now() * 1000 + day * 1000 * 60 * 60 * 24

		StarGodPlusExchangModel.instance:setCD(newCd)
		GlobalDispatcher:dispatch(GlobalNotify.StarGodPlusExchangeBuy)
	end
end

StarGodPlusExchangeAgent.instance = StarGodPlusExchangeAgent.New()

return StarGodPlusExchangeAgent
