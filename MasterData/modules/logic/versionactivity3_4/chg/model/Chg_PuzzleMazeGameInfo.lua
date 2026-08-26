-- chunkname: @modules/logic/versionactivity3_4/chg/model/Chg_PuzzleMazeGameInfo.lua

module("modules.logic.versionactivity3_4.chg.model.Chg_PuzzleMazeGameInfo", package.seeall)

local Chg_PuzzleMazeGameInfo = class("Chg_PuzzleMazeGameInfo")

function Chg_PuzzleMazeGameInfo:ctor(mapMO)
	self._mapMO = mapMO

	self:clear()
end

function Chg_PuzzleMazeGameInfo:clear()
	self.__info = false
end

function Chg_PuzzleMazeGameInfo:reset(jsonStr)
	self:clear()

	self.__info = cjson.decode(jsonStr)
end

function Chg_PuzzleMazeGameInfo:mapCO()
	return self.__info
end

function Chg_PuzzleMazeGameInfo:roundList()
	if not self.__info then
		return {}
	end

	return self.__info.roundList
end

function Chg_PuzzleMazeGameInfo:roundCount()
	return #self:roundList()
end

function Chg_PuzzleMazeGameInfo:curRoundCO()
	local index = self._mapMO:curRound() or 1

	return (self.__info or nil) and (self.__info.roundList[index] or {})
end

function Chg_PuzzleMazeGameInfo:energy()
	return (self.__info or nil) and (self.__info.energy or 0)
end

function Chg_PuzzleMazeGameInfo:v3a4_spriteName()
	return (self.__info or nil) and (self.__info.v3a4_spriteName or "")
end

function Chg_PuzzleMazeGameInfo:mapSize()
	if not self.__info then
		return 0, 0
	end

	local curRoundCO = self:curRoundCO()

	if not curRoundCO.width then
		if not curRoundCO.height then
			local height = 0

			return curRoundCO.width, height
		end
	end
end

function Chg_PuzzleMazeGameInfo:addEnergyBeginRound()
	if not self.__info then
		return 0
	end

	local curRoundCO = self:curRoundCO()

	if not curRoundCO.addEnergyBeginRound then
		return curRoundCO.addEnergyBeginRound
	end
end

return Chg_PuzzleMazeGameInfo
