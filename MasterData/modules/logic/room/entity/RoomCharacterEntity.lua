-- chunkname: @modules/logic/room/entity/RoomCharacterEntity.lua

module("modules.logic.room.entity.RoomCharacterEntity", package.seeall)

local RoomCharacterEntity = class("RoomCharacterEntity", RoomBaseEntity)

function RoomCharacterEntity:ctor(entityId)
	RoomCharacterEntity.super.ctor(self)

	self.id = entityId
	self.entityId = self.id
end

function RoomCharacterEntity:getTag()
	return SceneTag.RoomCharacter
end

function RoomCharacterEntity:init(go)
	self.containerGO = gohelper.create3d(go, RoomEnum.EntityChildKey.ContainerGOKey)
	self.staticContainerGO = self.containerGO
	self.containerGOTrs = self.containerGO.transform
	self.goTrs = go.transform

	RoomCharacterEntity.super.init(self, go)

	self._scene = GameSceneMgr.instance:getCurScene()

	if RoomController.instance:isObMode() then
		self.effect:addParams({
			[RoomEnum.EffectKey.BuildingGOKey] = {
				res = RoomScenePreloader.ResCharacterClickHelper
			}
		})
		self.effect:refreshEffect()
	end

	self.isPressing = false
end

function RoomCharacterEntity:initComponents()
	self:addComp("characterspineeffect", RoomCharacterSpineEffectComp)
	self:addComp("characterspine", RoomCharacterSpineComp)
	self:addComp("followPathComp", RoomCharacterFollowPathComp)
	self:addComp("charactermove", RoomCharacterMoveComp)
	self:addComp("effect", RoomEffectComp)
	self:addComp("birthday", RoomCharacterBirthdayComp)

	if RoomController.instance:isObMode() then
		self:addComp("collider", RoomColliderComp)
	end

	if not RoomEnum.IsShowUICharacterInteraction then
		self:addComp("characterinterac", RoomCharacterInteractionComp)
	end

	local roomCharacterMO = self:getMO()

	if roomCharacterMO and not roomCharacterMO:getCanWade() then
		self:addComp("characterfootprint", RoomCharacterFootPrintComp)
	end

	self:addComp("cameraFollowTargetComp", RoomCameraFollowTargetComp)
	self:addComp("interactActionComp", RoomCharacterInteractActionComp)
end

function RoomCharacterEntity:onStart()
	RoomCharacterEntity.super.onStart(self)
end

function RoomCharacterEntity:setLocalPos(x, y, z, tween)
	if self._tweenId then
		self._scene.tween:killById(self._tweenId)

		self._tweenId = nil
	end

	if tween then
		local posX, posY, posZ = transformhelper.getLocalPos(self.goTrs)

		self._tweenId = self._scene.tween:tweenFloat(0, 1, 0.05, self._frameCallback, self._finishCallback, self, {
			originalX = posX,
			originalY = posY,
			originalZ = posZ,
			x = x,
			y = y,
			z = z
		})
	else
		transformhelper.setLocalPos(self.goTrs, x, y, z)
	end

	local mo = self:getMO()

	RoomCharacterController.instance:dispatchEvent(RoomEvent.CharacterPositionChanged, mo.id)

	if self.characterspine then
		self.characterspine:characterPosChanged()
	end
end

function RoomCharacterEntity:setLocalScale(scaleX, scaleY, scaleZ)
	if gohelper.isNil(self.go) or not scaleX or not scaleY or not scaleZ then
		return
	end

	transformhelper.setLocalScale(self.goTrs, scaleX, scaleY, scaleZ)
end

function RoomCharacterEntity:getLocalPosXYZ()
	if gohelper.isNil(self.go) then
		return
	end

	return transformhelper.getLocalPos(self.goTrs)
end

function RoomCharacterEntity:getLocalScaleXYZ()
	if gohelper.isNil(self.go) then
		return
	end

	return transformhelper.getLocalScale(self.goTrs)
end

function RoomCharacterEntity:_frameCallback(value, param)
	local x = param.originalX + (param.x - param.originalX) * value
	local y = param.originalY + (param.y - param.originalY) * value
	local z = param.originalZ + (param.z - param.originalZ) * value

	transformhelper.setLocalPos(self.goTrs, x, y, z)
end

function RoomCharacterEntity:_finishCallback(param)
	transformhelper.setLocalPos(self.goTrs, param.x, param.y, param.z)
end

function RoomCharacterEntity:_getCharacterRes()
	local mo = self:getMO()

	return (RoomResHelper.getCharacterPath(mo.skinId))
end

function RoomCharacterEntity:beforeDestroy()
	if self._tweenId then
		self._scene.tween:killById(self._tweenId)

		self._tweenId = nil
	end

	TaskDispatcher.cancelTask(self._pressingEffectDelayDestroy, self)
	RoomCharacterEntity.super.beforeDestroy(self)
end

function RoomCharacterEntity:playConfirmEffect()
	self.effect:addParams({
		[RoomEnum.EffectKey.ConfirmCharacterEffectKey] = {
			res = RoomScenePreloader.ResEffectConfirmCharacter,
			containerGO = self.staticContainerGO
		}
	}, 2)
	self.effect:refreshEffect()
end

function RoomCharacterEntity:playClickEffect()
	self.effect:addParams({
		[RoomEnum.EffectKey.ConfirmCharacterEffectKey] = {
			res = RoomScenePreloader.ResCharacterClickEffect,
			containerGO = self.staticContainerGO
		}
	}, 1)
	self.effect:refreshEffect()
end

function RoomCharacterEntity:tweenUp()
	TaskDispatcher.cancelTask(self._pressingEffectDelayDestroy, self)

	self.isPressing = true

	self.characterspine:updateAlpha()
	self.effect:addParams({
		[RoomEnum.EffectKey.PressingEffectKey] = {
			res = RoomScenePreloader.ResEffectPressingCharacter,
			containerGO = self.staticContainerGO
		}
	})
	self.effect:refreshEffect()

	local pressingEffectGO = self.effect:getEffectGO(RoomEnum.EffectKey.PressingEffectKey)

	if pressingEffectGO then
		local pressingEffectAnim = pressingEffectGO:GetComponent(typeof(UnityEngine.Animator))

		if pressingEffectAnim then
			pressingEffectAnim:Play("open", 0, 0)
		end
	end

	if self.characterspine then
		self.characterspine:playAnim(RoomScenePreloader.ResAnim.PressingCharacter, "up")
	end

	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_role_drag)
end

function RoomCharacterEntity:tweenDown()
	self.isPressing = false

	self.characterspine:updateAlpha()

	local pressingEffectGO = self.effect:getEffectGO(RoomEnum.EffectKey.PressingEffectKey)

	if pressingEffectGO then
		local pressingEffectAnim = pressingEffectGO:GetComponent(typeof(UnityEngine.Animator))

		if pressingEffectAnim then
			pressingEffectAnim:Play("close", 0, 0)
		end
	end

	if self.characterspine then
		self.characterspine:playAnim(RoomScenePreloader.ResAnim.PressingCharacter, "down", 0, self._downDone, self)
	end

	TaskDispatcher.runDelay(self._pressingEffectDelayDestroy, self, 2)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_role_put)
end

function RoomCharacterEntity:_downDone()
	if self.characterspine then
		self.characterspine:clearAnim()
	end
end

function RoomCharacterEntity:_pressingEffectDelayDestroy()
	self.effect:removeParams({
		RoomEnum.EffectKey.PressingEffectKey
	})
	self.effect:refreshEffect()
end

function RoomCharacterEntity:playFaithEffect()
	local spineGO = self.characterspine:getCharacterGO()

	if not spineGO then
		return
	end

	self.effect:addParams({
		[RoomEnum.EffectKey.FaithEffectKey] = {
			res = RoomScenePreloader.ResCharacterFaithEffect,
			containerGO = self.staticContainerGO
		}
	}, 1.8)
	self.effect:refreshEffect()
end

function RoomCharacterEntity:getMO()
	self._mo = RoomCharacterModel.instance:getCharacterMOById(self.id) or self._mo

	return self._mo
end

return RoomCharacterEntity
