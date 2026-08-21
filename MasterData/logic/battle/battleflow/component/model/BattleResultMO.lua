-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/model/BattleResultMO.lua

module("logic.battle.battleflow.component.model.BattleResultMO", package.seeall)

local BattleResultMO = class("BattleResultMO")

function BattleResultMO:ctor()
	self._winnerCampIds = {}
	self._loserCampIds = {}
	self._isSurrender = false
	self._isValid = false
	self._isSkip = false
	self._isRealEnd = false
end

function BattleResultMO:clear()
	self._isValid = false
	self._isSurrender = false
	self._isSkip = false
	self._isRealEnd = false

	BattleTableUtil.clearTable(self._winnerCampIds)
	BattleTableUtil.clearTable(self._loserCampIds)
end

function BattleResultMO:setSurrender(isSurrender)
	self._isSurrender = isSurrender
end

function BattleResultMO:setSkip(isSkip)
	self._isSkip = isSkip
end

function BattleResultMO:setWinnerCampIds(winnerCampIds)
	self._isValid = true

	table.insertto(self._winnerCampIds, winnerCampIds)
end

function BattleResultMO:setLoserCampIds(loserCampIds)
	table.insertto(self._loserCampIds, loserCampIds)
end

function BattleResultMO:isWinnerCampId(campId)
	local index = table.indexof(self._winnerCampIds, campId)

	return index and true or false
end

function BattleResultMO:isLoserCampId(campId)
	local index = table.indexof(self._loserCampIds, campId)

	return index and true or false
end

function BattleResultMO:isSurrender()
	return self._isSurrender
end

function BattleResultMO:isSkip()
	return self._isSkip
end

function BattleResultMO:isValid()
	return self._isValid
end

function BattleResultMO:setRealEnd(realEnd)
	self._isRealEnd = realEnd
end

function BattleResultMO:isRealEnd()
	return self._isRealEnd
end

function BattleResultMO:internal_reset()
	self:clear()
end

return BattleResultMO
