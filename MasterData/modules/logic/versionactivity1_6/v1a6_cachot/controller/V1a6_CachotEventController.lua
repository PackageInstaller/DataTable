-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/controller/V1a6_CachotEventController.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.controller.V1a6_CachotEventController", package.seeall)

local V1a6_CachotEventController = class("V1a6_CachotEventController", BaseController)
local eventChangeReTriggerTypes = {
	[V1a6_CachotEnum.EventType.CollectionSelect] = true
}

function V1a6_CachotEventController:onInit()
	self._pauseType = {}
end

function V1a6_CachotEventController:reInit()
	self._pauseType = {}
end

function V1a6_CachotEventController:addConstEvents()
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.PlayerTriggerInteract, self.triggerEvent, self)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.SelectEventChange, self.selectEventChange, self)
end

function V1a6_CachotEventController:triggerEvent(eventMo, ...)
	if not self._eventFuncs then
		self:_buildEventFuncs()
	end

	if self:isPause() then
		self._nextEventList = self._nextEventList or {}

		table.insert(self._nextEventList, {
			eventMo,
			...
		})

		return
	end

	local eventCo = lua_rogue_event.configDict[eventMo.eventId]

	if not eventCo then
		return
	end

	local func = self._eventFuncs[eventCo.type]

	if func then
		func(self, eventMo, ...)
	else
		logError("未处理事件类型 " .. eventCo.type .. " id:" .. eventMo.eventId)
	end
end

function V1a6_CachotEventController:selectEventChange(eventMo)
	local eventCo = lua_rogue_event.configDict[eventMo.eventId]

	if not eventCo then
		return
	end

	if eventChangeReTriggerTypes[eventCo.type] then
		self:triggerEvent(eventMo)
	end
end

function V1a6_CachotEventController:isPause()
	return not not next(self._pauseType)
end

function V1a6_CachotEventController:setPause(isPause, pauseType)
	pauseType = pauseType or V1a6_CachotEnum.EventPauseType.Normal
	self._pauseType[pauseType] = isPause and true or nil

	if not self:isPause() and self._nextEventList then
		for _, v in ipairs(self._nextEventList) do
			self:triggerEvent(unpack(v))
		end

		self._nextEventList = nil
	end
end

function V1a6_CachotEventController:getNoCloseViews()
	return {
		ViewName.V1a6_CachotStoreView,
		ViewName.V1a6_CachotRewardView,
		ViewName.V1a6_CachotEpisodeView,
		ViewName.V1a6_CachotInteractView,
		ViewName.V1a6_CachotCollectionSelectView,
		ViewName.V1a6_CachotUpgradeView,
		ViewName.V1a6_CachotRoleRecoverView,
		ViewName.V1a6_CachotRoleRevivalView
	}
end

function V1a6_CachotEventController:_buildEventFuncs()
	self._eventFuncs = {}
	self._eventFuncs[V1a6_CachotEnum.EventType.Battle] = self.triggerBattle
	self._eventFuncs[V1a6_CachotEnum.EventType.HeroPosUpgrade] = self.triggerHeroPosUpgrade
	self._eventFuncs[V1a6_CachotEnum.EventType.ChoiceSelect] = self.triggerChoiceSelect
	self._eventFuncs[V1a6_CachotEnum.EventType.CharacterGet] = self.triggerCharacterGet
	self._eventFuncs[V1a6_CachotEnum.EventType.CharacterCure] = self.triggerCharacterCure
	self._eventFuncs[V1a6_CachotEnum.EventType.CharacterRebirth] = self.triggerCharacterRebirth
	self._eventFuncs[V1a6_CachotEnum.EventType.Store] = self.triggerStore
	self._eventFuncs[V1a6_CachotEnum.EventType.CollectionSelect] = self.triggerCollectionSelect
end

function V1a6_CachotEventController:triggerBattle(eventMo)
	local eventCo = lua_rogue_event.configDict[eventMo.eventId]

	if not eventCo then
		return
	end

	if eventMo:isBattleSuccess() then
		V1a6_CachotController.instance:openV1a6_CachotRewardView(eventMo)

		return
	end

	local eventFightCo = lua_rogue_event_fight.configDict[eventCo.eventId]

	if not eventFightCo then
		return
	end

	local episodeId = eventFightCo.episode
	local config = DungeonConfig.instance:getEpisodeCO(episodeId)

	DungeonFightController.instance:enterFight(config.chapterId, episodeId)
end

function V1a6_CachotEventController:triggerCollectionSelect(eventMo)
	local dropList = eventMo:getDropList()

	if not dropList or #dropList <= 0 then
		return
	end

	local dropMo = dropList[1]

	if dropMo.type == "COLLECTION" then
		self._dropIndex = dropMo.idx

		local viewParam = {}

		viewParam.selectCallback = self._onCollectionSelect
		viewParam.selectCallbackObj = self
		viewParam.collectionList = dropMo.colletionList

		V1a6_CachotController.instance:openV1a6_CachotCollectionSelectView(viewParam)
	end
end

function V1a6_CachotEventController:_onCollectionSelect(index)
	local topEventMo = V1a6_CachotRoomModel.instance:getNowTopEventMo()

	if not topEventMo or not self._dropIndex then
		return
	end

	RogueRpc.instance:sendRogueEventFightRewardRequest(V1a6_CachotEnum.ActivityId, topEventMo.eventId, self._dropIndex, index)
end

function V1a6_CachotEventController:triggerHeroPosUpgrade(eventMo)
	V1a6_CachotController.instance:openV1a6_CachotUpgradeView(eventMo)
end

function V1a6_CachotEventController:triggerChoiceSelect(eventMo)
	V1a6_CachotController.instance:openV1a6_CachotEpisodeView(eventMo)
end

function V1a6_CachotEventController:triggerCharacterGet(eventMo)
	V1a6_CachotController.instance:selectHeroFromEvent(eventMo)
end

function V1a6_CachotEventController:triggerCharacterCure(eventMo)
	V1a6_CachotController.instance:openV1a6_CachotRoleRecoverView(eventMo)
end

function V1a6_CachotEventController:triggerCharacterRebirth(eventMo)
	V1a6_CachotController.instance:openV1a6_CachotRoleRevivalView(eventMo)
end

function V1a6_CachotEventController:triggerStore(eventMo)
	V1a6_CachotController.instance:openV1a6_CachotStoreView(eventMo)
end

V1a6_CachotEventController.instance = V1a6_CachotEventController.New()

return V1a6_CachotEventController
