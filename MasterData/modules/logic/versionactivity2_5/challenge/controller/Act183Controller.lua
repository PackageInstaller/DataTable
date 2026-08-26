-- chunkname: @modules/logic/versionactivity2_5/challenge/controller/Act183Controller.lua

module("modules.logic.versionactivity2_5.challenge.controller.Act183Controller", package.seeall)

local Act183Controller = class("Act183Controller", BaseController)

function Act183Controller:openAct183MainView(params, callback, callbackObj)
	local activityId = Act183Model.instance:getActivityId()

	if not activityId then
		logError("挑战玩法活动id为空!!!先设置活动id再请求数据")

		return
	end

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity183
	}, function()
		return
	end)
	Activity183Rpc.instance:sendAct183GetInfoRequest(activityId, function(__, resultCode)
		if resultCode ~= 0 then
			return
		end

		ViewMgr.instance:openView(ViewName.Act183MainView, params)

		if callback then
			callback(callbackObj)
		end
	end)
end

function Act183Controller:openAct183DungeonView(params)
	ViewMgr.instance:openView(ViewName.Act183DungeonView, params)
end

function Act183Controller:openAct183TaskView(params)
	local activityId = Act183Model.instance:getActivityId()
	local status = ActivityHelper.getActivityStatus(activityId)

	if not Act183Model.instance:isInitDone() and status == ActivityEnum.ActivityStatus.Normal then
		Activity183Rpc.instance:sendAct183GetInfoRequest(activityId)
	end

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity183
	}, function()
		ViewMgr.instance:openView(ViewName.Act183TaskView, params)
	end)
end

function Act183Controller:openAct183BadgeView(params)
	ViewMgr.instance:openView(ViewName.Act183BadgeView, params)
end

function Act183Controller:openAct183ReportView(params)
	local activityId = Act183Model.instance:getActivityId()

	Activity183Rpc.instance:sendAct183GetRecordRequest(activityId, function(__, resultCode)
		if resultCode ~= 0 then
			return
		end

		ViewMgr.instance:openView(ViewName.Act183ReportView, params)
	end)
end

function Act183Controller:openAct183FinishView(params)
	ViewMgr.instance:openView(ViewName.Act183FinishView, params)
end

function Act183Controller:openAct183SettlementView(params)
	ViewMgr.instance:openView(ViewName.Act183SettlementView, params)
end

function Act183Controller:openAct183RepressView(params)
	ViewMgr.instance:openView(ViewName.Act183RepressView, params)
end

function Act183Controller:openAct183StoreView(params)
	ViewMgr.instance:openView(ViewName.V1a6_BossRush_StoreView, params)
end

function Act183Controller:openAct183CurrencyReplaceTipsView(params)
	ViewMgr.instance:openView(ViewName.Act183CurrencyReplaceTipsView, params)
end

function Act183Controller:resetGroupEpisode(activityId, groupId)
	if activityId and activityId ~= 0 and groupId and groupId ~= 0 then
		self:_clearGroupEpisodeRefreshAnimRecord(groupId)
		Activity183Rpc.instance:sendAct183ResetGroupRequest(activityId, groupId)
	end
end

function Act183Controller:updateResetGroupEpisodeInfo(activityId, groupInfo)
	local actInfo = Act183Model.instance:getActInfo()

	actInfo:updateGroupMo(groupInfo)
	self:dispatchEvent(Act183Event.OnUpdateGroupInfo)
end

function Act183Controller:resetEpisode(activityId, episodeId)
	if not episodeId then
		return
	end

	local episodeMo = Act183Model.instance:getEpisodeMoById(episodeId)
	local groupId = episodeMo and episodeMo:getGroupId()

	self:_clearGroupEpisodeRefreshAnimRecord(groupId)
	Activity183Rpc.instance:sendAct183ResetEpisodeRequest(activityId, episodeId)
end

function Act183Controller:_clearGroupEpisodeRefreshAnimRecord(groupId)
	local groupMo = Act183Model.instance:getGroupEpisodeMo(groupId)
	local passOrderEpisodes = groupMo and groupMo:getEpisodeListByPassOrder()
	local recordResult = {}

	for _, passOrderEpisode in ipairs(passOrderEpisodes or {}) do
		Act183Helper.saveHasPlayRefreshAnimRuleIdsInLocal(passOrderEpisode:getEpisodeId(), recordResult)
	end
end

function Act183Controller:updateResetEpisodeInfo(groupInfo)
	local actInfo = Act183Model.instance:getActInfo()

	actInfo:updateGroupMo(groupInfo)
	self:dispatchEvent(Act183Event.OnUpdateGroupInfo)
end

function Act183Controller:tryChooseRepress(activityId, episodeId, ruleIndex, heroIndex, callback, callbackObj)
	Activity183Rpc.instance:sendAct183ChooseRepressRequest(activityId, episodeId, ruleIndex, heroIndex, callback, callbackObj)
end

function Act183Controller:updateChooseRepressInfo(episodeId, repressInfo)
	local actInfo = Act183Model.instance:getActInfo()

	if not actInfo then
		return
	end

	local episodeCo = Act183Config.instance:getEpisodeCo(episodeId)
	local groupMo = actInfo:getGroupEpisodeMo(episodeCo.groupId)
	local episodeMo = groupMo:getEpisodeMo(episodeId)

	episodeMo:updateRepressMo(repressInfo)
	Act183Model.instance:recordLastRepressEpisodeId(episodeId)
	Act183Controller.instance:dispatchEvent(Act183Event.OnUpdateRepressInfo, episodeId, episodeMo)
end

function Act183Controller:onReconnectFight(episodeId)
	local episodeCo = Act183Config.instance:getEpisodeCo(episodeId)
	local activityId = episodeCo and episodeCo.activityId

	Act183Model.instance:setActivityId(activityId)
end

Act183Controller.instance = Act183Controller.New()

return Act183Controller
