-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/watertianyan/agent/WaterTianYanAgent.lua

module("logic.extensions.watertianyan.agent.WaterTianYanAgent", package.seeall)

local WaterTianYanAgent = class("WaterTianYanAgent", BaseAgent)

function WaterTianYanAgent:sendPM_WaterTianYanGetInfoReq(activityId)
	local req = WaterTianYanExtension_pb.PM_WaterTianYanGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function WaterTianYanAgent:handlePM_WaterTianYanGetInfoRes(status, msg)
	if status == 0 then
		WaterTianYanModel.instance:onGetInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.WaterTianYanGetInfoRes)
	end
end

function WaterTianYanAgent:sendPM_WaterTianYanUpgradeBuffReq(activityId, buffItemId)
	local req = WaterTianYanExtension_pb.PM_WaterTianYanUpgradeBuffReq()

	req.activityId = activityId
	req.buffItemId = buffItemId

	self:sendMsg(req)

	self._buffItemId = buffItemId
	self._upgradeBuffActivityId = activityId
end

function WaterTianYanAgent:handlePM_WaterTianYanUpgradeBuffRes(status, msg)
	if status == 0 then
		WaterTianYanModel.instance:onUpgradeBuffRes(msg, self._upgradeBuffActivityId, self._buffItemId)
		GlobalDispatcher:dispatch(GlobalNotify.WaterTianYanUpgradeBuffRes)
	end

	self._upgradeBuffActivityId = nil
	self._buffItemId = nil
end

function WaterTianYanAgent:sendPM_WaterTianYanRefreshBuildingStageListReq(activityId)
	local req = WaterTianYanExtension_pb.PM_WaterTianYanRefreshBuildingStageListReq()

	req.activityId = activityId

	self:sendMsg(req)

	self._refreshBuildingStageListActivityId = activityId
end

function WaterTianYanAgent:handlePM_WaterTianYanRefreshBuildingStageListRes(status, msg)
	if status == 0 then
		WaterTianYanModel.instance:onRefreshBuildingStageListRes(msg, self._refreshBuildingStageListActivityId)
		GlobalDispatcher:dispatch(GlobalNotify.WaterTianYanRefreshBuildingStageListRes)
	end

	self._refreshBuildingStageListActivityId = nil
end

function WaterTianYanAgent:sendPM_WaterTianYanBuildingStageChallengeReq(activityId, index, pmForm)
	local req = WaterTianYanExtension_pb.PM_WaterTianYanBuildingStageChallengeReq()

	req.activityId = activityId
	req.index = index

	req.pmForm:ParseFromString(pmForm:SerializeToString())
	self:sendMsg(req)

	self._buildingStageChallengeActivityId = activityId
	self._index = index
end

function WaterTianYanAgent:handlePM_WaterTianYanBuildingStageChallengeRes(status, msg)
	if status == 0 then
		WaterTianYanModel.instance:onBuildingStageChallengeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.WaterTianYanBuildingStageChallengeRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function WaterTianYanAgent:sendPM_WaterTianYanMainStageChallengeReq(activityId, stageId, buffItemIds, pmForm)
	local req = WaterTianYanExtension_pb.PM_WaterTianYanMainStageChallengeReq()

	req.activityId = activityId
	req.stageId = stageId

	if buffItemIds then
		for i, v in ipairs(buffItemIds) do
			req.buffItemIds:append(v)
		end
	end

	req.pmForm:ParseFromString(pmForm:SerializeToString())
	self:sendMsg(req)

	self._mainStageChallengeActivityId = activityId
	self._stageId = stageId
	self._buffItemIds = buffItemIds
end

function WaterTianYanAgent:handlePM_WaterTianYanMainStageChallengeRes(status, msg)
	if status == 0 then
		WaterTianYanModel.instance:onMainStageChallengeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.WaterTianYanMainStageChallengeRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function WaterTianYanAgent:sendPM_WaterTianYanResetMainStageReq(activityId)
	local req = WaterTianYanExtension_pb.PM_WaterTianYanResetMainStageReq()

	req.activityId = activityId

	self:sendMsg(req)

	self._resetMainStageActivityId = activityId
end

function WaterTianYanAgent:handlePM_WaterTianYanResetMainStageRes(status, msg)
	if status == 0 then
		WaterTianYanModel.instance:onResetMainStageRes(msg, self._resetMainStageActivityId)
		GlobalDispatcher:dispatch(GlobalNotify.WaterTianYanResetMainStageRes)
	end

	self._resetMainStageActivityId = nil
end

function WaterTianYanAgent:handlePM_Notify_WaterTianYanBuildingStageChallengeRes(status, msg)
	if status == 0 then
		WaterTianYanModel.instance:onNotifyBuildingStageChallengeRes(msg, self._buildingStageChallengeActivityId, self._index)
		GlobalDispatcher:dispatch(GlobalNotify.Notify_WaterTianYanBuildingStageChallengeRes, self._buildingStageChallengeActivityId)
	end

	self._buildingStageChallengeActivityId = nil
	self._index = nil
end

function WaterTianYanAgent:handlePM_Notify_WaterTianYanMainStageChallengeRes(status, msg)
	if status == 0 then
		WaterTianYanModel.instance:onNotifyMainStageChallengeRes(msg, self._mainStageChallengeActivityId, self._stageId, self._buffItemIds)
		GlobalDispatcher:dispatch(GlobalNotify.Notify_WaterTianYanMainStageChallengeRes, self._mainStageChallengeActivityId)
	end

	self._mainStageChallengeActivityId = nil
	self._stageId = nil
	self._buffItemIds = nil
end

WaterTianYanAgent.instance = WaterTianYanAgent.New()

return WaterTianYanAgent
