-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/expedition/agent/ExpeditionAgent.lua

module("logic.extensions.expedition.agent.ExpeditionAgent", package.seeall)

local ExpeditionAgent = class("ExpeditionAgent", BaseAgent)

ExpeditionAgent.PM_ExpeditionGetInfoRes = "ExpeditionAgent_PM_ExpeditionGetInfoRes"
ExpeditionAgent.PM_ExpeditionDoGridEventRes = "ExpeditionAgent_PM_ExpeditionDoGridEventRes"
ExpeditionAgent.PM_ExpeditionDoEventOverRes = "ExpeditionAgent_PM_ExpeditionDoEventOverRes"
ExpeditionAgent.PM_ExpeditionAskForSkipRes = "ExpeditionAgent_PM_ExpeditionAskForSkipRes"
ExpeditionAgent.PM_ExpeditionSkipLevelRes = "ExpeditionAgent_PM_ExpeditionSkipLevelRes"
ExpeditionAgent.PM_ExpeditionSetFormRes = "ExpeditionAgent_PM_ExpeditionSetFormRes"
ExpeditionAgent.PM_ExpeditionGetFormRes = "ExpeditionAgent_PM_ExpeditionGetFormRes"

function ExpeditionAgent:ctor()
	return
end

function ExpeditionAgent:setExtId(extId)
	ExpeditionAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function ExpeditionAgent:sendPM_ExpeditionGetInfoReq(handler, handlerObj, errHandler)
	local req = ExpeditionExtension_pb.PM_ExpeditionGetInfoReq()

	self:sendMsg(req)
	self:addEventOnce(ExpeditionAgent.PM_ExpeditionGetInfoRes, handler, handlerObj, errHandler)
end

function ExpeditionAgent:handlePM_ExpeditionGetInfoRes(status, msg)
	if status == 0 then
		ExpeditionModel.instance:setInfo(msg)
	end

	self:dispatch(ExpeditionAgent.PM_ExpeditionGetInfoRes, status, msg)
end

function ExpeditionAgent:sendPM_ExpeditionDoGridEventReq(eventIndex, param_pb, handler, handlerObj, errHandler)
	local req = ExpeditionExtension_pb.PM_ExpeditionDoGridEventReq()

	req.eventIndex = checknumber(eventIndex)

	req.param:ParseFromString(param_pb:SerializeToString())
	self:sendMsg(req)
	self:addEventOnce(ExpeditionAgent.PM_ExpeditionDoGridEventRes, handler, handlerObj, errHandler)
end

function ExpeditionAgent:handlePM_ExpeditionDoGridEventRes(status, msg)
	if status == 0 then
		-- block empty
	end

	self:dispatch(ExpeditionAgent.PM_ExpeditionDoGridEventRes, status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
end

function ExpeditionAgent:handlePM_ExpeditionDoEventOverRes(status, msg)
	if status == 0 then
		ExpeditionController.instance:onDoneGrid(msg)
	end

	self:dispatch(ExpeditionAgent.PM_ExpeditionDoEventOverRes, status, msg)
end

function ExpeditionAgent:showChangeSet(changeSetId, name)
	if name == "handlePM_ExpeditionDoEventOverRes" and SceneMgr.instance.isGogingToEnterBattleScene then
		-- block empty
	else
		ExpeditionAgent.super.showChangeSet(self, changeSetId, name)
	end
end

function ExpeditionAgent:sendPM_ExpeditionAskForSkipReq(handler, handlerObj, errHandler)
	local req = ExpeditionExtension_pb.PM_ExpeditionAskForSkipReq()

	self:sendMsg(req)
	self:addEventOnce(ExpeditionAgent.PM_ExpeditionAskForSkipRes, handler, handlerObj, errHandler)
end

function ExpeditionAgent:handlePM_ExpeditionAskForSkipRes(status, msg)
	self:dispatch(ExpeditionAgent.PM_ExpeditionAskForSkipRes, status, msg)
end

function ExpeditionAgent:sendPM_ExpeditionSkipLevelReq(selectedPetIds_i32_Ary, selectedBuffIds_i32_Ary, handler, handlerObj, errHandler)
	local req = ExpeditionExtension_pb.PM_ExpeditionSkipLevelReq()

	for i, v1 in ipairs(selectedPetIds_i32_Ary) do
		req.selectedPetIds:append(v1)
	end

	for i, v2 in ipairs(selectedBuffIds_i32_Ary) do
		req.selectedBuffIds:append(v2)
	end

	self:sendMsg(req)
	self:addEventOnce(ExpeditionAgent.PM_ExpeditionSkipLevelRes, handler, handlerObj, errHandler)
end

function ExpeditionAgent:handlePM_ExpeditionSkipLevelRes(status, msg)
	self:dispatch(ExpeditionAgent.PM_ExpeditionSkipLevelRes, status, msg)
end

function ExpeditionAgent:sendPM_ExpeditionNextLevelReq(level)
	local req = ExpeditionExtension_pb.PM_ExpeditionNextLevelReq()

	req.level = level

	self:sendMsg(req)
end

function ExpeditionAgent:handlePM_ExpeditionNextLevelRes(status, msg)
	if status == 0 then
		local level = msg.level
		local mapGridList = msg.mapGridList

		ExpeditionModel.instance:onNextLevel(level, mapGridList)
	end
end

function ExpeditionAgent:sendPM_ExpeditionSetFormReq(simpleForm_pb, handler, handlerObj, errHandler)
	local req = ExpeditionExtension_pb.PM_ExpeditionSetFormReq()

	req.simpleForm:ParseFromString(simpleForm_pb:SerializeToString())
	self:sendMsg(req)
	self:addEventOnce(ExpeditionAgent.PM_ExpeditionSetFormRes, handler, handlerObj, errHandler)
end

function ExpeditionAgent:handlePM_ExpeditionSetFormRes(status, msg)
	self:dispatch(ExpeditionAgent.PM_ExpeditionSetFormRes, status, msg)
end

function ExpeditionAgent:sendPM_ExpeditionReviveAllPetReq()
	local req = ExpeditionExtension_pb.PM_ExpeditionReviveAllPetReq()

	self:sendMsg(req)
end

function ExpeditionAgent:handlePM_ExpeditionReviveAllPetRes(status, msg)
	if status == 0 then
		ExpeditionModel.instance:reviveAllPets()
	end
end

function ExpeditionAgent:sendPM_ExpeditionGetFormReq(handler, handlerObj, errHandler)
	local req = ExpeditionExtension_pb.PM_ExpeditionGetFormReq()

	self:sendMsg(req)
	self:addEventOnce(ExpeditionAgent.PM_ExpeditionGetFormRes, handler, handlerObj, errHandler)
end

function ExpeditionAgent:handlePM_ExpeditionGetFormRes(status, msg)
	self:dispatch(ExpeditionAgent.PM_ExpeditionGetFormRes, status, msg)
end

function ExpeditionAgent:sendPM_ExpeditionSelectGridReq(nextGridIndex)
	local req = ExpeditionExtension_pb.PM_ExpeditionSelectGridReq()

	req.nextGridIndex = nextGridIndex

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:sendMsg(req)
	end
end

function ExpeditionAgent:handlePM_ExpeditionSelectGridRes(status, msg)
	if status == 0 then
		ExpeditionController.instance:onSelectMapGridRes(msg)
	end
end

function ExpeditionAgent:sendPM_ExpeditionLeaveGridMapReq()
	local req = ExpeditionExtension_pb.PM_ExpeditionLeaveGridMapReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:sendMsg(req)
	end
end

function ExpeditionAgent:handlePM_ExpeditionLeaveGridMapRes(status, msg)
	if status == 0 then
		ExpeditionController.instance:leaveGridMap(msg)
	end
end

function ExpeditionAgent:sendPM_ExpeditionSweepLevelReq()
	local req = ExpeditionExtension_pb.PM_ExpeditionSweepLevelReq()

	self:sendMsg(req)
end

function ExpeditionAgent:handlePM_ExpeditionSweepLevelRes(status, msg)
	if status == 0 then
		ExpeditionController.instance:onSweepLevelBack(msg)
	end
end

function ExpeditionAgent:sendPM_ExpeditionDoSweepEventReq(eventIndex, param)
	local req = ExpeditionExtension_pb.PM_ExpeditionDoSweepEventReq()

	req.eventIndex = eventIndex

	req.param:ParseFromString(param:SerializeToString())
	self:sendMsg(req)
end

function ExpeditionAgent:handlePM_ExpeditionDoSweepEventRes(status, msg)
	if status == 0 then
		ExpeditionController.instance:onDoSweepEvent(msg)
	end
end

function ExpeditionAgent:sendPM_ExpeditionGetWeeklyInfoReq()
	local req = ExpeditionExtension_pb.PM_ExpeditionGetWeeklyInfoReq()

	self:sendMsg(req)
end

function ExpeditionAgent:handlePM_ExpeditionGetWeeklyInfoRes(status, msg)
	if status == 0 then
		ExpeditionController.instance:onGetWeekCanPlayInfo(msg)
	end
end

function ExpeditionAgent:sendPM_ExpeditionOneKeySweepReq()
	local req = ExpeditionExtension_pb.PM_ExpeditionOneKeySweepReq()

	self:sendMsg(req)
end

function ExpeditionAgent:handlePM_ExpeditionOneKeySweepRes(status, msg)
	if status == 0 then
		ExpeditionController.instance:onOneKeySweepBack(msg)
	end
end

ExpeditionAgent.instance = ExpeditionAgent.New()

return ExpeditionAgent
