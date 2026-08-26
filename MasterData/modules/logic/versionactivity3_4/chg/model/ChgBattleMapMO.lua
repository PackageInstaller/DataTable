-- chunkname: @modules/logic/versionactivity3_4/chg/model/ChgBattleMapMO.lua

module("modules.logic.versionactivity3_4.chg.model.ChgBattleMapMO", package.seeall)

local ChgBattleMapMO = class("ChgBattleMapMO")

function ChgBattleMapMO:ctor()
	self._curEnergy = 0
	self._curRound = 1
	self._curRoundMO = ChgBattleMapRoundMO.New(self)
end

function ChgBattleMapMO.default_ctor(Self, memberName)
	local newMapMO = ChgBattleMapMO.New()

	newMapMO.__info = Chg_PuzzleMazeGameInfo.New(newMapMO)
	Self[memberName] = newMapMO
end

function ChgBattleMapMO:curRoundMO()
	return self._curRoundMO
end

function ChgBattleMapMO:curRound()
	return self._curRound
end

function ChgBattleMapMO:roundCount()
	return self.__info:roundCount()
end

function ChgBattleMapMO:curRoundCO()
	return self.__info:curRoundCO()
end

function ChgBattleMapMO:restart(jsonStr)
	self._curRound = 1

	self.__info:reset(jsonStr)
	self:setEnergy(self:maxEnergy())
	self:restartRound(true)
end

function ChgBattleMapMO:setEnergy(value)
	self._curEnergy = GameUtil.clamp(value, 0, self:maxEnergy())
end

function ChgBattleMapMO:curEnergy()
	return self._curEnergy
end

function ChgBattleMapMO:maxEnergy()
	return self.__info:energy()
end

function ChgBattleMapMO:addEnergyBeginRound()
	return self.__info:addEnergyBeginRound()
end

function ChgBattleMapMO:v3a4_spriteName()
	return self.__info:v3a4_spriteName()
end

function ChgBattleMapMO:mapSize()
	return self.__info:mapSize()
end

function ChgBattleMapMO:gridRowCol()
	local col, row = self:mapSize()

	return row, col
end

function ChgBattleMapMO:vertexRowCol()
	local row, col = self:gridRowCol()

	return row + 1, col + 1
end

function ChgBattleMapMO:setRound(newRound)
	self._curRound = newRound
end

function ChgBattleMapMO:restartRound(isNewRound)
	if isNewRound then
		self._curRoundMO:setStartEnergy(nil)
	else
		local startEnergy = self._curRoundMO:getStartEnergy()

		self:setEnergy(startEnergy)
	end

	self._curRoundMO:restart()
end

function ChgBattleMapMO:clampKey(x1, y1, x2, y2)
	local maxRow, maxCol = self:vertexRowCol()

	x1 = x1 and GameUtil.clamp(x1, 1, maxCol)
	x2 = x2 and GameUtil.clamp(x2, 1, maxCol)
	y1 = y1 and GameUtil.clamp(y1, 1, maxRow)
	y2 = y2 and GameUtil.clamp(y2, 1, maxRow)

	return x1, y1, x2, y2
end

return ChgBattleMapMO
