-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/impl/UnitMainPlayerPet.lua

module("logicscene.scene.unit.impl.UnitMainPlayerPet", package.seeall)

local UnitMainPlayerPet = class("UnitMainPlayerPet", SceneUnitBase)
local unitTime = UnityEngine.Time
local mainPetChatTime = ConstConfig.instance:getNumValueByKey("MainPetChatTime")

function UnitMainPlayerPet:getTag()
	return UnitTag.Pet
end

function UnitMainPlayerPet:getLayer()
	return SceneLayer.Unit_Value
end

function UnitMainPlayerPet:update(deltaTime)
	self.actions:update(deltaTime)
	self:_updateRandomChatWords(deltaTime)
end

function UnitMainPlayerPet:_updateRandomChatWords(deltaTime)
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

function UnitMainPlayerPet:_initComponents()
	UnitMainPlayerPet.super._initComponents(self)
	self:_addComponent("spine", UnitCompSpineEx)
	self:_addComponent("spineMover", UnitCompSpineMover)
	self:_addComponent("shadow", UnitCompShadowOther)
	self:_addComponent("talkhud", UnitCompHudTalking)
	self:_addComponent("hud", UnitCompHudCommon)
end

function UnitMainPlayerPet:onUnitCreated(params)
	self.transform:setPos(params.posX, params.posY, 0)
	self.transform:addListener(UnitNotify.PosChanged, self._onUnitPosChanged, self)

	self._owner = SceneMainPlayer.instance:getMainPlayer()

	local petCo = CharacterConfig.instance:getPetCo(self.raceId)

	self._petName = petCo.name
	self._owner.petUnit = self

	self.spineMover:playDefaultIdleAnim()
	self.transform:setMoveSpeed(self._owner.transform:getMoveSpeed() * 0.8)

	self._wholeScene = self.scene.stage.wholeScene

	self:setSceneUnit(self._wholeScene:AddSceneUnit(self.go))
	self:setUnderBridge(self._owner:isUnderBridge())
	self:followTarget(self._owner)
	self.shadow:setLocalPos(nil, -0.1)
	self.hud:setOffsetY3D(0.74)
end

function UnitMainPlayerPet:onUnitDestroyed()
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

function UnitMainPlayerPet:_onUnitPosChanged(x, y, z, isSetPosDirectly)
	self._wholeScene = self._wholeScene or self.scene.stage.wholeScene

	if self._wholeScene then
		local posX, posY = self.transform:getPos()

		self._wholeScene:UpdateCommonUnitPosition(self:getTag(), self.id, x, y)
	end
end

function UnitMainPlayerPet:getOwner()
	return self._owner
end

function UnitMainPlayerPet:getTalkingOffset()
	return 0, 1.1, 0
end

function UnitMainPlayerPet:getUnitHudType()
	return SceneHudMgr.HUD_NPC
end

function UnitMainPlayerPet:getUnitName()
	return self._petName
end

return UnitMainPlayerPet
