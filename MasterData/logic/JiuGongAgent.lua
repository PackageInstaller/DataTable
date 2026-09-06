-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/challenge/agent/JiuGongAgent.lua

module("logic.extensions.challenge.agent.JiuGongAgent", package.seeall)

local JiuGongAgent = class("JiuGongAgent", BaseAgent)

function JiuGongAgent:sendPM_JiuGongFairyStrengthReq()
	local req = JiuGongFairyStrengthExtension_pb.PM_JiuGongFairyStrengthReq()

	self:sendMsg(req)
end

function JiuGongAgent:handlePM_JiuGongFairyStrengthRes(status, msg)
	if status == 0 then
		local isstrengthing = msg.isStrengthing
		local prizeinfo = msg.prizeInfo

		JiuGongModel.instance:setPrizeInfos(prizeinfo, isstrengthing)
		JiuGongController.instance:localNotify("XiuLianInfoGot")
	end
end

function JiuGongAgent:sendPM_JiuGongFairyGainStrengthPrizeReq(prizeIndex, petId, equipStarGod)
	return
end

function JiuGongAgent:handlePM_JiuGongFairyGainStrengthPrizeRes(status, msg)
	if status == 0 then
		JiuGongModel.instance:setPrizeState(msg.prizeIndex + 1, msg.leftMillSec)
		JiuGongController.instance:localNotify("XiuLianInfoGot", "getprize")
	end
end

function JiuGongAgent:sendPM_JiuGongFairyOneKeyClearCdReq(prizeIndex)
	local req = JiuGongFairyStrengthExtension_pb.PM_JiuGongFairyOneKeyClearCdReq()

	req.prizeIndex = prizeIndex
	self._curIndex = prizeIndex

	self:sendMsg(req)
end

function JiuGongAgent:handlePM_JiuGongFairyOneKeyClearCdRes(status, msg)
	if status == 0 then
		JiuGongModel.instance:updateTime(msg.prizeIndex + 1, 0)
		JiuGongController.instance:localNotify("XiuLianInfoGot")
	end
end

JiuGongAgent.instance = JiuGongAgent.New()

return JiuGongAgent
