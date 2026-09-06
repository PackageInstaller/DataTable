-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/threeelimination/model/ThreeEliminationBattleCellMO.lua

module("logic.extensions.threeelimination.model.ThreeEliminationBattleCellMO", package.seeall)

local ThreeEliminationBattleCellMO = class("ThreeEliminationBattleCellMO")

function ThreeEliminationBattleCellMO:ctor()
	self._power = 0
	self.type = 0
end

function ThreeEliminationBattleCellMO:initCell(activityId, type)
	self.type = type

	local petCfg = ThreeEliminationConfig.instance:getPetCfg(activityId, type)
	local qualityCfg = ThreeEliminationConfig.instance:getQualityCfg(activityId, petCfg.quality)
	local gameLv = ThreeEliminationOtherModel.instance:getPlayerLv()

	self._power = qualityCfg[gameLv].zdl + ThreeEliminationOtherModel.instance:getAddPowerByRaceType(petCfg.raceType)
end

function ThreeEliminationBattleCellMO:getPower()
	return self._power
end

function ThreeEliminationBattleCellMO:battleWithPower(emenyPower)
	self._power = math.max(self._power - emenyPower, 0)
end

return ThreeEliminationBattleCellMO
