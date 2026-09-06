-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luotiandajiao/agent/LuoTianDaJiaoAgent.lua

module("logic.extensions.luotiandajiao.agent.LuoTianDaJiaoAgent", package.seeall)

local LuoTianDaJiaoAgent = class("LuoTianDaJiaoAgent", BaseAgent)

function LuoTianDaJiaoAgent:onInit()
	self:setShowChangeSetFunc(GameUtil.handler(self.showChangeSet, self))
end

function LuoTianDaJiaoAgent:showChangeSet(changeSetId, msgName)
	if msgName == "handlePM_LuoTianDaJiaoAfterFightRes" then
		BattleSettlementModel.instance:setChangeSetId(changeSetId)
	else
		MaterialFacade.instance:popAndShowChangeSetItems(changeSetId)
	end
end

function LuoTianDaJiaoAgent:sendPM_LuoTianDaJiaoGetInfoReq(actId)
	local req = LuoTianDaJiaoExtension_pb.PM_LuoTianDaJiaoGetInfoReq()

	req.actId = actId

	self:sendMsg(req)
end

function LuoTianDaJiaoAgent:handlePM_LuoTianDaJiaoGetInfoRes(status, msg)
	if status == 0 then
		LTDaJiaoModel.instance:onLuoTianDaJiaoGetInfoRes(msg)

		local isSuccess = true

		GlobalDispatcher:dispatch(GlobalNotify.LuoTianDaJiaoGetInfoRes, isSuccess)
	else
		local isSuccess = false

		GlobalDispatcher:dispatch(GlobalNotify.LuoTianDaJiaoGetInfoRes, isSuccess)
	end
end

function LuoTianDaJiaoAgent:sendPM_LuoTianDaJiaoUpgradeReq(actId)
	local req = LuoTianDaJiaoExtension_pb.PM_LuoTianDaJiaoUpgradeReq()

	req.actId = actId

	self:sendMsg(req)
end

function LuoTianDaJiaoAgent:handlePM_LuoTianDaJiaoUpgradeRes(status, msg)
	if status == 0 then
		LTDaJiaoModel.instance:onLuoTianDaJiaoUpgradeRes()
		GlobalDispatcher:dispatch(GlobalNotify.LuoTianDaJiaoUpgradeRes)
	end
end

function LuoTianDaJiaoAgent:sendPM_LuoTianDaJiaoChoiceReq(actId)
	local req = LuoTianDaJiaoExtension_pb.PM_LuoTianDaJiaoChoiceReq()

	req.actId = actId

	self:sendMsg(req)
end

function LuoTianDaJiaoAgent:handlePM_LuoTianDaJiaoChoiceRes(status, msg)
	if status == 0 then
		LTDaJiaoModel.instance:onLuoTianDaJiaoChoiceRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.LuoTianDaJiaoChoiceRes, msg)
	end
end

function LuoTianDaJiaoAgent:sendPM_LuoTianDaJiaoFightReq(actId)
	local req = LuoTianDaJiaoExtension_pb.PM_LuoTianDaJiaoFightReq()

	req.actId = actId

	self:sendMsg(req)
end

function LuoTianDaJiaoAgent:handlePM_LuoTianDaJiaoFightRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.LuoTianDaJiaoFightRes)
	end
end

function LuoTianDaJiaoAgent:sendPM_LuoTianDaJiaoGainPrizeReq(actId, index)
	local req = LuoTianDaJiaoExtension_pb.PM_LuoTianDaJiaoGainPrizeReq()

	req.actId = actId
	req.index = index
	self._groupId = index

	self:sendMsg(req)
end

function LuoTianDaJiaoAgent:handlePM_LuoTianDaJiaoGainPrizeRes(status, msg)
	if status == 0 then
		LTDaJiaoModel.instance:onLuoTianDaJiaoGainPrizeRes(self._groupId)

		self._groupId = nil

		GlobalDispatcher:dispatch(GlobalNotify.LuoTianDaJiaoGainPrizeRes)
	end
end

function LuoTianDaJiaoAgent:handlePM_LuoTianDaJiaoAfterFightRes(status, msg)
	if status == 0 then
		local changesetid = msg.changeSetId

		BattleSettlementModel.instance:setChangeSetId(changesetid)
		LTDaJiaoModel.instance:onLuoTianDaJiaoAfterFightRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.LuoTianDaJiaoAfterFightRes)
	end
end

LuoTianDaJiaoAgent.instance = LuoTianDaJiaoAgent.New()

return LuoTianDaJiaoAgent
