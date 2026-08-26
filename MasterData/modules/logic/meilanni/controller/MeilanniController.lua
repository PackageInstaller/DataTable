-- chunkname: @modules/logic/meilanni/controller/MeilanniController.lua

module("modules.logic.meilanni.controller.MeilanniController", package.seeall)

local MeilanniController = class("MeilanniController", BaseController)

function MeilanniController:onInit()
	self._statViewTime = nil
	self._statViewCostAP = 0
end

function MeilanniController:onInitFinish()
	return
end

function MeilanniController:addConstEvents()
	return
end

function MeilanniController:reInit()
	self._statViewTime = nil
	self._statViewCostAP = 0
end

function MeilanniController:activityIsEnd()
	local actMO = ActivityModel.instance:getActMO(MeilanniEnum.activityId)

	if not actMO then
		return false
	end

	local endTime = actMO:getRealEndTimeStamp()

	return endTime <= ServerTime.now()
end

function MeilanniController:openMeilanniView(param, isImmediate)
	param = param or {}

	if not param.mapId then
		local battleId = FightModel.instance:getBattleId()

		FightModel.instance:clearBattleId()

		if battleId then
			param.mapId = MeilanniModel.instance:getMapIdByBattleId(battleId)
		end

		param.mapId = param.mapId or MeilanniModel.instance:getCurMapId()
	end

	if param.mapId then
		MeilanniModel.instance:setCurMapId(param.mapId)
	end

	ViewMgr.instance:openView(ViewName.MeilanniView, param, isImmediate)
	self:statStart()
end

function MeilanniController:openMeilanniMainView(param, isImmediate)
	Activity108Rpc.instance:sendGet108InfosRequest(MeilanniEnum.activityId, function()
		ViewMgr.instance:openView(ViewName.MeilanniMainView, param, isImmediate)
	end, self)
end

function MeilanniController:immediateOpenMeilanniMainView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.MeilanniMainView, param, isImmediate)
end

function MeilanniController:openMeilanniBossInfoView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.MeilanniBossInfoView, param, isImmediate)
end

function MeilanniController:openMeilanniTaskView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.MeilanniTaskView, param, isImmediate)
end

function MeilanniController:openMeilanniEntrustView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.MeilanniEntrustView, param, isImmediate)
end

function MeilanniController:openMeilanniSettlementView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.MeilanniSettlementView, param, isImmediate)
end

function MeilanniController:startBattle(id)
	MeilanniModel.instance:setBattleElementId(id)
	Activity108Rpc.instance:sendEnterFightEventRequest(MeilanniEnum.activityId, id)
end

function MeilanniController:enterFight(elementId)
	local mapId = MeilanniModel.instance:getCurMapId()
	local elementInfo = MeilanniModel.instance:getEventInfo(mapId, elementId)
	local battleId = elementInfo:getBattleId()
	local episodeId = MeilanniEnum.episodeId

	DungeonModel.instance.curLookEpisodeId = episodeId

	local config = DungeonConfig.instance:getEpisodeCO(episodeId)

	DungeonFightController.instance:enterMeilanniFight(config.chapterId, episodeId, battleId)
end

function MeilanniController.getScoreDesc(score)
	if score ~= 0 then
		local scoreStr

		return score > 0 and string.format("<#9D1111><b>[</b>%s+%s<b>]</b></color>", luaLang("meilanni_pingfen"), score) or string.format("<#4E7656><b>[</b>%s%s<b>]</b></color>", luaLang("meilanni_pingfen"), score)
	end
end

function MeilanniController:statStart()
	if self._statViewTime then
		return
	end

	local mapId = MeilanniModel.instance:getCurMapId()
	local mapInfo = MeilanniModel.instance:getMapInfo(mapId)

	if not mapInfo then
		return
	end

	self._statViewCostAP = mapInfo:getTotalCostAP()
	self._statViewTime = ServerTime.now()
end

function MeilanniController:statEnd(result)
	if not self._statViewTime then
		return
	end

	local useTime = ServerTime.now() - self._statViewTime
	local mapId = MeilanniModel.instance:getCurMapId()
	local mapInfo = MeilanniModel.instance:getMapInfo(mapId)

	if not mapInfo then
		return
	end

	local score = mapInfo.score
	local curCostAP = mapInfo:getTotalCostAP()
	local actionPoint = curCostAP
	local incrementActionPoint = math.max(0, curCostAP - self._statViewCostAP)
	local challengesNum = mapInfo.totalCount

	self._statViewTime = nil

	StatController.instance:track(StatEnum.EventName.ExitMeilanniActivity, {
		[StatEnum.EventProperties.UseTime] = useTime,
		[StatEnum.EventProperties.MapId] = tostring(mapId),
		[StatEnum.EventProperties.ChallengesNum] = challengesNum,
		[StatEnum.EventProperties.ActionPoint] = actionPoint,
		[StatEnum.EventProperties.IncrementActionPoint] = incrementActionPoint,
		[StatEnum.EventProperties.Score] = score,
		[StatEnum.EventProperties.Result] = result or StatEnum.Result.None
	})
end

MeilanniController.instance = MeilanniController.New()

return MeilanniController
