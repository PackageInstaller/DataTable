-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/buffs/BuffInvisible.lua

module("logicscene.scene.battle.skills.buffs.BuffInvisible", package.seeall)

local BuffInvisible = class("BuffInvisible", BuffBase)

function BuffInvisible:onBuffBegin()
	self._unit.attrs:setInvisible(true)
	BuffInvisible.super.onBuffBegin(self)

	if goutil.isNil(self._unit.go) then
		return
	end

	self._unitLayer = self._unit.go.layer

	self._unit:setCurrLayer(SceneLayer.Invisible_Value)
	Framework.GameObjectUtil.SetLayerRecursively(self._unit.go, SceneLayer.Invisible_Value)
end

function BuffInvisible:onBuffEnd()
	self._unit.attrs:setInvisible(false)
	BuffInvisible.super.onBuffEnd(self)

	if goutil.isNil(self._unit.go) then
		return
	end

	local unitLayer = self._unit.go.layer

	if self._unitLayer and unitLayer == SceneLayer.Invisible_Value then
		self._unit:setCurrLayer(self._unitLayer)
		Framework.GameObjectUtil.SetLayerRecursively(self._unit.go, self._unitLayer)
	end
end

function BuffInvisible:update(deltaTime)
	self:_updateEffectOrder()

	if goutil.isNil(self._unit.go) then
		return
	end

	local unitLayer = self._unit.go.layer

	if unitLayer ~= SceneLayer.Invisible_Value then
		Framework.GameObjectUtil.SetLayerRecursively(self._unit.go, SceneLayer.Invisible_Value)
	end

	if self:isVisible() then
		local currLayer = self._unit:getCurrLayer()

		if currLayer == SceneLayer.Invisible_Value then
			currLayer = self._unit:getLayer()
		end

		if self._unit:isTransparent() then
			currLayer = SceneLayer.Invisible_Value
		end

		if self._effect and self._effect.effGo and self._effect.effGo.layer ~= currLayer then
			Framework.GameObjectUtil.SetLayerRecursively(self._effect.effGo, currLayer)
		end
	elseif self._effect and self._effect.effGo and self._effect.effGo.layer ~= SceneLayer.Invisible_Value then
		Framework.GameObjectUtil.SetLayerRecursively(self._effect.effGo, SceneLayer.Invisible_Value)
	end
end

return BuffInvisible
