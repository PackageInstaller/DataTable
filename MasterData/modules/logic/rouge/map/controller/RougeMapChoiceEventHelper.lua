-- chunkname: @modules/logic/rouge/map/controller/RougeMapChoiceEventHelper.lua

module("modules.logic.rouge.map.controller.RougeMapChoiceEventHelper", package.seeall)

local RougeMapChoiceEventHelper = class("RougeMapChoiceEventHelper")

function RougeMapChoiceEventHelper.triggerEventHandle(nodeMo)
	if not nodeMo then
		return
	end

	if nodeMo:checkIsStart() then
		return
	end

	local eventMo = nodeMo.eventMo

	if eventMo.state == RougeMapEnum.EventState.Finish then
		return
	end

	if eventMo.eventCo then
		local eventType = eventMo.eventCo.type

		RougeMapChoiceEventHelper._initEventHandleDict()

		local handle = RougeMapChoiceEventHelper.eventHandleDict[eventType]

		if not handle then
			logError("not event handle event type : " .. tostring(eventType))

			return
		end

		handle(nodeMo)
	end
end

function RougeMapChoiceEventHelper._initEventHandleDict()
	if RougeMapChoiceEventHelper.eventHandleDict then
		return
	end

	RougeMapChoiceEventHelper.eventHandleDict = {
		[RougeMapEnum.EventType.Empty] = RougeMapChoiceEventHelper.emptyHandle,
		[RougeMapEnum.EventType.NormalFight] = RougeMapChoiceEventHelper.fightHandle,
		[RougeMapEnum.EventType.HardFight] = RougeMapChoiceEventHelper.fightHandle,
		[RougeMapEnum.EventType.EliteFight] = RougeMapChoiceEventHelper.fightHandle,
		[RougeMapEnum.EventType.BossFight] = RougeMapChoiceEventHelper.fightHandle,
		[RougeMapEnum.EventType.Reward] = RougeMapChoiceEventHelper.choiceHandle,
		[RougeMapEnum.EventType.Choice] = RougeMapChoiceEventHelper.choiceHandle,
		[RougeMapEnum.EventType.Store] = RougeMapChoiceEventHelper.storeHandle,
		[RougeMapEnum.EventType.Rest] = RougeMapChoiceEventHelper.choiceHandle,
		[RougeMapEnum.EventType.WatchTower] = RougeMapChoiceEventHelper.choiceHandle,
		[RougeMapEnum.EventType.TreasurePlace] = RougeMapChoiceEventHelper.choiceHandle,
		[RougeMapEnum.EventType.ChoiceLair] = RougeMapChoiceEventHelper.choiceHandle,
		[RougeMapEnum.EventType.FightLair] = RougeMapChoiceEventHelper.fightHandle,
		[RougeMapEnum.EventType.Unknow] = RougeMapChoiceEventHelper.emptyHandle,
		[RougeMapEnum.EventType.LevelUpSp] = RougeMapChoiceEventHelper.choiceHandle
	}
end

function RougeMapChoiceEventHelper.triggerContinueEventHandle(nodeMo)
	if not nodeMo then
		return
	end

	if nodeMo:checkIsStart() then
		return
	end

	local eventMo = nodeMo.eventMo

	if eventMo.state == RougeMapEnum.EventState.Finish then
		return
	end

	if eventMo.eventCo then
		local eventType = eventMo.eventCo.type

		RougeMapChoiceEventHelper._initContinueEventHandleDict()

		local handle = RougeMapChoiceEventHelper.continueEventHandleDict[eventType]

		if not handle then
			logError("not continue event handle event type : " .. tostring(eventType))

			return
		end

		handle(nodeMo)
	end
end

function RougeMapChoiceEventHelper._initContinueEventHandleDict()
	if RougeMapChoiceEventHelper.continueEventHandleDict then
		return
	end

	RougeMapChoiceEventHelper.continueEventHandleDict = {
		[RougeMapEnum.EventType.Empty] = RougeMapChoiceEventHelper.emptyHandle,
		[RougeMapEnum.EventType.NormalFight] = RougeMapChoiceEventHelper.continueFightEventHandle,
		[RougeMapEnum.EventType.HardFight] = RougeMapChoiceEventHelper.continueFightEventHandle,
		[RougeMapEnum.EventType.EliteFight] = RougeMapChoiceEventHelper.continueFightEventHandle,
		[RougeMapEnum.EventType.BossFight] = RougeMapChoiceEventHelper.continueFightEventHandle,
		[RougeMapEnum.EventType.Reward] = RougeMapChoiceEventHelper.choiceHandle,
		[RougeMapEnum.EventType.Choice] = RougeMapChoiceEventHelper.choiceHandle,
		[RougeMapEnum.EventType.Store] = RougeMapChoiceEventHelper.storeHandle,
		[RougeMapEnum.EventType.Rest] = RougeMapChoiceEventHelper.choiceHandle,
		[RougeMapEnum.EventType.WatchTower] = RougeMapChoiceEventHelper.choiceHandle,
		[RougeMapEnum.EventType.TreasurePlace] = RougeMapChoiceEventHelper.choiceHandle,
		[RougeMapEnum.EventType.ChoiceLair] = RougeMapChoiceEventHelper.choiceHandle,
		[RougeMapEnum.EventType.FightLair] = RougeMapChoiceEventHelper.continueFightEventHandle,
		[RougeMapEnum.EventType.Unknow] = RougeMapChoiceEventHelper.emptyHandle,
		[RougeMapEnum.EventType.LevelUpSp] = RougeMapChoiceEventHelper.choiceHandle
	}
end

function RougeMapChoiceEventHelper.emptyHandle(nodeMo)
	logNormal("empty handle")
end

function RougeMapChoiceEventHelper.fightHandle(nodeMo)
	logNormal("fight handle")

	if nodeMo:isStartedEvent() then
		return
	end

	local eventCo = nodeMo:getEventCo()
	local chapterId = RougeMapEnum.ChapterId
	local fightEventCo = RougeMapConfig.instance:getFightEvent(eventCo.id)
	local isUsing = RougeDLCHelper.isCurrentUsingVersions(fightEventCo.versionEpisode)

	if isUsing then
		if not fightEventCo.episodeIdInstead then
			local episodeId = fightEventCo.episodeId

			if episodeId and episodeId ~= 0 then
				DungeonFightController.instance:enterFight(chapterId, episodeId)
			else
				logError(string.format("尝试进入肉鸽战斗失败, 战斗事件 %s 中 episodeId and episodeIdInstead 不可为空", eventCo.id))
			end
		end
	end
end

function RougeMapChoiceEventHelper.continueFightEventHandle()
	logNormal("continue fight handle")
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onShowContinueFight)
end

function RougeMapChoiceEventHelper.storeHandle(nodeMo)
	logNormal("store handle")
	ViewMgr.instance:openView(ViewName.RougeStoreView, nodeMo.eventMo)
end

function RougeMapChoiceEventHelper.choiceHandle(nodeMo)
	logNormal("choice handle")
	ViewMgr.instance:openView(ViewName.RougeMapChoiceView, nodeMo)
end

function RougeMapChoiceEventHelper.triggerEventHandleOnChoiceView(nodeMo)
	if not nodeMo then
		RougeMapChoiceEventHelper.defaultHandleOnChoiceView()

		return
	end

	if nodeMo:checkIsStart() then
		RougeMapChoiceEventHelper.defaultHandleOnChoiceView()

		return
	end

	local eventMo = nodeMo.eventMo

	if eventMo.state == RougeMapEnum.EventState.Finish then
		RougeMapChoiceEventHelper.defaultHandleOnChoiceView()

		return
	end

	if eventMo.eventCo then
		local eventType = eventMo.eventCo.type

		RougeMapChoiceEventHelper._initEventHandleOnChoiceViewDict()

		local handle = RougeMapChoiceEventHelper._onChoiceViewHandleDict[eventType]

		if not handle then
			logError("not on choice view event handle event type : " .. tostring(eventType))
			RougeMapChoiceEventHelper.defaultHandleOnChoiceView()

			return
		end

		return handle(nodeMo)
	end
end

function RougeMapChoiceEventHelper.defaultHandleOnChoiceView()
	ViewMgr.instance:closeView(ViewName.RougeMapChoiceView)
end

function RougeMapChoiceEventHelper._initEventHandleOnChoiceViewDict()
	if RougeMapChoiceEventHelper._onChoiceViewHandleDict then
		return
	end

	RougeMapChoiceEventHelper._onChoiceViewHandleDict = {
		[RougeMapEnum.EventType.Empty] = RougeMapChoiceEventHelper.defaultHandleOnChoiceView,
		[RougeMapEnum.EventType.NormalFight] = RougeMapChoiceEventHelper.onChoiceViewFightHandle,
		[RougeMapEnum.EventType.HardFight] = RougeMapChoiceEventHelper.onChoiceViewFightHandle,
		[RougeMapEnum.EventType.EliteFight] = RougeMapChoiceEventHelper.onChoiceViewFightHandle,
		[RougeMapEnum.EventType.BossFight] = RougeMapChoiceEventHelper.onChoiceViewFightHandle,
		[RougeMapEnum.EventType.Reward] = RougeMapChoiceEventHelper.onChoiceViewChoiceHandle,
		[RougeMapEnum.EventType.Choice] = RougeMapChoiceEventHelper.onChoiceViewChoiceHandle,
		[RougeMapEnum.EventType.Store] = RougeMapChoiceEventHelper.onChoiceViewStoreHandle,
		[RougeMapEnum.EventType.Rest] = RougeMapChoiceEventHelper.onChoiceViewChoiceHandle,
		[RougeMapEnum.EventType.WatchTower] = RougeMapChoiceEventHelper.onChoiceViewChoiceHandle,
		[RougeMapEnum.EventType.TreasurePlace] = RougeMapChoiceEventHelper.onChoiceViewChoiceHandle,
		[RougeMapEnum.EventType.ChoiceLair] = RougeMapChoiceEventHelper.onChoiceViewChoiceHandle,
		[RougeMapEnum.EventType.FightLair] = RougeMapChoiceEventHelper.onChoiceViewFightHandle,
		[RougeMapEnum.EventType.LevelUpSp] = RougeMapChoiceEventHelper.onChoiceViewChoiceHandle
	}
end

function RougeMapChoiceEventHelper.onChoiceViewFightHandle(nodeMo)
	RougeMapChoiceEventHelper.defaultHandleOnChoiceView()
	RougeMapChoiceEventHelper.fightHandle(nodeMo)
end

function RougeMapChoiceEventHelper.onChoiceViewChoiceHandle(nodeMo)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onChoiceEventChange, nodeMo)
end

function RougeMapChoiceEventHelper.onChoiceViewStoreHandle(nodeMo)
	RougeMapChoiceEventHelper.defaultHandleOnChoiceView()
	ViewMgr.instance:openView(ViewName.RougeStoreView, nodeMo.eventMo)
end

function RougeMapChoiceEventHelper._getLevelUpMaxNum(nodeMo)
	if nodeMo then
		local eventMo = nodeMo and nodeMo.eventMo
		local jsonData = eventMo and eventMo.jsonData

		return jsonData and jsonData.collectionLevelUpNum
	end
end

return RougeMapChoiceEventHelper
