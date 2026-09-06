-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/defendcarrot/model/buff/DefendCarrotIncreaseRadiusBuff.lua

module("logic.extensions.defendcarrot.model.buff.DefendCarrotIncreaseRadiusBuff", package.seeall)

local DefendCarrotIncreaseRadiusBuff = class("DefendCarrotIncreaseRadiusBuff", DefendCarrotChangeModeBuff)

function DefendCarrotIncreaseRadiusBuff:initComplete()
	DefendCarrotIncreaseRadiusBuff.super.initComplete(self)

	self._changeSpeed = checknumber(self._tiggerParam[self:gPId()])
	self._targetRadius = checknumber(self._tiggerParam[self:gPId()])
end

function DefendCarrotIncreaseRadiusBuff:onAdd(target)
	DefendCarrotIncreaseRadiusBuff.super.onAdd(self, target)

	self._radius = self._unit.radius

	GameUtil.callBack(self._unit.changeMode, self._unit, DefendCarrotEnum.BuffChangeMode.IncreaseRadius, self._changeSpeed, self._targetRadius)
end

function DefendCarrotIncreaseRadiusBuff:onRemove(unit)
	DefendCarrotIncreaseRadiusBuff.super.onRemove(self, unit)
	GameUtil.callBack(self._unit.resetMode, self._unit, DefendCarrotEnum.BuffChangeMode.IncreaseRadius)
end

function DefendCarrotIncreaseRadiusBuff:onUpdate(dt)
	self._radius = self._radius + self._changeSpeed * dt

	if self._radius > self._targetRadius then
		self._radius = self._targetRadius

		DefendCarrotGameController.instance:preReCycle(self._unit)
	end

	self._unit:setRadius(self._radius)
end

return DefendCarrotIncreaseRadiusBuff
