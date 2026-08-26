-- chunkname: @modules/logic/room/entity/RoomInitBuildingEntity.lua

module("modules.logic.room.entity.RoomInitBuildingEntity", package.seeall)

local RoomInitBuildingEntity = class("RoomInitBuildingEntity", RoomBaseEntity)

function RoomInitBuildingEntity:ctor(entityId)
	RoomInitBuildingEntity.super.ctor(self)

	self.id = entityId
	self.entityId = self.id
end

function RoomInitBuildingEntity:getTag()
	return SceneTag.RoomInitBuilding
end

function RoomInitBuildingEntity:init(go)
	self.containerGO = gohelper.create3d(go, RoomEnum.EntityChildKey.ContainerGOKey)
	self.staticContainerGO = gohelper.create3d(go, RoomEnum.EntityChildKey.StaticContainerGOKey)

	RoomInitBuildingEntity.super.init(self, go)

	self._scene = GameSceneMgr.instance:getCurScene()
end

function RoomInitBuildingEntity:initComponents()
	self:addComp("effect", RoomEffectComp)

	if RoomController.instance:isObMode() then
		self:addComp("collider", RoomColliderComp)
		self:addComp("atmosphere", RoomAtmosphereComp)
		self:addComp("roomGift", RoomGiftActComp)
	end

	self:addComp("nightlight", RoomNightLightComp)
	self:addComp("skin", RoomInitBuildingSkinComp)
	self:addComp("alphaThresholdComp", RoomAlphaThresholdComp)
end

function RoomInitBuildingEntity:onStart()
	RoomInitBuildingEntity.super.onStart(self)
	RoomCharacterController.instance:registerCallback(RoomEvent.CharacterListShowChanged, self._characterListShowChanged, self)
	RoomController.instance:registerCallback(RoomEvent.OnSwitchModeDone, self._onSwithMode, self)
end

function RoomInitBuildingEntity:refreshBuilding(alphaThreshold, alphaThresholdValue)
	local res = self:_getInitBuildingRes()

	if string.nilorempty(res) then
		self.effect:removeParams({
			RoomEnum.EffectKey.BuildingGOKey
		})
	else
		self.effect:addParams({
			[RoomEnum.EffectKey.BuildingGOKey] = {
				pathfinding = true,
				res = res,
				alphaThreshold = alphaThreshold,
				alphaThresholdValue = alphaThresholdValue
			}
		})
	end

	self.effect:refreshEffect()
end

function RoomInitBuildingEntity:_characterListShowChanged(isShow)
	self:setEnable(not RoomController.instance:isEditMode() and not isShow)
end

function RoomInitBuildingEntity:_onSwithMode()
	self:setEnable(not RoomController.instance:isEditMode())
end

function RoomInitBuildingEntity:setEnable(isEnable)
	if self.collider then
		self.collider:setEnable(isEnable and true or false)
	end
end

function RoomInitBuildingEntity:_getInitBuildingRes()
	local showSkinId = RoomSkinModel.instance:getShowSkin(self.id)

	return RoomConfig.instance:getRoomSkinModelPath(showSkinId) or RoomScenePreloader.ResInitBuilding
end

function RoomInitBuildingEntity:tweenAlphaThreshold(from, to, duration, finishCb, finishCbObj)
	if not self.alphaThresholdComp then
		return
	end

	self.alphaThresholdComp:tweenAlphaThreshold(from, to, duration, finishCb, finishCbObj)
end

function RoomInitBuildingEntity:beforeDestroy()
	RoomInitBuildingEntity.super.beforeDestroy(self)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.CharacterListShowChanged, self._characterListShowChanged, self)
	RoomController.instance:unregisterCallback(self._onSwithMode, self)
end

function RoomInitBuildingEntity:getCharacterMeshRendererList()
	return self.effect:getMeshRenderersByKey(RoomEnum.EffectKey.BuildingGOKey)
end

return RoomInitBuildingEntity
