-- chunkname: @modules/logic/room/entity/RoomTransportSiteEntity.lua

module("modules.logic.room.entity.RoomTransportSiteEntity", package.seeall)

local RoomTransportSiteEntity = class("RoomTransportSiteEntity", RoomBaseEntity)

function RoomTransportSiteEntity:ctor(entityId)
	RoomTransportSiteEntity.super.ctor(self)
	self:setEntityId(entityId)
end

function RoomTransportSiteEntity:setEntityId(entityId)
	self.id = entityId
	self.entityId = self.id
end

function RoomTransportSiteEntity:getTag()
	return SceneTag.RoomBuilding
end

function RoomTransportSiteEntity:init(go)
	self.containerGO = gohelper.create3d(go, RoomEnum.EntityChildKey.ContainerGOKey)
	self.staticContainerGO = self.containerGO
	self.containerGOTrs = self.containerGO.transform
	self.goTrs = go.transform

	RoomTransportSiteEntity.super.init(self, go)
end

function RoomTransportSiteEntity:playAudio(audioId)
	if audioId and audioId ~= 0 then
		self.__isHasAuidoTrigger = true

		AudioMgr.instance:trigger(audioId, self.go)
	end
end

function RoomTransportSiteEntity:initComponents()
	self:addComp("effect", RoomEffectComp)
	self:addComp("alphaThresholdComp", RoomAlphaThresholdComp)
	self:addComp("collider", RoomColliderComp)
	self:addComp("nightlight", RoomNightLightComp)
end

function RoomTransportSiteEntity:onStart()
	RoomTransportSiteEntity.super.onStart(self)
end

function RoomTransportSiteEntity:refreshBuilding()
	if not self.effect:isHasEffectGOByKey(RoomEnum.EffectKey.BuildingGOKey) then
		self.effect:addParams({
			[RoomEnum.EffectKey.BuildingGOKey] = {
				res = "scenes/m_s07_xiaowu/prefab/building/2_2_simulate/simulate_tingchezhan_1.prefab",
				pathfinding = true,
				deleteChildPath = "0"
			}
		})
		self.effect:refreshEffect()
	end
end

function RoomTransportSiteEntity:setLocalPos(x, y, z, tween)
	ZProj.TweenHelper.KillByObj(self.goTrs)

	if tween then
		ZProj.TweenHelper.DOLocalMove(self.goTrs, x, y, z, 0.1)
	else
		transformhelper.setLocalPos(self.goTrs, x, y, z)
	end
end

function RoomTransportSiteEntity:getAlphaThresholdValue()
	return nil
end

function RoomTransportSiteEntity:onEffectRebuild()
	if not self._isSmokeAnimPlaying then
		self:_playSmokeAnim(false)
	end

	local bodyGO = self:getBodyGO()

	if bodyGO then
		RoomMapController.instance:dispatchEvent(RoomEvent.RoomVieiwConfirmRefreshUI)
	end
end

function RoomTransportSiteEntity:getBodyGO()
	return self:_findBuildingGOChild(RoomEnum.EntityChildKey.BodyGOKey)
end

function RoomTransportSiteEntity:getHeadGO()
	return self:_findBuildingGOChild(RoomEnum.EntityChildKey.HeadGOKey)
end

function RoomTransportSiteEntity:playAnimator(animName)
	return self.effect:playEffectAnimator(RoomEnum.EffectKey.BuildingGOKey, animName)
end

function RoomTransportSiteEntity:playSmokeEffect()
	self:_returnSmokeEffect()
	self:_playSmokeAnim(true)

	self._isSmokeAnimPlaying = true

	TaskDispatcher.runDelay(self._delayReturnSmokeEffect, self, 3)
end

function RoomTransportSiteEntity:_delayReturnSmokeEffect()
	self._isSmokeAnimPlaying = false

	self:_playSmokeAnim(false)
end

function RoomTransportSiteEntity:_returnSmokeEffect()
	TaskDispatcher.cancelTask(self._delayReturnSmokeEffect, self)
end

function RoomTransportSiteEntity:_playSmokeAnim(isStart)
	local smokeGO = self:_findBuildingGOChild(RoomEnum.EntityChildKey.SmokeGOKey)

	if smokeGO then
		if isStart then
			gohelper.setActive(smokeGO, false)
		end

		gohelper.setActive(smokeGO, isStart)
	end
end

function RoomTransportSiteEntity:_findBuildingGOChild(childPath)
	return self.effect:getGameObjectByPath(RoomEnum.EffectKey.BuildingGOKey, childPath)
end

function RoomTransportSiteEntity:beforeDestroy()
	ZProj.TweenHelper.KillByObj(self.goTrs)
	self:_returnSmokeEffect()
	self:removeEvent()
end

function RoomTransportSiteEntity:removeEvent()
	return
end

function RoomTransportSiteEntity:getMO()
	return nil
end

function RoomTransportSiteEntity:getCharacterMeshRendererList()
	return self.effect:getMeshRenderersByKey(RoomEnum.EffectKey.BuildingGOKey)
end

return RoomTransportSiteEntity
