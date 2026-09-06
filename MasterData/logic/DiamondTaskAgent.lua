-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/diamondtask/agent/DiamondTaskAgent.lua

module("logic.extensions.diamondtask.agent.DiamondTaskAgent", package.seeall)

local DiamondTaskAgent = class("DiamondTaskAgent", BaseAgent)

function DiamondTaskAgent:sendGetDiamondTaskInfosReq()
	local req = DiamondTaskExtension_pb.GetDiamondTaskInfosReq()

	self:sendMsg(req)
end

function DiamondTaskAgent:handleGetDiamondTaskInfosRes(status, msg)
	forcePrint("DiamondTaskAgent:handleGetDiamondTaskInfosRes===", status)

	if status == 0 then
		local tasks = msg.tasks

		DiamondTaskModel.instance:onTaskInfoGot(tasks)
		DiamondTaskModel.instance:refreshPeriodInfo()
		GlobalDispatcher:dispatch(GlobalNotify.DiamondTaskInfoGot)
	end
end

function DiamondTaskAgent:sendGainTaskGiftReq(periodType, taskId_i32_Ary)
	local req = DiamondTaskExtension_pb.GainTaskGiftReq()

	req.periodType = periodType

	for i, v1 in ipairs(taskId_i32_Ary) do
		req.taskId:append(v1)
	end

	self:sendMsg(req)
end

function DiamondTaskAgent:handleGainTaskGiftRes(status, msg)
	if status == 0 then
		local periodType = msg.periodType
		local taskid = msg.taskId
		local addactivityscore = msg.addActivityScore

		DiamondTaskModel.instance:updateAccumulateScore(msg)

		for i, v in ipairs(taskid) do
			DiamondTaskModel.instance:onGiftGained(v)
		end

		DiamondTaskModel.instance:addScoreByType(periodType, addactivityscore)
		GlobalDispatcher:dispatch(GlobalNotify.DiamondTaskInfoGot)
	end
end

function DiamondTaskAgent:sendGainActivityScoreGiftReq(periodType, index_i32_Ary)
	local req = DiamondTaskExtension_pb.GainActivityScoreGiftReq()

	req.periodType = periodType

	for i, v2 in ipairs(index_i32_Ary) do
		req.index:append(v2)
	end

	self:sendMsg(req)
end

function DiamondTaskAgent:handleGainActivityScoreGiftRes(status, msg)
	if status == 0 then
		local periodtype = msg.periodType
		local index = msg.index

		for i, v in ipairs(index) do
			DiamondTaskModel.instance:onActiveGiftGained(periodtype, v)
		end

		GlobalDispatcher:dispatch(GlobalNotify.DiamondTaskInfoGot)
	end
end

function DiamondTaskAgent:handleNotifyProgressChangedRes(status, msg)
	if status == 0 then
		local newfinishtaskids = msg.newFinishTaskIds

		DiamondTaskModel.instance:finishTaskes(newfinishtaskids)
		GlobalDispatcher:dispatch(GlobalNotify.DiamondTaskInfoGot)
	end
end

function DiamondTaskAgent:sendGainAccumulateScoreGiftReq(periodType)
	local req = DiamondTaskExtension_pb.GainAccumulateScoreGiftReq()

	req.periodType = periodType

	self:sendMsg(req)
end

function DiamondTaskAgent:handleGainAccumulateScoreGiftRes(status, msg)
	if status == 0 then
		DiamondTaskModel.instance:updateAccumulateScore(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DiamondTaskInfoGot)
	end
end

DiamondTaskAgent.instance = DiamondTaskAgent.New()

return DiamondTaskAgent
