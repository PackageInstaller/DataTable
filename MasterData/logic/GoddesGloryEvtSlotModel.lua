-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessglory/model/GoddesGloryEvtSlotModel.lua

module("logic.extensions.goddessglory.model.GoddesGloryEvtSlotModel", package.seeall)

local GoddesGloryEvtSlotModel = class("GoddesGloryEvtSlotModel", BaseModel)

function GoddesGloryEvtSlotModel:onInit()
	self:onReset()
end

function GoddesGloryEvtSlotModel:onReset()
	self:clearSlots()
end

function GoddesGloryEvtSlotModel:clearSlots()
	self._slots = nil
	self._challengeId = 0
	self._stageId = 0
end

function GoddesGloryEvtSlotModel:getSlots()
	local challengeId = GoddessGloryModel.instance:getCurGoddessGloryId()
	local stageId = GoddessGloryModel.instance:getCurStageId()

	if challengeId ~= self._challengeId or self._stageId ~= stageId then
		self:clearSlots()
	end

	if not self._slots then
		self._slots = {}

		for i = 1, 3 do
			local slot = GoddesGloryEvtSlotMO.New()

			table.insert(self._slots, slot)
		end
	end

	local lastSlots

	for k, v in pairs(self._slots) do
		if v.event then
			v.event = GoddessGloryModel.instance:getEvent(challengeId, stageId, v.event.instanceId)
		end

		local slot = GoddesGloryEvtSlotMO.New()

		slot.event = v.event
		lastSlots = lastSlots or {}
		lastSlots[k] = slot
	end

	self._challengeId = challengeId
	self._stageId = stageId

	for i = 1, 3 do
		local slot = self._slots[i]

		if slot.event and slot.event.eventState ~= GoddessGloryEvtStatus.Executing then
			slot.event = nil
		end
	end

	local stageMO = GoddessGloryModel.instance:getGoddessGloryStage(challengeId, stageId)
	local events = stageMO:getCurExecutingEvts()

	for i = 1, #events do
		if not self:isEventInSlot(events[i].instanceId) then
			local emptySlot = self:getEmptySlot()

			emptySlot.event = events[i]
		end
	end

	local bossIndex, bossSlot

	for i = 1, #self._slots do
		local event = self._slots[i].event

		if event then
			local evtCo = GoddessGloryConfig.instance:getEventCo(event.eventId)

			if evtCo.type == GoddessGloryEvtType.Challenge and evtCo.isBossEvent then
				bossIndex = i
				bossSlot = self._slots[i]

				break
			end
		end
	end

	if bossIndex then
		self._slots[2] = bossSlot
		self._slots[bossIndex] = self._slots[2]
	end

	return self._slots, lastSlots
end

function GoddesGloryEvtSlotModel:isEventInSlot(instanceId)
	if not self._slots then
		return false
	end

	for i = 1, #self._slots do
		if self._slots[i].event and self._slots[i].event.instanceId == instanceId then
			return true
		end
	end

	return false
end

function GoddesGloryEvtSlotModel:getEmptySlot()
	if not self._slots then
		return
	end

	for i = 1, #self._slots do
		if not self._slots[i].event or self._slots[i].event.eventState ~= GoddessGloryEvtStatus.Executing then
			return self._slots[i]
		end
	end
end

GoddesGloryEvtSlotModel.instance = GoddesGloryEvtSlotModel.New()

return GoddesGloryEvtSlotModel
