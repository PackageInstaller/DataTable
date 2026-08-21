-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/view/BlurBgView.lua

module("logic.extensions.common.view.BlurBgView", package.seeall)

local M = class("BlurBgView", ViewComponent)

function M:ctor(blurRtPath, useCameraTarget)
	self._blurRtPath = blurRtPath
	self._downSample = 4
	self._iteration = 2

	if useCameraTarget then
		-- block empty
	end

	self._useCapture = true
	self._isOnlyBlurScene = false
	self._hasBlurBg = false

	M.super.ctor(self)
end

function M:buildUI()
	self._curCanvasGroup = goutil.addComponentOnce(self.mainGO, ComponentType.CanvasGroup)
	self._screenshotBlurImage = goutil.findChildRawImageComponent(self.mainGO, self._blurRtPath or "common_blur_rt")
	self._uiGlassBlur = SpaceX.UIGlassBlurUtil.Get(self._screenshotBlurImage.gameObject)

	local uiRoot = ViewMgr.instance:getUIRoot()
	local rectTransform = uiRoot.transform

	self._width = rectTransform.rect.width
	self._height = rectTransform.rect.height

	RectTransformUtils.SetSize(self._screenshotBlurImage.transform, self._width, self._height)
end

function M:onEnter()
	RectTransformUtils.SetSize(self._screenshotBlurImage.transform, self._width, self._height)

	if self._noBlurOnEnter then
		return
	end

	self:tryBlurBg()

	self._hasBlurBg = true
end

function M:onExit(reasonTyp)
	self._reasonTyp = reasonTyp
end

function M:onExitFinished()
	if WindowType.WindowCloseReasonType.QuickCloseType == self._reasonTyp then
		return
	end

	self._uiGlassBlur:ClearBlurBg()
	self._uiGlassBlur:ClearCapture()
end

function M:setNoBlurOnEnter(noBlurOnEnter)
	self._noBlurOnEnter = noBlurOnEnter
end

function M:destroyUI()
	RendererFeatureUtil.toggleRendererFeature(RendererFeatureName.UIGlassBlurBg, false, self._viewName)
	self._uiGlassBlur:ClearBlurBg()
	self._uiGlassBlur:ClearCapture()

	self._viewName = nil

	self._uiGlassBlur:RemoveListener()

	self._hasBlurBg = false
end

function M:setBlurArgs(downSample, iteration)
	self._downSample = downSample and downSample or 4
	self._iteration = iteration and iteration or 2
end

function M:tryBlurBg()
	self._viewName = self._viewPresentor and self._viewPresentor:getViewName() or "BlurBgView"
	self._uiGlassBlur.enabled = not self._useCapture

	self._uiGlassBlur:AddListener(self._tShowCaptureFrame, self)

	if not self._useCapture then
		SpaceX.UIBlurUtils.SetBgBlurArgs(self._downSample, self._iteration)
		RendererFeatureUtil.toggleRendererFeature(RendererFeatureName.UIGlassBlurBg, true, self._viewName)
		self._uiGlassBlur:BlurBg()
	else
		self._curCanvasGroup.alpha = 0

		if self._isOnlyBlurScene then
			self._uiGlassBlur:OnlyBlurScene()
		end

		self._uiGlassBlur:UpdateBlurArag(self._downSample, self._iteration)
		self._uiGlassBlur:CaptureAndBlur()
	end
end

function M:OnlyBlurScene()
	self._isOnlyBlurScene = true
end

function M:_tShowCaptureFrame()
	if goutil.isNil(self._screenshotBlurImage) then
		return
	end

	self._screenshotBlurImage.enabled = true
	self._curCanvasGroup.alpha = 1

	GlobalDispatcher:dispatchEvent(EventType.ON_BLUR_BG_CAPTURE_FINISH, self._viewName)
end

function M:_onCaptureFinish()
	local downSample = self._downSample
	local iteration = self._iteration
	local renderTexture = SpaceX.CommandBufferEffectUtils.Blur(self._screenshotBlurImage.texture, CommonPreloader.instance:getMaterialsCommAsset(CommonResPath.BlurMat), downSample, iteration)

	self._screenshotImage:SetRenderTexture(renderTexture)
end

function M:setMainGo(obj)
	self.mainGO = obj
end

function M:getRawImage()
	return self._screenshotBlurImage
end

return M
