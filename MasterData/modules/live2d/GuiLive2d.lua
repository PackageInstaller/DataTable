-- chunkname: @modules/live2d/GuiLive2d.lua

module("modules.live2d.GuiLive2d", package.seeall)

local GuiLive2d = class("GuiLive2d", BaseLive2d)
local cameraPath = "live2d/custom/live2d_camera.prefab"
local matPath = "live2d/custom/uiimage.mat"
local SystemInfo = UnityEngine.SystemInfo
local csLive2dUseInvisible = typeof(ZProj.Live2dUseInvisible)

GuiLive2d.DefaultLive2dCameraSize = 6.5

function GuiLive2d.Create(gameObj, isStory)
	local ret = MonoHelper.addNoUpdateLuaComOnceToGo(gameObj, GuiLive2d)

	ret._isStory = isStory
	ret._scale = CharacterVoiceEnum.Live2dScale

	return ret
end

local MaximumAdapterScale = 1.34
local BaseDPI = 400

function GuiLive2d.GetScaleByDevice()
	if not GameGlobalMgr.instance:getScreenState():getLocalQuality() then
		local quality = ModuleEnum.Performance.High
		local deviceDPI = UnityEngine.Screen.dpi
		local _qualityScale = 1

		if quality ~= ModuleEnum.Performance.Low and deviceDPI > 1 and deviceDPI < BaseDPI then
			_qualityScale = BaseDPI / deviceDPI
			_qualityScale = Mathf.Clamp(BaseDPI / deviceDPI, 1, 1.5)
		end

		local _adapterScaleOnCreate = math.min(GameUtil.getAdapterScale(), MaximumAdapterScale)

		return _qualityScale, _adapterScaleOnCreate
	end
end

function GuiLive2d:ctor()
	self._qualityScale, self._adapterScaleOnCreate = GuiLive2d.GetScaleByDevice()
end

function GuiLive2d:getCreateType()
	return self._createType
end

function GuiLive2d:getRawImageLocalPos()
	return recthelper.getAnchor(self._rawImageTransform)
end

function GuiLive2d:setCreateType(createType)
	self._createType = createType
	self._scale = CharacterVoiceEnum.getLive2dScale(self._createType)
	self._offsetX = nil
	self._offsetY = nil

	TaskDispatcher.cancelTask(self._updateRawImagePos, self)

	if not self._rawImageGo then
		self._rawImageGo = gohelper.create2d(self._gameTr.parent.gameObject, "live2d_rawImage")
		self._rawImageTransform = self._rawImageGo.transform

		self:setSpineScale(self._rawImageGo)
		self:refreshRawImagePos()
	end
end

function GuiLive2d:refreshRawImagePos()
	if self._rawImageTransform then
		CharacterVoiceEnum.setRTRawPos(self._rawImageTransform, self._createType, self._rtViewName)
	end
end

function GuiLive2d:setOffsetPos(offsetX, offsetY)
	self._offsetX = offsetX
	self._offsetY = offsetY

	TaskDispatcher.cancelTask(self._updateRawImagePos, self)
	TaskDispatcher.runRepeat(self._updateRawImagePos, self, 0)
end

function GuiLive2d:_updateRawImagePos()
	if not self._cameraVisible then
		return
	end

	self:refreshRawImagePos()
	CharacterVoiceEnum.setLive2dOffset(self, self._offsetX, self._offsetY, self._rtViewName)
end

function GuiLive2d:addEventListeners()
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self)
end

function GuiLive2d:removeEventListeners()
	self.removeEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self)
end

function GuiLive2d:_onScreenResize()
	if self._rawImageGo then
		self:setSpineScale(self._rawImageGo)
	end

	if self:_needChangeRTSize() then
		local scale = GameUtil.getAdapterScale()

		self._cameraSize = CharacterVoiceEnum.getCameraSize(self._createType) / scale

		if self._cameraSize > 0 and self._camera then
			self._camera.orthographicSize = self._cameraSize
		end
	end
end

function GuiLive2d:_needChangeRTSize()
	return CharacterVoiceEnum.ChangeRTSize and self._shareRT and self._shareRT ~= CharacterVoiceEnum.RTShareType.FullScreen
end

function GuiLive2d:hideCamera()
	self:_setCameraVisible(false)
end

function GuiLive2d:hideModel()
	self:_setCameraVisible(false)
	gohelper.setActive(self._spineGo, false)
end

function GuiLive2d:showModel()
	self:_setCameraVisible(true)
	gohelper.setActive(self._spineGo, true)

	if gohelper.isNil(self:getSpineGo()) == false then
		local bodyName = self:getCurBody()

		self:play(bodyName, bodyName == StoryAnimName.B_IDLE)
	end

	if not self._uiEffectGos then
		self:_addDelayProcessEffect()
	end
end

function GuiLive2d:_addDelayProcessEffect()
	self._repeatCount = 0
	self._repeatNum = CharacterVoiceEnum.DelayFrame

	TaskDispatcher.cancelTask(self._delayProcessEffect, self)
	TaskDispatcher.runRepeat(self._delayProcessEffect, self, 0, self._repeatNum)
end

function GuiLive2d:_delayProcessEffect()
	self._repeatCount = self._repeatCount + 1

	if self._repeatCount < self._repeatNum then
		return
	end

	self:_doProcessEffect()
end

function GuiLive2d:cancelCamera()
	self._cancelCamera = true
end

function GuiLive2d:isCancelCamera()
	return self._cancelCamera
end

function GuiLive2d:_setCameraVisible(value)
	self._cameraVisible = value

	if self._cameraGo then
		gohelper.setActive(self._cameraGo, value)
	end

	if self._rawImageGo then
		gohelper.setActive(self._rawImageGo, value)
	end
end

function GuiLive2d:setLocalScale(value)
	self._scale = value

	if self._spineTr then
		transformhelper.setLocalScale(self._spineTr, self._scale, self._scale, 1)
	end
end

function GuiLive2d:setCameraSize(value)
	self._cameraSize = value
end

function GuiLive2d:setCameraLayer(value)
	self._cameraLayer = value

	if self._camera and self._cameraLayer then
		self._camera.cullingMask = bit.lshift(1, self._cameraLayer)
	end
end

function GuiLive2d:_onResLoaded()
	GuiLive2d.super._onResLoaded(self)
	transformhelper.setLocalScale(self._spineTr, self._scale, self._scale, 1)
	self:_initSkinUiEffect()

	if not self._cancelCamera then
		self:_initCamera()
	end
end

function GuiLive2d:_initSkinUiEffect()
	self._tempVec2 = self._tempVec2 or Vector2.New()
	self._uiEffectGos = nil
	self._uiEffectGosClone = nil
	self._uiEffectList = nil
	self._uiEffectConfig = nil
	self._uiEffectInitVisible = nil
	self._hasProcessModelEffect = nil

	for i, v in ipairs(lua_skin_ui_effect.configList) do
		if not self:_skip(v.id) and string.find(self._resPath, v.id) then
			self._uiEffectConfig = v
			self._uiEffectList = string.split(v.effect, "|")
			self._uiEffectInitVisible = {}

			break
		end
	end
end

function GuiLive2d:_skip(id)
	return id == 304802
end

function GuiLive2d:hideModelEffect()
	if not self._uiEffectGos then
		return
	end

	for i, v in ipairs(self._uiEffectGos) do
		if self._uiEffectInitVisible[i] then
			gohelper.setActive(v, false)
		end
	end
end

function GuiLive2d:showModelEffect()
	if not self._uiEffectGos then
		return
	end

	for i, v in ipairs(self._uiEffectGos) do
		if self._uiEffectInitVisible[i] then
			gohelper.setActive(v, true)
		end
	end
end

function GuiLive2d:processModelEffect()
	self._hasProcessModelEffect = true

	self:_doProcessEffect()
end

function GuiLive2d:_processEffect()
	if self._uiEffectList then
		for i, v in ipairs(self._uiEffectList) do
			local root = gohelper.findChild(self._spineGo, v)

			if root then
				self._uiEffectInitVisible[i] = root.gameObject.activeSelf

				gohelper.setActive(root.gameObject, false)
			end
		end
	end

	self:_addDelayProcessEffect()
end

function GuiLive2d:_doProcessEffect()
	if gohelper.isNil(self._spineGo) then
		return
	end

	if not self._spineGo.activeInHierarchy then
		return
	end

	if self._uiEffectGos or not self._camera then
		return
	end

	self._hasProcessModelEffect = false
	self._uiEffectGos = self:getUserDataTb_()
	self._uiEffectGosClone = self:getUserDataTb_()

	if self._uiEffectList then
		for i, v in ipairs(self._uiEffectList) do
			local go, goClone = self:_initSkinUiEffectGo(v, self._uiEffectInitVisible[i], i)

			if go then
				table.insert(self._uiEffectGos, go)

				self._uiEffectGosClone[i] = goClone
			end
		end

		TaskDispatcher.runRepeat(self._realtimeAdjustPos, self, 0.1)
	end

	self:_initEffectLayer()

	if self:hasEverNodes() then
		self:_startRealtimeAdjustPos()
	end
end

function GuiLive2d:_initEffectLayer()
	local effectList, layerName

	for i, v in ipairs(lua_character_motion_effect_layer.configList) do
		if string.find(self._resPath, v.heroResName) then
			effectList = string.split(v.node1, "|")
			layerName = v.node1Layer

			break
		end
	end

	if not effectList then
		return
	end

	local layer = UnityLayer[layerName]

	if not layer then
		logError(string.format("layerName:%s is not exist", layerName))

		return
	end

	for i, path in ipairs(effectList) do
		local effectGo = gohelper.findChild(self._spineGo, path)

		if effectGo then
			gohelper.setLayer(effectGo, layer)
		else
			logError(string.format("GuiLive2d _initEffectLayer path:%s is not exist", path))
		end
	end
end

function GuiLive2d:_onBodyEffectShow(visible)
	if self._hasProcessModelEffect then
		self:_doProcessEffect()
	end

	self._isShowBodyEffect = visible

	self:_startRealtimeAdjustPos()
end

function GuiLive2d:_startRealtimeAdjustPos()
	TaskDispatcher.cancelTask(self._realtimeAdjustPos, self)

	if self._isShowBodyEffect and self._uiEffectGosClone and next(self._uiEffectGosClone) then
		TaskDispatcher.runRepeat(self._realtimeAdjustPos, self, 0.1)
	end
end

function GuiLive2d:_realtimeAdjustPos()
	local showEffect = false

	if self._uiEffectGos then
		for i, v in ipairs(self._uiEffectGos) do
			local goClone = self._uiEffectGosClone[i]

			if not gohelper.isNil(goClone) and not gohelper.isNil(v) and v.activeSelf then
				showEffect = true

				self:_adjustPos(goClone, v)
			end
		end
	end

	if not showEffect then
		TaskDispatcher.cancelTask(self._realtimeAdjustPos, self)
	end
end

function GuiLive2d:_initSkinUiEffectGo(path, initVisible, index)
	local root = gohelper.findChild(self._spineGo, path)

	if gohelper.isNil(root) then
		if SLFramework.FrameworkSettings.IsEditor then
			if string.find(path, "#") then
				logError(string.format("%s 分隔符使用错误，#要改为|", path))

				return
			end

			logError(string.format("找不到特效节点：%s,请检查路径", path))

			return
		end

		return
	end

	if initVisible then
		gohelper.setActive(root.gameObject, true)
	end

	local layer = LayerMask.NameToLayer("UI")
	local list = root.gameObject:GetComponentsInChildren(typeof(UnityEngine.UI.MaskableGraphic), true)

	for i = 0, list.Length - 1 do
		local graphic = list[i]

		if isDebugBuild and graphic.enabled then
			logError(string.format("特效:%s,节点：%s,UIParticle初始已启用,请动效老师检查!", path, graphic.name))
		end

		graphic.enabled = true

		gohelper.setLayer(graphic.gameObject, layer)
	end

	local isRealtimeUpdate = true

	if isRealtimeUpdate then
		local rootTrans = root.transform
		local rootClone = gohelper.create3d(rootTrans.parent.gameObject, root.name .. "_Clone")

		rootClone.transform.localPosition = rootTrans.localPosition

		gohelper.setActive(rootClone, false)

		local scale = self:_getEffectScale()

		transformhelper.setLocalScale(root.transform, scale, scale, scale)
		self:_adjustPos(rootClone, root)

		return root, rootClone
	end

	self:_adjustPos(root, root)

	local scale = self:_getEffectScale()

	transformhelper.setLocalScale(root.transform, scale, scale, scale)

	return root
end

function GuiLive2d:_getEffectScale()
	local scale = self._uiEffectConfig.scale

	if scale <= 0 then
		if SLFramework.FrameworkSettings.IsEditor then
			logError(string.format("id:%d特效scale值错误：%s,不能配小于0的值，正常值是1以上。", self._uiEffectConfig.id, scale))
		end

		scale = 1
	end

	return scale
end

function GuiLive2d:_adjustPos(rootClone, root)
	local viewportPoint = self._camera:WorldToViewportPoint(rootClone.transform.position)

	self._tempVec2.x = viewportPoint.x
	self._tempVec2.y = viewportPoint.y

	local pivot = self._tempVec2
	local target = self._rawImageGo.transform
	local offset = pivot - target.pivot

	offset = offset:Scale(target.rect.size)

	local worldPos = target.position + target:TransformVector(offset)

	transformhelper.setPosXY(root.transform, worldPos.x, worldPos.y)
end

function GuiLive2d:setCameraLoadedCallback(callback, callbackObj)
	self.cameraCallback = callback
	self.cameraCallbackObj = callbackObj
end

function GuiLive2d:setCameraLoadFinishCallback(callback, callbackObj)
	self.cameraFinishCallback = callback
	self.cameraFinishCallbackObj = callbackObj

	if not gohelper.isNil(self._cameraGo) and self.cameraFinishCallback then
		self.cameraFinishCallback(self.cameraFinishCallbackObj, self)
	end
end

function GuiLive2d:_initCamera()
	if self._guiL2dLoader then
		if self._cameraGo then
			self:_onCameraLoaded()
		end

		return
	end

	local cameraRoot = UnityEngine.GameObject.New("live2d_camera_root")
	local cameraTransform = cameraRoot.transform

	cameraTransform.parent = self._gameTr.parent

	transformhelper.setLocalScale(cameraTransform, 1, 1, 1)
	transformhelper.setLocalPos(cameraTransform, 0, 0, 0)

	self._guiL2dLoader = MultiAbLoader.New()

	self._guiL2dLoader:addPath(cameraPath)
	self._guiL2dLoader:addPath(matPath)
	self._guiL2dLoader:startLoad(self._loadL2dResFinish, self)
end

function GuiLive2d:openBloomView(value)
	self._openBloomView = value
end

function GuiLive2d:setShareRT(value, viewName)
	self._shareRT = value
	self._rtViewName = viewName
end

function GuiLive2d:getRTViewName()
	return self._rtViewName
end

function GuiLive2d.getTextureSizeByCameraSize(cameraSize)
	local textureSize = 1600

	textureSize = cameraSize / GuiLive2d.DefaultLive2dCameraSize * textureSize

	return math.floor(textureSize)
end

function GuiLive2d:_getOpenBloomView()
	local var_47_0 = self._openBloomView

	if self._openBloomView then
		var_47_0 = self._skinId

		if self._skinId then
			local config = lua_skin_ui_bloom.configDict[self._skinId]

			return config and config[self._openBloomView] == 1
		end
	end
end

function GuiLive2d:_getRT(textureSize)
	if self:_getOpenBloomView() then
		return UnityEngine.RenderTexture.GetTemporary(textureSize, textureSize, 0, UnityEngine.RenderTextureFormat.ARGBHalf)
	end

	return UnityEngine.RenderTexture.GetTemporary(textureSize, textureSize, 0, UnityEngine.RenderTextureFormat.ARGB32)
end

function GuiLive2d:_loadL2dResFinish()
	local cmrAssetItem = self._guiL2dLoader:getAssetItem(cameraPath)

	self._cameraGo = gohelper.clone(cmrAssetItem:GetResource(), self._gameTr.parent.gameObject)

	local camera = self._cameraGo:GetComponent(typeof(UnityEngine.Camera))

	self._camera = camera

	if self._openBloomView and camera then
		camera.nearClipPlane = -30
		camera.farClipPlane = 30
	end

	if self._rtViewName == ViewName.CharacterSkinGainView and camera then
		camera.nearClipPlane = -30
		camera.farClipPlane = 30
	end

	transformhelper.setLocalPosXY(self._cameraGo.transform, 0, CharacterVoiceEnum.getCameraOffsetY(self._createType))

	if self._cameraLayer then
		self:setCameraLayer(self._cameraLayer)
	end

	if self:_needChangeRTSize() then
		local scale = GameUtil.getAdapterScale()

		self._cameraSize = CharacterVoiceEnum.getCameraSize(self._createType) / scale
	end

	if self._cameraSize > 0 then
		camera.orthographicSize = self._cameraSize
	end

	local textureSizeByCamera = GuiLive2d.getTextureSizeByCameraSize(camera.orthographicSize)
	local textureSize = textureSizeByCamera * self._adapterScaleOnCreate * self._qualityScale
	local maxTextureSize = SystemInfo.maxTextureSize

	if maxTextureSize < textureSize then
		textureSize = maxTextureSize
	end

	if not self._rawImageGo then
		self._rawImageGo = gohelper.create2d(self._gameTr.parent.gameObject, "live2d_rawImage")
		self._rawImageTransform = self._rawImageGo.transform

		self:setSpineScale(self._rawImageGo)
		self:refreshRawImagePos()
	end

	local image = gohelper.onceAddComponent(self._rawImageGo, gohelper.Type_RawImage)

	image.raycastTarget = false

	if not self._shareRT then
		self._rt = self._rt or self:_getRT(textureSize)
		camera.targetTexture = self._rt
		image.texture = self._rt

		image:SetNativeSize()
	else
		if self._shareRT == CharacterVoiceEnum.RTShareType.BloomAuto then
			if self:_getOpenBloomView() then
				self._shareRT = CharacterVoiceEnum.RTShareType.BloomOpen or CharacterVoiceEnum.RTShareType.BloomClose
			end
		end

		if self._shareRT == CharacterVoiceEnum.RTShareType.FullScreen then
			Live2dRTShareController.instance:clearAllRT()

			self._rt = self._rt or self:_getRT(textureSize)
			camera.targetTexture = self._rt
			image.texture = self._rt

			image:SetNativeSize()
		end

		Live2dRTShareController.instance:addShareInfo(camera, image, self._shareRT, self._heroId, self._skinId, self._rtViewName)
	end

	local matAssetItem = self._guiL2dLoader:getAssetItem(matPath)

	self._mat = UnityEngine.Object.Instantiate(matAssetItem:GetResource())

	if self._uiMaskBuffer ~= nil then
		self:setImageUIMask(self._uiMaskBuffer)
	end

	image.material = self._mat

	self:_setMaterialToInvisible(self._mat)
	self:_onCameraLoaded()
end

function GuiLive2d:_isAfterLive2d()
	return self._uiEffectConfig and self._uiEffectConfig.id == 307502
end

function GuiLive2d:_setMaterialToInvisible(material)
	if gohelper.isNil(self._spineGo) then
		return
	end

	local csInstance = self._spineGo:GetComponent(csLive2dUseInvisible)

	if not csInstance then
		return
	end

	csInstance:SetRawImageMaterial(material)

	csInstance.isInUI = true
end

function GuiLive2d:setSpineScale(rawimageGO)
	local scale = GameUtil.getAdapterScale() / (self._adapterScaleOnCreate or 1) / (self._qualityScale or 1)

	if self:_needChangeRTSize() then
		scale = 1
	end

	transformhelper.setLocalScale(rawimageGO.transform, scale, scale, scale)
end

function GuiLive2d:_onCameraLoaded()
	if self:_isAfterLive2d() then
		gohelper.setSiblingAfter(self._rawImageGo, self._gameObj)
	else
		gohelper.setAsFirstSibling(self._rawImageGo)
	end

	if self._cameraVisible == nil then
		self._cameraVisible = true
	end

	self:_setCameraVisible(self._cameraVisible)
	self:_processEffect()

	if self.cameraCallback then
		self.cameraCallback(self.cameraCallbackObj, self)
	end

	if self.cameraFinishCallback then
		self.cameraFinishCallback(self.cameraFinishCallbackObj, self)
	end
end

function GuiLive2d:setImageUIMask(isActive)
	if self._mat then
		if isActive == true then
			self._mat:EnableKeyword("_UIMASK_ON")
		else
			self._mat:DisableKeyword("_UIMASK_ON")
		end
	else
		self._uiMaskBuffer = isActive
	end
end

function GuiLive2d:onDestroy()
	GuiLive2d.super.onDestroy(self)

	if self._guiL2dLoader then
		self._guiL2dLoader:dispose()

		self._guiL2dLoader = nil
	end

	self._mat = nil

	if self._rt then
		UnityEngine.RenderTexture.ReleaseTemporary(self._rt)

		self._rt = nil
	end

	TaskDispatcher.cancelTask(self._delayProcessEffect, self)
	TaskDispatcher.cancelTask(self._realtimeAdjustPos, self)
	TaskDispatcher.cancelTask(self._updateRawImagePos, self)

	self._uiEffectGos = nil
	self._uiEffectGosClone = nil
	self._rawImageGo = nil
	self._cameraGo = nil
end

return GuiLive2d
