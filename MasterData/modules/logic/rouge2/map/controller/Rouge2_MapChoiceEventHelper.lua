-- chunkname: @modules/logic/rouge2/map/controller/Rouge2_MapChoiceEventHelper.lua

module("modules.logic.rouge2.map.controller.Rouge2_MapChoiceEventHelper", package.seeall)

local Rouge2_MapChoiceEventHelper = class("Rouge2_MapChoiceEventHelper")

function Rouge2_MapChoiceEventHelper.triggerEventHandle(nodeMo)
	if not nodeMo then
		return
	end

	if nodeMo:checkIsStart() then
		return
	end

	local eventMo = nodeMo.eventMo

	if eventMo.state == Rouge2_MapEnum.EventState.Finish then
		return
	end

	if eventMo.eventCo then
		local eventType = eventMo.eventCo.type

		Rouge2_MapChoiceEventHelper._initEventHandleDict()

		local handle = Rouge2_MapChoiceEventHelper.eventHandleDict[eventType]

		if not handle then
			logError("not event handle event type : " .. tostring(eventType))

			return
		end

		handle(nodeMo)
	end
end

function Rouge2_MapChoiceEventHelper._initEventHandleDict()
	if Rouge2_MapChoiceEventHelper.eventHandleDict then
		return
	end

	Rouge2_MapChoiceEventHelper.eventHandleDict = {
		[Rouge2_MapEnum.EventType.Empty] = Rouge2_MapChoiceEventHelper.emptyHandle,
		[Rouge2_MapEnum.EventType.NormalFight] = Rouge2_MapChoiceEventHelper.fightHandle,
		[Rouge2_MapEnum.EventType.EliteFight] = Rouge2_MapChoiceEventHelper.fightHandle,
		[Rouge2_MapEnum.EventType.BossFight] = Rouge2_MapChoiceEventHelper.fightHandle,
		[Rouge2_MapEnum.EventType.HighHardFight] = Rouge2_MapChoiceEventHelper.choiceHandle,
		[Rouge2_MapEnum.EventType.Reward] = Rouge2_MapChoiceEventHelper.choiceHandle,
		[Rouge2_MapEnum.EventType.Rest] = Rouge2_MapChoiceEventHelper.choiceHandle,
		[Rouge2_MapEnum.EventType.Store] = Rouge2_MapChoiceEventHelper.storeHandle,
		[Rouge2_MapEnum.EventType.Strengthen] = Rouge2_MapChoiceEventHelper.choiceHandle,
		[Rouge2_MapEnum.EventType.StoryChoice] = Rouge2_MapChoiceEventHelper.choiceHandle,
		[Rouge2_MapEnum.EventType.ExploreChoice] = Rouge2_MapChoiceEventHelper.exploreChoiceHandle,
		[Rouge2_MapEnum.EventType.EasyFight] = Rouge2_MapChoiceEventHelper.fightHandle
	}
end

function Rouge2_MapChoiceEventHelper.triggerContinueEventHandle(nodeMo)
	if not nodeMo then
		return
	end

	if nodeMo:checkIsStart() then
		return
	end

	local eventMo = nodeMo.eventMo

	if eventMo.state == Rouge2_MapEnum.EventState.Finish then
		return
	end

	if eventMo.eventCo then
		local eventType = eventMo.eventCo.type

		Rouge2_MapChoiceEventHelper._initContinueEventHandleDict()

		local handle = Rouge2_MapChoiceEventHelper.continueEventHandleDict[eventType]

		if not handle then
			logError("not continue event handle event type : " .. tostring(eventType))

			return
		end

		handle(nodeMo)
	end
end

function Rouge2_MapChoiceEventHelper._initContinueEventHandleDict()
	if Rouge2_MapChoiceEventHelper.continueEventHandleDict then
		return
	end

	Rouge2_MapChoiceEventHelper.continueEventHandleDict = {
		[Rouge2_MapEnum.EventType.Empty] = Rouge2_MapChoiceEventHelper.emptyHandle,
		[Rouge2_MapEnum.EventType.NormalFight] = Rouge2_MapChoiceEventHelper.continueFightEventHandle,
		[Rouge2_MapEnum.EventType.EliteFight] = Rouge2_MapChoiceEventHelper.continueFightEventHandle,
		[Rouge2_MapEnum.EventType.BossFight] = Rouge2_MapChoiceEventHelper.continueFightEventHandle,
		[Rouge2_MapEnum.EventType.HighHardFight] = Rouge2_MapChoiceEventHelper.choiceHandle,
		[Rouge2_MapEnum.EventType.Reward] = Rouge2_MapChoiceEventHelper.choiceHandle,
		[Rouge2_MapEnum.EventType.Rest] = Rouge2_MapChoiceEventHelper.choiceHandle,
		[Rouge2_MapEnum.EventType.Store] = Rouge2_MapChoiceEventHelper.storeHandle,
		[Rouge2_MapEnum.EventType.Strengthen] = Rouge2_MapChoiceEventHelper.choiceHandle,
		[Rouge2_MapEnum.EventType.StoryChoice] = Rouge2_MapChoiceEventHelper.choiceHandle,
		[Rouge2_MapEnum.EventType.ExploreChoice] = Rouge2_MapChoiceEventHelper.exploreChoiceHandle,
		[Rouge2_MapEnum.EventType.EasyFight] = Rouge2_MapChoiceEventHelper.continueFightEventHandle
	}
end

function Rouge2_MapChoiceEventHelper.emptyHandle(nodeMo)
	logNormal("empty handle")
end

function Rouge2_MapChoiceEventHelper.fightHandle(nodeMo)
	logNormal("fight handle")

	if nodeMo:isStartedEvent() then
		return
	end

	local eventCo = nodeMo:getEventCo()
	local episodeId = eventCo and tonumber(eventCo.eventParam)
	local chapterId = Rouge2_MapEnum.ChapterId

	if episodeId and episodeId ~= 0 then
		DungeonFightController.instance:enterFight(chapterId, episodeId)
	else
		logError(string.format("尝试进入肉鸽战斗失败, 战斗事件 %s 中 eventParam 不可为空", eventCo.id))
	end
end

function Rouge2_MapChoiceEventHelper.continueFightEventHandle()
	logNormal("continue fight handle")
	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onShowContinueFight)
end

function Rouge2_MapChoiceEventHelper.storeHandle(nodeMo)
	logNormal("store handle")

	local state = nodeMo.eventMo:getStoreState()

	if state == Rouge2_MapEnum.StoreState.EnterFight then
		local stealEpisodeId = nodeMo.eventMo:getStealEpisodeId()

		DungeonFightController.instance:enterFight(Rouge2_MapEnum.ChapterId, stealEpisodeId)
		logNormal("商店进入战斗")

		return
	end

	ViewMgr.instance:openView(ViewName.Rouge2_MapStoreView, nodeMo)
end

function Rouge2_MapChoiceEventHelper.choiceHandle(nodeMo)
	logNormal("choice handle")

	local isFight = Rouge2_MapChoiceEventHelper._tryEnterChoiceFight(nodeMo)

	if isFight then
		return
	end

	ViewMgr.instance:openView(ViewName.Rouge2_MapChoiceView, nodeMo)
end

function Rouge2_MapChoiceEventHelper.exploreChoiceHandle(nodeMo)
	logNormal("explore choice handle")

	local isFight = Rouge2_MapChoiceEventHelper._tryEnterChoiceFight(nodeMo)

	if isFight then
		return
	end

	ViewMgr.instance:openView(ViewName.Rouge2_MapExploreChoiceView, nodeMo)
end

function Rouge2_MapChoiceEventHelper.triggerEventHandleOnChoiceView(nodeMo)
	if not nodeMo then
		Rouge2_MapChoiceEventHelper.defaultHandleOnChoiceView()

		return
	end

	if nodeMo:checkIsStart() then
		Rouge2_MapChoiceEventHelper.defaultHandleOnChoiceView()

		return
	end

	local eventMo = nodeMo.eventMo

	if eventMo.state == Rouge2_MapEnum.EventState.Finish then
		Rouge2_MapChoiceEventHelper.defaultHandleOnChoiceView()

		return
	end

	if eventMo.eventCo then
		local eventType = eventMo.eventCo.type

		Rouge2_MapChoiceEventHelper._initEventHandleOnChoiceViewDict()

		local handle = Rouge2_MapChoiceEventHelper._onChoiceViewHandleDict[eventType]

		if not handle then
			logError("not on choice view event handle event type : " .. tostring(eventType))
			Rouge2_MapChoiceEventHelper.defaultHandleOnChoiceView()

			return
		end

		return handle(nodeMo)
	end
end

function Rouge2_MapChoiceEventHelper.defaultHandleOnChoiceView()
	ViewMgr.instance:closeView(ViewName.Rouge2_MapChoiceView)
	ViewMgr.instance:closeView(ViewName.Rouge2_MapExploreChoiceView)
end

function Rouge2_MapChoiceEventHelper._initEventHandleOnChoiceViewDict()
	if Rouge2_MapChoiceEventHelper._onChoiceViewHandleDict then
		return
	end

	Rouge2_MapChoiceEventHelper._onChoiceViewHandleDict = {
		[Rouge2_MapEnum.EventType.Empty] = Rouge2_MapChoiceEventHelper.defaultHandleOnChoiceView,
		[Rouge2_MapEnum.EventType.NormalFight] = Rouge2_MapChoiceEventHelper.onChoiceViewFightHandle,
		[Rouge2_MapEnum.EventType.EliteFight] = Rouge2_MapChoiceEventHelper.onChoiceViewFightHandle,
		[Rouge2_MapEnum.EventType.BossFight] = Rouge2_MapChoiceEventHelper.onChoiceViewFightHandle,
		[Rouge2_MapEnum.EventType.HighHardFight] = Rouge2_MapChoiceEventHelper.onChoiceViewFightHandle,
		[Rouge2_MapEnum.EventType.Reward] = Rouge2_MapChoiceEventHelper.onChoiceViewChoiceHandle,
		[Rouge2_MapEnum.EventType.Rest] = Rouge2_MapChoiceEventHelper.onChoiceViewChoiceHandle,
		[Rouge2_MapEnum.EventType.Store] = Rouge2_MapChoiceEventHelper.onChoiceViewStoreHandle,
		[Rouge2_MapEnum.EventType.Strengthen] = Rouge2_MapChoiceEventHelper.onChoiceViewChoiceHandle,
		[Rouge2_MapEnum.EventType.StoryChoice] = Rouge2_MapChoiceEventHelper.onChoiceViewChoiceHandle,
		[Rouge2_MapEnum.EventType.ExploreChoice] = Rouge2_MapChoiceEventHelper.onChoiceViewChoiceHandle,
		[Rouge2_MapEnum.EventType.EasyFight] = Rouge2_MapChoiceEventHelper.onChoiceViewFightHandle
	}
end

function Rouge2_MapChoiceEventHelper.onChoiceViewFightHandle(nodeMo)
	Rouge2_MapChoiceEventHelper.defaultHandleOnChoiceView()
	Rouge2_MapChoiceEventHelper._tryEnterChoiceFight(nodeMo)
end

function Rouge2_MapChoiceEventHelper.onChoiceViewChoiceHandle(nodeMo)
	local isFight = Rouge2_MapChoiceEventHelper._tryEnterChoiceFight(nodeMo)

	if isFight then
		return
	end

	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onChoiceEventChange, nodeMo)
end

function Rouge2_MapChoiceEventHelper._tryEnterChoiceFight(nodeMo)
	local eventMo = nodeMo and nodeMo.eventMo
	local isFinish = nodeMo and nodeMo:isFinishEvent()
	local choiceEpisodeId = eventMo and eventMo:getChoiceEpisodeId()

	if choiceEpisodeId and choiceEpisodeId ~= 0 and not isFinish then
		logNormal(string.format("肉鸽选项事件进入战斗! eventId = %s, episodeId = %s", eventMo.eventId, choiceEpisodeId))
		DungeonFightController.instance:enterFight(Rouge2_MapEnum.ChapterId, choiceEpisodeId)

		return true
	end
end

function Rouge2_MapChoiceEventHelper.onChoiceViewStoreHandle(nodeMo)
	Rouge2_MapChoiceEventHelper.defaultHandleOnChoiceView()
	ViewMgr.instance:openView(ViewName.Rouge2_MapStoreView, nodeMo)
end

function Rouge2_MapChoiceEventHelper._getLevelUpMaxNum(nodeMo)
	if nodeMo then
		local eventMo = nodeMo and nodeMo.eventMo
		local jsonData = eventMo and eventMo.jsonData

		return jsonData and jsonData.collectionLevelUpNum
	end
end

return Rouge2_MapChoiceEventHelper
