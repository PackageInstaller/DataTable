-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/assignment/agent/PetDispatchAgent.lua

module("logic.extensions.assignment.agent.PetDispatchAgent", package.seeall)

local PetDispatchAgent = class("PetDispatchAgent", BaseAgent)

PetDispatchAgent.PM_GetMyPetDispatchInfoRes = "PetDispatchAgent_PM_GetMyPetDispatchInfoRes"
PetDispatchAgent.PM_GainTaskPrizeRes = "PetDispatchAgent_PM_GainTaskPrizeRes"
PetDispatchAgent.PM_RefreshTaskRes = "PetDispatchAgent_PM_RefreshTaskRes"
PetDispatchAgent.PM_DispatchPetsRes = "PetDispatchAgent_PM_DispatchPetsRes"

function PetDispatchAgent:sendGetMyPetDispatchInfoReq()
	local req = PetDispatchExtension_pb.GetMyPetDispatchInfoReq()

	self:sendMsg(req)
end

function PetDispatchAgent:handleGetMyPetDispatchInfoRes(status, msg)
	if status == 0 then
		local taskInfos = msg.taskInfos
		local boxId = msg.boxId
		local boxProgress = msg.boxProgress
		local todayTaskRefreshTimes = msg.todayTaskRefreshTimes
		local todayBoxRefreshTimes = msg.todayBoxRefreshTimes

		AssignmentController.instance:AssigmentInfo(taskInfos, boxId, boxProgress, todayTaskRefreshTimes, todayBoxRefreshTimes)
		GlobalDispatcher:dispatch(GlobalNotify.RefreshDispatchData)
	end

	self:dispatch(PetDispatchAgent.PM_GetMyPetDispatchInfoRes, status, msg)
end

function PetDispatchAgent:sendDispatchPetsReq(reqNos, handler, handlerObj, errHandler)
	local req = PetDispatchExtension_pb.DispatchPetsReq()

	for i, v in ipairs(reqNos) do
		local task = req.tasks:add()

		task.taskId = v.taskId

		for _, petId in ipairs(v.petIds) do
			task.petIds:append(petId)
		end
	end

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PetDispatchAgent.PM_DispatchPetsRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PetDispatchAgent:handleDispatchPetsRes(status, msg)
	if status == 0 then
		AssignmentController.instance:handleDispatchPetsRes(msg)
	end

	self:dispatch(PetDispatchAgent.PM_DispatchPetsRes, status, msg)
end

function PetDispatchAgent:sendGainTaskPrizeReq(taskIds, handler, handlerObj, errHandler)
	local req = PetDispatchExtension_pb.GainTaskPrizeReq()

	for i, taskId in ipairs(taskIds) do
		req.taskId:append(taskId)
	end

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PetDispatchAgent.PM_GainTaskPrizeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PetDispatchAgent:handleGainTaskPrizeRes(status, msg)
	if status == 0 then
		AssignmentController.instance:handleGainTaskPrizeRes(msg)
	end

	self:dispatch(PetDispatchAgent.PM_GainTaskPrizeRes, status, msg)
end

function PetDispatchAgent:sendGainBoxPrizeReq()
	local req = PetDispatchExtension_pb.GainBoxPrizeReq()

	self:sendMsg(req)
end

function PetDispatchAgent:handleGainBoxPrizeRes(status, msg)
	if status == 0 then
		local boxId = msg.boxId

		AssignmentController.instance:gainBoxPrize(boxId)
	end
end

function PetDispatchAgent:sendRefreshTaskReq(expectPrizeTypes, maxRefreshTimes, handler, handlerObj, errHandler)
	local req = PetDispatchExtension_pb.RefreshTaskReq()

	for i, v in ipairs(expectPrizeTypes) do
		req.expectPrizeTypes:append(v)
	end

	req.maxRefreshTimes = maxRefreshTimes

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PetDispatchAgent.PM_RefreshTaskRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PetDispatchAgent:handleRefreshTaskRes(status, msg)
	if status == 0 then
		local taskIds = msg.taskIds
		local todayTaskRefreshTimes = msg.todayTaskRefreshTimes

		AssignmentController.instance:refreshTask(taskIds, todayTaskRefreshTimes)
	end

	self:dispatch(PetDispatchAgent.PM_RefreshTaskRes, status, msg)
end

function PetDispatchAgent:sendRefreshBoxReq()
	local req = PetDispatchExtension_pb.RefreshBoxReq()

	self:sendMsg(req)
end

function PetDispatchAgent:handleRefreshBoxRes(status, msg)
	if status == 0 then
		local boxId = msg.boxId
		local todayBoxRefreshTimes = msg.todayBoxRefreshTimes

		AssignmentController.instance:refreshBox(boxId, todayBoxRefreshTimes)
	end
end

PetDispatchAgent.instance = PetDispatchAgent.New()

return PetDispatchAgent
