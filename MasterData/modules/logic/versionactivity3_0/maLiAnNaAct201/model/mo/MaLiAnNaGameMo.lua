-- chunkname: @modules/logic/versionactivity3_0/maLiAnNaAct201/model/mo/MaLiAnNaGameMo.lua

module("modules.logic.versionactivity3_0.maLiAnNaAct201.model.mo.MaLiAnNaGameMo", package.seeall)

local MaLiAnNaGameMo = class("MaLiAnNaGameMo", MaLiAnNaLaLevelMo)

function MaLiAnNaGameMo.create(id)
	local instance = MaLiAnNaGameMo.New()

	instance.id = id

	return instance
end

function MaLiAnNaGameMo:_initSlot(data)
	if data.slots ~= nil then
		for _, slotData in pairs(data.slots) do
			self.slots[slotData.id] = MaLiAnNaGameSlotMo.create(slotData)
		end
	end
end

function MaLiAnNaGameMo:_initRoad(data)
	if data.roads ~= nil then
		for _, roadData in pairs(data.roads) do
			local road = MaLiAnNaLaLevelMoRoad.create(roadData.id, roadData._roadType)

			road:updatePos(roadData.beginPosX, roadData.beginPosY, roadData.endPosX, roadData.endPosY)
			road:updateSlot(roadData._beginSlotId, roadData._endSlotId)
			table.insert(self.roads, road)
		end
	end

	self:_initRoadGraph()
end

function MaLiAnNaGameMo:update(deltaTime)
	if self.slots ~= nil then
		for _, slot in pairs(self.slots) do
			if slot ~= nil then
				slot:update(deltaTime)
			end
		end
	end
end

function MaLiAnNaGameMo:_initRoadGraph()
	if self._roadGraph == nil then
		self._roadGraph = {}
	end

	for i = 1, #self.roads do
		local road = self.roads[i]

		if road._beginSlotId ~= 0 and road._endSlotId ~= 0 then
			if self._roadGraph[road._beginSlotId] == nil then
				self._roadGraph[road._beginSlotId] = {}
			end

			if self._roadGraph[road._endSlotId] == nil then
				self._roadGraph[road._endSlotId] = {}
			end

			table.insert(self._roadGraph[road._beginSlotId], road._endSlotId)
			table.insert(self._roadGraph[road._endSlotId], road._beginSlotId)
		end
	end
end

function MaLiAnNaGameMo:getRoadGraph()
	return self._roadGraph
end

function MaLiAnNaGameMo:getAllSlot()
	return self.slots
end

function MaLiAnNaGameMo:getAllRoad()
	return self.roads
end

function MaLiAnNaGameMo:getSlotById(id)
	if self.slots == nil then
		return nil
	end

	return self.slots[id]
end

function MaLiAnNaGameMo:getSlotByConfigId(configId)
	if self.slots == nil then
		return nil
	end

	for _, slot in pairs(self.slots) do
		if slot.configId == configId then
			return slot
		end
	end

	return nil
end

function MaLiAnNaGameMo:haveRoad(slotIdA, slotIdB)
	if self.roads == nil then
		return false
	end

	for _, road in pairs(self.roads) do
		if road:haveSlot(slotIdA, slotIdB) then
			return true
		end
	end

	return false
end

function MaLiAnNaGameMo:destroy()
	if self.slots ~= nil then
		for _, slot in pairs(self.slots) do
			if slot then
				slot:destroy()
			end
		end

		self.slots = nil
	end
end

return MaLiAnNaGameMo
