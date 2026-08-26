-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/model/V1a6_CachotRoomModel.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotRoomModel", package.seeall)

local V1a6_CachotRoomModel = class("V1a6_CachotRoomModel", BaseModel)

function V1a6_CachotRoomModel:onInit()
	self._isPlayerMoving = false
	self._layer = 0
	self._room = 0
	self._roomEvents = {}
	self.isFromDramaToDrama = false
	self.isLockPlayerMove = false
end

function V1a6_CachotRoomModel:reInit()
	self:onInit()
end

function V1a6_CachotRoomModel:clear()
	self._layer = 0
	self._room = 0
	self._roomEvents = {}

	self:clearRoomChangeStatus()
end

local posIndex = {
	{
		2
	},
	{
		1,
		3
	},
	{
		1,
		2,
		3
	}
}

function V1a6_CachotRoomModel:setLayerAndRoom(layer, room)
	if layer == self._layer and room == self._room then
		return
	end

	V1a6_CachotStatController.instance:statFinishRoom(self._room, self._layer)
	V1a6_CachotStatController.instance:statEnterRoom()

	self._isRoomChange = self._room and self._room ~= 0
	self._isLayerChange = self._layer and self._layer ~= 0 and layer > 1 and self._layer ~= layer
	self._layer = layer
	self._room = room

	self:refreshRoomEvents()
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.RoomChange)
end

function V1a6_CachotRoomModel:getRoomIsChange()
	return self._isRoomChange
end

function V1a6_CachotRoomModel:getLayerIsChange()
	return self._isLayerChange
end

function V1a6_CachotRoomModel:clearRoomChangeStatus()
	self._isRoomChange = false
	self._isLayerChange = false
end

function V1a6_CachotRoomModel:refreshRoomEvents()
	local rogueInfo = V1a6_CachotModel.instance:getRogueInfo()

	if not rogueInfo then
		return
	end

	self._roomEvents = {}

	if rogueInfo.isFinish then
		return
	end

	local haveSelectEvent = false
	local allSelectEventIds = {}

	for _, v in ipairs(rogueInfo.currentEvents) do
		if v.status ~= 0 then
			allSelectEventIds[v.eventId] = true
			haveSelectEvent = true
		end
	end

	local total = #rogueInfo.currentEvents

	total = math.min(total, 3)

	for i = 1, total do
		local eventMo = rogueInfo.currentEvents[i]

		if not haveSelectEvent or allSelectEventIds[eventMo.eventId] then
			eventMo.index = posIndex[total][i]

			table.insert(self._roomEvents, eventMo)
		end
	end

	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.RoomEventChange)
end

function V1a6_CachotRoomModel:tryAddSelectEvent(eventMo)
	for _, v in pairs(self._roomEvents) do
		if v.eventId == eventMo.eventId then
			v:init(eventMo)

			break
		end
	end

	local selectEvent
	local rogueInfo = V1a6_CachotModel.instance:getRogueInfo()

	for _, v in ipairs(rogueInfo.selectedEvents) do
		if v.eventId == eventMo.eventId then
			selectEvent = v

			v:init(eventMo)

			break
		end
	end

	if not selectEvent then
		local newEventMo = RogueEventMO.New()

		newEventMo:init(eventMo)
		table.insert(rogueInfo.selectedEvents, newEventMo)
		self:refreshRoomEvents()

		return newEventMo
	else
		V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.SelectEventChange, selectEvent)
	end
end

local changeConclusionEventId

function V1a6_CachotRoomModel:tryRemoveSelectEvent(eventMo)
	changeConclusionEventId = changeConclusionEventId or tonumber(lua_rogue_const.configDict[V1a6_CachotEnum.Const.ChangeConclusion].value)

	if eventMo.eventId == changeConclusionEventId then
		V1a6_CachotEventController.instance:setPause(true, V1a6_CachotEnum.EventPauseType.Tips)
		PopupController.instance:addPopupView(PopupEnum.PriorityType.CachotTips, ViewName.V1a6_CachotTipsView, {
			str = lua_rogue_const.configDict[V1a6_CachotEnum.Const.ChangeConclusion].value2,
			style = V1a6_CachotEnum.TipStyle.ChangeConclusion
		})
	end

	local rogueInfo = V1a6_CachotModel.instance:getRogueInfo()

	for k, v in ipairs(rogueInfo.selectedEvents) do
		if v.eventId == eventMo.eventId then
			v:init(eventMo)
			table.remove(rogueInfo.selectedEvents, k)
			V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.SelectEventRemove, v)

			break
		end
	end

	for _, v in pairs(self._roomEvents) do
		if v.eventId == eventMo.eventId then
			v:init(eventMo)
			self:refreshRoomEvents()
		end
	end
end

function V1a6_CachotRoomModel:getNowBattleEventMo()
	local status = ActivityHelper.getActivityStatus(V1a6_CachotEnum.ActivityId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		return
	end

	local rogueInfo = V1a6_CachotModel.instance:getRogueInfo()

	if not rogueInfo then
		return
	end

	local battleEventMo

	for i = 1, #rogueInfo.selectedEvents do
		local eventId = rogueInfo.selectedEvents[i].eventId

		if lua_rogue_event.configDict[eventId].type == V1a6_CachotEnum.EventType.Battle then
			battleEventMo = rogueInfo.selectedEvents[i]

			break
		end
	end

	return battleEventMo
end

function V1a6_CachotRoomModel:getNowTopEventMo()
	local rogueInfo = V1a6_CachotModel.instance:getRogueInfo()

	if not rogueInfo or #rogueInfo.selectedEvents == 0 then
		return
	end

	return rogueInfo.selectedEvents[#rogueInfo.selectedEvents]
end

function V1a6_CachotRoomModel:getIsMoving()
	return self._isPlayerMoving
end

function V1a6_CachotRoomModel:setIsMoving(isMoving)
	if self._isPlayerMoving == isMoving then
		return
	end

	self._isPlayerMoving = isMoving

	if isMoving then
		V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.PlayerBeginMove)
	else
		V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.PlayerStopMove)
	end
end

function V1a6_CachotRoomModel:getRoomEventMos()
	return self._roomEvents
end

function V1a6_CachotRoomModel:getNearEventMo()
	return self._nearEventMo
end

function V1a6_CachotRoomModel:setNearEventMo(mo)
	if mo == self._nearEventMo then
		return
	end

	self._nearEventMo = mo

	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.NearEventMoChange, mo)
end

V1a6_CachotRoomModel.instance = V1a6_CachotRoomModel.New()

return V1a6_CachotRoomModel
