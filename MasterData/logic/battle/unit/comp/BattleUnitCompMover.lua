-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/unit/comp/BattleUnitCompMover.lua

module("logic.battle.unit.comp.BattleUnitCompMover", package.seeall)

local BattleUnitCompMover = class("BattleUnitCompMover", UnitCompMover)

function BattleUnitCompMover:onInit()
	BattleUnitCompMover.super.onInit(self)

	self._timeScale = 1
	self._baseSpeed = 1
	self._tempSpeedFactor = 1
	self._moveAudio = CriwareAudioEnum.grox_run
end

function BattleUnitCompMover:onReset()
	self:clearWayPoints()

	self._timeScale = 1
	self._baseSpeed = 1
	self._tempSpeedFactor = 1
	self._moveAudio = CriwareAudioEnum.grox_run
end

function BattleUnitCompMover:onUpdateTimeScale(timeScale)
	self._timeScale = timeScale

	self:_updateSpeed()
end

function BattleUnitCompMover:setSpeed(speed)
	self._baseSpeed = speed

	self:_updateSpeed()
end

function BattleUnitCompMover:setTempSpeedFactor(speed)
	self._tempSpeedFactor = speed

	self:_updateSpeed()
end

function BattleUnitCompMover:resetTempSpeedFactor()
	self._tempSpeedFactor = 1

	self:_updateSpeed()
end

function BattleUnitCompMover:forceSyncPosition()
	local x, z = self:getPos()

	self:setPosDirectly(x, z)
end

function BattleUnitCompMover:_updateSpeed()
	BattleUnitCompMover.super.setSpeed(self, self._baseSpeed * self._timeScale * self._tempSpeedFactor)
end

function BattleUnitCompMover:getSpeed()
	return self._speed
end

return BattleUnitCompMover
