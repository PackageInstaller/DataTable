-- chunkname: @modules/logic/story/view/StoryBackgroundView.lua

module("modules.logic.story.view.StoryBackgroundView", package.seeall)

local StoryBackgroundView = class("StoryBackgroundView", BaseView)
local BG_EFFECT_CONFIG = {
	[StoryEnum.BgEffectType.BgBlur] = {
		cls = StoryBgEffsBlur
	},
	[StoryEnum.BgEffectType.FishEye] = {
		cls = StoryBgEffsFishEye
	},
	[StoryEnum.BgEffectType.FullBlur] = {
		cls = StoryBgEffsFullBlur
	},
	[StoryEnum.BgEffectType.BgGray] = {
		cls = StoryBgEffsGray
	},
	[StoryEnum.BgEffectType.FullGray] = {
		cls = StoryBgEffsFullGray
	},
	[StoryEnum.BgEffectType.Interfere] = {
		cls = StoryBgEffsInterfere
	},
	[StoryEnum.BgEffectType.Sketch] = {
		cls = StoryBgEffsSketch
	},
	[StoryEnum.BgEffectType.Opposition] = {
		cls = StoryBgEffsOpposition
	},
	[StoryEnum.BgEffectType.RgbSplit] = {
		cls = StoryBgEffsRgbSplit
	},
	[StoryEnum.BgEffectType.Malfunction] = {
		cls = StoryBgEffsMalfunction
	},
	[StoryEnum.BgEffectType.EagleEye] = {
		cls = StoryBgEffsEagleEye
	},
	[StoryEnum.BgEffectType.Filter] = {
		cls = StoryBgEffsFilter
	},
	[StoryEnum.BgEffectType.BlindFilter] = {
		cls = StoryBgEffsBlindFilter
	},
	[StoryEnum.BgEffectType.Distress] = {
		cls = StoryBgEffsDistress
	},
	[StoryEnum.BgEffectType.OutFocus] = {
		cls = StoryBgEffsOutFocus
	},
	[StoryEnum.BgEffectType.DiamondLight] = {
		cls = StoryBgEffsDiamondLight
	},
	[StoryEnum.BgEffectType.Starburst] = {
		cls = StoryBgEffsStarburst
	},
	[StoryEnum.BgEffectType.SetLayer] = {
		cls = StoryBgEffsSetLayer
	},
	[StoryEnum.BgEffectType.BgDistress] = {
		cls = StoryBgEffsBgDistress
	},
	[StoryEnum.BgEffectType.BgShake] = {
		cls = StoryBgEffsBgShake
	},
	[StoryEnum.BgEffectType.HandCameraShake] = {
		cls = StoryBgEffsHandCameraShake
	},
	[StoryEnum.BgEffectType.Penetration] = {
		cls = StoryBgEffsPenetration
	},
	[StoryEnum.BgEffectType.CustomBlur] = {
		cls = StoryBgEffsCustomBlur
	},
	[StoryEnum.BgEffectType.LineLight] = {
		cls = StoryBgEffsLineLight
	},
	[StoryEnum.BgEffectType.EnterSplitScreen] = {
		cls = StoryBgEffsEnterSplitScreen
	},
	[StoryEnum.BgEffectType.ExitSplitScreen] = {
		cls = StoryBgEffsExitSplitScreen
	},
	[StoryEnum.BgEffectType.TextureShake] = {
		cls = StoryBgEffsTextureShake
	},
	[StoryEnum.BgEffectType.ShapeMask] = {
		cls = StoryBgEffsShapeMask
	},
	[StoryEnum.BgEffectType.PartialBlur] = {
		cls = StoryBgEffsPartialBlur
	},
	[StoryEnum.BgEffectType.PerspectiveCamera] = {
		cls = StoryBgEffsPerspectiveCamera
	},
	[StoryEnum.BgEffectType.TimeStop] = {
		cls = StoryBgEffsTimeStop
	},
	[StoryEnum.BgEffectType.UpFlow] = {
		cls = StoryBgEffsUpFlow
	},
	[StoryEnum.BgEffectType.ScreenHalo] = {
		cls = StoryBgEffsScreenHalo
	},
	[StoryEnum.BgEffectType.ScreenHalo2] = {
		cls = StoryBgEffsScreenHalo
	},
	[StoryEnum.BgEffectType.CrtFilter] = {
		cls = StoryBgEffsCrtFilter
	},
	[StoryEnum.BgEffectType.CameraEffect] = {
		cls = StoryBgEffsCameraEffect
	},
	[StoryEnum.BgEffectType.MonitorFilter] = {
		cls = StoryBgEffsMonitorFilter
	}
}

function StoryBackgroundView:onInitView()
	self._gobottom = gohelper.findChild(self.viewGO, "#go_bottombg")
	self._simagebgold = gohelper.findChildSingleImage(self.viewGO, "#go_bottombg/#simage_bgold")
	self._simagebgoldtop = gohelper.findChildSingleImage(self.viewGO, "#go_bottombg/#simage_bgold/#simage_bgoldtop")
	self._bottombgSpine = gohelper.findChild(self.viewGO, "#go_bottombg/#go_bottombgspine")
	self._gofront = gohelper.findChild(self.viewGO, "#go_upbg")
	self._goblack = gohelper.findChild(self.viewGO, "#go_blackbg")
	self._simagebgimg = gohelper.findChildSingleImage(self.viewGO, "#go_upbg/#simage_bgimg")
	self._simagebgimgtop = gohelper.findChildSingleImage(self.viewGO, "#go_upbg/#simage_bgimg/#simage_bgtop")
	self._upbgspine = gohelper.findChild(self.viewGO, "#go_upbg/#go_upbgspine")
	self._gosideways = gohelper.findChild(self.viewGO, "#go_sideways")
	self._goblur = gohelper.findChild(self.viewGO, "#go_upbg/#simage_bgimg/#go_blur")
	self._gobliteff = gohelper.findChild(self.viewGO, "#go_blitbg")
	self._gobliteffsecond = gohelper.findChild(self.viewGO, "#go_blitbgsecond")
	self._goUpVideoRoot = gohelper.findChild(self.viewGO, "#go_upbg/#go_video")
	self._goBottomVideoRoot = gohelper.findChild(self.viewGO, "#go_bottombg/#go_video")
	self._bgEffMgr = StoryEffectManager.New(BG_EFFECT_CONFIG)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function StoryBackgroundView:addEvents()
	return
end

function StoryBackgroundView:removeEvents()
	return
end

function StoryBackgroundView:_editableInitView()
	self._cimagebgold = self._simagebgold.gameObject:GetComponent(typeof(UnityEngine.UI.CustomImage))
	self._cimagebgimg = self._simagebgimg.gameObject:GetComponent(typeof(UnityEngine.UI.CustomImage))
	self._imagebgold = gohelper.findChildImage(self.viewGO, "#go_bottombg/#simage_bgold")
	self._imagebgoldtop = gohelper.findChildImage(self.viewGO, "#go_bottombg/#simage_bgold/#simage_bgoldtop")
	self._imagebg = gohelper.findChildImage(self.viewGO, "#go_upbg/#simage_bgimg")
	self._imagebgtop = gohelper.findChildImage(self.viewGO, "#go_upbg/#simage_bgimg/#simage_bgtop")
	self._imgFitHeight = self._simagebgimg.gameObject:GetComponent(typeof(ZProj.UIBgFitHeightAdapter))
	self._imgOldFitHeight = self._imagebgold.gameObject:GetComponent(typeof(ZProj.UIBgFitHeightAdapter))
	self._bgAnimator = self._gofront.gameObject:GetComponent(typeof(UnityEngine.Animator))
	self._bgBlur = self._simagebgimg.gameObject:GetComponent(typeof(UrpCustom.UIGaussianEffect))
	self._bgBlur.enabled = false
	self._borderCanvas = self._goblack:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._blitEff = self._gobliteff:GetComponent(typeof(UrpCustom.UIBlitEffect))
	self._blitEffSecond = self._gobliteffsecond:GetComponent(typeof(UrpCustom.UIBlitEffect))

	self:_loadRes()
	self:_initData()
end

function StoryBackgroundView:_loadRes()
	local dissolvePath = "ui/materials/dynamic/story_dissolve.mat"

	self._matLoader = MultiAbLoader.New()

	self._matLoader:addPath(dissolvePath)
	self._matLoader:startLoad(function()
		local dissolveItem = self._matLoader:getAssetItem(dissolvePath)

		if dissolveItem then
			self._dissolveMat = dissolveItem:GetResource(dissolvePath)
		else
			logError("Resource is not found at path : " .. dissolvePath)
		end
	end, self)

	self._handleBgTransFuncDict = {
		[StoryEnum.BgTransType.Hard] = self._hardTrans,
		[StoryEnum.BgTransType.TransparencyFade] = self._fadeTrans,
		[StoryEnum.BgTransType.DarkFade] = self._darkFadeTrans,
		[StoryEnum.BgTransType.WhiteFade] = self._whiteFadeTrans,
		[StoryEnum.BgTransType.UpDarkFade] = self._darkUpTrans,
		[StoryEnum.BgTransType.RightDarkFade] = self._rightDarkTrans,
		[StoryEnum.BgTransType.Fragmentate] = self._fragmentTrans,
		[StoryEnum.BgTransType.Dissolve] = self._dissolveTrans,
		[StoryEnum.BgTransType.LeftDarkFade] = self._leftDarkTrans,
		[StoryEnum.BgTransType.MovieChangeStart] = self._movieChangeStartTrans,
		[StoryEnum.BgTransType.MovieChangeSwitch] = self._movieChangeSwitchTrans,
		[StoryEnum.BgTransType.TurnPage3] = self._turnPageTrans,
		[StoryEnum.BgTransType.Bloom1] = self._bloom1Trans,
		[StoryEnum.BgTransType.Bloom2] = self._bloom2Trans,
		[StoryEnum.BgTransType.ShakeCameraLR] = self._shakeCameraTrans,
		[StoryEnum.BgTransType.ShakeCameraUD] = self._shakeCameraTrans,
		[StoryEnum.BgTransType.ScreenSplit] = self._screenSplitTrans,
		[StoryEnum.BgTransType.ScreenSplitExit] = self._screenSplitExitTrans
	}
end

function StoryBackgroundView:_initData()
	self._borderCanvas.alpha = 0
	self._bgSpine = nil
	self._bgCo = {}
	self._lastBgCo = {}

	gohelper.setActive(self._gobottom, false)
	gohelper.setActive(self._gofront, false)
	self:_showBgBottom(false)
	self:_showBgTop(false)

	if StoryModel.instance.skipFade then
		gohelper.setActive(self._goblack, false)
	end
end

function StoryBackgroundView:onOpen()
	ViewMgr.instance:openView(ViewName.StoryHeroView, nil, false)
	ViewMgr.instance:openView(ViewName.StoryLeadRoleSpineView, nil, true)
	ViewMgr.instance:openView(ViewName.StoryView, nil, true)
	self:_addEvents()

	local isOverseas = SettingsModel.instance:isOverseas()

	if not isOverseas then
		local isSpVersionStory = StoryModel.instance:isSpVersionStory()

		self._initVoice = GameConfig:GetCurVoiceShortcut()

		if not isSpVersionStory and (self._initVoice == "jp" or self._initVoice == "kr") then
			AudioMgr.instance:changeLang("en")
		end
	end
end

function StoryBackgroundView:_addEvents()
	self.addEventCb(self, StoryController.instance, StoryEvent.RefreshStep, self._onUpdateUI, self)
	self.addEventCb(self, StoryController.instance, StoryEvent.RefreshBackground, self._colorFadeBgRefresh, self)
	self.addEventCb(self, StoryController.instance, StoryEvent.ShowBackground, self._showBg, self)
end

function StoryBackgroundView:_showBg()
	gohelper.setActive(self._gobottom, true)
	gohelper.setActive(self._gofront, true)
end

function StoryBackgroundView:_onUpdateUI(param)
	self:_checkPlayBorderFade(param)

	if #param.branches > 0 then
		return
	end

	self._bgParam = param

	self:_checkPlayBgBlurFade()

	local bgCo = StoryStepModel.instance:getStepListById(self._bgParam.stepId).bg

	if bgCo.transType == StoryEnum.BgTransType.Keep then
		return
	end

	self._lastBgCo = LuaUtil.deepCopy(self._bgCo)
	self._bgCo = bgCo

	self:_resetData()
	TaskDispatcher.cancelTask(self._enterChange, self)
	TaskDispatcher.runDelay(self._enterChange, self, self._bgCo.waitTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
end

function StoryBackgroundView:_checkPlayBorderFade(param)
	local borderCo = StoryStepModel.instance:getStepListById(param.stepId).mourningBorder

	if self._fadeType and self._fadeType == borderCo.borderType then
		return
	end

	self._fadeType = borderCo.borderType

	if self._fadeType == StoryEnum.BorderType.Keep then
		return
	end

	if self._borderFadeId then
		ZProj.TweenHelper.KillById(self._borderFadeId)
	end

	if borderCo.borderType == StoryEnum.BorderType.None then
		self._borderCanvas.alpha = 1
	elseif borderCo.borderType == StoryEnum.BorderType.FadeOut then
		self._borderFadeId = ZProj.TweenHelper.DOFadeCanvasGroup(self._goblack, 1, 0, borderCo.borderTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	elseif borderCo.borderType == StoryEnum.BorderType.FadeIn then
		self._borderFadeId = ZProj.TweenHelper.DOFadeCanvasGroup(self._goblack, 0, 1, borderCo.borderTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	end
end

function StoryBackgroundView:_checkPlayBgBlurFade()
	local bgCo = StoryStepModel.instance:getStepListById(self._bgParam.stepId).bg

	if bgCo.bgType ~= StoryEnum.BgType.Picture then
		return
	end

	if bgCo.transType == StoryEnum.BgTransType.Keep then
		return
	end

	if bgCo.bgImg ~= self._bgCo.bgImg then
		return
	end

	if self._bgCo.effType ~= StoryEnum.BgEffectType.BgBlur then
		return
	end

	self:_actBgEffBlurFade()
end

function StoryBackgroundView:_resetData()
	if self._goRightFade then
		gohelper.setActive(self._goRightFade, false)
	end

	if self._bgCo.transType ~= StoryEnum.BgTransType.RightDarkFade and self._goLeftFade then
		gohelper.setActive(self._goLeftFade, false)
	end

	if self._bgCo.transType ~= StoryEnum.BgTransType.MovieChangeStart and self._bgCo.transType ~= StoryEnum.BgTransType.MovieChangeSwitch then
		if self._bgMovieGo then
			gohelper.setActive(self._bgMovieGo, false)
		end

		if self._moveCameraAnimator and self._moveCameraAnimator.runtimeAnimatorController == self._cameraMovieAnimator then
			self._moveCameraAnimator.runtimeAnimatorController = nil
		end
	end

	gohelper.setActive(self._goblur, false)

	self._imgFitHeight.enabled = false
	self._imgOldFitHeight.enabled = false
	self._cimagebgimg.vecInSide = Vector4.zero
	self._cimagebgold.vecInSide = Vector4.zero
	self._bgBlur.zoneImage = nil

	if not self:_ignoreClearMat() then
		self._imagebg.material = nil
	end

	self._imagebgtop.material = nil
	self._imagebgold.material = nil
	self._imagebgoldtop.material = nil

	if self._simagebgimg and self._simagebgimg.gameObject then
		ZProj.TweenHelper.KillByObj(self._simagebgimg.gameObject.transform)
	end

	if self._dissolveId then
		ZProj.TweenHelper.KillById(self._dissolveId)

		self._dissolveId = nil
	end

	if self._blurId then
		ZProj.TweenHelper.KillById(self._blurId)

		self._blurId = nil
	end
end

function StoryBackgroundView:_ignoreClearMat()
	if self._bgEffMgr:isActive(StoryEnum.BgEffectType.BgBlur) then
		return true
	end

	if (self._lastBgCo.transType == StoryEnum.BgTransType.MeltOut15 or self._lastBgCo.transType == StoryEnum.BgTransType.MeltOut25) and (self._bgCo.transType == StoryEnum.BgTransType.MeltIn15 or self._bgCo.transType == StoryEnum.BgTransType.MeltIn25 or self._bgCo.transType == StoryEnum.BgTransType.Hard) then
		return true
	end

	if self._bgCo.effType == StoryEnum.BgEffectType.ExitSplitScreen then
		return true
	end

	return false
end

function StoryBackgroundView:_actBgEffBlurFade()
	local transTime = self._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]

	if self._bgCo.effType == StoryEnum.BgEffectType.BgBlur and transTime > 0.1 then
		return
	end

	PostProcessingMgr.instance:setUIBlurActive(0)
	PostProcessingMgr.instance:setFreezeVisble(false)

	local value = self._bgBlur.blurWeight

	self._blurId = ZProj.TweenHelper.DOTweenFloat(value, 0, 1.5, self._blurChange, self._blurFinished, self, nil, EaseType.Linear)
end

function StoryBackgroundView:_blurChange(value)
	if not self._bgBlur then
		self:_blurFinished()

		return
	end

	self._bgBlur.blurWeight = value
end

function StoryBackgroundView:_blurFinished()
	if self._blurId then
		ZProj.TweenHelper.KillById(self._blurId)

		self._blurId = nil
	end
end

function StoryBackgroundView:_enterChange()
	self._rootAni = nil

	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	if self._bgSubGo then
		gohelper.destroy(self._bgSubGo)

		self._bgSubGo = nil
	end

	self._matPath = nil
	self._prefabPath = nil

	if self._handleBgTransFuncDict[self._bgCo.transType] then
		self._handleBgTransFuncDict[self._bgCo.transType](self, self._bgCo.transType)
	else
		self:_commonTrans(self._bgCo.transType)
	end
end

function StoryBackgroundView:_colorFadeBgRefresh()
	local bgZoneMo = StoryBgZoneModel.instance:getBgZoneByPath(self._bgCo.bgImg)

	if bgZoneMo then
		self._cimagebgimg.enabled = true

		gohelper.setActive(self._simagebgimgtop.gameObject, true)
	end

	self:_hardTrans()
end

function StoryBackgroundView:_hardTrans()
	self:_refreshBg()
	self:_resetBgState()
end

function StoryBackgroundView:_refreshBg()
	if self._lastCaptureTexture then
		UnityEngine.RenderTexture.ReleaseTemporary(self._lastCaptureTexture)

		self._lastCaptureTexture = nil
	end

	if self._bgCo.bgType == StoryEnum.BgType.Video then
		self:_playVideo()

		return
	end

	self:_hideVideo()

	if not self._simagebgimg then
		return
	end

	if self._bgCo.bgType == StoryEnum.BgType.Picture then
		self._lastCaptureTexture = UnityEngine.RenderTexture.GetTemporary(self._blitEff.capturedTexture.width, self._blitEff.capturedTexture.height, 0, UnityEngine.RenderTextureFormat.ARGB32)

		UnityEngine.Graphics.CopyTexture(self._blitEff.capturedTexture, self._lastCaptureTexture)

		if self._bgCo.bgImg == "" then
			self:_showBgTop(false)
			self:_showBgBottom(false)

			return
		end

		self:_showBgTop(true)
		gohelper.setActive(self._upbgspine, false)
		self:_loadTopBg()

		if self._bgScaleId then
			ZProj.TweenHelper.KillById(self._bgScaleId)

			self._bgScaleId = nil
		end

		if self._bgPosId then
			ZProj.TweenHelper.KillById(self._bgPosId)

			self._bgPosId = nil
		end

		if self._bgRotateId then
			ZProj.TweenHelper.KillById(self._bgRotateId)

			self._bgRotateId = nil
		end
	else
		self:_showBgTop(false)

		if self._bgCo.bgImg == "" or string.split(self._bgCo.bgImg, ".")[1] == "" then
			gohelper.setActive(self._upbgspine, false)

			return
		end

		gohelper.setActive(self._upbgspine, true)

		self._effectLoader = PrefabInstantiate.Create(self._upbgspine)

		self._effectLoader:startLoad(self._bgCo.bgImg, self._onNewBgEffectLoaded, self)
	end
end

function StoryBackgroundView:_refreshLastBg()
	if self._lastBgCo.bgType == StoryEnum.BgType.Video then
		self:_playVideo(true)

		return
	end

	self:_hideVideo(true)

	if self._lastBgCo.bgType == StoryEnum.BgType.Picture then
		if string.nilorempty(self._lastBgCo.bgImg) then
			self:_showBgBottom(false)

			return
		end

		self:_loadBottomBg()
	else
		self:_showBgBottom(false)
		gohelper.setActive(self._bottombgSpine, true)
		self:_onOldBgEffectLoaded()
	end
end

function StoryBackgroundView:_onNewBgImgLoaded()
	if self._bgCo.transType == StoryEnum.BgTransType.Hard and self._bgCo.effType == StoryEnum.BgEffectType.None then
		self._imagebg.material = nil
	end

	if not self._imagebg or not self._imagebg.sprite then
		return
	end

	gohelper.setActive(self.viewGO, true)

	local _, h = ZProj.UGUIHelper.GetImageSpriteSize(self._imagebg, 0, 0)

	self._imgFitHeight.enabled = h < 1080

	if h >= 1080 then
		transformhelper.setLocalScale(self._simagebgimg.transform, 1.05, 1.05, 1.05)
	end

	self._imagebg:SetNativeSize()
	self:_checkPlayEffect()
end

function StoryBackgroundView:_showBgBottom(show)
	gohelper.setActive(self._simagebgold.gameObject, show)

	if not show then
		self._simagebgold:UnLoadImage()
	end
end

function StoryBackgroundView:_showBgTop(show)
	if not self._simagebgimg then
		return
	end

	gohelper.setActive(self._simagebgimg.gameObject, show)

	if not show then
		self._simagebgimg:UnLoadImage()
	end
end

function StoryBackgroundView:_loadBottomBg()
	gohelper.setActive(self._simagebgold.gameObject, true)
	gohelper.setActive(self._bottombgSpine, false)
	self._simagebgold:UnLoadImage()
	self._simagebgoldtop:UnLoadImage()

	local bgOldZoneMo = StoryBgZoneModel.instance:getBgZoneByPath(self._lastBgCo.bgImg)

	gohelper.setActive(self._simagebgoldtop.gameObject, bgOldZoneMo)

	if bgOldZoneMo then
		self._simagebgoldtop:LoadImage(ResUrl.getStoryRes(bgOldZoneMo.path), self._onOldBgImgTopLoaded, self)
		transformhelper.setLocalPosXY(self._simagebgoldtop.gameObject.transform, bgOldZoneMo.offsetX, bgOldZoneMo.offsetY)
		self._simagebgold:LoadImage(ResUrl.getStoryRes(bgOldZoneMo.sourcePath), self._onOldBgImgLoaded, self)

		self._cimagebgold.vecInSide = Vector4.zero
	else
		self._simagebgold:LoadImage(ResUrl.getStoryRes(self._lastBgCo.bgImg), self._onOldBgImgLoaded, self)

		self._cimagebgold.vecInSide = Vector4.zero
	end
end

function StoryBackgroundView:_loadTopBg()
	local bgZoneMo = StoryBgZoneModel.instance:getBgZoneByPath(self._bgCo.bgImg)

	gohelper.setActive(self._simagebgimgtop.gameObject, false)

	self._cimagebgimg.enabled = true

	if bgZoneMo then
		if self._simagebgimgtop.curImageUrl == ResUrl.getStoryRes(bgZoneMo.path) then
			self:_onNewBgImgTopLoaded()
		else
			self._simagebgimgtop:UnLoadImage()
			gohelper.setActive(self._simagebgimgtop.gameObject, true)
			self._simagebgimgtop:LoadImage(ResUrl.getStoryRes(bgZoneMo.path), self._onNewBgImgTopLoaded, self)
			transformhelper.setLocalPosXY(self._simagebgimgtop.gameObject.transform, bgZoneMo.offsetX, bgZoneMo.offsetY)
		end
	else
		if self._simagebgimg.curImageUrl == ResUrl.getStoryRes(self._bgCo.bgImg) then
			self:_onNewBgImgLoaded()
		else
			self._simagebgimg:LoadImage(ResUrl.getStoryRes(self._bgCo.bgImg), self._onNewBgImgLoaded, self)
		end

		self._cimagebgimg.vecInSide = Vector4.zero
	end
end

function StoryBackgroundView:_onNewBgImgTopLoaded()
	local bgZoneMo = StoryBgZoneModel.instance:getBgZoneByPath(self._bgCo.bgImg)

	if not bgZoneMo then
		return
	end

	self._imagebgtop:SetNativeSize()
	self:_setZoneMat()

	if self._simagebgimg.curImageUrl == ResUrl.getStoryRes(bgZoneMo.sourcePath) then
		self:_onNewZoneBgImgLoaded()
	else
		self._simagebgimg:UnLoadImage()
		self._simagebgimg:LoadImage(ResUrl.getStoryRes(bgZoneMo.sourcePath), self._onNewZoneBgImgLoaded, self)
	end
end

function StoryBackgroundView:_onNewZoneBgImgLoaded()
	gohelper.setActive(self._simagebgimgtop.gameObject, true)
	self:_onNewBgImgLoaded()
	self:_setZoneMat()
end

function StoryBackgroundView:_setZoneMat()
	if not self._imagebg or not self._imagebg.material or not self._imagebgtop or not self._imagebgtop.sprite then
		return
	end

	local bgZoneMo = StoryBgZoneModel.instance:getBgZoneByPath(self._bgCo.bgImg)

	if not bgZoneMo then
		return
	end

	self._cimagebgimg.vecInSide = Vector4(recthelper.getWidth(self._imagebgtop.transform), recthelper.getHeight(self._imagebgtop.transform), bgZoneMo.offsetX, bgZoneMo.offsetY)

	if self._bgBlur.enabled then
		self._bgBlur.zoneImage = self._imagebgtop
	end
end

function StoryBackgroundView:_onOldBgImgTopLoaded()
	self._imagebgoldtop:SetNativeSize()
end

function StoryBackgroundView:_onOldBgImgLoaded()
	local _, h = ZProj.UGUIHelper.GetImageSpriteSize(self._imagebgold, 0, 0)

	transformhelper.setLocalPosXY(self._simagebgold.gameObject.transform, self._lastBgCo.offset[1], self._lastBgCo.offset[2])
	transformhelper.setLocalRotation(self._simagebgold.gameObject.transform, 0, 0, self._lastBgCo.angle)
	transformhelper.setLocalScale(self._gobottom.transform, self._lastBgCo.scale, self._lastBgCo.scale, 1)

	self._imgOldFitHeight.enabled = h < 1080

	if h >= 1080 then
		transformhelper.setLocalScale(self._simagebgold.transform, 1.05, 1.05, 1.05)
	end

	self._imagebgold:SetNativeSize()

	self._imagebgold.color = Color.white
end

function StoryBackgroundView:_onNewBgEffectLoaded()
	if self._bgEffectGo then
		gohelper.destroy(self._bgEffectGo)

		self._bgEffectGo = nil
	end

	self._bgEffectGo = self._effectLoader:getInstGO()

	self:_checkPlayEffect()
end

function StoryBackgroundView:_onOldBgEffectLoaded()
	if self._bgEffectOldGo then
		gohelper.destroy(self._bgEffectOldGo)

		self._bgEffectOldGo = nil
	end

	if self._bgEffectGo then
		self._bgEffectOldGo = gohelper.clone(self._bgEffectGo, self._bottombgSpine, "effectold")

		gohelper.destroy(self._bgEffectGo)

		self._bgEffectGo = nil
	end
end

function StoryBackgroundView:_advanceLoadBgOld()
	self._simagebgold:UnLoadImage()
	self._simagebgoldtop:UnLoadImage()

	local bgZoneMo = StoryBgZoneModel.instance:getBgZoneByPath(self._bgCo.bgImg)

	gohelper.setActive(self._simagebgoldtop.gameObject, bgZoneMo)

	if bgZoneMo then
		self._simagebgoldtop:LoadImage(ResUrl.getStoryRes(bgZoneMo.path), self._onOldBgImgTopLoaded, self)
		transformhelper.setLocalPosXY(self._simagebgoldtop.gameObject.transform, bgZoneMo.offsetX, bgZoneMo.offsetY)
		self._simagebgold:LoadImage(ResUrl.getStoryRes(bgZoneMo.sourcePath), function()
			self._imagebgold.color = Color.white

			self._imagebgold:SetNativeSize()
			self:_onNewBgImgLoaded()
		end)
	else
		self._simagebgold:LoadImage(ResUrl.getStoryRes(self._bgCo.bgImg), function()
			self._imagebgold.color = Color.white

			self._imagebgold:SetNativeSize()
			self:_onNewBgImgLoaded()
		end)
	end
end

function StoryBackgroundView:_checkPlayEffect()
	self._bgEffMgr:deactivateExcept(self._bgCo.effType)
	self:_playBgEffsFunc(self._bgCo)
	self:_checkBgEffStack()
end

function StoryBackgroundView:_checkBgEffStack()
	local stepId = StoryModel.instance:getCurStepId()
	local preSteps = StoryModel.instance:getPreSteps(stepId)

	if not preSteps or #preSteps < 1 then
		return
	end

	local preStepCo = StoryStepModel.instance:getStepListById(preSteps[1])

	if not preStepCo then
		return
	end

	if preStepCo.conversation.type == StoryEnum.ConversationType.BgEffStack then
		self:_playBgEffsFunc(preStepCo.bg)
	end
end

function StoryBackgroundView:_playBgEffsFunc(bgCo)
	if not bgCo then
		return
	end

	self._bgEffMgr:activate(bgCo.effType, bgCo)
end

function StoryBackgroundView:_resetBgState()
	if not self._simagebgimg or not self._simagebgimg.gameObject then
		return
	end

	local transTimes = self._bgCo.transTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]

	if transTimes < 0.05 then
		transformhelper.setLocalPosXY(self._simagebgimg.gameObject.transform, self._bgCo.offset[1], self._bgCo.offset[2])
		transformhelper.setLocalRotation(self._simagebgimg.gameObject.transform, 0, 0, self._bgCo.angle)
		transformhelper.setLocalScale(self._gofront.transform, self._bgCo.scale, self._bgCo.scale, 1)
	elseif self._bgCo.effType == StoryEnum.BgEffectType.MoveCurve then
		if not self._bgCo.effDegree then
			local easyType = EaseType.InCubic

			self._bgPosId = ZProj.TweenHelper.DOAnchorPos(self._simagebgimg.gameObject.transform, self._bgCo.offset[1], self._bgCo.offset[2], transTimes, nil, nil, nil, easyType)
			self._bgRotateId = ZProj.TweenHelper.DOLocalRotate(self._simagebgimg.gameObject.transform, 0, 0, self._bgCo.angle, transTimes, nil, nil, nil, EaseType.InSine)
			self._bgScaleId = ZProj.TweenHelper.DOScale(self._gofront.gameObject.transform, self._bgCo.scale, self._bgCo.scale, 1, transTimes, nil, nil, nil, EaseType.InQuad)
		end
	end
end

function StoryBackgroundView:_hideBg()
	self:_showBgBottom(false)
	self:_hideVideo(true)
end

function StoryBackgroundView:_fadeTrans()
	if self._bgCo.bgType == StoryEnum.BgType.Picture then
		self:_hideVideo()

		self._imagebg.color.a = 0
		self._imagebg.color = Color.white

		self:_showBgTop(true)
		self:_resetBgState()

		if self._bgFadeId then
			ZProj.TweenHelper.KillById(self._bgFadeId)
		end

		self._bgFadeId = ZProj.TweenHelper.DOFadeCanvasGroup(self._imagebg.gameObject, 0, 1, self._bgCo.fadeTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], self._hideBg, self, nil, EaseType.Linear)

		self:_showBgBottom(true)
		self:_loadTopBg()
		self:_fadeTransLoadOldBg()

		return
	end

	if self._bgCo.bgType == StoryEnum.BgType.Video then
		if self._bgFadeId then
			ZProj.TweenHelper.KillById(self._bgFadeId)
		end

		self._bgFadeId = ZProj.TweenHelper.DOFadeCanvasGroup(self._goUpVideoRoot, 0, 1, self._bgCo.fadeTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], self._hideBg, self, nil, EaseType.Linear)

		self:_refreshLastBg()
		self:_refreshBg()

		return
	end
end

function StoryBackgroundView:_fadeTransLoadOldBg()
	if self._lastBgCo.bgType ~= StoryEnum.BgType.Picture or string.nilorempty(self._lastBgCo.bgImg) then
		return
	end

	self._simagebgold:UnLoadImage()
	self._simagebgoldtop:UnLoadImage()

	local bgZoneMo = StoryBgZoneModel.instance:getBgZoneByPath(self._lastBgCo.bgImg)

	gohelper.setActive(self._simagebgoldtop.gameObject, bgZoneMo)

	if bgZoneMo then
		self._simagebgoldtop:LoadImage(ResUrl.getStoryRes(bgZoneMo.path), self._onOldBgImgTopLoaded, self)
		transformhelper.setLocalPosXY(self._simagebgoldtop.gameObject.transform, bgZoneMo.offsetX, bgZoneMo.offsetY)
		self._simagebgold:LoadImage(ResUrl.getStoryRes(bgZoneMo.sourcePath), function()
			self._imagebgold.color = Color.white

			self:_onOldBgImgLoaded()
			self:_refreshBg()
		end)
	else
		self._simagebgold:LoadImage(ResUrl.getStoryRes(self._lastBgCo.bgImg), function()
			self._imagebgold.color = Color.white

			self:_onOldBgImgLoaded()
			self:_refreshBg()
		end)
	end
end

function StoryBackgroundView:_darkFadeTrans()
	StoryController.instance:dispatchEvent(StoryEvent.PlayDarkFade)
end

function StoryBackgroundView:_whiteFadeTrans()
	StoryController.instance:dispatchEvent(StoryEvent.PlayWhiteFade)
end

function StoryBackgroundView:_darkUpTrans()
	StoryController.instance:dispatchEvent(StoryEvent.PlayDarkFadeUp)
	self:_refreshBg()
	self:_resetBgState()
end

function StoryBackgroundView:_commonTrans(type)
	self._curTransType = type

	local transMo = StoryBgEffectTransModel.instance:getStoryBgEffectTransByType(type)
	local resList = {}

	if transMo.prefab and transMo.prefab ~= "" then
		self._prefabPath = ResUrl.getStoryBgEffect(transMo.prefab)

		table.insert(resList, self._prefabPath)
	end

	self.loadRes(self, resList, self._onBgResLoaded, self)
end

function StoryBackgroundView:_onBgResLoaded()
	if self._prefabPath then
		local prefAssetItem = self._loader:getAssetItem(self._prefabPath)

		self._bgSubGo = gohelper.clone(prefAssetItem:GetResource(), self._imagebg.gameObject)

		local typeMatPropsCtrl = typeof(ZProj.MaterialPropsCtrl)
		local matPropsCtrl = self._bgSubGo:GetComponent(typeMatPropsCtrl)

		if matPropsCtrl and matPropsCtrl.mas ~= nil and matPropsCtrl.mas[0] ~= nil then
			self._imagebg.material = matPropsCtrl.mas[0]
			self._imagebgtop.material = matPropsCtrl.mas[0]

			StoryTool.enablePostProcess(true)
		end

		if self._curTransType == StoryEnum.BgTransType.Distort then
			StoryTool.enablePostProcess(true)

			local rootGo = gohelper.findChild(self._bgSubGo, "root")

			self._rootAni = rootGo:GetComponent(typeof(UnityEngine.Animator))

			TaskDispatcher.runDelay(self._distortEnd, self, self._bgCo.transTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
		end
	end

	self:_showBgBottom(true)

	if self._bgCo.bgImg ~= "" then
		self:_advanceLoadBgOld()
	end

	local delay = StoryBgEffectTransModel.instance:getStoryBgEffectTransByType(self._curTransType).transTime

	TaskDispatcher.runDelay(self._commonTransFinished, self, delay)
end

function StoryBackgroundView:_commonTransFinished()
	self:_refreshBg()
	self:_resetBgState()

	local delay = StoryBgEffectTransModel.instance:getStoryBgEffectTransByType(self._curTransType).transTime

	if delay > 0 then
		self._imagebg.material = nil
		self._imagebgtop.material = nil
	end
end

function StoryBackgroundView:_distortEnd()
	if self._rootAni then
		self._rootAni:SetBool("change", true)
	end
end

function StoryBackgroundView:_rightDarkTrans()
	if not self._goRightFade then
		local path = self.viewContainer:getSetting().otherRes[1]

		self._goRightFade = self.viewContainer:getResInst(path, self._gosideways)
		self._rightAnim = self._goRightFade:GetComponent(typeof(UnityEngine.Animation))
	end

	gohelper.setActive(self._goRightFade, true)
	self._rightAnim:Play()
	TaskDispatcher.runDelay(self._changeRightDark, self, 0.2)
end

function StoryBackgroundView:_changeRightDark()
	self:_refreshBg()
	self:_resetBgState()

	if self._goLeftFade then
		gohelper.setActive(self._goLeftFade, false)
	end
end

function StoryBackgroundView:_leftDarkTrans()
	if not self._goLeftFade then
		local path = self.viewContainer:getSetting().otherRes[2]

		self._goLeftFade = self.viewContainer:getResInst(path, self._gosideways)
		self._leftAnim = self._goLeftFade:GetComponent(typeof(UnityEngine.Animation))
	else
		gohelper.setActive(self._goLeftFade, true)
	end

	if self._goRightFade then
		gohelper.setActive(self._goRightFade, false)
	end

	self._leftAnim:Play()
	TaskDispatcher.runDelay(self._leftDarkTransFinished, self, 1.5)
end

function StoryBackgroundView:_leftDarkTransFinished()
	self:_refreshBg()
	self:_resetBgState()
end

function StoryBackgroundView:_fragmentTrans()
	return
end

function StoryBackgroundView:_movieChangeStartTrans()
	self._curTransType = StoryEnum.BgTransType.MovieChangeStart

	local transMo = StoryBgEffectTransModel.instance:getStoryBgEffectTransByType(self._curTransType)
	local resList = {}

	if not self._bgMovieGo then
		self._moviePrefabPath = ResUrl.getStoryBgEffect(transMo.prefab)

		table.insert(resList, self._moviePrefabPath)
	end

	if not self._cameraMovieAnimator then
		self._cameraAnimPath = "ui/animations/dynamic/custommaterialpass.controller"

		table.insert(resList, self._cameraAnimPath)
	end

	self.loadRes(self, resList, self._onMoveChangeBgResLoaded, self)
end

function StoryBackgroundView:_onMoveChangeBgResLoaded()
	if not self._bgMovieGo and self._moviePrefabPath then
		local prefAssetItem = self._loader:getAssetItem(self._moviePrefabPath)

		self._bgMovieGo = gohelper.clone(prefAssetItem:GetResource(), self._imagebg.gameObject)
		self._simageMovieCurBg = gohelper.findChildSingleImage(self._bgMovieGo, "#now/#simage_dec")
		self._simageMovieNewBg = gohelper.findChildSingleImage(self._bgMovieGo, "#next/#simage_dec")
	end

	gohelper.setActive(self._bgMovieGo, true)

	self._movieAnim = self._bgMovieGo:GetComponent(gohelper.Type_Animator)
	self._cameraMovieAnimator = self._cameraMovieAnimator or self._loader:getAssetItem(self._cameraAnimPath):GetResource()
	self._moveCameraAnimator = CameraMgr.instance:getCameraRootAnimator()
	self._moveCameraAnimator.enabled = true
	self._moveCameraAnimator.runtimeAnimatorController = self._cameraMovieAnimator

	self:_setMovieNowBg()
	self._movieAnim:Play("idle", 0, 0)
end

function StoryBackgroundView:_movieChangeSwitchTrans()
	self._curTransType = StoryEnum.BgTransType.MovieChangeSwitch

	if not self._bgMovieGo then
		return
	end

	self._moveCameraAnimator = CameraMgr.instance:getCameraRootAnimator()
	self._moveCameraAnimator.enabled = true
	self._moveCameraAnimator.runtimeAnimatorController = self._cameraMovieAnimator

	self._simageMovieNewBg:LoadImage(ResUrl.getStoryRes(self._bgCo.bgImg))

	if self._movieAnim then
		self._movieAnim:Play("switch", 0, 0)
		self._moveCameraAnimator:Play("dynamicblur", 0, 0)
		TaskDispatcher.runDelay(self._setMovieNowBg, self, 0.3)
	end
end

function StoryBackgroundView:_setMovieNowBg()
	self._simageMovieCurBg:LoadImage(ResUrl.getStoryRes(self._bgCo.bgImg))
end

function StoryBackgroundView:_turnPageTrans()
	self._curTransType = StoryEnum.BgTransType.TurnPage3

	local transMo = StoryBgEffectTransModel.instance:getStoryBgEffectTransByType(self._curTransType)
	local resList = {}

	if not self._turnPageGo then
		self._turnPagePrefabPath = ResUrl.getStoryBgEffect(transMo.prefab)

		table.insert(resList, self._turnPagePrefabPath)
	end

	self.loadRes(self, resList, self._onTurnPageBgResLoaded, self)
end

function StoryBackgroundView:_onTurnPageBgResLoaded()
	if not self._turnPageGo and self._turnPagePrefabPath then
		local prefAssetItem = self._loader:getAssetItem(self._turnPagePrefabPath)

		self._turnPageGo = gohelper.clone(prefAssetItem:GetResource(), self._imagebg.gameObject)
		self._turnPageAnim = self._turnPageGo:GetComponent(typeof(UnityEngine.Animation))
	end

	gohelper.setActive(self._turnPageGo, true)
	StoryTool.enablePostProcess(true)

	local storyViewGo = StoryViewMgr.instance:getStoryView()
	local imgGo = gohelper.findChild(storyViewGo, "#go_middle/#go_img2")

	self._imgAnim = imgGo:GetComponent(typeof(UnityEngine.Animation))

	self._imgAnim:Play()
	self._turnPageAnim:Play()
	TaskDispatcher.runDelay(self._onTurnPageFinished, self, 0.67)
end

function StoryBackgroundView:_onTurnPageFinished()
	if self._turnPageGo then
		gohelper.destroy(self._turnPageGo)

		self._turnPageGo = nil
	end

	local rectMask2D = self._imgAnim:GetComponent(gohelper.Type_RectMask2D)

	rectMask2D.padding = Vector4(0, 0, 0, 0)
end

function StoryBackgroundView:_shakeCameraTrans(transType)
	self._curTransType = transType or StoryEnum.BgTransType.ShakeCameraLR
	self._bgTrans = StoryBgTransCameraShake.New()

	self._bgTrans:init(self._curTransType)
	self._bgTrans:start(self._onShakeCameraFinished, self)
end

function StoryBackgroundView:_onShakeCameraFinished()
	if self._bgTrans then
		self._bgTrans:destroy()

		self._bgTrans = nil
	end
end

function StoryBackgroundView:_screenSplitTrans(transType)
	self._curTransType = transType or StoryEnum.BgTransType.ScreenSplit
	self._bgTrans = StoryBgTransScreenSplit.New()

	self._bgTrans:init(self._curTransType)
	self._bgTrans:start(self._onScreenSplitFinished, self)

	self._cimagebgold.color = Color.white
end

function StoryBackgroundView:_onScreenSplitFinished()
	if self._bgTrans then
		self._bgTrans:destroy()

		self._bgTrans = nil
	end
end

function StoryBackgroundView:_screenSplitExitTrans(transType)
	self._curTransType = transType or StoryEnum.BgTransType.ScreenSplitExit
	self._bgTrans = StoryBgTransScreenSplit.New()

	self._bgTrans:init(self._curTransType)
	self._bgTrans:start(self._onScreenSplitExitFinished, self)

	self._cimagebgold.color = Color.white
end

function StoryBackgroundView:_onScreenSplitExitFinished()
	if self._bgTrans then
		self._bgTrans:destroy()

		self._bgTrans = nil
	end
end

function StoryBackgroundView:_dissolveTrans()
	if self._bgCo.bgType == StoryEnum.BgType.Picture then
		self:_showBgBottom(true)
		gohelper.setActive(self._bottombgSpine, false)

		if self._bgCo.bgImg ~= "" then
			self:_advanceLoadBgOld()
		end
	else
		self:_showBgBottom(false)
		gohelper.setActive(self._bottombgSpine, true)

		if string.split(self._bgCo.bgImg, ".")[1] ~= "" then
			self._effectLoader = PrefabInstantiate.Create(self._bottombgSpine)

			self._effectLoader:startLoad(self._bgCo.bgImg)
		end
	end

	self._imagebg:SetNativeSize()

	self._imagebg.material = self._dissolveMat
	self._imagebgtop.material = self._dissolveMat

	self:_dissolveChange(0)

	self._dissolveId = ZProj.TweenHelper.DOTweenFloat(0, -1.2, 2, self._dissolveChange, self._dissolveFinished, self, nil, EaseType.Linear)
end

function StoryBackgroundView:_dissolveChange(value)
	self._imagebg.material:SetFloat(ShaderPropertyId.DissolveFactor, value)
	self._imagebgtop.material:SetFloat(ShaderPropertyId.DissolveFactor, value)
end

function StoryBackgroundView:_dissolveFinished()
	self:_refreshBg()
	self:_resetBgState()

	self._imagebg.material = nil
	self._imagebgtop.material = nil
end

function StoryBackgroundView:_bloom1Trans()
	self:_bloomTrans(StoryEnum.BgTransType.Bloom1)
end

function StoryBackgroundView:_bloom2Trans()
	self:_bloomTrans(StoryEnum.BgTransType.Bloom2)
end

function StoryBackgroundView:_bloomTrans(type)
	self._curTransType = type

	if self._bgTrans then
		self._bgTrans:destroy()

		self._bgTrans = nil
	end

	self._bgTrans = StoryBgTransBloom.New()

	self._bgTrans:init()
	self._bgTrans:setBgTransType(type)
	self._bgTrans:start(self._bloomFinished, self)
end

function StoryBackgroundView:_bloomFinished()
	if self._bgTrans then
		self._bgTrans:destroy()

		self._bgTrans = nil
	end
end

function StoryBackgroundView:loadRes(resList, callback, callbackObj)
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	if resList and #resList > 0 then
		self._loader = MultiAbLoader.New()

		self._loader:setPathList(resList)
		self._loader:startLoad(callback, callbackObj)
	elseif callback then
		callback(callbackObj)
	end
end

function StoryBackgroundView:_playVideo(isBottom)
	if isBottom then
		self:_showBgBottom(false)
		gohelper.setActive(self._bottombgSpine, false)

		self._bottomVideoComp = self._bottomVideoComp or MonoHelper.addNoUpdateLuaComOnceToGo(self._goBottomVideoRoot, StoryBackgroundVideoComp)

		self._bottomVideoComp:playVideo(self._lastBgCo)

		return
	end

	self:_showBgTop(false)
	gohelper.setActive(self._upbgspine, false)

	self._bgVideoComp = self._bgVideoComp or MonoHelper.addNoUpdateLuaComOnceToGo(self._goUpVideoRoot, StoryBackgroundVideoComp)

	self._bgVideoComp:playVideo(self._bgCo)
end

function StoryBackgroundView:_hideVideo(isBottom)
	if isBottom then
		if self._bottomVideoComp then
			self._bottomVideoComp:setVisible(false)
		end

		return
	end

	if self._bgVideoComp then
		self._bgVideoComp:setVisible(false)
	end
end

function StoryBackgroundView:onClose()
	self:_clearBg()

	if self._bgFadeId then
		ZProj.TweenHelper.KillById(self._bgFadeId)
	end

	gohelper.setActive(self.viewGO, false)
	ViewMgr.instance:closeView(ViewName.StoryHeroView)
	self:_removeEvents()

	local isOverseas = SettingsModel.instance:isOverseas()

	if isOverseas then
		return
	end

	self._initVoice = self._initVoice or GameConfig:GetCurVoiceShortcut()

	AudioMgr.instance:changeLang(self._initVoice)
end

function StoryBackgroundView:_clearBg()
	self._bgEffMgr:deactivateAll()

	if self._blurId then
		ZProj.TweenHelper.KillById(self._blurId)

		self._blurId = nil
	end

	if self._bgScaleId then
		ZProj.TweenHelper.KillById(self._bgScaleId)

		self._bgScaleId = nil
	end

	if self._bgPosId then
		ZProj.TweenHelper.KillById(self._bgPosId)

		self._bgPosId = nil
	end

	if self._bgRotateId then
		ZProj.TweenHelper.KillById(self._bgRotateId)

		self._bgRotateId = nil
	end

	TaskDispatcher.cancelTask(self._onTurnPageFinished, self)
	TaskDispatcher.cancelTask(self._changeRightDark, self)
	TaskDispatcher.cancelTask(self._enterChange, self)
	TaskDispatcher.cancelTask(self._distortEnd, self)
	TaskDispatcher.cancelTask(self._leftDarkTransFinished, self)
	TaskDispatcher.cancelTask(self._commonTransFinished, self)

	if self._bgTrans then
		self._bgTrans:destroy()

		self._bgTrans = nil
	end

	if self._simagebgimg then
		self._simagebgimg:UnLoadImage()

		self._simagebgimg = nil
	end

	if self._simagebgimgtop then
		self._simagebgimgtop:UnLoadImage()

		self._simagebgimgtop = nil
	end

	if self._simagebgold then
		self._simagebgold:UnLoadImage()

		self._simagebgold = nil
	end

	if self._simagebgoldtop then
		self._simagebgoldtop:UnLoadImage()

		self._simagebgoldtop = nil
	end
end

function StoryBackgroundView:_removeEvents()
	self.removeEventCb(self, StoryController.instance, StoryEvent.RefreshStep, self._onUpdateUI, self)
	self.removeEventCb(self, StoryController.instance, StoryEvent.RefreshBackground, self._colorFadeBgRefresh, self)
	self.removeEventCb(self, StoryController.instance, StoryEvent.ShowBackground, self._showBg, self)
end

function StoryBackgroundView:onDestroyView()
	if self._lastCaptureTexture then
		UnityEngine.RenderTexture.ReleaseTemporary(self._lastCaptureTexture)

		self._lastCaptureTexture = nil
	end

	self:_clearBg()
	PostProcessingMgr.instance:setUIPPValue("saturation", 0.5)
	PostProcessingMgr.instance:setUIPPValue("Saturation", 0.5)
	PostProcessingMgr.instance:setBlurWeight(1)

	if self._borderFadeId then
		ZProj.TweenHelper.KillById(self._borderFadeId)
	end

	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	if self._matLoader then
		self._matLoader:dispose()

		self._matLoader = nil
	end

	if self._bgEffMgr then
		self._bgEffMgr:destroy()

		self._bgEffMgr = nil
	end
end

return StoryBackgroundView
