-- chunkname: @modules/logic/story/view/StoryBackgroundView.lua

module("modules.logic.story.view.StoryBackgroundView", package.seeall)

local StoryBackgroundView = class("StoryBackgroundView", BaseView)

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
	self._playingBgEffDict = {}

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
	self._borderCanvas = self._goblack:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._blitEff = self._gobliteff:GetComponent(typeof(UrpCustom.UIBlitEffect))
	self._blitEffSecond = self._gobliteffsecond:GetComponent(typeof(UrpCustom.UIBlitEffect))

	self:_loadRes()
	self:_initData()
end

function StoryBackgroundView:_loadRes()
	local fisheyePath = "ui/materials/dynamic/story_fisheye.mat"
	local blurPath = "ui/materials/dynamic/uibackgoundblur.mat"
	local blurZonePath = "ui/materials/dynamic/uibackgoundblur_zone.mat"
	local dissolvePath = "ui/materials/dynamic/story_dissolve.mat"

	self._matLoader = MultiAbLoader.New()

	self._matLoader:addPath(fisheyePath)
	self._matLoader:addPath(blurPath)
	self._matLoader:addPath(blurZonePath)
	self._matLoader:addPath(dissolvePath)
	self._matLoader:startLoad(function()
		local fisheyeItem = self._matLoader:getAssetItem(fisheyePath)

		if fisheyeItem then
			self._fisheyeMat = fisheyeItem:GetResource(fisheyePath)
		else
			logError("Resource is not found at path : " .. fisheyePath)
		end

		local blurItem = self._matLoader:getAssetItem(blurPath)

		if blurItem then
			self._blurMat = blurItem:GetResource(blurPath)
		else
			logError("Resource is not found at path : " .. blurPath)
		end

		local blurZoneItem = self._matLoader:getAssetItem(blurZonePath)

		if blurZoneItem then
			self._blurZoneMat = blurZoneItem:GetResource(blurZonePath)
		else
			logError("Resource is not found at path : " .. blurZonePath)
		end

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
	self._handleBgEffsFuncDict = {
		[StoryEnum.BgEffectType.BgBlur] = self._actBgEffBlur,
		[StoryEnum.BgEffectType.FishEye] = self._actBgEffFishEye,
		[StoryEnum.BgEffectType.BgShake] = self._actBgEffBgShake,
		[StoryEnum.BgEffectType.FullBlur] = self._actBgEffFullBlur,
		[StoryEnum.BgEffectType.BgGray] = self._actBgEffGray,
		[StoryEnum.BgEffectType.FullGray] = self._actBgEffFullGray,
		[StoryEnum.BgEffectType.Interfere] = self._actBgEffInterfere,
		[StoryEnum.BgEffectType.Sketch] = self._actBgEffSketch,
		[StoryEnum.BgEffectType.BlindFilter] = self._actBgEffBlindFilter,
		[StoryEnum.BgEffectType.Opposition] = self._actBgEffOpposition,
		[StoryEnum.BgEffectType.RgbSplit] = self._actBgEffRgbSplit,
		[StoryEnum.BgEffectType.Malfunction] = self._actBgEffMalfunction,
		[StoryEnum.BgEffectType.EagleEye] = self._actBgEffEagleEye,
		[StoryEnum.BgEffectType.Filter] = self._actBgEffFilter,
		[StoryEnum.BgEffectType.Distress] = self._actBgEffDistress,
		[StoryEnum.BgEffectType.OutFocus] = self._actBgEffOutFocus,
		[StoryEnum.BgEffectType.DiamondLight] = self._actBgEffDiamondLight,
		[StoryEnum.BgEffectType.Starburst] = self._actBgEffStarburst,
		[StoryEnum.BgEffectType.SetLayer] = self._actBgEffSetLayer,
		[StoryEnum.BgEffectType.BgDistress] = self._actBgEffBgDistress,
		[StoryEnum.BgEffectType.HandCameraShake] = self._actBgEffHandCameraShake,
		[StoryEnum.BgEffectType.Penetration] = self._actBgEffPenetration,
		[StoryEnum.BgEffectType.CustomBlur] = self._actBgEffCustomBlur,
		[StoryEnum.BgEffectType.LineLight] = self._actBgEffLineLight,
		[StoryEnum.BgEffectType.EnterSplitScreen] = self._actBgEffEnterSplitScreen,
		[StoryEnum.BgEffectType.ExitSplitScreen] = self._actBgEffExitSplitScreen,
		[StoryEnum.BgEffectType.TextureShake] = self._actBgEffTextureShake,
		[StoryEnum.BgEffectType.ShapeMask] = self._actBgEffShapeMask,
		[StoryEnum.BgEffectType.PartialBlur] = self._actBgEffPartialBlur,
		[StoryEnum.BgEffectType.PerspectiveCamera] = self._actBgEffPerspectiveCamera,
		[StoryEnum.BgEffectType.TimeStop] = self._actBgEffTimeStop,
		[StoryEnum.BgEffectType.UpFlow] = self._actBgEffUpFlow,
		[StoryEnum.BgEffectType.ScreenHalo] = self._actBgEffScreenHalo,
		[StoryEnum.BgEffectType.ScreenHalo2] = self._actBgEffScreenHalo,
		[StoryEnum.BgEffectType.CrtFilter] = self._actBgEffCrtFilter,
		[StoryEnum.BgEffectType.CameraEffect] = self._actBgEffCameraEffect
	}
	self._handleResetBgEffs = {
		[StoryEnum.BgEffectType.BgBlur] = self._resetBgEffBlur,
		[StoryEnum.BgEffectType.FishEye] = self._resetBgEffFishEye,
		[StoryEnum.BgEffectType.BgShake] = self._resetBgEffBgShake,
		[StoryEnum.BgEffectType.FullBlur] = self._resetBgEffFullBlur,
		[StoryEnum.BgEffectType.BgGray] = self._resetBgEffGray,
		[StoryEnum.BgEffectType.FullGray] = self._resetBgEffFullGray,
		[StoryEnum.BgEffectType.Interfere] = self._resetBgEffInterfere,
		[StoryEnum.BgEffectType.Sketch] = self._resetBgEffSketch,
		[StoryEnum.BgEffectType.BlindFilter] = self._resetBgEffBlindFilter,
		[StoryEnum.BgEffectType.Opposition] = self._resetBgEffOpposition,
		[StoryEnum.BgEffectType.RgbSplit] = self._resetBgEffRgbSplit,
		[StoryEnum.BgEffectType.Malfunction] = self._resetBgEffMalfunction,
		[StoryEnum.BgEffectType.EagleEye] = self._resetBgEffEagleEye,
		[StoryEnum.BgEffectType.Filter] = self._resetBgEffFilter,
		[StoryEnum.BgEffectType.Distress] = self._resetBgEffDistress,
		[StoryEnum.BgEffectType.OutFocus] = self._resetBgEffOutFocus,
		[StoryEnum.BgEffectType.DiamondLight] = self._resetBgEffDiamondLight,
		[StoryEnum.BgEffectType.Starburst] = self._resetBgEffStarburst,
		[StoryEnum.BgEffectType.SetLayer] = self._resetBgEffSetLayer,
		[StoryEnum.BgEffectType.BgDistress] = self._resetBgEffBgDistress,
		[StoryEnum.BgEffectType.HandCameraShake] = self._resetBgEffHandCameraShake,
		[StoryEnum.BgEffectType.Penetration] = self._resetBgEffPenetration,
		[StoryEnum.BgEffectType.CustomBlur] = self._resetBgEffCustomBlur,
		[StoryEnum.BgEffectType.LineLight] = self._resetBgEffLineLight,
		[StoryEnum.BgEffectType.EnterSplitScreen] = self._resetBgEffEnterSplitScreen,
		[StoryEnum.BgEffectType.ExitSplitScreen] = self._resetBgEffExitSplitScreen,
		[StoryEnum.BgEffectType.TextureShake] = self._resetBgEffTextureShake,
		[StoryEnum.BgEffectType.ShapeMask] = self._resetBgEffShapeMask,
		[StoryEnum.BgEffectType.PartialBlur] = self._resetBgEffPartialBlur,
		[StoryEnum.BgEffectType.PerspectiveCamera] = self._resetBgEffPerspectiveCamera,
		[StoryEnum.BgEffectType.TimeStop] = self._resetBgEffTimeStop,
		[StoryEnum.BgEffectType.UpFlow] = self._resetBgEffUpFlow,
		[StoryEnum.BgEffectType.ScreenHalo] = self._resetBgEffScreenHalo,
		[StoryEnum.BgEffectType.ScreenHalo2] = self._resetBgEffScreenHalo,
		[StoryEnum.BgEffectType.CrtFilter] = self._resetBgEffCrtFilter,
		[StoryEnum.BgEffectType.CameraEffect] = self._resetBgEffCameraEffect
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
	self._bgBlur.enabled = self._bgCo.effType == StoryEnum.BgEffectType.BgBlur
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
	if self._imagebg.material == self._blurMat and self._bgCo.effType == StoryEnum.BgEffectType.BgBlur then
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
			self._simagebgimg:UnLoadImage()
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
	for effType, v in pairs(self._playingBgEffDict) do
		if v and effType ~= self._bgCo.effType then
			self._playingBgEffDict[effType] = nil

			local handle = self._handleResetBgEffs[effType]

			if handle then
				handle(self)
			end
		end
	end

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

	if self._handleBgEffsFuncDict[bgCo.effType] then
		self._playingBgEffDict[bgCo.effType] = true

		self._handleBgEffsFuncDict[bgCo.effType](self, bgCo)
	end
end

function StoryBackgroundView:_resetBgEffBlur()
	if self._bgCo.effType == StoryEnum.BgEffectType.BgBlur then
		return
	end

	self._bgBlur.blurWeight = 0

	gohelper.setActive(self._goblur, false)

	self._bgBlur.enabled = false
	self._cimagebgimg.vecInSide = Vector4.zero
	self._bgBlur.zoneImage = nil
end

function StoryBackgroundView:_resetBgEffFishEye()
	if self._bgCo.effType == StoryEnum.BgEffectType.FishEye then
		return
	end
end

function StoryBackgroundView:_resetBgEffFullBlur()
	if self._bgCo.effType == StoryEnum.BgEffectType.FullBlur then
		return
	end

	StoryController.instance:dispatchEvent(StoryEvent.PlayFullBlurOut, 0)
end

function StoryBackgroundView:_resetBgEffGray()
	if self._bgCo.effType == StoryEnum.BgEffectType.BgGray then
		return
	end

	if self._lastBgSubGo and self._lastBgCo.effType ~= StoryEnum.BgEffectType.BgGray then
		gohelper.destroy(self._lastBgSubGo)

		self._lastBgSubGo = nil
	end

	self:_actBgEffGrayUpdate(0)
end

function StoryBackgroundView:_resetBgEffFullGray()
	if self._bgCo.effType == StoryEnum.BgEffectType.FullGray then
		return
	end

	self:_actBgEffFullGrayUpdate(0.5)
end

function StoryBackgroundView:_resetBgEffEagleEye()
	if self._bgCo.effType == StoryEnum.BgEffectType.EagleEye then
		return
	end

	self:_onEagleEyeFinished()
end

function StoryBackgroundView:_resetBgEffFilter()
	if self._bgCo.effType == StoryEnum.BgEffectType.Filter then
		return
	end

	self:_onBgFliterEffFinished()
end

function StoryBackgroundView:_resetBgEffDistress()
	if self._bgCo.effType == StoryEnum.BgEffectType.Distress then
		return
	end

	if self._bgDistressCls then
		self._bgDistressCls:destroy()

		self._bgDistressCls = nil
	end
end

function StoryBackgroundView:_resetBgEffDiamondLight()
	if self._bgDiamondLightCls then
		self._bgDiamondLightCls:destroy()

		self._bgDiamondLightCls = nil
	end
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

function StoryBackgroundView:_actBgEffBlur()
	StoryTool.enablePostProcess(true)
	PostProcessingMgr.instance:setUIBlurActive(0)
	PostProcessingMgr.instance:setFreezeVisble(false)

	self._imagebg.material = self._blurMat
	self._imagebgtop.material = self._blurZoneMat
	self._bgBlur.enabled = true

	local value = {
		0,
		0.8,
		0.9,
		1
	}

	self._bgBlur.blurFactor = 0

	local transTime = self._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]

	if transTime > 0.1 then
		self._blurId = ZProj.TweenHelper.DOTweenFloat(self._bgBlur.blurWeight, value[self._bgCo.effDegree + 1], transTime, self._blurChange, self._blurFinished, self, nil, EaseType.Linear)
	else
		self:_blurChange(value[self._bgCo.effDegree + 1])
	end
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

function StoryBackgroundView:_actBgEffFishEye()
	self._imagebg.material = self._fisheyeMat
	self._imagebgtop.material = self._fisheyeMat
end

function StoryBackgroundView:_actBgEffBgShake(bgCo)
	local targetBgCo = bgCo or self._bgCo

	if not self._bgShakeCls then
		if targetBgCo.effDegree == 0 then
			return
		end

		if targetBgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
			return
		end

		self._bgShakeCls = StoryBgEffsBgShake.New()

		self._bgShakeCls:init(targetBgCo)
		self._bgShakeCls:start(self._resetBgEffBgShake, self)
	else
		self._bgShakeCls:reset(targetBgCo)
	end
end

function StoryBackgroundView:_resetBgEffBgShake()
	if self._bgShakeCls then
		self._bgShakeCls:destroy()

		self._bgShakeCls = nil
	end
end

function StoryBackgroundView:_actBgEffFullBlur()
	if self._bgCo.effDegree == StoryEnum.EffDegree.None then
		StoryController.instance:dispatchEvent(StoryEvent.PlayFullBlurOut, self._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	else
		StoryController.instance:dispatchEvent(StoryEvent.PlayFullBlurIn, self._bgCo.effDegree, self._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	end
end

function StoryBackgroundView:_actBgEffGray()
	if self._bgGrayId then
		ZProj.TweenHelper.KillById(self._bgGrayId)

		self._bgGrayId = nil
	end

	self:_actBgEffFullGrayUpdate(0.5)

	if self._bgCo.effDegree == 0 then
		self._prefabPath = ResUrl.getStoryBgEffect("v1a9_saturation")

		self.loadRes(self, {
			self._prefabPath
		}, self._actBgEffGrayLoaded, self)
	else
		if not self._prefabPath or not self._bgSubGo then
			return
		end

		local matPropsCtrl = self._bgSubGo:GetComponent(typeof(ZProj.MaterialPropsCtrl))

		if not matPropsCtrl then
			return
		end

		StoryTool.enablePostProcess(true)

		if self._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
			self:_actBgEffGrayUpdate(0)
		else
			local value = matPropsCtrl.float_01

			self._bgGrayId = ZProj.TweenHelper.DOTweenFloat(value, 0, self._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], self._actBgEffGrayUpdate, self._actGrayFinished, self)
		end
	end
end

function StoryBackgroundView:_actBgEffGrayLoaded()
	if self._bgSubGo and self._lastBgCo.effType == StoryEnum.BgEffectType.BgGray then
		self._lastBgSubGo = self._lastBgSubGo or gohelper.clone(self._bgSubGo, self._imagebgold.gameObject)

		local matPropsCtrl = self._lastBgSubGo:GetComponent(typeof(ZProj.MaterialPropsCtrl))

		self._imagebgold.material = matPropsCtrl.mas[0]
		self._imagebgoldtop.material = matPropsCtrl.mas[0]
	end

	if self._prefabPath then
		if self._bgSubGo and self._lastBgCo.effType == StoryEnum.BgEffectType.BgGray then
			gohelper.destroy(self._bgSubGo)
		end

		local prefAssetItem = self._loader:getAssetItem(self._prefabPath)

		self._bgSubGo = gohelper.clone(prefAssetItem:GetResource(), self._imagebg.gameObject)

		local matPropsCtrl = self._bgSubGo:GetComponent(typeof(ZProj.MaterialPropsCtrl))

		self._imagebg.material = matPropsCtrl.mas[0]
		self._imagebgtop.material = matPropsCtrl.mas[0]

		StoryTool.enablePostProcess(true)

		if self._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
			self:_actBgEffGrayUpdate(1)
		else
			self._bgGrayId = ZProj.TweenHelper.DOTweenFloat(0, 1, self._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], self._actBgEffGrayUpdate, self._actGrayFinished, self)
		end
	end
end

function StoryBackgroundView:_actBgEffGrayUpdate(value)
	if not self._bgSubGo then
		return
	end

	local matPropsCtrl = self._bgSubGo:GetComponent(typeof(ZProj.MaterialPropsCtrl))

	if not matPropsCtrl then
		return
	end

	matPropsCtrl.float_01 = value
end

function StoryBackgroundView:_actGrayFinished()
	if self._bgGrayId then
		ZProj.TweenHelper.KillById(self._bgGrayId)

		self._bgGrayId = nil
	end
end

function StoryBackgroundView:_actBgEffFullGray()
	self:_actBgEffGrayUpdate(0)

	if self._bgGrayId then
		ZProj.TweenHelper.KillById(self._bgGrayId)

		self._bgGrayId = nil
	end

	if self._bgCo.effDegree == 0 then
		StoryTool.enablePostProcess(true)

		if self._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
			self:_actBgEffFullGrayUpdate(1)
		else
			self._bgGrayId = ZProj.TweenHelper.DOTweenFloat(0.5, 1, self._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], self._actBgEffFullGrayUpdate, self._actGrayFinished, self)
		end
	elseif self._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		self:_actBgEffFullGrayUpdate(0.5)
	else
		local value = PostProcessingMgr.instance:getUIPPValue("Saturation")

		self._bgGrayId = ZProj.TweenHelper.DOTweenFloat(value, 0.5, self._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], self._actBgEffFullGrayUpdate, self._actGrayFinished, self)
	end
end

function StoryBackgroundView:_actBgEffFullGrayUpdate(value)
	PostProcessingMgr.instance:setUIPPValue("saturation", value)
	PostProcessingMgr.instance:setUIPPValue("Saturation", value)
end

function StoryBackgroundView:_resetBgEffInterfere()
	if self._bgCo.effType == StoryEnum.BgEffectType.Interfere then
		return
	end

	if not self._interfereGo then
		return
	end

	gohelper.destroy(self._interfereGo)

	self._interfereGo = nil

	StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UISecond)
	StoryViewMgr.instance:setStoryLeadRoleSpineViewLayer(UnityLayer.UIThird)
	gohelper.setLayer(self._gobliteff, UnityLayer.UI, true)
end

function StoryBackgroundView:_actBgEffInterfere()
	if self._interfereGo then
		self:_setInterfere()
	else
		self._interfereEffPrefPath = ResUrl.getStoryBgEffect("glitch_common")

		local resList = {}

		table.insert(resList, self._interfereEffPrefPath)
		self.loadRes(self, resList, self._onInterfereResLoaded, self)
	end
end

function StoryBackgroundView:_onInterfereResLoaded()
	if self._interfereEffPrefPath then
		local prefAssetItem = self._loader:getAssetItem(self._interfereEffPrefPath)
		local frontGo = ViewMgr.instance:getContainer(ViewName.StoryFrontView).viewGO

		self._interfereGo = gohelper.clone(prefAssetItem:GetResource(), frontGo)

		self:_setInterfere()
	end
end

function StoryBackgroundView:_setInterfere()
	StoryTool.enablePostProcess(true)
	gohelper.setAsFirstSibling(self._interfereGo)

	local img = self._interfereGo:GetComponent(typeof(UnityEngine.UI.Image))

	img.material:SetTexture("_MainTex", self._blitEff.capturedTexture)
	StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UITop)
	StoryViewMgr.instance:setStoryLeadRoleSpineViewLayer(UnityLayer.UITop)
	gohelper.setLayer(self._gobliteff, UnityLayer.UISecond, true)
end

function StoryBackgroundView:_resetBgEffSketch()
	if self._bgCo.effType == StoryEnum.BgEffectType.Sketch then
		return
	end

	if self._bgSketchId then
		ZProj.TweenHelper.KillById(self._bgSketchId)

		self._bgSketchId = nil
	end

	if not self._sketchGo then
		return
	end

	gohelper.destroy(self._sketchGo)

	self._sketchGo = nil

	StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UISecond)
	StoryViewMgr.instance:setStoryLeadRoleSpineViewLayer(UnityLayer.UIThird)
	gohelper.setLayer(self._gobliteff, UnityLayer.UI, true)
end

function StoryBackgroundView:_actBgEffSketch()
	if self._bgSketchId then
		ZProj.TweenHelper.KillById(self._bgSketchId)

		self._bgSketchId = nil
	end

	if self._bgCo.effDegree == 0 and not self._sketchGo then
		return
	end

	if self._sketchGo then
		self:_setSketch()
	else
		self._sketchEffPrefPath = ResUrl.getStoryBgEffect("storybg_sketch")

		local resList = {}

		table.insert(resList, self._sketchEffPrefPath)
		self.loadRes(self, resList, self._onSketchResLoaded, self)
	end
end

local sketchEffDegrees = {
	1,
	0.4,
	0.2,
	0
}

function StoryBackgroundView:_onSketchResLoaded()
	if self._sketchEffPrefPath then
		local prefAssetItem = self._loader:getAssetItem(self._sketchEffPrefPath)
		local frontGo = ViewMgr.instance:getContainer(ViewName.StoryFrontView).viewGO

		self._sketchGo = gohelper.clone(prefAssetItem:GetResource(), frontGo)

		self:_setSketch()
	end
end

function StoryBackgroundView:_setSketch()
	StoryTool.enablePostProcess(true)
	gohelper.setAsFirstSibling(self._sketchGo)

	self._imgSketch = self._sketchGo:GetComponent(typeof(UnityEngine.UI.Image))

	self._imgSketch.material:SetTexture("_MainTex", self._blitEff.capturedTexture)

	if self._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		self:_sketchUpdate(sketchEffDegrees[self._bgCo.effDegree + 1])
	else
		local value = self._imgSketch.material:GetFloat("_SourceColLerp")
		local value

		if self._bgCo.effDegree > 0 then
			value = 1
		end

		self._bgSketchId = ZProj.TweenHelper.DOTweenFloat(value, sketchEffDegrees[self._bgCo.effDegree + 1], self._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], self._sketchUpdate, self._sketchFinished, self)
	end

	StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UITop)
	StoryViewMgr.instance:setStoryLeadRoleSpineViewLayer(UnityLayer.UITop)
	gohelper.setLayer(self._gobliteff, UnityLayer.UISecond, true)
end

function StoryBackgroundView:_sketchUpdate(value)
	self._imgSketch.material:SetFloat("_SourceColLerp", value)
end

function StoryBackgroundView:_sketchFinished()
	if self._bgSketchId then
		ZProj.TweenHelper.KillById(self._bgSketchId)

		self._bgSketchId = nil
	end
end

function StoryBackgroundView:_resetBgEffBlindFilter()
	if self._bgBlindFilterCls then
		self._bgBlindFilterCls:destroy()

		self._bgBlindFilterCls = nil
	end
end

function StoryBackgroundView:_actBgEffBlindFilter()
	if not self._bgBlindFilterCls then
		if self._bgCo.effDegree == 0 then
			return
		end

		self._bgBlindFilterCls = StoryBgEffsBlindFilter.New()

		self._bgBlindFilterCls:init(self._bgCo)
		self._bgBlindFilterCls:start(self._resetBgEffBlindFilter, self)
	else
		if self._bgCo.effDegree == 0 then
			self:_resetBgEffBlindFilter()

			return
		end

		self._bgBlindFilterCls:reset(self._bgCo)
	end
end

function StoryBackgroundView:_actBgEffEagleEye()
	if not self._bgEffEagleEye then
		self._bgEffEagleEye = StoryBgEffsEagleEye.New()

		self._bgEffEagleEye:init(self._bgCo)
		self._bgEffEagleEye:start(self._onEagleEyeFinished, self)
	else
		self._bgEffEagleEye:reset(self._bgCo)
	end
end

function StoryBackgroundView:_onEagleEyeFinished()
	if self._bgEffEagleEye then
		self._bgEffEagleEye:destroy()

		self._bgEffEagleEye = nil
	end
end

function StoryBackgroundView:_actBgEffFilter()
	if not self._bgFilterCls then
		self._bgFilterCls = StoryBgEffsFilter.New()

		self._bgFilterCls:init(self._bgCo)
		self._bgFilterCls:start(self._onBgFliterEffFinished, self)
	else
		self._bgFilterCls:reset(self._bgCo)
	end
end

function StoryBackgroundView:_onBgFliterEffFinished()
	if self._bgFilterCls then
		self._bgFilterCls:destroy()

		self._bgFilterCls = nil
	end
end

function StoryBackgroundView:_actBgEffDistress()
	if not self._bgDistressCls then
		self._bgDistressCls = StoryBgEffsDistress.New()

		self._bgDistressCls:init(self._bgCo)
		self._bgDistressCls:start()
	else
		self._bgDistressCls:reset(self._bgCo)
	end
end

function StoryBackgroundView:_actBgEffOutFocus()
	if not self._bgOutFocusCls then
		if self._bgCo.effDegree == 1 then
			return
		end

		self._bgOutFocusCls = StoryBgEffsOutFocus.New()

		self._bgOutFocusCls:init(self._bgCo)
		self._bgOutFocusCls:start(self._resetBgEffOutFocus, self)
	else
		self._bgOutFocusCls:reset(self._bgCo)
	end
end

function StoryBackgroundView:_resetBgEffOutFocus()
	if self._bgOutFocusCls then
		self._bgOutFocusCls:destroy()

		self._bgOutFocusCls = nil
	end
end

function StoryBackgroundView:_actBgEffDiamondLight()
	if not self._bgDiamondLightCls then
		if self._bgCo.effDegree == 1 then
			return
		end

		self._bgDiamondLightCls = StoryBgEffsDiamondLight.New()

		self._bgDiamondLightCls:init(self._bgCo)
		self._bgDiamondLightCls:start(self._resetBgEffDiamondLight, self)
	else
		self._bgDiamondLightCls:reset(self._bgCo)
	end
end

function StoryBackgroundView:_actBgEffStarburst()
	if not self._bgStarburstCls then
		self._bgStarburstCls = StoryBgEffsStarburst.New()

		self._bgStarburstCls:init(self._bgCo)
		self._bgStarburstCls:start()
	else
		self._bgStarburstCls:reset(self._bgCo)
	end
end

function StoryBackgroundView:_resetBgEffStarburst(force)
	if not force and self._bgCo.effType == StoryEnum.BgEffectType.Starburst then
		return
	end

	if self._bgStarburstCls then
		self._bgStarburstCls:destroy()

		self._bgStarburstCls = nil
	end
end

function StoryBackgroundView:_actBgEffSetLayer()
	if not self._bgSetLayerCls then
		self._bgSetLayerCls = StoryBgEffsSetLayer.New()

		self._bgSetLayerCls:init(self._bgCo)
		self._bgSetLayerCls:start()
	else
		self._bgSetLayerCls:reset(self._bgCo)
	end
end

function StoryBackgroundView:_resetBgEffSetLayer(force)
	if not force and self._bgCo.effType == StoryEnum.BgEffectType.SetLayer then
		return
	end

	if self._bgSetLayerCls then
		self._bgSetLayerCls:destroy()

		self._bgSetLayerCls = nil
	end
end

function StoryBackgroundView:_actBgEffBgDistress()
	if not self._bgBgDistressCls then
		self._bgBgDistressCls = StoryBgEffsBgDistress.New()

		self._bgBgDistressCls:init(self._bgCo)
		self._bgBgDistressCls:start()
	else
		self._bgBgDistressCls:reset(self._bgCo)
	end
end

function StoryBackgroundView:_resetBgEffBgDistress()
	if self._bgCo.effType == StoryEnum.BgEffectType.BgDistress then
		return
	end

	if self._bgBgDistressCls then
		self._bgBgDistressCls:destroy()

		self._bgBgDistressCls = nil
	end
end

function StoryBackgroundView:_actBgEffHandCameraShake(bgCo)
	local targetBgCo = bgCo or self._bgCo

	if not self._bgHandCameraShakeCls then
		if targetBgCo.effDegree == 0 then
			return
		end

		if targetBgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
			return
		end

		self._bgHandCameraShakeCls = StoryBgEffsHandCameraShake.New()

		self._bgHandCameraShakeCls:init(targetBgCo)
		self._bgHandCameraShakeCls:start(self._resetBgEffHandCameraShake, self)
	else
		self._bgHandCameraShakeCls:reset(targetBgCo)
	end
end

function StoryBackgroundView:_resetBgEffHandCameraShake()
	if self._bgHandCameraShakeCls then
		self._bgHandCameraShakeCls:destroy()

		self._bgHandCameraShakeCls = nil
	end
end

function StoryBackgroundView:_actBgEffPenetration()
	if not self._bgPenetrationCls then
		if self._bgCo.effDegree ~= 0 then
			return
		end

		self._bgPenetrationCls = StoryBgEffsPenetration.New()

		self._bgPenetrationCls:init(self._bgCo)
		self._bgPenetrationCls:start(self._resetBgEffPenetration, self)
	else
		self._bgPenetrationCls:reset(self._bgCo)
	end
end

function StoryBackgroundView:_resetBgEffPenetration()
	if self._bgPenetrationCls then
		self._bgPenetrationCls:destroy()

		self._bgPenetrationCls = nil
	end
end

function StoryBackgroundView:_actBgEffCustomBlur()
	local rad = self._lastBgCo and math.atan2(self._lastBgCo.offset[2] - self._bgCo.offset[2], self._lastBgCo.offset[1] - self._bgCo.offset[1]) or 0
	local angle = math.deg(rad)

	if not self._bgCustomBlurCls then
		if self._bgCo.effDegree == 0 then
			return
		end

		self._bgCustomBlurCls = StoryBgEffsCustomBlur.New()

		self._bgCustomBlurCls:init(self._bgCo)
		self._bgCustomBlurCls:setAngle(angle)
		self._bgCustomBlurCls:start(self._resetBgEffCustomBlur, self)
	else
		self._bgCustomBlurCls:setAngle(angle)
		self._bgCustomBlurCls:reset(self._bgCo)
	end
end

function StoryBackgroundView:_resetBgEffCustomBlur()
	if self._bgCustomBlurCls then
		self._bgCustomBlurCls:destroy()

		self._bgCustomBlurCls = nil
	end
end

function StoryBackgroundView:_actBgEffLineLight()
	if not self._bgLineLightCls then
		if self._bgCo.effDegree == 1 then
			return
		end

		self._bgLineLightCls = StoryBgEffsLineLight.New()

		self._bgLineLightCls:init(self._bgCo)
		self._bgLineLightCls:start(self._resetBgEffLineLight, self)
	else
		self._bgLineLightCls:reset(self._bgCo)
	end
end

function StoryBackgroundView:_resetBgEffLineLight()
	if self._bgLineLightCls then
		self._bgLineLightCls:destroy()

		self._bgLineLightCls = nil
	end
end

function StoryBackgroundView:_actBgEffEnterSplitScreen()
	if not self._bgEnterSplitScreenCls then
		self._bgEnterSplitScreenCls = StoryBgEffsEnterSplitScreen.New()

		self._bgEnterSplitScreenCls:init(self._bgCo)
		self._bgEnterSplitScreenCls:start(self._resetBgEffEnterSplitScreen, self)
	else
		self._bgEnterSplitScreenCls:reset(self._bgCo)
	end
end

function StoryBackgroundView:_resetBgEffEnterSplitScreen()
	local isSplitScreen = StoryModel.instance:isInScreenSplitMode()

	if not isSplitScreen and self._bgEnterSplitScreenCls then
		self._bgEnterSplitScreenCls:destroy()

		self._bgEnterSplitScreenCls = nil
	end
end

function StoryBackgroundView:_actBgEffExitSplitScreen()
	if not self._bgExitSplitScreenCls then
		self._bgExitSplitScreenCls = StoryBgEffsExitSplitScreen.New()

		self._bgExitSplitScreenCls:init(self._bgCo)
		self._bgExitSplitScreenCls:start(self._resetBgEffExitSplitScreen, self)
	else
		self._bgExitSplitScreenCls:reset(self._bgCo)
	end
end

function StoryBackgroundView:_resetBgEffExitSplitScreen()
	if self._bgCo.effType ~= StoryEnum.BgEffectType.ExitSplitScreen and self._bgExitSplitScreenCls then
		self._bgExitSplitScreenCls:destroy()

		self._bgExitSplitScreenCls = nil
	end
end

function StoryBackgroundView:_actBgEffTextureShake()
	if not self._bgEffTextureShake then
		self._bgEffTextureShake = StoryBgEffsTextureShake.New()

		self._bgEffTextureShake:init(self._bgCo)
		self._bgEffTextureShake:start(self._resetBgEffTextureShake, self)
	else
		self._bgEffTextureShake:reset(self._bgCo)
	end
end

function StoryBackgroundView:_resetBgEffTextureShake()
	if self._bgEffTextureShake then
		self._bgEffTextureShake:destroy()

		self._bgEffTextureShake = nil
	end
end

function StoryBackgroundView:_actBgEffShapeMask()
	if not self._bgEffShapeMask then
		self._bgEffShapeMask = StoryBgEffsShapeMask.New()

		self._bgEffShapeMask:init(self._bgCo)
		self._bgEffShapeMask:start(self._resetBgEffShapeMask, self)
	else
		self._bgEffShapeMask:reset(self._bgCo)
	end
end

function StoryBackgroundView:_resetBgEffShapeMask()
	if self._bgEffShapeMask then
		self._bgEffShapeMask:destroy()

		self._bgEffShapeMask = nil
	end
end

function StoryBackgroundView:_actBgEffPartialBlur()
	if not self._bgEffPartialBlur then
		self._bgEffPartialBlur = StoryBgEffsPartialBlur.New()

		self._bgEffPartialBlur:init(self._bgCo)
		self._bgEffPartialBlur:start(self._resetBgEffPartialBlur, self)
	else
		self._bgEffPartialBlur:reset(self._bgCo)
	end
end

function StoryBackgroundView:_resetBgEffPartialBlur()
	if self._bgEffPartialBlur then
		self._bgEffPartialBlur:destroy()

		self._bgEffPartialBlur = nil
	end
end

function StoryBackgroundView:_actBgEffPerspectiveCamera()
	if not self._bgEffPerspectiveCamera then
		if self._bgCo.effDegree == 1 then
			return
		end

		self._bgEffPerspectiveCamera = StoryBgEffsPerspectiveCamera.New()

		self._bgEffPerspectiveCamera:init(self._bgCo)
		self._bgEffPerspectiveCamera:start(self._resetBgEffPerspectiveCamera, self)
	else
		self._bgEffPerspectiveCamera:reset(self._bgCo)
	end
end

function StoryBackgroundView:_resetBgEffPerspectiveCamera()
	if self._bgEffPerspectiveCamera then
		self._bgEffPerspectiveCamera:destroy()

		self._bgEffPerspectiveCamera = nil
	end
end

function StoryBackgroundView:_resetBgEffOpposition()
	if self._bgOppositionId then
		ZProj.TweenHelper.KillById(self._bgOppositionId)

		self._bgOppositionId = nil
	end

	if not self._oppositionGo then
		return
	end

	gohelper.destroy(self._oppositionGo)

	self._oppositionGo = nil

	local storyViewGo = StoryViewMgr.instance:getStoryView()

	gohelper.setLayer(storyViewGo, UnityLayer.UISecond, true)

	local storyLeadRoleViewGo = ViewMgr.instance:getContainer(ViewName.StoryLeadRoleSpineView).viewGO
	local maskGo = gohelper.findChild(storyLeadRoleViewGo, "#go_spineroot")

	gohelper.setLayer(maskGo, UnityLayer.UIThird, true)
	gohelper.setLayer(self._gobliteff, UnityLayer.UI, true)
end

function StoryBackgroundView:_actBgEffOpposition()
	if self._bgOppositionId then
		ZProj.TweenHelper.KillById(self._bgOppositionId)

		self._bgOppositionId = nil
	end

	if self._bgCo.effDegree == 0 and not self._oppositionGo then
		return
	end

	if self._oppositionGo then
		self:_setOpposition()
	else
		self._oppositonPrefPath = ResUrl.getStoryBgEffect("storybg_colorinverse")

		local resList = {}

		table.insert(resList, self._oppositonPrefPath)
		self.loadRes(self, resList, self._onOppositionResLoaded, self)
	end
end

function StoryBackgroundView:_onOppositionResLoaded()
	if self._oppositonPrefPath then
		local prefAssetItem = self._loader:getAssetItem(self._oppositonPrefPath)
		local frontGo = ViewMgr.instance:getContainer(ViewName.StoryFrontView).viewGO

		self._oppositionGo = gohelper.clone(prefAssetItem:GetResource(), frontGo)

		self:_setOpposition()
	end
end

local oppositionEffDegrees = {
	1,
	0.4,
	0.2,
	0
}

function StoryBackgroundView:_setOpposition()
	StoryTool.enablePostProcess(true)
	gohelper.setAsFirstSibling(self._oppositionGo)

	self._imgOpposition = self._oppositionGo:GetComponent(typeof(UnityEngine.UI.Image))

	self._imgOpposition.material:SetTexture("_MainTex", self._blitEff.capturedTexture)

	if self._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		self:_oppositionUpdate(oppositionEffDegrees[self._bgCo.effDegree + 1])
	else
		local value = self._imgOpposition.material:GetFloat("_ColorInverseFactor")
		local value

		if self._bgCo.effDegree > 0 then
			value = 1
		end

		self._bgOppositionId = ZProj.TweenHelper.DOTweenFloat(value, oppositionEffDegrees[self._bgCo.effDegree + 1], self._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], self._oppositionUpdate, self._oppositionFinished, self)
	end

	local storyViewGo = StoryViewMgr.instance:getStoryView()

	gohelper.setLayer(storyViewGo, UnityLayer.UITop, true)

	local storyLeadRoleViewGo = ViewMgr.instance:getContainer(ViewName.StoryLeadRoleSpineView).viewGO
	local maskGo = gohelper.findChild(storyLeadRoleViewGo, "#go_spineroot")

	gohelper.setLayer(maskGo, UnityLayer.UITop, true)
	gohelper.setLayer(self._gobliteff, UnityLayer.UISecond, true)
end

function StoryBackgroundView:_oppositionUpdate(value)
	self._imgOpposition.material:SetFloat("_ColorInverseFactor", value)
end

function StoryBackgroundView:_oppositionFinished()
	if self._bgOppositionId then
		ZProj.TweenHelper.KillById(self._bgOppositionId)

		self._bgOppositionId = nil
	end
end

function StoryBackgroundView:_resetBgEffRgbSplit()
	if not self._rbgSplitGo then
		return
	end

	gohelper.destroy(self._rbgSplitGo)

	self._rbgSplitGo = nil

	gohelper.setLayer(self._gobliteff, UnityLayer.UI, true)
	StoryViewMgr.instance:setStoryHeroViewLayer(UnityLayer.UISecond)
	StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UISecond)
	StoryViewMgr.instance:setStoryLeadRoleSpineViewLayer(UnityLayer.UISecond)
end

function StoryBackgroundView:_actBgEffRgbSplit()
	if self._bgCo.effDegree == StoryEnum.BgRgbSplitType.Trans then
		self:_showTransRgbSplit()
	elseif self._bgCo.effDegree == StoryEnum.BgRgbSplitType.Once then
		self:_showOnceRgbSplit()
	elseif self._bgCo.effDegree == StoryEnum.BgRgbSplitType.LoopWeak then
		self:_showLoopWeakRgbSplit()
	elseif self._bgCo.effDegree == StoryEnum.BgRgbSplitType.LoopStrong then
		self:_showLoopStrongRgbSplit()
	end
end

function StoryBackgroundView:_showTransRgbSplit()
	if self._rbgSplitGo then
		gohelper.destroy(self._rbgSplitGo)

		self._rbgSplitGo = nil
	end

	self._transRgbSplitPrefPath = ResUrl.getStoryBgEffect("storybg_rgbsplit_changebg_doublerole")

	local resList = {}

	table.insert(resList, self._transRgbSplitPrefPath)
	self.loadRes(self, resList, self._onTransRgbSplitResLoaded, self)
end

function StoryBackgroundView:_onTransRgbSplitResLoaded()
	if self._transRgbSplitPrefPath then
		local prefAssetItem = self._loader:getAssetItem(self._transRgbSplitPrefPath)
		local frontGo = ViewMgr.instance:getContainer(ViewName.StoryFrontView).viewGO

		self._rbgSplitGo = gohelper.clone(prefAssetItem:GetResource(), frontGo)

		self:_setTransRgbSplit()
	end
end

function StoryBackgroundView:_setTransRgbSplit()
	StoryTool.enablePostProcess(true)
	gohelper.setAsFirstSibling(self._rbgSplitGo)

	self._imgOld = gohelper.findChildImage(self._rbgSplitGo, "image_old")
	self._imgNew = gohelper.findChildImage(self._rbgSplitGo, "image_new")
	self._goAnim = gohelper.findChild(self._rbgSplitGo, "anim")

	gohelper.setActive(self._imgOld.gameObject, true)
	gohelper.setActive(self._imgNew.gameObject, true)
	gohelper.setActive(self._goAnim, true)
	gohelper.setLayer(self._gobliteff, UnityLayer.UISecond, true)
	self._imgOld.material:SetTexture("_MainTex", self._lastCaptureTexture)
	self._imgNew.material:SetTexture("_MainTex", self._blitEffSecond.capturedTexture)
	TaskDispatcher.runDelay(self._resetBgEffRgbSplit, self, 1.2)
end

function StoryBackgroundView:_showOnceRgbSplit()
	if self._rbgSplitGo then
		gohelper.destroy(self._rbgSplitGo)

		self._rbgSplitGo = nil
	end

	self._onceRgbSplitPrefPath = ResUrl.getStoryBgEffect("storybg_rgbsplit_once")

	local resList = {}

	table.insert(resList, self._onceRgbSplitPrefPath)
	self.loadRes(self, resList, self._onOnceRgbSplitResLoaded, self)
end

function StoryBackgroundView:_onOnceRgbSplitResLoaded()
	if self._onceRgbSplitPrefPath then
		local prefAssetItem = self._loader:getAssetItem(self._onceRgbSplitPrefPath)
		local frontGo = ViewMgr.instance:getContainer(ViewName.StoryHeroView).viewGO

		self._rbgSplitGo = gohelper.clone(prefAssetItem:GetResource(), frontGo)

		StoryTool.enablePostProcess(true)
		gohelper.setAsFirstSibling(self._rbgSplitGo)

		self._img = self._rbgSplitGo:GetComponent(typeof(UnityEngine.UI.Image))

		gohelper.setActive(self._img.gameObject, true)
		self._img.material:SetTexture("_MainTex", self._blitEff.capturedTexture)
		TaskDispatcher.runDelay(self._resetBgEffRgbSplit, self, 0.267)
	end
end

function StoryBackgroundView:_showLoopWeakRgbSplit()
	if self._rbgSplitGo then
		gohelper.destroy(self._rbgSplitGo)

		self._rbgSplitGo = nil
	end

	self._loopWeakRgbSplitPrefPath = ResUrl.getStoryBgEffect("storybg_rgbsplit_loop")

	local resList = {}

	table.insert(resList, self._loopWeakRgbSplitPrefPath)
	self.loadRes(self, resList, self._onLoopWeakRgbSplitResLoaded, self)
end

function StoryBackgroundView:_onLoopWeakRgbSplitResLoaded()
	if self._loopWeakRgbSplitPrefPath then
		local prefAssetItem = self._loader:getAssetItem(self._loopWeakRgbSplitPrefPath)

		StoryViewMgr.instance:setStoryHeroViewLayer(UnityLayer.UIThird)
		StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UIThird)
		StoryViewMgr.instance:setStoryLeadRoleSpineViewLayer(UnityLayer.UIThird)

		local frontGo = StoryViewMgr.instance:getStoryHeroView()

		self._rbgSplitGo = gohelper.clone(prefAssetItem:GetResource(), frontGo)

		StoryTool.enablePostProcess(true)
		gohelper.setAsFirstSibling(self._rbgSplitGo)

		self._img = self._rbgSplitGo:GetComponent(typeof(UnityEngine.UI.Image))

		gohelper.setActive(self._img.gameObject, true)
		self._img.material:SetTexture("_MainTex", self._blitEff.capturedTexture)
	end
end

function StoryBackgroundView:_showLoopStrongRgbSplit()
	if self._rbgSplitGo then
		gohelper.destroy(self._rbgSplitGo)

		self._rbgSplitGo = nil
	end

	self._loopStrongRgbSplitPrefPath = ResUrl.getStoryBgEffect("storybg_rgbsplit_loop_strong")

	local resList = {}

	table.insert(resList, self._loopStrongRgbSplitPrefPath)
	self.loadRes(self, resList, self._onLoopStrongRgbSplitResLoaded, self)
end

function StoryBackgroundView:_onLoopStrongRgbSplitResLoaded()
	if self._loopStrongRgbSplitPrefPath then
		local prefAssetItem = self._loader:getAssetItem(self._loopStrongRgbSplitPrefPath)
		local frontGo = ViewMgr.instance:getContainer(ViewName.StoryHeroView).viewGO

		self._rbgSplitGo = gohelper.clone(prefAssetItem:GetResource(), frontGo)

		StoryTool.enablePostProcess(true)
		gohelper.setAsFirstSibling(self._rbgSplitGo)

		self._img = self._rbgSplitGo:GetComponent(typeof(UnityEngine.UI.Image))

		gohelper.setActive(self._img.gameObject, true)
		self._img.material:SetTexture("_MainTex", self._blitEff.capturedTexture)
	end
end

function StoryBackgroundView:_actBgEffMalfunction()
	if self._bgCo.effDegree == StoryEnum.BgRgbSplitType.Trans then
		self:_showTransMalfunction()
	end
end

function StoryBackgroundView:_resetBgEffMalfunction()
	if self._malfunctionGo then
		gohelper.destroy(self._malfunctionGo)

		self._malfunctionGo = nil
	end

	if self._gobliteff then
		gohelper.setLayer(self._gobliteff, UnityLayer.UI, true)
	end
end

function StoryBackgroundView:_showTransMalfunction()
	if self._rbgSplitGo then
		gohelper.destroy(self._rbgSplitGo)

		self._rbgSplitGo = nil
	end

	self._transMalfunctionPrefPath = ResUrl.getStoryBgEffect("storybg_rgbsplit_changebg_doublerole2")

	local resList = {}

	table.insert(resList, self._transMalfunctionPrefPath)
	self.loadRes(self, resList, self._onTransMalfunctionResLoaded, self)
end

function StoryBackgroundView:_onTransMalfunctionResLoaded()
	if self._transMalfunctionPrefPath then
		local prefAssetItem = self._loader:getAssetItem(self._transMalfunctionPrefPath)
		local frontGo = StoryViewMgr.instance:getStoryView()

		self._malfunctionGo = gohelper.clone(prefAssetItem:GetResource(), frontGo)

		self:_setTransMalfunction()
	end
end

function StoryBackgroundView:_setTransMalfunction()
	StoryTool.enablePostProcess(true)
	gohelper.setAsFirstSibling(self._malfunctionGo)

	self._imgOld = gohelper.findChildImage(self._malfunctionGo, "image_old")
	self._imgNew = gohelper.findChildImage(self._malfunctionGo, "image_new")
	self._goAnim = gohelper.findChild(self._malfunctionGo, "anim")

	gohelper.setActive(self._imgOld.gameObject, true)
	gohelper.setActive(self._imgNew.gameObject, true)
	gohelper.setActive(self._goAnim, true)

	local canvas = gohelper.onceAddComponent(self._malfunctionGo, typeof(UnityEngine.Canvas))

	canvas.overrideSorting = true
	canvas.sortingOrder = 2004

	gohelper.setLayer(self._gobliteff, UnityLayer.UISecond, true)
	gohelper.setLayer(self._malfunctionGo, UnityLayer.UISecond, true)
	self._imgOld.material:SetTexture("_MainTex", self._lastCaptureTexture)
	self._imgNew.material:SetTexture("_MainTex", self._blitEffSecond.capturedTexture)
	TaskDispatcher.runDelay(self._changeMalfunctionLayer, self, 2.8)
	TaskDispatcher.runDelay(self._resetBgEffMalfunction, self, 4)
end

function StoryBackgroundView:_changeMalfunctionLayer()
	if self._malfunctionGo then
		gohelper.setLayer(self._malfunctionGo, UnityLayer.UITop, true)
	end
end

function StoryBackgroundView:_actBgEffTimeStop()
	if not self._bgTimeStopCls then
		self._bgTimeStopCls = StoryBgEffsTimeStop.New()

		self._bgTimeStopCls:init(self._bgCo)
		self._bgTimeStopCls:start(self._resetBgEffTimeStop, self)
	else
		self._bgTimeStopCls:reset(self._bgCo)
	end
end

function StoryBackgroundView:_resetBgEffTimeStop()
	if self._bgTimeStopCls then
		self._bgTimeStopCls:destroy()

		self._bgTimeStopCls = nil
	end
end

function StoryBackgroundView:_actBgEffUpFlow()
	if not self._bgUpFlowCls then
		self._bgUpFlowCls = StoryBgEffsUpFlow.New()

		self._bgUpFlowCls:init(self._bgCo)
		self._bgUpFlowCls:start(self._resetBgEffUpFlow, self)
	else
		self._bgUpFlowCls:reset(self._bgCo)
	end
end

function StoryBackgroundView:_resetBgEffUpFlow()
	if self._bgUpFlowCls then
		self._bgUpFlowCls:destroy()

		self._bgUpFlowCls = nil
	end
end

function StoryBackgroundView:_actBgEffScreenHalo()
	if not self._bgScreenHaloCls then
		self._bgScreenHaloCls = StoryBgEffsScreenHalo.New()

		self._bgScreenHaloCls:init(self._bgCo)
		self._bgScreenHaloCls:start()
	else
		self._bgScreenHaloCls:reset(self._bgCo)
	end
end

function StoryBackgroundView:_resetBgEffScreenHalo()
	if self._bgScreenHaloCls then
		self._bgScreenHaloCls:destroy()

		self._bgScreenHaloCls = nil
	end
end

function StoryBackgroundView:_actBgEffCrtFilter()
	if not self._bgCrtFilterCls then
		self._bgCrtFilterCls = StoryBgEffsCrtFilter.New()

		self._bgCrtFilterCls:init(self._bgCo)
		self._bgCrtFilterCls:start()
	else
		self._bgCrtFilterCls:reset(self._bgCo)
	end
end

function StoryBackgroundView:_resetBgEffCrtFilter()
	if self._bgCrtFilterCls then
		self._bgCrtFilterCls:destroy()

		self._bgCrtFilterCls = nil
	end
end

function StoryBackgroundView:_actBgEffCameraEffect(type)
	if not self._bgCameraEffCls then
		self._bgCameraEffCls = StoryBgEffsCameraEffect.New()

		self._bgCameraEffCls:init(self._bgCo)
		self._bgCameraEffCls:start()
	else
		self._bgCameraEffCls:reset(self._bgCo)
	end
end

function StoryBackgroundView:_resetBgEffCameraEffect()
	if self._bgCameraEffCls then
		self._bgCameraEffCls:destroy()

		self._bgCameraEffCls = nil
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
	self:_resetBgEffOutFocus()
	self:_resetBgEffDiamondLight()
	self:_resetBgEffStarburst(true)
	self:_resetBgEffSetLayer(true)
	self:_resetBgEffBgShake()
	self:_resetBgEffHandCameraShake()
	self:_resetBgEffCustomBlur()
	self:_resetBgEffLineLight()
	self:_resetBgEffEnterSplitScreen()
	self:_resetBgEffExitSplitScreen()
	self:_resetBgEffTextureShake()
	self:_resetBgEffShapeMask()
	self:_resetBgEffMalfunction()
	self:_resetBgEffPartialBlur()
	self:_resetBgEffPerspectiveCamera()
	self:_resetBgEffScreenHalo()
	self:_resetBgEffCrtFilter()
	self:_resetBgEffCameraEffect()

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

	if self._bgGrayId then
		ZProj.TweenHelper.KillById(self._bgGrayId)

		self._bgGrayId = nil
	end

	if self._bgSketchId then
		ZProj.TweenHelper.KillById(self._bgSketchId)

		self._bgSketchId = nil
	end

	if self._bgFilterId then
		ZProj.TweenHelper.KillById(self._bgFilterId)

		self._bgFilterId = nil
	end

	if self._bgOppositionId then
		ZProj.TweenHelper.KillById(self._bgOppositionId)

		self._bgOppositionId = nil
	end

	TaskDispatcher.cancelTask(self._resetBgEffRgbSplit, self)
	TaskDispatcher.cancelTask(self._onTurnPageFinished, self)
	TaskDispatcher.cancelTask(self._changeRightDark, self)
	TaskDispatcher.cancelTask(self._enterChange, self)
	TaskDispatcher.cancelTask(self._distortEnd, self)
	TaskDispatcher.cancelTask(self._leftDarkTransFinished, self)
	TaskDispatcher.cancelTask(self._commonTransFinished, self)
	self:_onEagleEyeFinished()

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
	self:_actBgEffFullGrayUpdate(0.5)
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
end

return StoryBackgroundView
