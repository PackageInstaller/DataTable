-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/impl/UnitMainPlayerPet3D.lua

module("logicscene.scene.unit.impl.UnitMainPlayerPet3D", package.seeall)

local UnitMainPlayerPet3D = class("UnitMainPlayerPet3D", SceneUnitBase)
local unitTime = UnityEngine.Time
local mainPetChatTime = ConstConfig.instance:getNumValueByKey("MainPetChatTime")

function UnitMainPlayerPet3D:getTag()
	return UnitTag.Pet
end

function UnitMainPlayerPet3D:getLayer()
	return SceneLayer.Unit_Value
end

function UnitMainPlayerPet3D:update(deltaTime)
	self.actions:update(deltaTime)
	self:_updateRandomChatWords(deltaTime)
	self.transform:updateRoatationY(deltaTime)
end

function UnitMainPlayerPet3D:_updateRandomChatWords(deltaTime)
	local hudObj = self.talkhud:getHudObject()

	if not hudObj then
		return
	end

	if not self._lastPlayChatWordsTime then
		if hudObj.activeSelf or not self._lastPlayChatWordsTime then
			self._lastPlayChatWordsTime = unitTime.time

			return
		end

		if unitTime.time - self._lastPlayChatWordsTime >= mainPetChatTime then
			self._lastPlayChatWordsTime = unitTime.time

			MainUIController.instance:playRandomMainPetChat(self)
		end
	end
end

function UnitMainPlayerPet3D:_initComponents()
	UnitMainPlayerPet3D.super._initComponents(self)
	self:_addComponent("spine", UnitCompAvatarMainPet3D)
	self:_addComponent("spineMover", UnitCompAnimatorMover)
	self:_addComponent("shadow", UnitCompShadowOther)
	self:_addComponent("talkhud", UnitCompHudTalking)
	self:_addComponent("hud", UnitCompHudCommon)
end

function UnitMainPlayerPet3D:onUnitCreated(params)
	self.transform:setPos(params.posX, params.posY, 0)
	self.transform:addListener(UnitNotify.PosChanged, self._onUnitPosChanged, self)

	self._owner = SceneMainPlayer.instance:getMainPlayer()

	local petCo = CharacterConfig.instance:getPetCo(self.raceId)

	self._petName = petCo.name

	self._owner:addPetUnit(SceneUnitBase.UnitMainPlayerPet, self)
	self.spineMover:playDefaultIdleAnim()
	self.transform:setMoveSpeed(self._owner.transform:getMoveSpeed() * 0.9)

	self._wholeScene = self.scene.stage.wholeScene

	self:setSceneUnit(self._wholeScene:AddSceneUnit(self.go))
	self:setUnderBridge(self._owner:isUnderBridge())

	local distanceConfig = {
		1.2,
		4
	}

	self:followTarget(self._owner, distanceConfig)
	Framework.TransformUtil.SetLocalScale(self.go.transform, 2, 2, 2)
	self.shadow:setLocalPos(nil, -0.1)
	self.shadow:setScale(0.3)
	self.hud:setOffsetY3D(0.74)
end

function UnitMainPlayerPet3D:onUnitDestroyed()
	self.scene:removeUnitPet(self)
	self.transform:removeListener(UnitNotify.PosChanged, self._onUnitPosChanged, self)

	if self.go then
		goutil.destroy(self.go)

		self.go = nil
	end

	self._wholeScene = nil

	self.actions:stopAllActions()
	self:clearSceneUnit()
	self:OnDestroy()
end

function UnitMainPlayerPet3D:_onUnitPosChanged(x, y, z, isSetPosDirectly)
	self._wholeScene = self._wholeScene or self.scene.stage.wholeScene

	if self._wholeScene then
		local posX, posY = self.transform:getPos()

		self._wholeScene:UpdateCommonUnitPosition(self:getTag(), self.id, x, y)
	end
end

function UnitMainPlayerPet3D:getOwner()
	return self._owner
end

function UnitMainPlayerPet3D:getTalkingOffset()
	return 0, 1.1, 0
end

function UnitMainPlayerPet3D:getUnitHudType()
	return SceneHudMgr.HUD_NPC
end

function UnitMainPlayerPet3D:getUnitName()
	return self._petName
end

return UnitMainPlayerPet3D
