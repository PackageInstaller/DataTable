-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/avatar/new/avatarcontroller/AvatarMountCtrl.lua

module("logiccommon.common.avatar.avatarcontroller.AvatarMountCtrl", package.seeall)

local AvatarMountCtrl = class("AvatarMountCtrl", AvatarController)

function AvatarMountCtrl:ctor(avatarBase)
	AvatarMountCtrl.super.ctor(self, avatarBase)

	self.mount = AvatarMountNew.New(self)
	self.fakePlayer = AvatarFakePlayer.New(self)
	self.fakePlayer.useType = AvatarUseType.Scene
	self._isVisible = true
	self._syncMout = nil
	self.isMounted = nil
	self._mountPath = nil
	self._mountLayer = nil
	self._animatorUpdateMode = nil
	self._animatorCullingMode = nil
	self.mountLayerIndex = nil
	self._animLayers = nil
	self._layer = nil

	self.mount._resLoader:setPreRecycleHandler(self._onRecycleMountResObject, self)
	self.addListener(self, AvatarNotify.OnMountLoaded, self._onMountLoaded, self)
	self.addListener(self, AvatarNotify.OnFakerAvatarLoader, self._onFakeAvatarLoaded, self)
end

function AvatarMountCtrl:_getControllerType()
	return AvatarControllerType.Mount
end

function AvatarMountCtrl:onAvatarLoaded()
	AvatarMountCtrl.super.onAvatarLoaded(self)

	self._isVisible = true
	self._rootParent = self._avatar:getParent()
end

function AvatarMountCtrl:onAvatarLoadedCallBack()
	AvatarMountCtrl.super.onAvatarLoadedCallBack(self)

	self._playerAnim = self._avatar.animatorCtrl:getAnimator()
	self._animatorUpdateMode = self._playerAnim.updateMode
	self._animatorCullingMode = self._playerAnim.cullingMode

	self:_updateMountState()
end

function AvatarMountCtrl:onAvatarInvisible()
	AvatarMountCtrl.super.onAvatarInvisible(self)

	self._isVisible = false

	self:onAvatarReset()
end

function AvatarMountCtrl:onAvatarVisible()
	AvatarMountCtrl.super.onAvatarVisible(self)

	self._isVisible = true

	if self._avatar:getGameObject() then
		self._playerAnim = self._avatar.animatorCtrl:getAnimator()
		self._animatorUpdateMode = self._playerAnim.updateMode
		self._animatorCullingMode = self._playerAnim.cullingMode

		self:_updateMountState()
	end
end

function AvatarMountCtrl:onAvatarReset()
	AvatarMountCtrl.super.onAvatarReset(self)

	local go = self._avatar:getGameObject()

	if self._syncMout and self._avatar:getGameObject() then
		self._syncMout = SyncPositionByBones.Get(go)
		self._syncMout.enabled = false
		self._syncMout = nil
	else
		self._syncMout = nil
	end

	self.mount:reset()
	self.fakePlayer:reset()

	self.isMounted = nil
	self._mountLayer = nil
	self._mountPath = nil
	self._playerAnim = nil
	self._animLayers = nil
	self.mountLayerIndex = nil

	removetimer(self._updatePlayerParent, self)
	removetimer(self._updateFakePlayerParent, self)
end

function AvatarMountCtrl:onAvatarDestroy()
	AvatarMountCtrl.super.onAvatarDestroy(self)
	self.mount:destroy()

	self.mount = nil
	self._rootParent = nil
	self._animatorUpdateMode = nil
	self._animatorCullingMode = nil

	self:removeAllListener(AvatarNotify.OnMountLoaded)
	self:removeAllListener(AvatarNotify.OnFakerAvatarLoader)
end

function AvatarMountCtrl:setLayer(layer)
	self._layer = layer

	self.mount:setLayer(self._layer)
	self.fakePlayer:setLayer(self._layer)
end

function AvatarMountCtrl:_onMountLoaded(mount)
	if self._isVisible then
		if self.mount == mount then
			self:_startMounting()
			self:_buildMountEffects()
			self._avatar:dispatch(AvatarNotify.OnMountLoaded, mount)
			self:updateMountingLayer()
		else
			printInfo("ctrl error mount")
		end
	else
		self:onAvatarReset()
	end
end

function AvatarMountCtrl:getCurMountId()
	if self._avatar and self._avatar.avatarmo then
		return self._avatar.avatarmo.mount
	end
end

function AvatarMountCtrl:getCurIsMount()
	if self._avatar and self._avatar.avatarmo then
		return self._avatar.avatarmo.isMount
	end

	return false
end

function AvatarMountCtrl:getCurMountCfg()
	local mountId = self:getCurMountId()
	local cfg

	if mountId then
		if DressModel.EscortMountId == mountId then
			cfg = MountConfig.instance:getEscortMountCo()
		elseif mountId ~= 0 then
			cfg = MountConfig.instance:getMountCo(mountId)
		end
	end

	return cfg
end

function AvatarMountCtrl:_updateMountState()
	if not self._avatar:getGameObject() then
		return
	end

	local cfg = self:getCurMountCfg()

	if cfg then
		local mountResPath = GameUrl.getMountUrlNew(cfg.mountMod, self._avatar.useType)

		if string.nilorempty(cfg.mountLayer) then
			if not AnimatorHash.mountLayer then
				local mountLayer = cfg.mountLayer

				self:_setMount(mountResPath, mountLayer)
			end
		end
	end

	if self:getCurIsMount() and not string.nilorempty(self._mountPath) then
		self:startMount()
	else
		self:dismount()
	end

	self:updateMountingLayer()
end

function AvatarMountCtrl:_setMount(assetPath, mountLayer)
	self._mountPath = assetPath

	if string.nilorempty(mountLayer) then
		self._mountLayer = AnimatorHash.mountLayer or mountLayer
	end

	self:_initAnimatorLayers()
end

function AvatarMountCtrl:startMount()
	if not self.isMounted and not string.nilorempty(self._mountPath) then
		self.isMounted = true

		self.mount:setParent(self._rootParent)
		self.mount:load(self._mountPath)
	elseif self.mount:getGameObject() then
		self:_startMounting()
	end
end

function AvatarMountCtrl:dismount()
	if not self.isMounted then
		return
	end

	self.isMounted = nil

	local anims = self._avatar.animatorCtrl:getCurAnimators()

	for i = 1, #anims do
		anims[i].updateMode = self._animatorUpdateMode
		anims[i].cullingMode = self._animatorCullingMode
	end

	if self._syncMout then
		self._syncMout.enabled = false
	end

	if self._avatar and self._avatar.avatarmo then
		self._avatar.avatarmo.isMount = nil
	end

	self._avatar:setParent(self._rootParent)
	self:updateMountingLayer()
	self.mount:reset()
	self.fakePlayer:reset()
end

function AvatarMountCtrl:isMountLoaded()
	return not self.isMounted or string.nilorempty(self._mountPath) or self.mount:isObjLoaded()
end

function AvatarMountCtrl:_startMounting()
	self:_updateMountPoint()

	local mountAnim = self.mount.animatorCtrl:getAnimator()
	local anims = self._avatar.animatorCtrl:getCurAnimators()

	for i = 1, #anims do
		anims[i].updateMode = mountAnim.updateMode
		anims[i].cullingMode = mountAnim.cullingMode
	end

	self:updateMountingLayer()
	self:_endMounting()

	if self.fakePlayer.avatarmo then
		self.fakePlayer:setVisible(true)
		self.fakePlayer:updateState()
	end
end

function AvatarMountCtrl:_updateMountPoint()
	if not self.isMounted then
		return
	end

	self._rootParent = self._avatar:getParent()

	self.mount:setParent(self._rootParent)

	local mountGo = self.mount:getGameObject()

	if mountGo then
		local posParams = self:getCurrentMountPosParams()

		Framework.TransformUtil.SetLocalPos(mountGo.transform, checknumber(posParams[1]), checknumber(posParams[2]), checknumber(posParams[3]))
	end

	self.fakePlayer:setParent(self._rootParent)

	local mountPoint = self.mount:getBoneByPointType(AvatarHangPointType.Mount)
	local go = self._avatar:getGameObject()

	self._syncMout = SyncPositionByBones.Get(go)
	self._syncMout.enabled = false

	go.transform:SetParent(mountPoint.transform)
	GameUtil.setLocalRotation(go, 90, 0, 0)

	self._mountSycBone = self._avatar:getBoneByName("Bip001")

	if self._mountSycBone then
		self._syncMout.originBone = mountPoint
		self._syncMout.targetBone = self._mountSycBone
		self._syncMout.enabled = true

		settimer(0.1, self._updatePlayerParent, self, false)
	end

	if self.fakePlayer:isAllLoaded() then
		local subMountPoint = self.mount:getBoneByPointType(AvatarHangPointType.SubMount)
		local fakeGo = self.fakePlayer:getGameObject()

		fakeGo.transform:SetParent(subMountPoint.transform)
		GameUtil.setLocalRotation(fakeGo, 90, 0, 0)

		local subMountSycBone = self.fakePlayer:getBoneByName("Bip001")

		if subMountSycBone then
			local syncFake = SyncPositionByBones.Get(fakeGo)

			syncFake.originBone = subMountPoint
			syncFake.targetBone = subMountSycBone
			syncFake.enabled = true

			settimer(0.1, self._updateFakePlayerParent, self, false)
		end
	end
end

function AvatarMountCtrl:_updatePlayerParent()
	local go = self._avatar:getGameObject()

	go.transform:SetParent(self._rootParent)
end

function AvatarMountCtrl:_initAnimatorLayers()
	if not self._playerAnim then
		return
	end

	if not self._animLayers then
		local layerCount = self._playerAnim.layerCount

		for i = 0, layerCount - 1 do
			self._animLayers = self._animLayers or {}

			local name = self._playerAnim:GetLayerName(i)

			self._animLayers[name] = i
		end
	end

	self.mountLayerIndex = -1

	if self._animLayers and not string.nilorempty(self._mountLayer) then
		self.mountLayerIndex = self._animLayers[self._mountLayer]
	end

	self._avatar.animatorCtrl:parseParams()
	self.fakePlayer.animatorCtrl:parseParams()
end

function AvatarMountCtrl:updateMountingLayer()
	local lwPos = self._avatar:getBoneByName(AvatarHangPointName[AvatarHangPointType.Lwave])

	if lwPos then
		if self.isMounted then
			GameUtil.setLocalPos(lwPos, -0.85, 0.986, -0.744)
			GameUtil.setLocalRotation(lwPos, 0, 270, 0)
		else
			GameUtil.setLocalPos(lwPos, -0.489, 1.876, 0.15)
			GameUtil.setLocalRotation(lwPos, 0, 0, 0)
		end
	end

	self._avatar.pendantsCtrl:updateMountState(AvatarPendantType.Lhand, AvatarHangPointType.Weapon)
	self._avatar.pendantsCtrl:updateMountState(AvatarPendantType.Rhand, AvatarHangPointType.Weapon)

	if self.fakePlayer:isAllLoaded() then
		self.fakePlayer.pendantsCtrl:updateMountState(AvatarPendantType.Lhand, AvatarHangPointType.Weapon)
		self.fakePlayer.pendantsCtrl:updateMountState(AvatarPendantType.Rhand, AvatarHangPointType.Weapon)
	end

	self:_initAnimatorLayers()

	if not self._playerAnim or not self._playerAnim.isActiveAndEnabled or not self._animLayers or not self.mountLayerIndex or self.mountLayerIndex == -1 then
		self._avatar.animatorCtrl:setBool(UnityEngine.Animator.StringToHash("ui"), false)
		self._avatar.animatorCtrl:playAnim(UnityEngine.Animator.StringToHash("Base Layer.idle"))

		if self.fakePlayer:isAllLoaded() then
			self.fakePlayer.animatorCtrl:setBool(UnityEngine.Animator.StringToHash("ui"), false)
			self.fakePlayer.animatorCtrl:playAnim(UnityEngine.Animator.StringToHash("Base Layer.idle"))
		end

		return
	end

	if self.isMounted and not string.nilorempty(self._mountPath) then
		self._avatar.animatorCtrl:setBool(UnityEngine.Animator.StringToHash("ui"), false)
		self._avatar.animatorCtrl:playAnim(UnityEngine.Animator.StringToHash("Base Layer.idle"))

		for k, v in pairs(self._animLayers) do
			self._avatar.animatorCtrl:setLayerWeight(v, self.mountLayerIndex == v and 1 or 0)
		end

		if self.fakePlayer:isAllLoaded() then
			self.fakePlayer.animatorCtrl:setBool(UnityEngine.Animator.StringToHash("ui"), false)
			self.fakePlayer.animatorCtrl:playAnim(UnityEngine.Animator.StringToHash("Base Layer.idle"))

			for k, v in pairs(self._animLayers) do
				self.fakePlayer.animatorCtrl:setLayerWeight(v, self.mountLayerIndex == v and 1 or 0)
			end
		end
	else
		self._avatar.animatorCtrl:setBool(UnityEngine.Animator.StringToHash("ui"), false)
		self._avatar.animatorCtrl:playAnim(UnityEngine.Animator.StringToHash("Base Layer.idle"))

		for k, v in pairs(self._animLayers) do
			self._avatar.animatorCtrl:setLayerWeight(v, v == 0 and 1 or 0)
		end

		if self.fakePlayer:isAllLoaded() then
			self.fakePlayer.animatorCtrl:setBool(UnityEngine.Animator.StringToHash("ui"), false)
			self.fakePlayer.animatorCtrl:playAnim(UnityEngine.Animator.StringToHash("Base Layer.idle"))

			for k, v in pairs(self._animLayers) do
				self.fakePlayer.animatorCtrl:setLayerWeight(v, v == 0 and 1 or 0)
			end
		end
	end
end

function AvatarMountCtrl:_endMounting()
	self:syncMountAnim()
	self:syncMountPosition()
end

function AvatarMountCtrl:_onRecycleMountResObject(loader, obj)
	if self._rootParent then
		self.mount:setParent(self._rootParent)
		self.fakePlayer:setParent(self._rootParent)
	end
end

function AvatarMountCtrl:_buildMountEffects()
	self.mount.effectsCtrl:clearAllEffects()

	local mountCo = self:getCurMountCfg()

	if not mountCo then
		return
	end

	local effConfig

	if self._avatar.useType == AvatarUseType.UI then
		effConfig = mountCo.effects_hpm
	end

	effConfig = effConfig or mountCo.effects

	if not effConfig or #effConfig == 0 then
		return
	end

	for i = 1, #effConfig do
		local path, hagPoint, effType = self:_parseEffParams(effConfig[i])

		if (self._avatar.useType ~= AvatarUseType.UI or effType ~= AvatarFXEffType.WalkOnly) and path and hagPoint then
			if not string.find(path, ".prefab") then
				path = path .. ".prefab"
			end

			self.mount.effectsCtrl:setEffect("effect/prefabs/zuoqi/" .. path, hagPoint, effType)
		end
	end
end

function AvatarMountCtrl:_parseEffParams(effConfig)
	if string.nilorempty(effConfig) then
		return
	end

	local cfgs = string.split(effConfig, ",")

	return cfgs[1], cfgs[2], checknumber(cfgs[3] or 0)
end

function AvatarMountCtrl:syncMountAnim()
	if not self.isMounted or not self.mountLayerIndex or self.mountLayerIndex == -1 then
		return
	end

	self._avatar.animatorCtrl:replayAnim()
	self.fakePlayer.animatorCtrl:replayAnim()
end

function AvatarMountCtrl:syncMountPosition()
	return
end

function AvatarMountCtrl:setFakeAvatarMo(mo)
	self.fakePlayer.useType = AvatarUseType.Scene

	self.fakePlayer:updateByMo(mo)
end

function AvatarMountCtrl:resetFakeAvatar()
	self.fakePlayer:reset()
end

function AvatarMountCtrl:_onFakeAvatarLoaded(fakeAvatar)
	local mountGo = self.mount:getGameObject()

	if not self.isMounted or not mountGo then
		self.fakePlayer:setVisible(false)

		return
	end

	self.fakePlayer:setVisible(true)

	local subMountPoint = self.mount:getBoneByPointType(AvatarHangPointType.SubMount)

	if subMountPoint then
		local go = self.fakePlayer:getGameObject()

		go.transform:SetParent(subMountPoint.transform)
		GameUtil.setLocalRotation(go, 90, 0, 0)

		local subMountSycBone = self.fakePlayer:getBoneByName("Bip001")

		if subMountSycBone then
			local syncFake = SyncPositionByBones.Get(self.fakePlayer:getGameObject())

			syncFake.originBone = subMountPoint
			syncFake.targetBone = subMountSycBone
			syncFake.enabled = true

			settimer(0.1, self._updateFakePlayerParent, self, false)
		end
	end

	local mountAnim = self.mount.animatorCtrl:getAnimator()
	local anims = self.fakePlayer.animatorCtrl:getCurAnimators()

	for i = 1, #anims do
		anims[i].updateMode = mountAnim.updateMode
		anims[i].cullingMode = mountAnim.cullingMode
	end

	self:updateMountingLayer()
end

function AvatarMountCtrl:_updateFakePlayerParent()
	local go = self.fakePlayer:getGameObject()

	if go then
		go.transform:SetParent(self._rootParent)
	end
end

function AvatarMountCtrl:getCurrentMountPosParams()
	local cfg = self:getCurMountCfg()

	if cfg and cfg.posParams then
		return cfg.posParams
	end

	return {
		0,
		0,
		0
	}
end

function AvatarMountCtrl:getMountBoneByPointType(pointType)
	if self.isMounted and self.mount then
		return self.mount:getBoneByPointType(pointType)
	end

	return nil
end

return AvatarMountCtrl
