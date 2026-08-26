-- chunkname: @modules/logic/versionactivity3_0/maLiAnNaAct201/model/mo/base/MaLiAnNaLaLevelMo.lua

module("modules.logic.versionactivity3_0.maLiAnNaAct201.model.mo.base.MaLiAnNaLaLevelMo", package.seeall)

local MaLiAnNaLaLevelMo = class("MaLiAnNaLaLevelMo")

function MaLiAnNaLaLevelMo.create(id)
	local instance = MaLiAnNaLaLevelMo.New()

	instance.id = id

	return instance
end

function MaLiAnNaLaLevelMo:ctor()
	self.id = 0
	self.slots = {}
	self.roads = {}
end

function MaLiAnNaLaLevelMo:init(data)
	if data == nil then
		return
	end

	self.id = data.id

	self:_initSlot(data)
	self:_initRoad(data)
end

function MaLiAnNaLaLevelMo:_initSlot(data)
	if data.slots ~= nil then
		for _, slotData in pairs(data.slots) do
			local slot = MaLiAnNaLaLevelMoSlot.create(slotData.configId, slotData.id)

			slot:updateHeroId(slotData.heroId)
			slot:updatePos(slotData.posX, slotData.posY)
			table.insert(self.slots, slot)
		end
	end
end

function MaLiAnNaLaLevelMo:_initRoad(data)
	if data.roads ~= nil then
		for _, roadData in pairs(data.roads) do
			local road = MaLiAnNaLaLevelMoRoad.create(roadData.id, roadData.roadType)

			road:updatePos(roadData.beginPosX, roadData.beginPosY, roadData.endPosX, roadData.endPosY)
			road:updateSlot(roadData.beginSlotId, roadData.endSlotId)
			table.insert(self.roads, road)
		end
	end
end

function MaLiAnNaLaLevelMo:getStr()
	local str = string.format("id = %d ,", self.id)

	if self.slots ~= nil then
		str = str .. "slots = { "

		for _, slot in pairs(self.slots) do
			str = str .. "{ " .. slot:getStr() .. " }, "
		end

		str = str .. "}, "
	end

	if self.roads ~= nil then
		str = str .. "roads = { "

		for _, road in pairs(self.roads) do
			str = str .. "{ " .. road:getStr() .. " }, "
		end

		str = str .. "}, "
	end

	return str
end

return MaLiAnNaLaLevelMo
