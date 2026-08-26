-- chunkname: @modules/logic/versionactivity3_0/maLiAnNaAct201/model/mo/base/MaLiAnNaLaLevelMoRoad.lua

module("modules.logic.versionactivity3_0.maLiAnNaAct201.model.mo.base.MaLiAnNaLaLevelMoRoad", package.seeall)

local MaLiAnNaLaLevelMoRoad = class("MaLiAnNaLaLevelMoRoad")

function MaLiAnNaLaLevelMoRoad.create(id, roadType)
	local instance = MaLiAnNaLaLevelMoRoad.New()

	instance.id = id

	if roadType ~= nil then
		instance._roadType = roadType
	end

	return instance
end

function MaLiAnNaLaLevelMoRoad:ctor()
	self.id = 0
	self.beginPosX = 0
	self.beginPosY = 0
	self.endPosX = 0
	self.endPosY = 0
	self._roadType = Activity201MaLiAnNaEnum.RoadType.RailWay
	self._beginSlotId = 0
	self._endSlotId = 0
end

function MaLiAnNaLaLevelMoRoad:updatePos(beginPosX, beginPosY, endPosX, endPosY)
	self.beginPosX = beginPosX
	self.beginPosY = beginPosY
	self.endPosX = endPosX
	self.endPosY = endPosY
end

function MaLiAnNaLaLevelMoRoad:getBeginPos()
	return self.beginPosX, self.beginPosY
end

function MaLiAnNaLaLevelMoRoad:getEndPos()
	return self.endPosX, self.endPosY
end

function MaLiAnNaLaLevelMoRoad:updateSlot(beginSlotId, endSlotId)
	self._beginSlotId = beginSlotId
	self._endSlotId = endSlotId
end

function MaLiAnNaLaLevelMoRoad:haveSlot(slotIdA, slotIdB)
	if self._beginSlotId == slotIdA and self._endSlotId == slotIdB then
		return true
	end

	if self._beginSlotId == slotIdB and self._endSlotId == slotIdA then
		return true
	end

	return false
end

function MaLiAnNaLaLevelMoRoad:findHaveSlot(slotId)
	local haveSlot = false
	local otherSlotId

	if self._beginSlotId == slotId then
		haveSlot = true
		otherSlotId = self._endSlotId
	end

	if self._endSlotId == slotId then
		haveSlot = true
		otherSlotId = self._beginSlotId
	end

	return haveSlot, otherSlotId
end

function MaLiAnNaLaLevelMoRoad:getStr()
	return string.format("id = %d, beginPosX = %d, beginPosY = %d, endPosX = %d, endPosY = %d, beginSlotId = %d, endSlotId = %d, roadType = %d", self.id, self.beginPosX, self.beginPosY, self.endPosX, self.endPosY, self._beginSlotId, self._endSlotId, self._roadType)
end

return MaLiAnNaLaLevelMoRoad
