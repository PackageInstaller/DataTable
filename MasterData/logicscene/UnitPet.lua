-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/impl/UnitPet.lua

module("logicscene.scene.unit.impl.UnitPet", package.seeall)

local UnitPet = class("UnitPet", SceneUnitBase)
local typeOfBoxCollider = typeof(UnityEngine.BoxCollider)

function UnitPet:Awake()
	UnitPet.super.Awake(self)
	self.spine:addListener(UnitNotify.SpineLoaded, self._onPlayerBodyLoaded, self)
end

function UnitPet:getTag()
	return UnitTag.Pet
end

function UnitPet:getLayer()
	return SceneLayer.Unit_Value
end

function UnitPet:getAvatarName()
	return "UnitPet_" .. self.id
end

function UnitPet:update(deltaTime)
	self.actions:update(deltaTime)
	self.transform:updateRoatationY(deltaTime)
end

function UnitPet:_initComponents()
	UnitPet.super._initComponents(self)
	self:_addComponent("spine", UnitCompAvatarPet)
	self:_addComponent("spineMover", UnitCompAnimatorMover)
	self:_addComponent("shadow", UnitCompShadowOther)
	self:_addComponent("talkhud", UnitCompHudTalking)
	self:_addComponent("hud", UnitCompHudCommon)
end

function UnitPet:onUnitCreated(params)
	self.transform:setPos(params.posX, params.posY, 0)

	self._isMotion = params.motion

	if self._isMotion then
		self.transform:addListener(UnitNotify.PosChanged, self._onUnitPosChanged, self)
	end

	local ownerTag, ownerId, avatarData, petName, petTag = self:_getData()

	self._owner = ownerTag == UnitTag.MainPlayer and SceneMainPlayer.instance:getMainPlayer() or ownerTag == UnitTag.Player and self.scene.unitFactory:getUnit(ownerTag, ownerId) or self.scene.unitFactory:getUnit(ownerTag, tonumber(ownerId))
	self._avatarPartIds = avatarData
	self._petName = petName

	self._owner:addPetUnit(petTag, self)
	self.spineMover:playDefaultIdleAnim()
	self.transform:setMoveSpeed(self._owner.transform:getMoveSpeed() * 0.8)

	if self._isMotion then
		self._wholeScene = self.scene.stage.wholeScene

		self:setSceneUnit(self._wholeScene:AddSceneUnit(self.go))
	end

	self:setUnderBridge(self._owner:isUnderBridge())

	local distanceConfig

	self:followTarget(self._owner, (petTag == SceneUnitBase.UnitCute or nil) and {
		1,
		2.1
	})
	self.shadow:setLocalPos(nil, -0.1)
	self.hud:setOffsetY3D(0.74)
end

function UnitPet:onUnitDestroyed()
	self.spine:removeListener(UnitNotify.SpineLoaded, self._onPlayerBodyLoaded, self)
	GlobalDispatcher:removeListener(GlobalNotify.PigRaiseNameUpdate, self.onMainPlayerNameChange, self)

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

function UnitPet:onUnitVisible(go)
	self._isClipping = nil

	self:updateModel()
end

function UnitPet:onUnitInVisible(go)
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

function UnitPet:updateModel()
	if self._isClipping then
		return
	end

	if self.spine and self._avatarPartIds then
		local ownerTag, ownerId, avatarData, petName, petTag = self:_getData()
		local avatarPetMo = AvatarPetMo.New(petTag == SceneUnitBase.UnitCute and CutePetConfig.instance:getCutePetById(self.petId).modelId or PigraiseConfig.instance:getPetCfgById(self.petId).modelId, true)

		for k, v in pairs(self._avatarPartIds) do
			local cfg = PigraiseConfig.instance:getModelinfoCfgById(self.petId, k, v)

			if cfg and cfg.partId and cfg.partId > 0 then
				avatarPetMo:setDataByCfgId(cfg.partId)
			end
		end

		self.spine:setBody(avatarPetMo)
		self.spine:onUnitVisible()
		self.hud:setHudOffset(0, 0.74, 0)
	end
end

function UnitPet:_onUnitPosChanged(x, y, z, isSetPosDirectly)
	self._wholeScene = self._wholeScene or self.scene.stage.wholeScene

	if self._wholeScene then
		local posX, posY = self.transform:getPos()

		self._wholeScene:UpdateCommonUnitPosition(self:getTag(), self.id, x, y)
	end
end

function UnitPet:getOwner()
	return self._owner
end

function UnitPet:_getOwner()
	if self.userData then
		local userData = GameUtil.jsonToTable(self.userData) or {}

		return userData.ownerTag, userData.ownerId
	end
end

function UnitPet:_getData()
	if self.userData then
		local userData = GameUtil.jsonToTable(self.userData) or {}

		if not userData.petName then
			local petName = "猪猪侠"

			self.petId = userData.petId

			return userData.ownerTag, userData.ownerId, userData.partIds, petName, userData.petTag
		end
	end
end

function UnitPet:SetAvatarData(partIds)
	self._avatarPartIds = partIds
end

function UnitPet:_onPlayerBodyLoaded()
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
		boxCollider.center = Vector3.New(0, 0.5, 0)
		boxCollider.size = Vector3.New(1, 1, 1)

		GlobalDispatcher:addListener(GlobalNotify.PigRaiseNameUpdate, self.onMainPlayerNameChange, self)
	end

	self.transform:setLocalRotationY(180, true)

	local go = self.spine:getAvatarGo()

	self.spineMover:onUnitVisible(go)
	self.shadow:onUnitVisible(go)
	self.talkhud:onUnitVisible(go)
	self.hud:onUnitVisible(go)
	self.hud:_initFollowTarget()
end

function UnitPet:getTalkingOffset()
	return 0, 1.1, 0
end

function UnitPet:getUnitHudType()
	return SceneHudMgr.HUD_NPC
end

function UnitPet:getUnitName()
	return self._petName
end

function UnitPet:setUnitName(name)
	if not GameUtil.isEmptyString(name) then
		self._petName = name
	end
end

function UnitPet:onMainPlayerNameChange()
	self._petName = PigraiseModel.instance:getPigName()

	self.hud:_initFollowTarget()
end

return UnitPet
