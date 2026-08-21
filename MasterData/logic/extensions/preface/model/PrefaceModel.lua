-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/preface/model/PrefaceModel.lua

module("logic.extensions.preface.model.PrefaceModel", package.seeall)

local M = class("PrefaceModel")

function M:setInfo(info)
	self._dungeonCode = info.dungeonCode
	self._dungeonCo = DungeonConfig.instance:getDungeonCfgById(self._dungeonCode)
	self._isShowPlot = info.isShowPlot
	self._hasAfflatusBuff = info.afflatusBuff
	self._multiCount = info.multiCount
	self._dungeonIndex = info.dungeonIndex
	self._isNotReturnDungeon = false
	self._gamePlay = BattleEnum.GamePlayType.NORMAL
end

function M:getDungeonType()
	return self._dungeonCo.type
end

function M:getDungeonCode()
	return self._dungeonCode
end

function M:getDungeonCo()
	return self._dungeonCo
end

function M:getDungeonStarRequire()
	return self._dungeonCo and self._dungeonCo.starRequire or false
end

function M:getPlotCodeBeforeBattle()
	return self._dungeonCo and self._dungeonCo.plotBeforeBattle or false
end

function M:getPlotCodeAfterBattle()
	return self._dungeonCo and self._dungeonCo.plotAfterBattle or false
end

function M:getDungeonBGM()
	local dungeonCO = DungeonConfig.instance:getDungeonCfgById(self._dungeonCode)

	if dungeonCO and dungeonCO.bgmName and dungeonCO.bgmName ~= "" then
		return dungeonCO.bgmName
	else
		return "battlebgm1"
	end
end

function M:getDungeonSpaceAudio()
	local dungeonCO = DungeonConfig.instance:getDungeonCfgById(self._dungeonCode)

	if dungeonCO and dungeonCO.spaceAudioName and dungeonCO.spaceAudioName ~= "" then
		return dungeonCO.spaceAudioName
	else
		return "amb_battle_city"
	end
end

function M:getDungeonIndex()
	return self._dungeonIndex
end

function M:setBattleIsWin(win)
	self._isWin = win
end

function M:getBattleIsWin()
	return self._isWin
end

function M:setIsNotReturnDungeon(status)
	self._isNotReturnDungeon = status
end

function M:getIsNotReturnDungeon()
	return self._isNotReturnDungeon
end

function M:getPlotCodeAfterReady()
	return self._dungeonCo.plotAfterReady
end

function M:isShowPlot()
	return self._isShowPlot
end

function M:isHaveAfflatusBuff()
	return self._hasAfflatusBuff
end

function M:getMultiCount()
	return self._multiCount
end

function M:getGamePlay()
	return self._gamePlay
end

return M
