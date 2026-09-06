-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/UnitCompHudEffect.lua

module("logicscene.scene.unit.component.hud.UnitCompHudEffect", package.seeall)

local UnitCompHudEffect = class("UnitCompHudEffect", UnitComponentBase)

function UnitCompHudEffect:setResPath(resPath)
	self._resPath = resPath
end

function UnitCompHudEffect:setHagPoint(hagPoint)
	self._hagPoint = hagPoint or GameEnum.MountPointType.Head

	if self._hagPoint and self._effect then
		local parent = self._unit:getMountPoint(self._hagPoint)

		self._effect:setParent(parent.transform)
	end
end

function UnitCompHudEffect:setScale(scale)
	self._scale = scale or 1

	if self._effect then
		self._effect:setScale(self._scale)
	end
end

function UnitCompHudEffect:setLocalPos(x, y, z)
	self._x = x or 0
	self._y = y or 0
	self._z = z or 0

	if self._effect then
		self._effect:setLocalPos(self._x, self._y, self._z)
	end
end

function UnitCompHudEffect:onUnitVisible(go)
	if string.nilorempty(self._resPath) then
		return
	end

	self._effect = GameEffectManager.instance:playEffect(self._resPath, true)

	self:setHagPoint(self._hagPoint)
	self:setScale(self._scale)
	self:setLocalPos(self._x, self._y, self._z)
	self._effect:setLayer(self._unit:getLayer())
end

function UnitCompHudEffect:onUnitInVisible(go)
	if self._effect then
		GameEffectManager.instance:stopEffect(self._effect)

		self._effect = nil
	end
end

function UnitCompHudEffect:setActive(visible)
	if self._effect then
		self._effect:setActive(visible)
	end
end

function UnitCompHudEffect:onDestroy()
	if self._effect then
		GameEffectManager.instance:stopEffect(self._effect)

		self._effect = nil
	end
end

return UnitCompHudEffect
