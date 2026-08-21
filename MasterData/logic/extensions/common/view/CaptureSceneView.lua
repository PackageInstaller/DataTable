-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/view/CaptureSceneView.lua

module("logic.extensions.common.view.CaptureSceneView", package.seeall)

local M = class("CaptureSceneView", ViewComponent)

function M:ctor(rtPath)
	self._rtPath = rtPath

	M.super.ctor(self)
end

function M:buildUI()
	self._rawImage = goutil.findChildRawImageComponent(self.mainGO, self._rtPath or "common_blur_rt")
	self._photo = Astral.PhotoBase.Add(self._rawImage.gameObject)

	self:updateImageSize()

	local blurUtil = SpaceX.UIGlassBlurUtil.Get(self._rawImage.gameObject)

	blurUtil.enabled = false
end

function M:destroyUI()
	self._photo:TurnOff()

	self._photo = nil
end

function M:onEnter()
	self:updateImageSize()

	if self._noWorkOnEnter then
		return
	end

	local camCode = self:getOnEnterCaptureCamCode()

	if camCode then
		self:tryCaptureWithCamCode(camCode)

		return
	end

	local camData = self:getOnEnterCaptureCamData()

	if camData then
		self:tryCaptureWithData(camData.pX, camData.pY, camData.pZ, camData.rX, camData.rY, camData.rZ, camData.fov)

		return
	end

	printError("not set up onEnter data")
end

function M:onExit()
	return
end

function M:onExitFinished()
	if self._renderTexture then
		UnityEngine.RenderTexture.ReleaseTemporary(self._renderTexture)
	end

	self._renderTexture = false

	if self._texture2D then
		goutil.destroy(self._texture2D)
	end

	self._texture2D = false
end

function M:getRawImage()
	return self._rawImage
end

function M:updateImageSize()
	local uiRoot = ViewMgr.instance:getUIRoot()
	local rectTransform = uiRoot.transform
	local width = math.ceil(rectTransform.rect.width)
	local height = math.ceil(rectTransform.rect.height)

	RectTransformUtils.SetSize(self._rawImage.transform, width, height)

	return width, height
end

function M:setNoWorkOnEnter(noWorkOnEnter)
	self._noWorkOnEnter = noWorkOnEnter
end

function M:setOnEnterCaptureCamCode(camCode)
	self._onEnterCaptureCamCode = camCode
end

function M:getOnEnterCaptureCamCode()
	return self._onEnterCaptureCamCode
end

function M:setOnEnterCaptureCamData(pX, pY, pZ, rX, rY, rZ, fov)
	self._onEnterCaptureCamData = {
		pX = pX,
		pY = pY,
		pZ = pZ,
		rX = rX,
		rY = rY,
		rZ = rZ,
		fov = fov
	}
end

function M:getOnEnterCaptureCamData()
	return self._onEnterCaptureCamData
end

function M:setBlur(needBlur, downSample, iteration)
	self._needBlur = needBlur
	self._downSample = downSample
	self._iteration = iteration
end

function M:setLayerMask(mask)
	self._layerMask = mask
end

function M:getLayerMask()
	return self._layerMask
end

function M:tryCaptureWithCamCode(camCode)
	local camCfg = MainPerformConfig.instance:getConfigByKey(ConfigName.MainPerformCameraR, camCode)

	if not camCfg then
		return false
	end

	local posData = camCfg and camCfg.posData or {}
	local pX = posData[1] or 0
	local pY = posData[2] or 0
	local pX, pY, pZ = pX, pY, posData[3] or 0
	local rX = posData[4] or 0
	local rY = posData[5] or 0
	local rX, rY, rZ = rX, rY, posData[6] or 0
	local fov = posData[7] or MainPerformEnum.DefaultFov

	self:tryCaptureWithData(pX, pY, pZ, rX, rY, rZ, fov)
end

function M:tryCaptureWithData(pX, pY, pZ, rX, rY, rZ, fov)
	local width, height = self:updateImageSize()

	goutil.setActive(self._rawImage.gameObject, true)
	self._photo:TurnOn(width, height, UnityEngine.RenderTextureFormat.ARGB32, 2)

	local cam = PhotoBaseExtension.GetCamera(self._photo)
	local offsetX, offsetY, offsetZ = TransformUtils.GetLocalPosition(cam.transform.parent, 0, 0, 0)

	PhotoBaseExtension.SetCameraTag(self._photo, "RTCamera")
	PhotoBaseExtension.SetCameraPerspective(self._photo, fov)
	PhotoBaseExtension.SetCameraPostProcessing(self._photo, true, SceneLayer.Default_Value)

	local customLayerMask = self:getLayerMask()
	local layerMaskVolume, layerMaskCulling

	if customLayerMask then
		layerMaskVolume = customLayerMask
		layerMaskCulling = customLayerMask
	else
		layerMaskVolume = Astral.LayerUtil.GetLayerMask(SceneLayer.Default_Value, SceneLayer.Unit_Value, SceneLayer.Stone_Value)
		layerMaskCulling = Astral.LayerUtil.GetLayerMask(SceneLayer.Default_Value, SceneLayer.Unit_Value, SceneLayer.Stone_Value)
	end

	URPCameraUtils.SetVolumeLayerMask(cam, layerMaskVolume)

	cam.cullingMask = layerMaskCulling

	self._photo:SetCameraPosition(pX - offsetX, pY - offsetY, pZ - offsetZ)
	self._photo:SetCameraRotation(rX, rY, rZ)

	local captureRect = UnityEngine.Rect.New(0, 0, width, height)

	URPCameraUtils.CaptureScreenShotToFile(cam, captureRect, nil, self._onCaptureFinish, self)
end

function M:_onCaptureFinish(texture2D)
	self._texture2D = texture2D

	if self._needBlur then
		local downSample = self._downSample
		local iteration = self._iteration

		self._renderTexture = SpaceX.CommandBufferEffectUtils.Blur(texture2D, CommonPreloader.instance:getMaterialsCommAsset(CommonResPath.BlurMat), downSample, iteration)
		self._rawImage.texture = self._renderTexture
	else
		self._rawImage.texture = texture2D
	end

	self._rawImage.enabled = true

	self._photo:TurnOff()
end

return M
