-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamteam/model/DreamTeamModel.lua

module("logic.extensions.dreamteam.model.DreamTeamModel", package.seeall)

local DreamTeamModel = class("DreamTeamModel", BaseModel)

function DreamTeamModel:ctor()
	return
end

function DreamTeamModel:onInit()
	self:onReset()
end

function DreamTeamModel:onReset()
	self._energy = 0
	self._hasGainOutPrizeIds = {}
	self._dailyUsedTimes = 0
	self._hasGainGlobalPrizeIds = {}
	self._globalGainNum = 0
	self._isFirstGetInfo = true
	self._animData = nil
end

function DreamTeamModel:onGetInfoRes(msg)
	if not self._isFirstGetInfo then
		self:_updateAnimData(self._energy, msg.energy)
	else
		self._isFirstGetInfo = false
	end

	self._energy = msg.energy
	self._hasGainOutPrizeIds = msg.hasGainOutPrizeIds or {}
	self._dailyUsedTimes = msg.dailyUsedTimes
	self._hasGainGlobalPrizeIds = msg.hasGainGlobalPrizeIds
	self._globalGainNum = msg.globalGainNum
end

function DreamTeamModel:_updateAnimData(oldEnergy, newEnergy)
	self._animData = {
		oldEnergy = oldEnergy,
		newEnergy = newEnergy
	}
end

function DreamTeamModel:getAnimData()
	self._animData = nil

	return self._animData
end

function DreamTeamModel:getUsedTimes()
	return self._dailyUsedTimes
end

function DreamTeamModel:getEnergy()
	return self._energy
end

function DreamTeamModel:getGlobalGainNum()
	return self._globalGainNum
end

function DreamTeamModel:isGetedGlobalPrize(id)
	return TableUtil.isHad(self._hasGainGlobalPrizeIds, id)
end

function DreamTeamModel:updateGainOutPrizeIds(id)
	if not self:isGainOutPrizeById(id) then
		table.insert(self._hasGainOutPrizeIds, id)
	end
end

function DreamTeamModel:updateGlobalPrizeIds(id)
	if not self:isGetedGlobalPrize(id) then
		table.insert(self._hasGainGlobalPrizeIds, id)
	end
end

function DreamTeamModel:isGainOutPrizeById(id)
	for i, v in pairs(self._hasGainOutPrizeIds) do
		if v == id then
			return true
		end
	end

	return false
end

function DreamTeamModel:isGetAllOutPrizeIds()
	return #self._hasGainOutPrizeIds >= 5
end

DreamTeamModel.instance = DreamTeamModel.New()

return DreamTeamModel
