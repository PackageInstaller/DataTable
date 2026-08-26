-- chunkname: @modules/logic/fight/model/FightMagicCircleInfo.lua

module("modules.logic.fight.model.FightMagicCircleInfo", package.seeall)

local FightMagicCircleInfo = pureTable("FightMagicCircleInfo")

function FightMagicCircleInfo:ctor()
	self.magicCircleId = nil
end

function FightMagicCircleInfo:refreshData(data)
	self.magicCircleId = data.magicCircleId
	self.round = data.round
	self.createUid = data.createUid
	self.electricLevel = data.electricLevel
	self.electricProgress = data.electricProgress
	self.maxElectricProgress = data.maxElectricProgress
end

function FightMagicCircleInfo:deleteData(id)
	if id == self.magicCircleId then
		self.magicCircleId = nil

		return true
	end
end

function FightMagicCircleInfo:clear()
	self.magicCircleId = nil
	self.round = nil
	self.createUid = nil
	self.electricLevel = nil
	self.electricProgress = nil
	self.maxElectricProgress = nil
end

return FightMagicCircleInfo
