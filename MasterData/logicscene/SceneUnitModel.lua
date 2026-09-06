-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/impl/SceneUnitModel.lua

module("logicscene.scene.unit.impl.SceneUnitModel", package.seeall)

local SceneUnitModel = class("SceneUnitModel", SceneUnitBase)

function SceneUnitModel:ctor(componetContainer, params)
	SceneUnitModel.super.ctor(self, componetContainer)

	self._params = params
end

function SceneUnitModel:getTag()
	return UnitTag.TilingSceneElem
end

function SceneUnitModel:getLayer()
	return SceneLayer.Unit_Value
end

function SceneUnitModel:setUnitTag(unitTag)
	self._unitTag = unitTag
end

function SceneUnitModel:getUnitTag()
	return self._unitTag
end

function SceneUnitModel:getTalkingOffset()
	return 0, 1.1, 0
end

function SceneUnitModel:getUnitHudType()
	if self._params.hud then
		return self._params.hud.hudType or SceneHudMgr.HUD_NPC
	end
end

function SceneUnitModel:getUnitName()
	if self._params.hud then
		return self._params.hud.name
	end
end

function SceneUnitModel:getUnitHudOffset()
	if self._params.hud and self._params.hud.offset then
		return self._params.hud.offset[1] or 0, self._params.hud.offset[2] or 0, self._params.hud.offset[3] or 0
	end
end

function SceneUnitModel:_initComponents()
	SceneUnitModel.super._initComponents(self)
end

function SceneUnitModel:onUnitVisible(go)
	SceneUnitModel.super.onUnitVisible(self, go)

	local shadow = goutil.findChild(go, "shadow")

	if shadow then
		GoUtil.SetSortingOrder(shadow, -1500)
	end
end

function SceneUnitModel:onUnitCreated(params)
	self.transform:setPos(params.posX, params.posY, 0)
	self:_setUpComponents()

	if not self._params.moveSpeed then
		self.transform:setMoveSpeed(self._params.moveSpeed or 1)

		self._isMotion = params.motion

		if self._isMotion then
			self.transform:addListener(UnitNotify.PosChanged, self._onUnitPosChanged, self)
			self:patrolInZone(self._params.zoneId or 0)
		end

		self.spineMover:playDefaultIdleAnim()

		self._wholeScene = self.scene.stage.wholeScene

		if self._isMotion then
			self:setSceneUnit(self._wholeScene:AddSceneUnit(self.go))
		end

		self:setUnitTag(self._params.tag)
	end
end

function SceneUnitModel:_initComponents()
	UnitCommonAvatar.super._initComponents(self)
	self:_addComponent("hud", UnitCompHudCommon)
end

function SceneUnitModel:_setUpComponents()
	if self._params.is3DModel then
		self:_addComponent("spine", UnitCompAnimator)
		self.spine:onInit()
		self:_addComponent("spineMover", UnitCompAnimatorMover)
		self.spineMover:onInit()
	else
		self:_addComponent("spine", UnitCompSpineEx)
		self.spine:onInit()
		self:_addComponent("spineMover", UnitCompSpineMover)
		self.spineMover:onInit()
	end

	if checknumber(self._params.shadowScale) > 0 then
		self:_addComponent("shadow", UnitCompShadowOther)
		self.shadow:onInit()
		self.shadow:setScale(cfgCo.shadowScale)
	end

	if self._params.hud then
		self:_addComponent("hud", UnitCompHudCommon)
		self.hud:onInit()

		if self._params.hud.offset then
			self.hud:setHudOffset(self._params.hud.offset[1] or 0, self._params.hud.offset[2] or 0, self._params.hud.offset[3] or 0)
		end
	end

	if self._params.comps then
		for k, v in pairs(self._params.comps) do
			self:_addComponent(k, v)
			self[k]:onInit()
		end
	end
end

function SceneUnitModel:onUnitDestroyed()
	if self._isMotion then
		self.transform:removeListener(UnitNotify.PosChanged, self._onUnitPosChanged, self)
	end

	self._params = nil
	self._wholeScene = nil

	self.actions:stopAllActions()
	self:clearSceneUnit()
	self:OnDestroy()
end

function SceneUnitModel:_onUnitPosChanged(x, y, z, isSetPosDirectly)
	self._wholeScene = self._wholeScene or self.scene.stage.wholeScene

	if self._wholeScene then
		local posX, posY = self.transform:getPos()

		self._wholeScene:UpdateCommonUnitPosition(UnitTag.TilingSceneElem, self.id, x, y)
	end
end

return SceneUnitModel
