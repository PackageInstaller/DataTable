-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/impl/UnitZoo.lua

module("logicscene.scene.unit.impl.UnitZoo", package.seeall)

local UnitZoo = class("UnitZoo", SceneUnitBase)
local typeOfBoxCollider = typeof(UnityEngine.BoxCollider)

function UnitZoo:Awake()
	UnitZoo.super.Awake(self)
	self.spine:addListener(UnitNotify.SpineLoaded, self._onPlayerBodyLoaded, self)
end

function UnitZoo:getTag()
	return UnitTag.Pet
end

function UnitZoo:getLayer()
	return SceneLayer.Unit_Value
end

function UnitZoo:getAvatarName()
	return "UnitZoo_" .. self.id
end

function UnitZoo:update(deltaTime)
	self.actions:update(deltaTime)
	self.transform:updateRoatationY(deltaTime)
end

function UnitZoo:_initComponents()
	UnitZoo.super._initComponents(self)
	self:_addComponent("spine", UnitCompAvatarZoo)
	self:_addComponent("spineMover", UnitCompAnimatorMover)
	self:_addComponent("shadow", UnitCompShadowOther)
end

function UnitZoo:onUnitCreated(params)
	self.transform:setPos(params.posX, params.posY, 0)

	self._isMotion = params.motion

	if self._isMotion then
		self.transform:addListener(UnitNotify.PosChanged, self._onUnitPosChanged, self)
	end

	local ownerTag, ownerId, avatarData = self:_getData()

	self._owner = ownerTag == UnitTag.MainPlayer and SceneMainPlayer.instance:getMainPlayer() or ownerTag == UnitTag.Player and self.scene.unitFactory:getUnit(ownerTag, ownerId) or self.scene.unitFactory:getUnit(ownerTag, tonumber(ownerId))
	self._avatarPartIds = avatarData

	self._owner:addPetUnit(SceneUnitBase.UnitZoo, self)
	self.spineMover:playDefaultIdleAnim()
	self.transform:setMoveSpeed(self._owner.transform:getMoveSpeed() * 0.8)

	if self._isMotion then
		self._wholeScene = self.scene.stage.wholeScene

		self:setSceneUnit(self._wholeScene:AddSceneUnit(self.go))
	end

	self:setUnderBridge(self._owner:isUnderBridge())

	local distanceConfig = {
		1,
		2.1
	}

	self:followTarget(self._owner, distanceConfig)
	self.shadow:setLocalPos(nil, -0.1)
end

function UnitZoo:onUnitDestroyed()
	self.spine:removeListener(UnitNotify.SpineLoaded, self._onPlayerBodyLoaded, self)

	if self._isMotion then
		self.transform:removeListener(UnitNotify.PosChanged, self._onUnitPosChanged, self)
	end

	if self.go then
		goutil.destroy(self.go)

		self.go = nil
	end

	self._avatarPartIds = nil
	self._wholeScene = nil

	self.actions:stopAllActions()
	self:clearSceneUnit()
	self:OnDestroy()
end

function UnitZoo:onUnitVisible(go)
	self._isClipping = nil

	self:updateModel()
end

function UnitZoo:onUnitInVisible(go)
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

function UnitZoo:updateModel()
	if self._isClipping then
		return
	end

	if self.spine and self._avatarPartIds then
		local avatarPetMo = AvatarConfig.instance:getAvatarMoByCfgId(ZooConfig.instance:getAnimalById(self.petId).skeletonId)

		for k, v in pairs(self._avatarPartIds) do
			local cfg = ZooConfig.instance:getGene(checkint(v))

			if cfg and cfg.modelId and cfg.modelId > 0 then
				avatarPetMo:setDataByCfgId(cfg.modelId)
			end
		end

		self.spine:setBody(avatarPetMo)
		self.spine:onUnitVisible()
	end
end

function UnitZoo:_onUnitPosChanged(x, y, z, isSetPosDirectly)
	self._wholeScene = self._wholeScene or self.scene.stage.wholeScene

	if self._wholeScene then
		local posX, posY = self.transform:getPos()

		self._wholeScene:UpdateCommonUnitPosition(self:getTag(), self.id, x, y)
	end
end

function UnitZoo:getOwner()
	return self._owner
end

function UnitZoo:_getOwner()
	if self.userData then
		local userData = GameUtil.jsonToTable(self.userData) or {}

		return userData.ownerTag, userData.ownerId
	end
end

function UnitZoo:_getData()
	if self.userData then
		local userData = GameUtil.jsonToTable(self.userData) or {}

		return userData.ownerTag, userData.ownerId, userData.partIds
	end
end

function UnitZoo:SetAvatarData(newData)
	self.petId = newData.petId
	self._avatarPartIds = newData.partIds
end

function UnitZoo:_onPlayerBodyLoaded()
	local go = self.spine:getAvatarGo()

	go.name = self:getAvatarName()

	local ownerTag, ownerId = self:_getOwner()
	local owner = self:getOwner()

	if owner and owner.getOwner then
		owner = owner:getOwner()

		if owner then
			ownerTag = owner:getTag()
		end
	end

	if ownerTag == UnitTag.MainPlayer then
		local boxCollider = go:GetComponent(typeOfBoxCollider)

		boxCollider = boxCollider or go:AddComponent(typeOfBoxCollider)
		boxCollider.center = Vector3.New(0, 0.6, 0)
		boxCollider.size = Vector3.New(0.7, 1, 1)
	end

	self.transform:setLocalRotationY(180, true)

	local go = self.spine:getAvatarGo()

	UnitZoo.super.onUnitVisible(self, go)
end

function UnitZoo:getTalkingOffset()
	return 0, 1.1, 0
end

function UnitZoo:getUnitHudType()
	return SceneHudMgr.HUD_NPC
end

function UnitZoo:getUnitName()
	return self._petName
end

return UnitZoo
