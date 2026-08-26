-- chunkname: @modules/logic/room/entity/RoomCritterEntity.lua

module("modules.logic.room.entity.RoomCritterEntity", package.seeall)

local RoomCritterEntity = class("RoomCritterEntity", RoomBaseEntity)

function RoomCritterEntity:ctor(entityId)
	RoomCritterEntity.super.ctor(self)

	self.id = entityId
	self.entityId = self.id
end

function RoomCritterEntity:getTag()
	return SceneTag.RoomCharacter
end

function RoomCritterEntity:init(go)
	self.containerGO = gohelper.create3d(go, RoomEnum.EntityChildKey.ContainerGOKey)
	self.staticContainerGO = self.containerGO
	self.containerGOTrs = self.containerGO.transform
	self.goTrs = go.transform

	RoomCritterEntity.super.init(self, go)

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
	self.__willDestroy = false
end

function RoomCritterEntity:initComponents()
	self:addComp("effect", RoomEffectComp)
	self:addComp("critterspineeffect", RoomCritterSpineEffectComp)
	self:addComp("critterspine", RoomCritterSpineComp)
	self:addComp("critterfollower", RoomCritterFollowerComp)

	if RoomController.instance:isObMode() then
		self:addComp("collider", RoomColliderComp)
	end

	self:addComp("eventiconComp", RoomCritterEventItemComp)
end

function RoomCritterEntity:onStart()
	RoomCritterEntity.super.onStart(self)
end

function RoomCritterEntity:setLocalPos(x, y, z, tween)
	if self._tweenId then
		self._scene.tween:killById(self._tweenId)

		self._tweenId = nil
	end

	if tween then
		local localPos = self.go.transform.localPosition

		self._tweenId = self._scene.tween:tweenFloat(0, 1, 0.05, self._frameCallback, self._finishCallback, self, {
			originalX = localPos.x,
			originalY = localPos.y,
			originalZ = localPos.z,
			x = x,
			y = y,
			z = z
		})
	else
		transformhelper.setLocalPos(self.go.transform, x, y, z)
	end

	if self.critterspine then
		self.critterspine:characterPosChanged()
	end
end

function RoomCritterEntity:_frameCallback(value, param)
	local x = param.originalX + (param.x - param.originalX) * value
	local y = param.originalY + (param.y - param.originalY) * value
	local z = param.originalZ + (param.z - param.originalZ) * value

	transformhelper.setLocalPos(self.go.transform, x, y, z)
end

function RoomCritterEntity:_finishCallback(param)
	transformhelper.setLocalPos(self.go.transform, param.x, param.y, param.z)
end

function RoomCritterEntity:beforeDestroy()
	self.__willDestroy = true

	if self._tweenId then
		self._scene.tween:killById(self._tweenId)

		self._tweenId = nil
	end

	TaskDispatcher.cancelTask(self._pressingEffectDelayDestroy, self)
	RoomCritterEntity.super.beforeDestroy(self)
end

function RoomCritterEntity:playConfirmEffect()
	self.effect:addParams({
		[RoomEnum.EffectKey.ConfirmCharacterEffectKey] = {
			res = RoomScenePreloader.ResEffectConfirmCharacter,
			containerGO = self.staticContainerGO
		}
	}, 2)
	self.effect:refreshEffect()
end

function RoomCritterEntity:playClickEffect()
	self.effect:addParams({
		[RoomEnum.EffectKey.ConfirmCharacterEffectKey] = {
			res = RoomScenePreloader.ResCharacterClickEffect,
			containerGO = self.staticContainerGO
		}
	}, 1)
	self.effect:refreshEffect()
end

function RoomCritterEntity:playCommonInteractionEff(effId, delayDestroy)
	if self.__willDestroy then
		return
	end

	local cfg = CritterConfig.instance:getCritterCommonInteractionEffCfg(effId)

	if not cfg then
		return
	end

	local effKey = cfg.effectKey
	local res = RoomResHelper.getCharacterEffectABPath(cfg.effectRes)

	if self.critterspine then
		local spineGO = self.critterspine:getSpineGO()

		if gohelper.isNil(spineGO) then
			return
		end

		local pointPath = RoomCharacterHelper.getSpinePointPath(cfg.point)
		local containerGO = gohelper.findChild(spineGO, pointPath)

		if gohelper.isNil(containerGO) then
			containerGO = self.containerGO

			logError(string.format(" RoomCritterEntity:playCommonInteractionEff error, no point, critterUid:%s, pointPath:%s", self.entityId, pointPath))
		end

		self.effect:addParams({
			[effKey] = {
				res = res,
				containerGO = containerGO
			}
		}, delayDestroy)
		self.effect:refreshEffect()
	end
end

function RoomCritterEntity:stopCommonInteractionEff(effId)
	if self.__willDestroy then
		return
	end

	local cfg = CritterConfig.instance:getCritterCommonInteractionEffCfg(effId)

	if not cfg then
		return
	end

	local effKey = cfg.effectKey

	self.effect:removeParams({
		effKey
	})
	self.effect:refreshEffect()
end

function RoomCritterEntity:stopAllCommonInteractionEff()
	if self.__willDestroy then
		return
	end

	local allEffKeyList = CritterConfig.instance:getAllCritterCommonInteractionEffKeyList()

	self.effect:removeParams(allEffKeyList)
	self.effect:refreshEffect()
end

function RoomCritterEntity:tweenUp()
	TaskDispatcher.cancelTask(self._pressingEffectDelayDestroy, self)

	self.isPressing = true

	self.critterspine:updateAlpha()

	local scale
	local mo = self:getMO()
	local isRestingCritter = mo and mo:isRestingCritter()

	self.effect:addParams({
		[RoomEnum.EffectKey.PressingEffectKey] = {
			res = RoomScenePreloader.ResEffectPressingCharacter,
			containerGO = self.staticContainerGO,
			localScale = (isRestingCritter or nil) and Vector3.one * CritterEnum.CritterPressingEffectScaleInSeatSlot
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

	if self.critterspine then
		self.critterspine:playAnim(RoomScenePreloader.ResAnim.PressingCharacter, "up")
	end

	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_role_drag)
end

function RoomCritterEntity:tweenDown()
	self.isPressing = false

	self.critterspine:updateAlpha()

	local pressingEffectGO = self.effect:getEffectGO(RoomEnum.EffectKey.PressingEffectKey)

	if pressingEffectGO then
		local pressingEffectAnim = pressingEffectGO:GetComponent(typeof(UnityEngine.Animator))

		if pressingEffectAnim then
			pressingEffectAnim:Play("close", 0, 0)
		end
	end

	if self.critterspine then
		self.critterspine:playAnim(RoomScenePreloader.ResAnim.PressingCharacter, "down", 0, self._downDone, self)
	end

	TaskDispatcher.runDelay(self._pressingEffectDelayDestroy, self, 2)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_role_put)
end

function RoomCritterEntity:_downDone()
	if self.critterspine then
		self.critterspine:clearAnim()
	end
end

function RoomCritterEntity:_pressingEffectDelayDestroy()
	self.effect:removeParams({
		RoomEnum.EffectKey.PressingEffectKey
	})
	self.effect:refreshEffect()
end

function RoomCritterEntity:getMO()
	self._mo = RoomCritterModel.instance:getCritterMOById(self.id) or self._mo

	return self._mo
end

return RoomCritterEntity
