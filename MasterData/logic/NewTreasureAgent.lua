-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasurenew/agent/NewTreasureAgent.lua

module("logic.extensions.treasurenew.agent.NewTreasureAgent", package.seeall)

local NewTreasureAgent = class("NewTreasureAgent", BaseAgent)

NewTreasureAgent.PM_NewTreasureInfoRes = "NewTreasureAgent_PM_NewTreasureInfoRes"
NewTreasureAgent.PM_NewTreasureFinishDigRes = "NewTreasureAgent_PM_NewTreasureFinishDigRes"
NewTreasureAgent.PM_NewTreasurePrizeRes = "NewTreasureAgent_PM_NewTreasurePrizeRes"
NewTreasureAgent.PM_NewTreasureNotifyStartDigRes = "NewTreasureAgent_PM_NewTreasureNotifyStartDigRes"

function NewTreasureAgent:ctor()
	return
end

function NewTreasureAgent:setExtId(extId)
	NewTreasureAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function NewTreasureAgent:sendPM_NewTreasureInfoReq(handler, handlerObj, errHandler)
	forcePrint("==========LoginController._enterGame=======NewTreasureAgent:sendPM_NewTreasureInfoReq====")

	local req = NewTreasureExtension_pb.PM_NewTreasureInfoReq()

	self:sendMsg(req)
	self:addEventOnce(NewTreasureAgent.PM_NewTreasureInfoRes, handler, handlerObj, errHandler)
end

function NewTreasureAgent:handlePM_NewTreasureInfoRes(status, msg)
	forcePrint("==========LoginController._enterGame=======NewTreasureAgent:sendPM_NewTreasureInfoReq====back")
	self:dispatch(NewTreasureAgent.PM_NewTreasureInfoRes, status, msg)
end

function NewTreasureAgent:sendPM_NewTreasureFinishDigReq(handler, handlerObj, errHandler)
	local req = NewTreasureExtension_pb.PM_NewTreasureFinishDigReq()

	self:sendMsg(req)
	self:addEventOnce(NewTreasureAgent.PM_NewTreasureFinishDigRes, handler, handlerObj, errHandler)
end

function NewTreasureAgent:handlePM_NewTreasureFinishDigRes(status, msg)
	self:dispatch(NewTreasureAgent.PM_NewTreasureFinishDigRes, status, msg)
end

function NewTreasureAgent:sendPM_NewTreasurePrizeReq(handler, handlerObj, errHandler)
	local req = NewTreasureExtension_pb.PM_NewTreasurePrizeReq()

	self:sendMsg(req)
	self:addEventOnce(NewTreasureAgent.PM_NewTreasurePrizeRes, handler, handlerObj, errHandler)
end

function NewTreasureAgent:handlePM_NewTreasurePrizeRes(status, msg)
	self:dispatch(NewTreasureAgent.PM_NewTreasurePrizeRes, status, msg)
end

function NewTreasureAgent:handlePM_NewTreasureNotifyStartDigRes(status, msg)
	self:dispatch(NewTreasureAgent.PM_NewTreasureNotifyStartDigRes, status, msg)
end

function NewTreasureAgent:sendPM_NewTreasureDirectGainPrizeReq(materialId, num)
	local req = NewTreasureExtension_pb.PM_NewTreasureDirectGainPrizeReq()

	req.materialId = materialId
	req.num = num

	self:sendMsg(req)
end

function NewTreasureAgent:handlePM_NewTreasureDirectGainPrizeRes(status, msg)
	if status == 0 then
		TreasureNewController.instance:handleQuickUseMap(msg)
	end
end

NewTreasureAgent.instance = NewTreasureAgent.New()

return NewTreasureAgent
