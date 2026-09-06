-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/impl/UnitTilingElem.lua

module("logicscene.scene.unit.impl.UnitTilingElem", package.seeall)

local UnitTilingElem = class("UnitTilingElem", SceneUnitBase)

function UnitTilingElem:getTag()
	return UnitTag.TilingSceneElem
end

function UnitTilingElem:getLayer()
	return SceneLayer.Unit_Value
end

function UnitTilingElem:_initComponents()
	UnitTilingElem.super._initComponents(self)
	self:_addComponent("spine", UnitCompSpineEx)
	self:_addComponent("spineMover", UnitCompSpineMover)
	self:_addComponent("hudEffect", UnitCompHudEffect)
end

function UnitTilingElem:onUnitVisible(go)
	UnitTilingElem.super.onUnitVisible(self, go)

	local shadow = goutil.findChild(go, "shadow")

	if shadow then
		GoUtil.SetSortingOrder(shadow, -1500)
	end
end

function UnitTilingElem:onUnitCreated(params)
	self.transform:setPos(params.posX, params.posY, 0)

	local cfgCo = SceneConfig.instance:getTilingElemCo(self.itemId)

	if cfgCo.shadowScale > 0 then
		self:_addComponent("shadow", UnitCompShadowOther)
		self.shadow:onInit()
		self.shadow:setScale(cfgCo.shadowScale)
	end

	local moveSpeed

	if cfgCo then
		moveSpeed = cfgCo.speed
	end

	if cfgCo.effect then
		self.hudEffect:setResPath("effect/prefabs/scene/fx_scene_monster_tiaozhuan.prefab")
		self.hudEffect:setScale(0.05)
	end

	self.transform:setMoveSpeed(moveSpeed or 1)

	self._isMotion = params.motion

	if self._isMotion then
		self.transform:addListener(UnitNotify.PosChanged, self._onUnitPosChanged, self)
		self:patrolInRect({
			width = 2,
			height = 2,
			x = params.posX,
			y = params.posY
		})
	end

	self.spineMover:playDefaultIdleAnim()

	self._wholeScene = self.scene.stage.wholeScene

	if self._isMotion then
		self:setSceneUnit(self._wholeScene:AddSceneUnit(self.go))
	end

	if cfgCo.scene == TilingElemScene.Exitrance then
		self._wholeScene:CreateTrigger(self.scene:getSceneId(), TilingSceneConfig.ExitranceTriggerId, Vector2.New(params.posX, params.posY), Vector2.New(self.radius, self.radius))
	end
end

function UnitTilingElem:onUnitDestroyed()
	if self._isMotion then
		self.transform:removeListener(UnitNotify.PosChanged, self._onUnitPosChanged, self)
	end

	local cfgCo = SceneConfig.instance:getTilingElemCo(self.itemId)

	if cfgCo.scene == TilingElemScene.Exitrance then
		self._wholeScene:RemoveTrigger(self.scene:getSceneId(), TilingSceneConfig.ExitranceTriggerId)
	end

	self._wholeScene = nil

	self.actions:stopAllActions()
	self:clearSceneUnit()
	self:OnDestroy()
end

function UnitTilingElem:_onUnitPosChanged(x, y, z, isSetPosDirectly)
	self._wholeScene = self._wholeScene or self.scene.stage.wholeScene

	if self._wholeScene then
		local posX, posY = self.transform:getPos()

		self._wholeScene:UpdateCommonUnitPosition(UnitTag.TilingSceneElem, self.id, x, y)
	end
end

return UnitTilingElem
