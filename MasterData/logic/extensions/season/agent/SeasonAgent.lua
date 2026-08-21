-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/agent/SeasonAgent.lua

module("logic.extensions.season.agent.SeasonAgent", package.seeall)

local M = class("SeasonAgent", BaseAgent)

function M:sendSeasonInfoRequest()
	if SeasonFacade.instance:hasActivityOpen() then
		local req = SeasonExtension_pb.SeasonInfoRequest()

		self:sendMsg(req)
	end
end

function M:handleSeasonInfoReply(status, msg)
	if status == 0 then
		SeasonModel.instance:updateDataByAgent(msg)
		GlobalDispatcher:dispatchEvent(EventType.SEASON_INFO_UPDATE)
	end
end

function M:sendReportRequest()
	if SeasonFacade.instance:hasActivityOpen() then
		local req = SeasonExtension_pb.ReportRequest()

		self:sendMsg(req)
	end
end

function M:handleReportReply(status, msg)
	if status == 0 then
		SeasonModel.instance:updateReportByAgent(msg)
	end
end

function M:sendSeasonListTaskRequest()
	local req = SeasonExtension_pb.SeasonListTaskRequest()

	self:sendMsg(req)
end

function M:handleSeasonListTaskReply(status, msg)
	if status == 0 then
		SeasonModel.instance:updateTasksByAgent(msg)
		GlobalDispatcher:dispatchEvent(EventType.SEASON_TASK_UPDATE)
	end
end

function M:sendUpgradeRequest(lv)
	local req = SeasonExtension_pb.UpgradeRequest()

	req.lv = lv

	self:sendMsg(req)
end

function M:handleUpgradeReply(status, msg)
	if status == 0 then
		self:sendSeasonInfoRequest()
	end
end

function M:sendUnlockVipRequest(type)
	local req = SeasonExtension_pb.UnlockVipRequest()

	req.type = type

	self:sendMsg(req)
end

function M:handleUnlockVipReply(status, msg)
	if status == 0 then
		self:sendSeasonInfoRequest()
	end
end

function M:sendTakeTaskPointRequest(ids)
	local req = SeasonExtension_pb.TakeTaskPointRequest()

	for _, id in ipairs(ids) do
		table.insert(req.ids, id)
	end

	self:sendMsg(req)
end

function M:handleTakeTaskPointReply(status, msg)
	if status == 0 then
		for _, taskId in ipairs(msg.ids) do
			SeasonModel.instance:setTaskFinished(taskId)
		end

		GlobalDispatcher:dispatchEvent(EventType.SEASON_RECEIVE_TASK)
		self:sendSeasonInfoRequest()
		self:sendSeasonListTaskRequest()
		SeasonController.instance:popGainItems()
		SeasonController.instance:clearGainItems()
	end
end

function M:sendTakeLvRewardRequest(lv)
	local req = SeasonExtension_pb.TakeLvRewardRequest()

	req.lv = lv

	self:sendMsg(req)
end

function M:handleTakeLvRewardReply(status, msg)
	if status == 0 then
		self:sendSeasonInfoRequest()
	end
end

function M:handlePointPush(status, msg)
	if status == 0 then
		local data = {}

		data.score = msg.point
		data.taskId = msg.taskId
	end
end

function M:handleSeasonSettle(status, msg)
	if status == 0 then
		SeasonModel.instance:setNew(true)
		SeasonModel.instance:setSummarizeInfo(msg)
	end
end

function M:sendReceiveScheduleRewardRequest(ids)
	local req = SeasonExtension_pb.ReceiveScheduleRewardRequest()

	for _, id in ipairs(ids) do
		table.insert(req.ids, id)
	end

	PlayerController.instance:blockPlayerUpgradeShow(true)
	self:sendMsg(req)
end

function M:handleReceiveScheduleRewardReply(status, msg)
	if status == 0 then
		for _, id in ipairs(msg.ids) do
			SeasonModel.instance:receiveScheduleReward(id)
		end

		GlobalDispatcher:dispatchEvent(EventType.SEASON_TASK_PROGRESS_UPDATE)
		SeasonController.instance:popGainItems()
		SeasonController.instance:clearGainItems()
	end

	PlayerController.instance:blockPlayerUpgradeShow(false)
end

M.instance = M.New()

return M
