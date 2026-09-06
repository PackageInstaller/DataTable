-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/model/buff/OriMatGameIncreaseRadiusBuff.lua

module("logic.extensions.orimatgame.model.buff.OriMatGameIncreaseRadiusBuff", package.seeall)

local OriMatGameIncreaseRadiusBuff = class("OriMatGameIncreaseRadiusBuff", OriMatGameChangeModeBuff)

function OriMatGameIncreaseRadiusBuff:initComplete()
	OriMatGameIncreaseRadiusBuff.super.initComplete(self)

	self._changeSpeed = checknumber(self._tiggerParam[self:gPId()])
	self._targetRadius = checknumber(self._tiggerParam[self:gPId()])
end

function OriMatGameIncreaseRadiusBuff:onAdd(target)
	OriMatGameIncreaseRadiusBuff.super.onAdd(self, target)

	self._radius = self._unit.radius

	GameUtil.callBack(self._unit.changeMode, self._unit, OriMatGameEnum.BuffChangeMode.IncreaseRadius, self._changeSpeed, self._targetRadius)
end

function OriMatGameIncreaseRadiusBuff:onRemove(unit)
	OriMatGameIncreaseRadiusBuff.super.onRemove(self, unit)
	GameUtil.callBack(self._unit.resetMode, self._unit, OriMatGameEnum.BuffChangeMode.IncreaseRadius)
end

function OriMatGameIncreaseRadiusBuff:onUpdate(dt)
	self._radius = self._radius + self._changeSpeed * dt

	if self._radius > self._targetRadius then
		self._radius = self._targetRadius

		OriMatGameGameController.instance:preReCycle(self._unit)
	end

	self._unit:setRadius(self._radius)
end

return OriMatGameIncreaseRadiusBuff
