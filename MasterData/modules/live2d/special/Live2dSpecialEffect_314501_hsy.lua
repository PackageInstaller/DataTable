-- chunkname: @modules/live2d/special/Live2dSpecialEffect_314501_hsy.lua

module("modules.live2d.special.Live2dSpecialEffect_314501_hsy", package.seeall)

local Live2dSpecialEffect_314501_hsy = class("Live2dSpecialEffect_314501_hsy", BaseLive2dSpecialEffect)

function Live2dSpecialEffect_314501_hsy:_onInit()
	self._isInStoryView = ViewMgr.instance:isOpen(ViewName.StoryView)
	self._isInVoiceView = ViewMgr.instance:isOpen(ViewName.CharacterDataView)
	self._normalMapPath0 = "live2d/dynamic/314501_hsy_01_bloom_special.png"
	self._normalMapPath1 = "live2d/dynamic/314501_hsy_00_bloom_special.png"
end

function Live2dSpecialEffect_314501_hsy:addEventListeners()
	self.addEventCb(self, PostProcessingMgr.instance, PostProcessingEvent.onCameraRootAnimatorControllerChange, self.onAnimatorControllerChange, self)
end

function Live2dSpecialEffect_314501_hsy:removeEventListeners()
	self.removeEventCb(self, PostProcessingMgr.instance, PostProcessingEvent.onCameraRootAnimatorControllerChange, self.onAnimatorControllerChange, self)
end

local needSetHsyLightTexture = {
	"b_piaofu1",
	"b_piaofu2",
	"b_huiyin"
}
local needResetHsyLightTexture = {
	"b_idle",
	"b_piaofu3"
}

function Live2dSpecialEffect_314501_hsy:_onBodyChange(prevBodyName, curBodyName)
	if self:isFindAnim(curBodyName, needSetHsyLightTexture) then
		self:clearTimer()
		self:_setHsyLightTexture()

		return
	end

	if self:isFindAnim(curBodyName, needResetHsyLightTexture) then
		self:clearTimer()
		self:_resetHsyLightTexture()

		return
	end
end

function Live2dSpecialEffect_314501_hsy:clearTimer()
	TaskDispatcher.cancelTask(self._delaySetHsyLightTexture, self)
	TaskDispatcher.cancelTask(self._delayResetHsyLightTexture, self)
	TaskDispatcher.cancelTask(self._delayEnableKeyword, self)
end

function Live2dSpecialEffect_314501_hsy:_setHsyLightTexture()
	self._isSetHsyLightTexture = true

	if not self._isLightTextureLoadedFinish then
		self:loadHsyLightTexture()

		return
	end

	if self._hasSetHsyLightTexture then
		return
	end

	self._hasSetHsyLightTexture = true

	self:_playCameraBloomAnim()
	TaskDispatcher.runDelay(self._delaySetHsyLightTexture, self, 1)
end

function Live2dSpecialEffect_314501_hsy:_delaySetHsyLightTexture()
	local cubctrl = self:getCubismController()

	if gohelper.isNil(cubctrl) then
		return
	end

	self._rawMap0 = self._rawMap0 or cubctrl.InstancedMaterials[0]:GetTexture("_NormalMap")
	self._rawMap1 = self._rawMap1 or cubctrl.InstancedMaterials[1]:GetTexture("_NormalMap")

	cubctrl.InstancedMaterials[0]:SetTexture("_NormalMap", self._normalMap0)
	cubctrl.InstancedMaterials[1]:SetTexture("_NormalMap", self._normalMap1)
end

function Live2dSpecialEffect_314501_hsy:_resetHsyLightTexture()
	self._isSetHsyLightTexture = false

	if not self._hasSetHsyLightTexture then
		return
	end

	self._hasSetHsyLightTexture = false

	self:_resetCamera()

	if self:isInStoryView() then
		TaskDispatcher.runDelay(self._delayResetHsyLightTexture, self, 1)
	end
end

function Live2dSpecialEffect_314501_hsy:_delayResetHsyLightTexture()
	self:_delayDisableKeyword()

	local cubctrl = self:getCubismController()

	if gohelper.isNil(cubctrl) then
		return
	end

	if self._rawMap0 then
		cubctrl.InstancedMaterials[0]:SetTexture("_NormalMap", self._rawMap0)
	end

	if self._rawMap1 then
		cubctrl.InstancedMaterials[1]:SetTexture("_NormalMap", self._rawMap1)
	end
end

function Live2dSpecialEffect_314501_hsy:initAnimatorName()
	if self:isInVoiceView() then
		if self:isPlayingVoiceId(1314532) then
			self._animationControllerName = "v3a8_hsy_bloom_ui2"

			return
		end

		self._animationControllerName = "v3a8_hsy_bloom_ui"

		return
	end

	if self:isInStoryView() then
		self._animationControllerName = "v3a8_hsy_bloom_story"

		return
	end

	self._animationControllerName = "v3a8_hsy_bloom"
end

function Live2dSpecialEffect_314501_hsy:loadHsyLightTexture()
	self._rawMap0 = nil
	self._rawMap1 = nil

	if not self._effectLoader then
		self._effectLoader = MultiAbLoader.New()

		self._effectLoader:addPath("ui/animations/dynamic/v3a8_hsy_bloom_ui2.controller")
		self._effectLoader:addPath("ui/animations/dynamic/v3a8_hsy_bloom_ui.controller")
		self._effectLoader:addPath("ui/animations/dynamic/v3a8_hsy_bloom_story.controller")
		self._effectLoader:addPath("ui/animations/dynamic/v3a8_hsy_bloom.controller")
		self._effectLoader:addPath(self._normalMapPath0)
		self._effectLoader:addPath(self._normalMapPath1)
		self._effectLoader:startLoad(self._loadEffectFinished, self)
	end
end

function Live2dSpecialEffect_314501_hsy:_loadEffectFinished()
	self._isLightTextureLoadedFinish = true

	local normalMap0 = self._effectLoader:getAssetItem(self._normalMapPath0)

	self._normalMap0 = normalMap0 and normalMap0:GetResource(self._normalMapPath0)

	local normalMap1 = self._effectLoader:getAssetItem(self._normalMapPath1)

	self._normalMap1 = normalMap1 and normalMap1:GetResource(self._normalMapPath1)

	if self._isSetHsyLightTexture then
		self:_setHsyLightTexture()
	else
		self:_resetHsyLightTexture()
	end
end

function Live2dSpecialEffect_314501_hsy:_playCameraBloomAnim()
	if not self._effectLoader then
		return
	end

	self:initAnimatorName()
	self:_setPPVolume()

	local url = string.format("ui/animations/dynamic/%s.controller", self._animationControllerName)
	local assetItem = self._effectLoader:getAssetItem(url)
	local animatorInst = assetItem:GetResource(url)
	local animator = CameraMgr.instance:getCameraRootAnimator()

	CameraMgr.instance:setCameraRootAnimatorController(animatorInst)

	animator.enabled = true

	animator:Play("start")
	self:setUnitCamera()
end

function Live2dSpecialEffect_314501_hsy:_resetCamera()
	local player = CameraMgr.instance:getCameraRootAnimatorPlayer()

	if not player then
		return
	end

	local animator = player.animator
	local animatorInst = animator.runtimeAnimatorController

	if not animatorInst or animatorInst.name ~= self._animationControllerName then
		return
	end

	local defaultEndAnim = "end"
	local endAnim

	if not self:isInVoiceView() and not self:isInStoryView() then
		local curLightMode = WeatherController.instance:getCurLightMode()

		if curLightMode then
			local animList = {
				"end_sunny",
				"end_cloudy",
				"end_dusk",
				"end_night"
			}

			endAnim = animList[curLightMode]
		end
	end

	player:Play(endAnim or defaultEndAnim, self._clearCameraAnimationController, self)

	if not self:isInStoryView() then
		local animationEventWrap = CameraMgr.instance:getCameraRootAnimationEventWrap()

		if animationEventWrap then
			animationEventWrap:AddEventListener("bloomTexExchange", self._onBloomTexExchange, self)
		end
	end
end

function Live2dSpecialEffect_314501_hsy:_onBloomTexExchange()
	self:_delayResetHsyLightTexture()
end

function Live2dSpecialEffect_314501_hsy:setUnitCamera()
	if not self:isInVoiceView() then
		return
	end

	TaskDispatcher.runDelay(self._delayEnableKeyword, self, 0.5)

	local go = CameraMgr.instance:getUnitCameraGO()

	gohelper.setActive(go, true)

	if self.unitCameraRawData then
		return
	end

	local camera = CameraMgr.instance:getUnitCamera()
	local trs = CameraMgr.instance:getUnitCameraTrs()
	local rawData = {}

	rawData.posX, rawData.posY, rawData.posZ = transformhelper.getPos(trs)
	rawData.scaleX, rawData.scaleY, rawData.scaleZ = transformhelper.getLocalScale(trs)
	rawData.orthographic = camera.orthographic
	rawData.orthographicSize = camera.orthographicSize
	rawData.farClipPlane = camera.farClipPlane
	rawData.nearClipPlane = camera.nearClipPlane
	rawData.aspect = camera.aspect
	self.unitCameraRawData = rawData

	local live2dCamera = self:getLive2dCamera()

	if not live2dCamera then
		return
	end

	local live2dTrs = live2dCamera.transform
	local worldPosX, worldPosY, worldPosZ = transformhelper.getPos(live2dTrs)

	transformhelper.setPos(trs, worldPosX, worldPosY, worldPosZ)

	local worldScaleX, worldScaleY, worldScaleZ = transformhelper.getLossyScale(live2dTrs)
	local parentScaleX, parentScaleY, parentScaleZ = transformhelper.getLossyScale(trs.parent)

	transformhelper.setLocalScale(trs, worldScaleX / parentScaleX, worldScaleY / parentScaleY, worldScaleZ / parentScaleZ)

	camera.orthographic = live2dCamera.orthographic
	camera.orthographicSize = live2dCamera.orthographicSize
	camera.nearClipPlane = live2dCamera.nearClipPlane
	camera.farClipPlane = live2dCamera.farClipPlane
	camera.aspect = live2dCamera.aspect
end

function Live2dSpecialEffect_314501_hsy:resetUnitCamera()
	if not self:isInVoiceView() then
		return
	end

	local go = CameraMgr.instance:getUnitCameraGO()
	local camera = CameraMgr.instance:getUnitCamera()
	local trs = CameraMgr.instance:getUnitCameraTrs()
	local show = CameraMgr.instance:getSceneCameraActive()

	if not show then
		gohelper.setActive(go, false)
	end

	if not self.unitCameraRawData then
		return
	end

	local rawData = self.unitCameraRawData

	transformhelper.setPos(trs, rawData.posX, rawData.posY, rawData.posZ)
	transformhelper.setLocalScale(trs, rawData.scaleX, rawData.scaleY, rawData.scaleZ)

	camera.orthographic = rawData.orthographic
	camera.orthographicSize = rawData.orthographicSize
	camera.farClipPlane = rawData.farClipPlane
	camera.nearClipPlane = rawData.nearClipPlane
	camera.aspect = rawData.aspect
	self.unitCameraRawData = nil
end

function Live2dSpecialEffect_314501_hsy:_clearCameraAnimationController()
	self:resetUnitCamera()
	self:_resetPPVolume()

	if self:isInVoiceView() then
		local animationEventWrap = CameraMgr.instance:getCameraRootAnimationEventWrap()

		if animationEventWrap then
			animationEventWrap:RemoveEventListener("bloomTexExchange")
		end
	end

	local animator = CameraMgr.instance:getCameraRootAnimator()
	local animatorInst = animator.runtimeAnimatorController

	if not animatorInst or animatorInst.name ~= self._animationControllerName then
		return
	end

	CameraMgr.instance:setCameraRootAnimatorController()
end

function Live2dSpecialEffect_314501_hsy:_delayEnableKeyword()
	if self._isEnableKeyword then
		return
	end

	local mat = self:getMat()

	if mat then
		mat:EnableKeyword("USE_BLOOMTEX")

		self._isEnableKeyword = true
	end
end

function Live2dSpecialEffect_314501_hsy:_delayDisableKeyword()
	if not self._isEnableKeyword then
		return
	end

	local mat = self:getMat()

	if mat then
		mat:DisableKeyword("USE_BLOOMTEX")

		self._isEnableKeyword = false
	end
end

function Live2dSpecialEffect_314501_hsy:isInVoiceView()
	return self._isInVoiceView
end

function Live2dSpecialEffect_314501_hsy:isInStoryView()
	return self._isInStoryView
end

function Live2dSpecialEffect_314501_hsy:_resetPPVolume()
	if not self._rawPPVolumeProfile then
		return
	end

	PostProcessingMgr.instance:setProfile(self._rawPPVolumeProfile)

	self._rawPPVolumeProfile = nil
end

function Live2dSpecialEffect_314501_hsy:_setPPVolume()
	if self._rawPPVolumeProfile then
		return
	end

	self._rawPPVolumeProfile = PostProcessingMgr.instance:getUnitProfile()

	local profile = ConstAbCache.instance:getRes(PostProcessingMgr.MainAllProfilePath)

	PostProcessingMgr.instance:setProfile(profile)
end

function Live2dSpecialEffect_314501_hsy:onAnimatorControllerChange(controllerName)
	if controllerName == self._animationControllerName then
		return
	end

	local player = CameraMgr.instance:getCameraRootAnimatorPlayer()

	if not player then
		return
	end

	local animator = player.animator
	local animatorInst = animator.runtimeAnimatorController

	if not animatorInst or animatorInst.name ~= self._animationControllerName then
		return
	end

	local layer = 0
	local info = animator:GetCurrentAnimatorStateInfo(layer)

	animator:Play(info.fullPathHash, layer, 1)
	animator:Update(0)
	self:_clearCameraAnimationController()

	if not self:isInStoryView() then
		self:_onBloomTexExchange()
	end
end

function Live2dSpecialEffect_314501_hsy:onDestroy()
	if self._effectLoader then
		self._effectLoader:dispose()

		self._effectLoader = nil
	end

	self:_resetPPVolume()
	self:_clearCameraAnimationController()
	self:_delayDisableKeyword()

	self._rawMap0 = nil
	self._rawMap1 = nil

	TaskDispatcher.cancelTask(self._delaySetHsyLightTexture, self)
	TaskDispatcher.cancelTask(self._delayResetHsyLightTexture, self)
	TaskDispatcher.cancelTask(self._delayEnableKeyword, self)
end

return Live2dSpecialEffect_314501_hsy
