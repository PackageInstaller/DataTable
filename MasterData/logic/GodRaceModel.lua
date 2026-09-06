-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godrace/model/GodRaceModel.lua

module("logic.extensions.godrace.model.GodRaceModel", package.seeall)

local GodRaceModel = class("GodRaceModel", BaseModel)

function GodRaceModel:ctor()
	GodRaceModel.super.ctor(self)
end

function GodRaceModel:onInit()
	self._wakedRaceIds = {}
	self._canWakeWithSlotList = {}
end

function GodRaceModel:onReset()
	return
end

function GodRaceModel:setWaked(wakedIds)
	self._wakedRaceIds = wakedIds
end

function GodRaceModel:addWaked(wakedId)
	table.insert(self._wakedRaceIds, wakedId)
end

function GodRaceModel:isWaked(raceId)
	if self._wakedRaceIds then
		for i, v in ipairs(self._wakedRaceIds) do
			if raceId == v then
				return true
			end
		end
	end

	return false
end

function GodRaceModel:setCanWakeWithSlot(list)
	self._canWakeWithSlotList = list
end

function GodRaceModel:getWakeInfo(raceId)
	local ret = {}

	if self._canWakeWithSlotLis then
		for i, v in ipairs(self._canWakeWithSlotLis) do
			if v.raceIdBefore == raceId then
				ret.pet1 = v.leftSlotIsPutPet
				ret.pet2 = v.rightSlotIsPutPet
			end
		end
	end

	return ret
end

GodRaceModel.instance = GodRaceModel.New()

return GodRaceModel
