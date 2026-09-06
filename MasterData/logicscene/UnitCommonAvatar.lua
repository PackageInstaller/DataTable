-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/impl/UnitCommonAvatar.lua

module("logicscene.scene.unit.impl.UnitCommonAvatar", package.seeall)

local UnitCommonAvatar = class("UnitCommonAvatar", UnitAvatar)

function UnitCommonAvatar:ctor(componetContainer, params)
	UnitCommonAvatar.super.ctor(self, componetContainer)

	self._params = params
	self.willRemoved = false
end

function UnitCommonAvatar:getTag()
	return UnitTag.TilingSceneElem
end

function UnitCommonAvatar:getLayer()
	return SceneLayer.Unit_Value
end

function UnitCommonAvatar:getAvatarType()
	return self._params.avatarMo:getAvatarType()
end

function UnitCommonAvatar:_initComponents()
	UnitCommonAvatar.super._initComponents(self)
	self:_addComponent("spineMover", UnitCompAnimatorMover)
	self:_addComponent("shadow", UnitCompShadowOther)
end

function UnitCommonAvatar:onUnitCreated(params)
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
		self.spine:setBody(self._params.avatarMo)
	end
end

function UnitCommonAvatar:_setUpComponents()
	if self._params.comps then
		for k, v in pairs(self._params.comps) do
			self:_addComponent(k, v)
			self[k]:onInit()
		end
	end

	if self._params.hud then
		self:_addComponent(self._params.hud.clsName or "hud", self._params.hud.cls or UnitCompHudCommon)
		self.hud:onInit()

		if self._params.hud.offset then
			self.hud:setHudOffset(self._params.hud.offset[1] or 0, self._params.hud.offset[2] or 0, self._params.hud.offset[3] or 0)
		end
	end
end

function UnitCommonAvatar:onUnitDestroyed()
	if self._isMotion then
		self.transform:removeListener(UnitNotify.PosChanged, self._onUnitPosChanged, self)
	end

	self._params = nil
	self._wholeScene = nil

	self.actions:stopAllActions()
	self:clearSceneUnit()
	self:OnDestroy()
end

function UnitCommonAvatar:update(deltaTime)
	self.actions:update(deltaTime)
	self.transform:updateRoatationY(deltaTime)
end

function UnitCommonAvatar:_onUnitPosChanged(x, y, z, isSetPosDirectly)
	self._wholeScene = self._wholeScene or self.scene.stage.wholeScene

	if self._wholeScene then
		local posX, posY = self.transform:getPos()

		self._wholeScene:UpdateCommonUnitPosition(UnitTag.TilingSceneElem, self.id, x, y)
	end
end

function UnitCommonAvatar:onUnitVisible(go)
	self._isClipping = nil

	self:updateModel()
end

function UnitCommonAvatar:onUnitInVisible(go)
	self._gameObject = nil
	self._isClipping = true

	if self._compList then
		local cnt = #self._compList

		for i = 1, cnt do
			local comp = self._compList[i]

			if comp.onUnitInVisible then
				comp:onUnitInVisible(go)
			end
		end
	end
end

function UnitCommonAvatar:getAvatarName()
	return UnitTag.TilingSceneElem .. "_" .. tostring(self.id)
end

function UnitCommonAvatar:setAvatarMo(avatarMo)
	self._params.avatarMo = avatarMo

	self:updateModel()
end

function UnitCommonAvatar:setUnitTag(unitTag)
	self._unitTag = unitTag
end

function UnitCommonAvatar:getUnitTag()
	return self._unitTag
end

function UnitCommonAvatar:getTalkingOffset()
	return 0, 1.1, 0
end

function UnitCommonAvatar:getUnitHudType()
	if self._params.hud then
		return self._params.hud.hudType or SceneHudMgr.HUD_NPC
	end
end

function UnitCommonAvatar:getUnitName()
	if self._params.hud then
		return self._params.hud.name
	end
end

function UnitCommonAvatar:updateModel()
	if self._isClipping then
		return
	end

	if self.spine then
		local avatarMo = self._params.avatarMo

		self.spine:setBody(avatarMo)
		self.spine:onUnitVisible()
	end
end

function UnitCommonAvatar:_onPlayerBodyLoaded()
	UnitCommonAvatar.super._onPlayerBodyLoaded(self)

	local go = self.spine:getAvatarGo()

	UnitCommonAvatar.super.onUnitVisible(self, go)
	self.transform:forceUpdateRoatationY()
end

return UnitCommonAvatar
