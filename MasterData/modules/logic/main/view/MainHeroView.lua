-- chunkname: @modules/logic/main/view/MainHeroView.lua

module("modules.logic.main.view.MainHeroView", package.seeall)

local MainHeroView = class("MainHeroView", BaseView)

function MainHeroView:onInitView()
	self._golightspinecontrol = gohelper.findChild(self.viewGO, "#go_lightspinecontrol")
	self._gospinescale = gohelper.findChild(self.viewGO, "#go_spine_scale")
	self._golightspine = gohelper.findChild(self.viewGO, "#go_spine_scale/lightspine/#go_lightspine")
	self._txtanacn = gohelper.findChildText(self.viewGO, "bottom/#txt_ana_cn")
	self._txtanaen = gohelper.findChildText(self.viewGO, "bottom/#txt_ana_en")
	self._gocontentbg = gohelper.findChild(self.viewGO, "bottom/#go_contentbg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MainHeroView:addEvents()
	return
end

function MainHeroView:removeEvents()
	return
end

local weatherController = WeatherController.instance

function MainHeroView:onOpen()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenFullViewFinish, self._onOpenFullViewFinish, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenFullView, self._onOpenFullView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseFullView, self._onCloseFullView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.ReOpenWhileOpen, self._reOpenWhileOpen, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self, LuaEventSystem.Low)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self, LuaEventSystem.Low)
	self.addEventCb(self, WeatherController.instance, WeatherEvent.PlayVoice, self._onWeatherPlayVoice, self)
	self.addEventCb(self, WeatherController.instance, WeatherEvent.LoadPhotoFrameBg, self._onWeatherLoadPhotoFrameBg, self)
	self.addEventCb(self, WeatherController.instance, WeatherEvent.OnRoleBlend, self._onWeatherOnRoleBlend, self)
	self.addEventCb(self, MainController.instance, MainEvent.OnReceiveAddFaithEvent, self._onSuccessTouchHead, self)
	self.addEventCb(self, MainController.instance, MainEvent.OnClickSwitchRole, self._onClickSwitchRole, self)
	self.addEventCb(self, MainController.instance, MainEvent.OnSceneClose, self._onSceneClose, self)
	self.addEventCb(self, MainController.instance, MainEvent.SetMainViewVisible, self._setViewVisible, self)
	self.addEventCb(self, MainController.instance, MainEvent.ChangeMainHeroSkin, self._changeMainHeroSkin, self)
	self.addEventCb(self, MainController.instance, MainEvent.OnShowMainThumbnailView, self._onShowMainThumbnailView, self)
	self.addEventCb(self, MainController.instance, MainEvent.SetMainViewRootVisible, self._setViewRootVisible, self)
	self.addEventCb(self, MainController.instance, MainEvent.ForceStopVoice, self._forceStopVoice, self)
	self.addEventCb(self, MainController.instance, MainEvent.SetHeroInScene, self._onSetHeroInScene, self)
	self.addEventCb(self, MainSceneSwitchController.instance, MainSceneSwitchEvent.StartSwitchScene, self._onStartSwitchScene, self, LuaEventSystem.High)
	self.addEventCb(self, MainSceneSwitchController.instance, MainSceneSwitchEvent.SwitchSceneFinish, self._onSwitchSceneFinish, self)
	self.addEventCb(self, StoryController.instance, StoryEvent.Start, self._onStart, self)
	self.addEventCb(self, StoryController.instance, StoryEvent.Finish, self._onFinish, self)
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self)
	self.addEventCb(self, GameSceneMgr.instance, SceneEventName.DelayCloseLoading, self._onDelayCloseLoading, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onLoadingCloseView, self, LuaEventSystem.High)
	self.addEventCb(self, LoginController.instance, LoginEvent.OnBeginLogout, self._onBeginLogout, self)
	self.addEventCb(self, PlayerCardController.instance, PlayerCardEvent.RefreshMainHeroSkin, self._onRefreshMainHeroSkin, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.MainHeroGmPlayVoice, self._onMainHeroGmPlayVoice, self)
	self.addEventCb(self, CharacterVoiceController.instance, CharacterVoiceEvent.XRAnInteractionStart, self._onXRAnInteractionStart, self)

	self._canvasGroupForVoice = gohelper.onceAddComponent(self.viewGO, typeof(UnityEngine.CanvasGroup))
end

function MainHeroView:_onXRAnInteractionStart()
	self._animator:Play("mainview_out", 0, 0)
end

function MainHeroView:_onMainHeroGmPlayVoice(voiceId)
	local config = lua_character_voice.configDict[self._curHeroId][voiceId]

	if not config then
		logError(string.format("MainHeroView:_onMainHeroGmPlayVoice heroId:%s voiceId:%s not config", self._curHeroId, voiceId))

		return
	end

	if not string.find(config.skins, self._curSkinId) then
		logError(string.format("MainHeroView:_onMainHeroGmPlayVoice heroId:%s voiceId:%s skinId:%s 皮肤不匹配", self._curHeroId, voiceId, self._curSkinId))

		return
	end

	self:clickPlayVoice(config)
end

function MainHeroView:_onScreenResize()
	self:_repeatSetSpineScale()
end

function MainHeroView:_onStart(storyId)
	if CharacterVoiceEnum.MainViewIgnoreStory[storyId] then
		return
	end

	if self._lightSpine then
		if not self._showInScene then
			self:_setStencil(true)
		end

		self._isSpineCleared = true

		self:_onStopVoice()
		self._lightSpine:clear()

		self._spineGo = nil
		self._spineTransform = nil
		self._spineMaterial = nil

		WeatherController.instance:clearMat()
	end
end

function MainHeroView:_onFinish(storyId)
	if CharacterVoiceEnum.MainViewIgnoreStory[storyId] then
		return
	end

	if not self._isSpineCleared then
		return
	end

	self._isSpineCleared = false
	self._storyFinish = true
	self._curHeroId, self._curSkinId = CharacterSwitchListModel.instance:getMainHero()

	if self._curHeroId and self._curSkinId then
		self:_updateHero(self._curHeroId, self._curSkinId)
	end
end

function MainHeroView:_onBeginLogout()
	self:_clearEvents()
end

function MainHeroView:_onLoadingCloseView(viewName)
	if viewName == ViewName.LoadingView then
		local isOpenMainThumbnailView = ViewMgr.instance:isOpen(ViewName.MainThumbnailView)

		if self._canvasGroup then
			self._canvasGroup.alpha = 1
			self._canvasGroup = nil

			if not isOpenMainThumbnailView then
				self._animator:Play("mainview_in", 0, 0)
				MainController.instance:dispatchEvent(MainEvent.PlayOpenAnim)
			end
		end

		self:_checkPlayGreetingVoices()
	end
end

function MainHeroView:_onDelayCloseLoading()
	local canvasGroup = gohelper.onceAddComponent(self.viewGO, typeof(UnityEngine.CanvasGroup))

	canvasGroup.alpha = 0
	self._canvasGroup = canvasGroup
end

function MainHeroView:_onShowMainThumbnailView()
	local canvasGroup = gohelper.onceAddComponent(self.viewGO, typeof(UnityEngine.CanvasGroup))

	canvasGroup.alpha = 0
end

function MainHeroView:_changeMainHeroSkin(skinCo, showInScene, skipUseOffset)
	if not ViewMgr.instance:isOpen(ViewName.SkinOffsetAdjustView) and not ViewMgr.instance:isOpen(ViewName.GMToolView) then
		return
	end

	self._changeShowInScene = showInScene

	if self._lightSpine then
		self:_onStopVoice()
	end

	self:_updateHero(skinCo.characterId, skinCo.id, skipUseOffset)
end

function MainHeroView:_onRefreshMainHeroSkin()
	self._curHeroId, self._curSkinId = CharacterSwitchListModel.instance:getMainHero()

	if self._curHeroId and self._curSkinId then
		self:_updateHero(self._curHeroId, self._curSkinId)
	end
end

function MainHeroView:_onSpineLoaded()
	if self._storyFinish then
		self._storyFinish = nil

		self:_setShowInScene(true)
	end

	if not ViewMgr.instance:isOpen(ViewName.SkinOffsetAdjustView) then
		return
	end

	self:_setShowInScene(self._changeShowInScene)
end

function MainHeroView:_setViewVisible(value)
	self._mainViewVisible = value
	self._changeTime = Time.realtimeSinceStartup
end

function MainHeroView:_onSceneClose()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseFullView, self._onCloseFullView, self)
end

function MainHeroView:_onClickSwitchRole()
	self:checkSwitchShowInScene()
end

function MainHeroView:checkSwitchShowInScene()
	if not self._showInScene then
		self:_setShowInScene(true)

		if self._lightSpine then
			self._lightSpine:fadeIn()
		end
	end
end

function MainHeroView:_onWeatherPlayVoice(param)
	if not PlayerModel.instance:getMainThumbnail() then
		return
	end

	if self:isPlayingVoice() or not self:isShowInScene() then
		return
	end

	param[2] = true

	self:playVoice(param[1])
end

function MainHeroView:_onWeatherLoadPhotoFrameBg()
	self:loadPhotoFrameBg()
end

function MainHeroView:_onWeatherOnRoleBlend(param)
	self:onRoleBlend(param[1], param[2])
	self:_updateMainColor()
end

function MainHeroView:_setViewRootVisible(value)
	if not value and self._lightSpine then
		self:_onStopVoice()
	end
end

function MainHeroView:_updateMainColor()
	if not self._lightSpine then
		return
	end

	if self._showInScene then
		local color = WeatherController.instance:getMainColor()

		self._lightSpine:setMainColor(color)
		self._lightSpine:setLumFactor(WeatherEnum.HeroInSceneLumFactor)
	else
		local curLightMode = WeatherController.instance:getCurLightMode()

		if not curLightMode then
			return
		end

		local color = WeatherEnum.HeroInFrameColor[curLightMode]

		self._lightSpine:setMainColor(color)
		self._lightSpine:setLumFactor(WeatherEnum.HeroInFrameLumFactor[curLightMode])
	end
end

function MainHeroView:_onStartSwitchScene()
	if not self._showInScene then
		self:_setShowInScene(true)
	end
end

function MainHeroView:_onSwitchSceneFinish()
	self:_initFrame()
end

function MainHeroView:_initFrame()
	self._frameBg = nil
	self._frameSpineNode = nil
	self._frameBg = weatherController:getSceneNode("s01_obj_a/Anim/Drawing/s01_xiangkuang_d_back")

	if not self._frameBg then
		logError("_initFrame no frameBg")
	end

	local spineMountPoint = weatherController:getSceneNode("s01_obj_a/Anim/Drawing/spine")

	if spineMountPoint then
		self._frameSpineNode = spineMountPoint.transform
	else
		logError("_initFrame no spineMountPoint")
	end

	gohelper.setActive(self._frameBg, false)

	self._frameSpineNodeX = 3.11
	self._frameSpineNodeY = 0.51
	self._frameSpineNodeZ = 3.09
	self._frameSpineNodeScale = 0.39

	local bgRenderer = self._frameBg:GetComponent(typeof(UnityEngine.Renderer))

	self._frameBgMaterial = UnityEngine.Material.Instantiate(bgRenderer.sharedMaterial)
	bgRenderer.material = self._frameBgMaterial
end

function MainHeroView:_editableInitView()
	self:_clearTrackMainHeroInteractionData()
	self:_enableKeyword()

	self._skinInteraction = nil
	self._curHeroId, self._curSkinId = CharacterSwitchListModel.instance:getMainHero()

	if self._curHeroId and self._curSkinId then
		self:_updateHero(self._curHeroId, self._curSkinId)
	end

	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._cameraAnimator = CameraMgr.instance:getCameraRootAnimator()
	self._click = SLFramework.UGUI.UIClickListener.Get(self._golightspinecontrol)

	self._click:AddClickDownListener(self._clickDown, self)

	self._drag = SLFramework.UGUI.UIDragListener.Get(self._golightspinecontrol)

	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._drag:AddDragListener(self._onDrag, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)
	self.addEventCb(self, GameStateMgr.instance, GameStateEvent.OnTouchScreenUp, self._onTouch, self)

	self._showInScene = true

	self:_initFrame()

	local _shader = UnityEngine.Shader

	self._TintColorId = _shader.PropertyToID("_TintColor")

	self:_repeatSetSpineScale()
end

function MainHeroView:_setSpineScale()
	MainHeroView.setSpineScale(self._gospinescale)
end

function MainHeroView:_repeatSetSpineScale()
	self:_setSpineScale()
	TaskDispatcher.cancelTask(self._setSpineScale, self)
	TaskDispatcher.runRepeat(self._setSpineScale, self, 0.1, 5)
end

function MainHeroView.setSpineScale(go)
	local scale = GameUtil.getAdapterScale()

	transformhelper.setLocalScale(go.transform, scale, scale, scale)
end

function MainHeroView:showInScene()
	if not self._spineMaterial then
		return
	end

	self._lightSpine:setEffectFrameVisible(true)
	self:_setStencil(true)

	self._spineTransform.parent = self._golightspine.transform

	transformhelper.setLocalScale(self._spineTransform, 1, 1, 1)
	transformhelper.setLocalPos(self._spineTransform, 0, 0, 0)
	transformhelper.setLocalRotation(self._spineGo.transform, 0, 0, 0)
	gohelper.setLayer(self._spineGo, UnityLayer.Unit, true)
	gohelper.setActive(self._frameBg, false)
	weatherController:setRoleMaskEnabled(true)
	weatherController:setStateByString("Photo_album", "no")
	self:_updateMainColor()
end

function MainHeroView:showInFrame()
	if not self._spineMaterial then
		return
	end

	self._lightSpine:setEffectFrameVisible(false)
	self:_setStencil(false)
	transformhelper.setLocalScale(self._frameSpineNode, 1, 1, 1)
	transformhelper.setLocalPos(self._frameSpineNode, 0, 0, 0)

	self._spineTransform.parent = self._frameSpineNode

	local scale = transformhelper.getLocalScale(self._spineTransform)

	transformhelper.setLocalScale(self._spineTransform, scale, scale, scale)
	transformhelper.setLocalRotation(self._spineTransform, 0, 0, 0)

	local offsetX = self._frameSpineNodeX
	local offsetY = self._frameSpineNodeY
	local offsetScale = self._frameSpineNodeScale

	if not string.nilorempty(self._heroSkinConfig.mainViewFrameOffset) then
		local offsetParam = SkinConfig.instance:getSkinOffset(self._heroSkinConfig.mainViewFrameOffset)

		offsetX = offsetParam[1]
		offsetY = offsetParam[2]
		offsetScale = offsetParam[3]

		local sceneId = MainSceneSwitchModel.instance:getCurSceneId()
		local settingsConfig = sceneId and lua_scene_settings.configDict[sceneId]

		if settingsConfig then
			offsetX = offsetX + settingsConfig.spineOffset[1]
			offsetY = offsetY + settingsConfig.spineOffset[2]
		end
	end

	transformhelper.setLocalScale(self._frameSpineNode, offsetScale, offsetScale, offsetScale)
	transformhelper.setLocalPos(self._frameSpineNode, offsetX, offsetY, self._frameSpineNodeZ)
	gohelper.setLayer(self._spineGo, UnityLayer.Scene, true)

	if not self:loadPhotoFrameBg() then
		gohelper.setActive(self._frameBg, true)
	end

	weatherController:setRoleMaskEnabled(false)
	weatherController:setStateByString("Photo_album", "yes")
	self:_updateMainColor()
end

function MainHeroView:loadPhotoFrameBg()
	if self._showInScene then
		return false
	end

	if self._curLightMode then
		return false
	end

	local curLightMode = weatherController:getCurLightMode()

	if not curLightMode or self._curLightMode == curLightMode then
		return false
	end

	self._curLightMode = curLightMode

	if self._photoFrameBgLoader then
		self._photoFrameBgLoader:dispose()

		self._photoFrameBgLoader = nil
	end

	local loader = MultiAbLoader.New()

	self._photoFrameBgLoader = loader

	local sceneId = MainSceneSwitchModel.instance:getCurSceneId()
	local path = WeatherFrameComp.getFramePath(sceneId)

	loader:addPath(path)
	loader:startLoad(function()
		local assetItem = loader:getAssetItem(path)
		local texture = assetItem:GetResource(path)

		self._frameBgMaterial:SetTexture("_MainTex", texture)
		gohelper.setActive(self._frameBg, true)
	end)

	return true
end

function MainHeroView:onRoleBlend(value, isEnd)
	if not self._targetFrameTintColor then
		local curLightMode = weatherController:getCurLightMode()
		local prevLightMode = weatherController:getPrevLightMode() or curLightMode

		if not curLightMode then
			return
		end

		local sceneId = MainSceneSwitchModel.instance:getCurSceneId()

		self._targetFrameTintColor = WeatherFrameComp.getFrameColor(sceneId, curLightMode)
		self._srcFrameTintColor = WeatherFrameComp.getFrameColor(sceneId, prevLightMode)

		self._frameBgMaterial:EnableKeyword("_COLORGRADING_ON")
	end

	self._frameBgMaterial:SetColor(self._TintColorId, weatherController:lerpColorRGBA(self._srcFrameTintColor, self._targetFrameTintColor, value))

	if isEnd then
		local alphaValue = self._targetFrameTintColor.a

		self._targetFrameTintColor = nil

		if weatherController:getCurLightMode() == 1 and alphaValue and alphaValue <= 0 then
			self._frameBgMaterial:DisableKeyword("_COLORGRADING_ON")
		end
	end
end

function MainHeroView:_updateHero(heroId, skinId, skipUseOffset)
	self._anchorMinPos = nil
	self._anchorMaxPos = nil
	self._heroId = heroId
	self._skinId = skinId

	local heroConfig = HeroConfig.instance:getHeroCO(self._heroId)
	local skinCo = SkinConfig.instance:getSkinCo(self._skinId or heroConfig and heroConfig.skin)

	if not skinCo then
		self:_updateTrackInfoSkinId(nil)

		return
	end

	self._heroPhotoFrameBg = heroConfig.photoFrameBg
	self._heroSkinConfig = skinCo
	self._heroSkinTriggerArea = {}

	self:_updateTrackInfoSkinId(skinCo.id)

	if not skipUseOffset then
		local offsetParam = SkinConfig.instance:getSkinOffset(skinCo.mainViewOffset)
		local transform = self._golightspine.transform

		recthelper.setAnchor(transform, tonumber(offsetParam[1]), tonumber(offsetParam[2]))

		local scale = tonumber(offsetParam[3])

		transform.localScale = Vector3.one * scale
	end

	self._lightSpine = self._lightSpine or LightModelAgent.Create(self._golightspine, true)
	self._defaultStencilValue = not string.nilorempty(skinCo.defaultStencilValue) and string.splitToNumber(skinCo.defaultStencilValue, "#") or nil
	self._frameStencilValue = not string.nilorempty(skinCo.frameStencilValue) and string.splitToNumber(skinCo.frameStencilValue, "#") or nil

	self._lightSpine:setResPath(skinCo, self._onLightSpineLoaded, self)
	self._lightSpine:setInMainView()
	self._lightSpine:setBodyChangeCallback(self._onBodyChange, self)
end

function MainHeroView:_onBodyChange(prevBodyName, curBodyName)
	if self._skinInteraction then
		self._skinInteraction:onBodyChange(prevBodyName, curBodyName)
	end
end

function MainHeroView:_setStencil(inScene)
	if inScene then
		if self._defaultStencilValue then
			self._lightSpine:setStencilValues(self._defaultStencilValue[1], self._defaultStencilValue[2], self._defaultStencilValue[3])
		else
			self._lightSpine:setStencilRef(0)
		end
	elseif self._frameStencilValue then
		self._lightSpine:setStencilValues(self._frameStencilValue[1], self._frameStencilValue[2], self._frameStencilValue[3])
	else
		self._lightSpine:setStencilRef(1)
	end
end

function MainHeroView:_checkPlayGreetingVoices()
	if LimitedRoleController.instance:isPlaying() then
		return
	end

	local isOpenMainThumbnailView = ViewMgr.instance:isOpen(ViewName.MainThumbnailView)

	if self._needPlayGreeting and not ViewMgr.instance:isOpen(ViewName.LoadingView) and not isOpenMainThumbnailView then
		self:_playGreetingVoices()
	end
end

function MainHeroView:_playGreetingVoices()
	local greetingVoices = HeroModel.instance:getVoiceConfig(self._heroId, CharacterEnum.VoiceType.Greeting, nil, self._skinId)

	if greetingVoices and #greetingVoices > 0 then
		self:_onWeatherPlayVoice({
			greetingVoices[1]
		})
	end
end

function MainHeroView:_onLightSpineLoaded()
	TaskDispatcher.cancelTask(self._delayInitLightSpine, self)
	TaskDispatcher.runDelay(self._delayInitLightSpine, self, 0.1)
end

function MainHeroView:_delayInitLightSpine()
	self._spineGo = self._lightSpine:getSpineGo()

	if gohelper.isNil(self._spineGo) then
		return
	end

	callWithCatch(self._initSkinInteraction, self)

	self._spineTransform = self._spineGo.transform

	local renderer = self._lightSpine:getRenderer()

	self._spineMaterial = renderer.sharedMaterial

	self:_setStencil(true)
	WeatherController.instance:setLightModel(self._lightSpine)

	if not self._firstLoadSpine then
		self._firstLoadSpine = true

		if PlayerModel.instance:getMainThumbnail() then
			-- block empty
		end

		local hasOpenFullView = ViewMgr.instance:hasOpenFullView()
		local playWeatherVoice = not hasOpenFullView

		if MainController.instance.firstEnterMainScene then
			MainController.instance.firstEnterMainScene = false
			playWeatherVoice = false

			if not hasOpenFullView then
				self._needPlayGreeting = true

				self:_checkPlayGreetingVoices()
			end
		end

		weatherController:initRoleGo(self._spineGo, self._heroId, self._spineMaterial, playWeatherVoice, self._skinId)
	else
		local param = {
			heroPlayWeatherVoice = true,
			roleGo = self._lightSpine:getSpineGo(),
			heroId = self._heroId,
			sharedMaterial = self._spineMaterial,
			skinId = self._skinId
		}

		weatherController:changeRoleGo(param)
	end

	local noInteractiveComp = self.viewContainer:getNoInteractiveComp()

	noInteractiveComp:init()
	self:_onSpineLoaded()
end

function MainHeroView:isPlayingVoice()
	if not self._lightSpine then
		return false
	end

	if self._skinInteraction and self._skinInteraction:isPlayingVoice() then
		return true
	end

	return self._lightSpine:isPlayingVoice()
end

function MainHeroView:getLightSpine()
	return self._lightSpine
end

function MainHeroView:isShowInScene()
	return self._showInScene
end

function MainHeroView:checkSpecialTouchByKey(id, pos, areaIndex)
	local key = "triggerArea" .. id
	local areaList = self._heroSkinTriggerArea[key]

	if not areaList then
		areaList = {}
		self._heroSkinTriggerArea[key] = areaList

		local triggerAreaStr = self._heroSkinConfig[key]
		local triggerAreaList = string.split(triggerAreaStr, "_")

		for i, v in ipairs(triggerAreaList) do
			local paramList = string.split(v, "|")

			if #paramList == 2 then
				local startPos = string.split(paramList[1], "#")
				local endPos = string.split(paramList[2], "#")
				local startX = tonumber(startPos[1])
				local startY = tonumber(startPos[2])
				local endX = tonumber(endPos[1])
				local endY = tonumber(endPos[2])
				local area = {
					startX,
					startY,
					endX,
					endY
				}

				table.insert(areaList, area)
			end
		end
	end

	for i, v in ipairs(areaList) do
		local startX = tonumber(v[1])
		local startY = tonumber(v[2])
		local endX = tonumber(v[3])
		local endY = tonumber(v[4])

		if pos and (not areaIndex or areaIndex == i) and startX <= pos.x and endX >= pos.x and startY >= pos.y and endY <= pos.y then
			self:_updateTrackInfoAreaId(tonumber(id))

			return true
		end
	end

	return false
end

function MainHeroView:_checkSpecialTouch(config, pos)
	return self:checkSpecialTouchByKey(config.param, pos)
end

function MainHeroView:_onTouch()
	if not LimitedRoleController.instance:isPlaying() and self._mainViewVisible == false and Time.realtimeSinceStartup - self._changeTime > 0.5 then
		TaskDispatcher.runDelay(self._delayCheckShowMain, self, 0.01)
	end
end

function MainHeroView:_delayCheckShowMain()
	if not LimitedRoleController.instance:isPlaying() and self._mainViewVisible == false and Time.realtimeSinceStartup - self._changeTime > 0.5 then
		MainController.instance:dispatchEvent(MainEvent.SetMainViewVisible, true)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_main_display)
	end
end

function MainHeroView:_onDragBegin(param, pointerEventData)
	if self._skinInteraction and self._skinInteraction:needRespond() then
		self._dragSpecialRespond = self:_getDragSpecialRespond(CharacterEnum.VoiceType.MainViewDragSpecialRespond)

		if not self._dragSpecialRespond then
			return
		end

		if self._skinInteraction:isCustomDrag() then
			local canDrag = self._skinInteraction:beforeBeginDrag(self, self._dragSpecialRespond, self._heroSkinConfig)

			if not canDrag then
				return
			end

			self._skinInteraction:beginDrag()

			return
		end

		self:_checkSpecialTouch(self._dragSpecialRespond)

		local key = "triggerArea" .. self._dragSpecialRespond.param
		local areaList = self._heroSkinTriggerArea[key]

		self._dragArea = areaList[1]

		local param2 = self._dragSpecialRespond.param2
		local param2List = string.split(param2, "#")

		self._dragParamName = param2List[1]
		self._dragParamMinValue = tonumber(param2List[2])
		self._dragParamMaxValue = tonumber(param2List[3])
		self._dragParamLength = self._dragParamMaxValue - self._dragParamMinValue
		self._dragParamIndex = self._lightSpine:addParameter(self._dragParamName, 0, self._dragParamMinValue)

		self._skinInteraction:beginDrag()
		AudioMgr.instance:trigger(AudioEnum.UI.hero3100_mainsfx_mic_drag)
	end
end

function MainHeroView:_onDrag(param, pointerEventData)
	if not self._dragSpecialRespond then
		return
	end

	local pos = recthelper.screenPosToAnchorPos(GamepadController.instance:getMousePosition(), self._golightspinecontrol.transform)

	if self._skinInteraction:isCustomDrag() then
		self._skinInteraction:beforeOnDrag(pos)

		return
	end

	local startX = self._dragArea[1]
	local startY = self._dragArea[2]
	local endX = self._dragArea[3]
	local endY = self._dragArea[4]

	if pos and startX <= pos.x and endX >= pos.x and startY >= pos.y and endY <= pos.y then
		local value = pos.x - startX
		local percent = value / (endX - startX)
		local percentValue = self._dragParamMinValue + percent * self._dragParamLength

		self._lightSpine:updateParameter(self._dragParamIndex, percentValue)

		if percentValue >= self._dragParamMaxValue - 5 then
			local specialRespond = self._dragSpecialRespond

			self:_onDragEnd()
			self:_doClickPlayVoice(specialRespond)
		end
	end
end

function MainHeroView:_onDragEnd()
	if self._dragParamName then
		self._lightSpine:removeParameter(self._dragParamName)

		self._dragParamName = nil
	end

	if self._skinInteraction:isCustomDrag() then
		self._skinInteraction:beforeEndDrag()
	end

	if self._dragSpecialRespond and self._skinInteraction then
		self._skinInteraction:endDrag()
	end

	self._dragSpecialRespond = nil
end

function MainHeroView:_clickDown()
	if self._mainViewVisible == false then
		return
	end

	MainController.instance:dispatchEvent(MainEvent.ClickDown)

	if not self._showInScene then
		return
	end

	if gohelper.isNil(self._spineGo) then
		return
	end

	local pos = recthelper.screenPosToAnchorPos(GamepadController.instance:getMousePosition(), self._golightspinecontrol.transform)

	self:_initSkinInteraction()
	self._skinInteraction:onClick(pos)
end

function MainHeroView:_initSkinInteraction()
	local oldSkinInteraction = self._skinInteraction

	if oldSkinInteraction and oldSkinInteraction:getSkinId() ~= self._skinId then
		oldSkinInteraction:onDestroy()

		self._skinInteraction = nil
	end

	if not self._skinInteraction then
		self._skinInteraction = self:getSkinInteraction(self._skinId)

		self._skinInteraction:init(self, self._skinId)
	end
end

function MainHeroView:getSkinInteraction(skinId)
	if skinId == 303301 or skinId == 303302 then
		return TTTSkinInteraction.New()
	end

	local clsName = CharacterVoiceEnum.SkinInteraction[skinId]
	local cls = clsName and _G[clsName]

	if cls then
		return cls.New()
	end

	return CommonSkinInteraction.New()
end

function MainHeroView:_clickDefault(pos)
	self:_updateTrackInfoAreaId(nil)

	local interactionConfig = self:_getSpecialInteraction()

	if interactionConfig and self:_checkPosInBound(pos) and self._skinInteraction:canPlay(interactionConfig) then
		local params = string.splitToNumber(interactionConfig.param, "#")

		if math.random() * 100 < params[1] then
			CharacterVoiceController.instance:setSpecialInteractionPlayType(CharacterVoiceEnum.PlayType.Click)
			self:_doClickPlayVoice(interactionConfig)

			return
		end
	end

	if self._skinInteraction:needRespond() then
		local specialRespondConfig = self:_getSpecialTouch(CharacterEnum.VoiceType.MainViewSpecialRespond, pos)

		if specialRespondConfig and self._skinInteraction:canPlay(specialRespondConfig) then
			local specialRespondConfig2 = self._skinInteraction:selectFromGroup(specialRespondConfig)

			self:_doClickPlayVoice(specialRespondConfig2)
		end

		return
	end

	local specialConfig = self:_getSpecialTouch(CharacterEnum.VoiceType.MainViewSpecialTouch, pos)

	if specialConfig and math.random() > 0.5 and self._skinInteraction:canPlay(specialConfig) then
		local config = MainHeroView.getRandomMultiVoice(specialConfig, self._heroId, self._skinId)

		self:_doClickPlayVoice(config, true)

		return
	end

	local normalConfig = self:_getNormalTouch(pos)

	if normalConfig and self._skinInteraction:canPlay(normalConfig) then
		self:_doClickPlayVoice(normalConfig, true)
	end
end

function MainHeroView:_getSpecialInteraction(type)
	local voices = HeroModel.instance:getVoiceConfig(self._heroId, type or CharacterEnum.VoiceType.MainViewSpecialInteraction, function(config)
		return self._clickPlayConfig ~= config
	end, self._skinId)

	if voices and #voices > 0 then
		local index = math.random(1, #voices)

		return voices[index] or voices[1]
	end
end

function MainHeroView:_getDragSpecialRespond(type)
	local voices = HeroModel.instance:getVoiceConfig(self._heroId, type or CharacterEnum.VoiceType.MainViewSpecialInteraction, function(config)
		return self._clickPlayConfig ~= config and not string.nilorempty(config.param2)
	end, self._skinId)

	if voices and #voices > 0 then
		return voices[1]
	end
end

function MainHeroView:_getSpecialTouch(type, pos)
	local specialVoices = HeroModel.instance:getVoiceConfig(self._heroId, type, function(config)
		return self._clickPlayConfig ~= config and self:_checkSpecialTouch(config, pos)
	end, self._skinId)

	if specialVoices and #specialVoices > 0 then
		return specialVoices[1]
	end
end

function MainHeroView:_getNormalTouch(pos)
	if self:_checkPosInBound(pos) then
		local normalVoices = HeroModel.instance:getVoiceConfig(self._heroId, CharacterEnum.VoiceType.MainViewNormalTouch, function(config)
			return self._clickPlayConfig ~= config
		end, self._skinId)
		local config = MainHeroView.getHeightWeight(normalVoices)

		return MainHeroView.getRandomMultiVoice(config, self._heroId, self._skinId)
	end
end

function MainHeroView.getRandomMultiVoice(config, heroId, skinId)
	if not config then
		return
	end

	local needRandom = math.random() <= 0.5

	if needRandom then
		local list = CharacterDataConfig.instance:getCharacterTypeVoicesCO(heroId, CharacterEnum.VoiceType.MultiVoice, skinId)

		for i, v in ipairs(list) do
			if tonumber(v.param) == config.audio then
				return v
			end
		end
	end

	return config
end

function MainHeroView:_checkPosInBound(pos)
	if not self._anchorMinPos or not self._anchorMaxPos then
		local minPos, maxPos = self._lightSpine:getBoundsMinMaxPos()

		self._anchorMinPos = recthelper.worldPosToAnchorPos(Vector3(minPos.x, maxPos.y, minPos.z), self._golightspinecontrol.transform, CameraMgr.instance:getUICamera(), CameraMgr.instance:getUnitCamera())
		self._anchorMaxPos = recthelper.worldPosToAnchorPos(Vector3(maxPos.x, minPos.y, maxPos.z), self._golightspinecontrol.transform, CameraMgr.instance:getUICamera(), CameraMgr.instance:getUnitCamera())
	end

	local anchorMinPos = self._anchorMinPos
	local anchorMaxPos = self._anchorMaxPos

	if pos.x >= anchorMinPos.x and pos.x <= anchorMaxPos.x and pos.y <= anchorMinPos.y and pos.y >= anchorMaxPos.y then
		return true
	end
end

function MainHeroView:addFaith()
	if HeroModel.instance:getTouchHeadNumber() <= 0 then
		return
	end

	HeroRpc.instance:sendTouchHeadRequest(self._heroId)
end

function MainHeroView:_onSuccessTouchHead(addSuccess)
	if not self._showFaithToast then
		return
	end

	self._showFaithToast = false

	if addSuccess then
		GameFacade.showToast(ToastEnum.MainHeroAddSuccess)
	else
		GameFacade.showToast(ToastEnum.MainHeroAddFail)
	end
end

function MainHeroView.getHeightWeight(configList)
	if configList and #configList > 0 then
		local weight = 0

		for i, v in ipairs(configList) do
			weight = weight + v.param
		end

		local propValue = math.random()
		local calcValue = 0

		for i, v in ipairs(configList) do
			calcValue = calcValue + v.param

			if propValue <= calcValue / weight then
				return v
			end
		end
	end

	return nil
end

function MainHeroView:_doClickPlayVoice(config, showFaithToast)
	self._showFaithToast = showFaithToast

	self:addFaith()
	self:clickPlayVoice(config)
end

function MainHeroView:clickPlayVoice(config)
	self._clickPlayConfig = config

	self:playVoice(config)
end

function MainHeroView:_onStopVoice()
	self._lightSpine:stopVoice()

	if self._skinInteraction then
		self._skinInteraction:onStopVoice()
	end
end

function MainHeroView:_initVoiceEffects(config)
	if string.nilorempty(config.effects) then
		return
	end

	self:_resetVoiceEffects()

	local voiceEffects = string.splitToNumber(config.effects, "|")
	local effectParams = GameUtil.splitString2(config.effectParams, true, "|", "#")

	self._voiceEffects = {}

	local lang
	local targetIndex = GameLanguageMgr.instance:getStoryIndexByShortCut(AudioConfig.instance:getAudioCOById(config.audio) and AudioMgr.instance:getLangByAudioId(config.audio) or AudioMgr.instance:getCurLang())

	for i, effectType in ipairs(voiceEffects) do
		local duration = effectParams[i][targetIndex]

		if duration then
			self._voiceEffects[effectType] = {
				endTime = Time.time + duration
			}

			if effectType == CharacterVoiceEnum.EffectsType.HideMainView then
				self._animator:Play("mainview_out", 0, 0)
			elseif effectType == CharacterVoiceEnum.EffectsType.RestrictedInteraction then
				self._canvasGroupForVoice.blocksRaycasts = false
			end
		else
			logError(string.format("MainHeroView _initVoiceEffects duration is nil for audio:%s effectType %s targetIndex:%s", config.audio, effectType, targetIndex))
		end
	end

	TaskDispatcher.cancelTask(self._frameCheckVoiceEffect, self)
	TaskDispatcher.runRepeat(self._frameCheckVoiceEffect, self, 0)
end

function MainHeroView:_frameCheckVoiceEffect()
	if not self._voiceEffects then
		TaskDispatcher.cancelTask(self._frameCheckVoiceEffect, self)

		return
	end

	for k, v in pairs(self._voiceEffects) do
		if Time.time >= v.endTime then
			if k == CharacterVoiceEnum.EffectsType.HideMainView then
				self._animator:Play("mainview_in", 0, 0)
			elseif k == CharacterVoiceEnum.EffectsType.RestrictedInteraction then
				self._canvasGroupForVoice.blocksRaycasts = true
			end

			self._voiceEffects[k] = nil
		end
	end

	if next(self._voiceEffects) == nil then
		TaskDispatcher.cancelTask(self._frameCheckVoiceEffect, self)
	end
end

function MainHeroView:_resetVoiceEffects()
	if not self._voiceEffects then
		return
	end

	if self._voiceEffects[CharacterVoiceEnum.EffectsType.HideMainView] then
		self._animator:Play("mainview_in", 0, 0)
	end

	if self._voiceEffects[CharacterVoiceEnum.EffectsType.RestrictedInteraction] then
		self._canvasGroupForVoice.blocksRaycasts = true
	end

	self._voiceEffects = nil
end

function MainHeroView:playVoice(config)
	if not self._lightSpine then
		return
	end

	if self._skinInteraction then
		self._skinInteraction:beforePlayVoice(config)
	end

	self._lightSpine:setSkipBodyEffect(true)
	self:_onStopVoice()
	self._lightSpine:setSkipBodyEffect(false)

	if self._skinInteraction then
		self:_initVoiceEffects(config)
		self._skinInteraction:onPlayVoice(config)
	end

	self._lightSpine:playVoice(config, function()
		if self._skinInteraction then
			self._skinInteraction:playVoiceFinish(config)
		end

		self._interactionStartTime = Time.time
		self._specialIdleStartTime = Time.time
	end, self._txtanacn, self._txtanaen, self._gocontentbg)

	if self._skinInteraction then
		self._skinInteraction:afterPlayVoice(config)
	end

	self:_trackMainHeroInteraction(config and config.audio)
end

function MainHeroView:onlyPlayVoice(config)
	self:_onStopVoice()
	self._lightSpine:playVoice(config, function()
		self._interactionStartTime = Time.time
		self._specialIdleStartTime = Time.time
	end, self._txtanacn, self._txtanaen, self._gocontentbg)
end

function MainHeroView:_enableKeyword()
	UnityEngine.Shader.EnableKeyword("_MAININTERFACELIGHT")

	BaseLive2d.enableMainInterfaceLight = true
end

function MainHeroView:_disableKeyword()
	UnityEngine.Shader.DisableKeyword("_MAININTERFACELIGHT")

	BaseLive2d.enableMainInterfaceLight = false
end

function MainHeroView:_onOpenFullView(viewName)
	if viewName == ViewName.CharacterSkinTipView then
		self:_disableKeyword()
	end
end

function MainHeroView:_getSwitchViewName()
	return ViewName.MainSwitchView
end

function MainHeroView:_onOpenFullViewFinish(viewName)
	if viewName ~= self:_getSwitchViewName() then
		self:_disableKeyword()
	end

	self:_hideModelEffect()
	weatherController:setStateByString("Photo_album", "no")
end

function MainHeroView:_checkLightSpineVisible(time)
	local hasOpenFullView = ViewMgr.instance:hasOpenFullView()

	TaskDispatcher.cancelTask(self._hideLightSpineVisible, self)

	if hasOpenFullView then
		if self._golightspine.activeSelf then
			TaskDispatcher.runDelay(self._hideLightSpineVisible, self, time or 1)
		end
	else
		gohelper.setActive(self._golightspine, true)
	end
end

function MainHeroView:_hideLightSpineVisible()
	gohelper.setActive(self._golightspine, false)
end

function MainHeroView:_isViewGOActive()
	return self.viewGO.activeSelf and self.viewGO.activeInHierarchy
end

function MainHeroView:_hasOpenFullView()
	for _, viewName in ipairs(ViewMgr.instance:getOpenViewNameList()) do
		local setting = ViewMgr.instance:getSetting(viewName)

		if setting and (setting.viewType == ViewType.Full or setting.bgBlur) then
			return true
		end
	end
end

function MainHeroView:_activationSettings()
	self:_enableKeyword()
end

function MainHeroView:_hideModelEffect()
	TaskDispatcher.cancelTask(self._showModelEffect, self)

	if self._lightSpine then
		self._lightSpine:setEffectVisible(false)
	end
end

function MainHeroView:_showModelEffect()
	if self._lightSpine and self._showInScene then
		self._lightSpine:setEffectVisible(true)
	end
end

function MainHeroView:_delayShowModelEffect()
	self:_hideModelEffect()
	TaskDispatcher.runDelay(self._showModelEffect, self, 0.1)
end

function MainHeroView:_onCloseFullView(viewName)
	if ViewMgr.instance:isOpen(ViewName.MainThumbnailView) then
		if not ViewMgr.instance:hasOpenFullView() then
			self:_delayShowModelEffect()
		end

		return
	end

	if not self:_isViewGOActive() then
		return
	end

	if MainSceneSwitchController.instance:isSwitching() then
		return
	end

	if not self:_hasOpenFullView() then
		self:_activationSettings()

		if self._lightSpine then
			self._lightSpine:processModelEffect()
		end

		self:_delayShowModelEffect()

		local showInScene = self._showInScene

		if showInScene then
			if math.random() < 0.1 then
				showInScene = not showInScene
			end
		elseif math.random() < 0.7 then
			showInScene = not showInScene
		end

		if ViewMgr.instance:isOpen(ViewName.SkinOffsetAdjustView) then
			showInScene = true
		end

		if not showInScene then
			local animator = self._cameraAnimator

			if animator.runtimeAnimatorController and animator.enabled then
				showInScene = true
			end
		end

		if GuideModel.instance:getDoingGuideId() and not GuideController.instance:isForbidGuides() then
			showInScene = true
		end

		if self._skinInteraction then
			self._skinInteraction:onCloseFullView()
		end

		if showInScene then
			self:_playWelcomeVoice()
			weatherController:resetWeatherChangeVoiceFlag()
		end

		if showInScene == self._showInScene then
			weatherController:setStateByString("Photo_album", showInScene and "no" or "yes")

			return
		end

		self:_setShowInScene(showInScene)
	end
end

function MainHeroView:_setShowInScene(showInScene)
	self._showInScene = showInScene

	if self._showInScene then
		self:showInScene()
	else
		self:showInFrame()
	end

	MainController.instance:dispatchEvent(MainEvent.HeroShowInScene, self._showInScene)
end

function MainHeroView:_onSetHeroInScene(showInScene)
	if self._showInScene ~= showInScene then
		self:_setShowInScene(showInScene)
	end
end

function MainHeroView:debugShowMode(showInScene)
	self:_setShowInScene(showInScene)
end

function MainHeroView:_reOpenWhileOpen(viewName)
	if ViewMgr.instance:isFull(viewName) then
		self:_onOpenFullViewFinish(viewName)
	end
end

function MainHeroView:_playWelcomeVoice(force)
	if self:_hasOpenFullView() then
		return
	end

	if not force and math.random() > 0.3 then
		return false
	end

	local interactionConfig = self:_getSpecialInteraction()

	if interactionConfig then
		local params = string.splitToNumber(interactionConfig.param, "#")

		if not params[2] then
			if params[2] > math.random() * 100 then
				CharacterVoiceController.instance:setSpecialInteractionPlayType(CharacterVoiceEnum.PlayType.Auto)
				self:_initSkinInteraction()
				self:clickPlayVoice(interactionConfig)

				return true
			end
		end
	end

	local config = MainHeroView.getWelcomeLikeVoice(CharacterEnum.VoiceType.MainViewWelcome, self._heroId, self._skinId)

	if config then
		self:playVoice(config)

		return true
	end

	return false
end

function MainHeroView.getWelcomeLikeVoice(type, heroId, skinId)
	local nowDate = WeatherModel.instance:getNowDate()

	nowDate.hour = 0
	nowDate.min = 0
	nowDate.sec = 0

	local zeroTime = os.time(nowDate)
	local nowTime = os.time()
	local welcomeVoices = HeroModel.instance:getVoiceConfig(heroId, type, function(config)
		local timeList = GameUtil.splitString2(config.time, false, "|", "#")

		for i, param in ipairs(timeList) do
			if MainHeroView._checkTime(param, zeroTime, nowTime) then
				return true
			end
		end

		return false
	end, skinId)

	return (MainHeroView.getHeightWeight(welcomeVoices))
end

function MainHeroView._checkTime(param, zeroTime, nowTime)
	local timeParam = string.split(param[1], ":")
	local h = tonumber(timeParam[1])
	local m = tonumber(timeParam[2])
	local duration = tonumber(param[2])

	if not h or not m or not duration then
		return false
	end

	local startTime = zeroTime + (h * 60 + m) * 60
	local endTime = startTime + duration * 3600

	return startTime <= nowTime and nowTime <= endTime
end

function MainHeroView:_onOpenView(viewName)
	if ViewMgr.instance:isOpen(ViewName.SkinOffsetAdjustView) and viewName == ViewName.CharacterSwitchView then
		self.viewContainer:_setVisible(false)

		return
	end

	local setting = ViewMgr.instance:getSetting(viewName)

	if setting and (setting.viewType == ViewType.Full or setting.bgBlur) and self._lightSpine then
		self:_tryStopVoice()
	end

	if viewName == ViewName.MainThumbnailView then
		self._animator:Play("mainview_out", 0, 0)
		TaskDispatcher.runDelay(self._hide, self, 0.4)

		if self._tweenId then
			ZProj.TweenHelper.KillById(self._tweenId)

			self._tweenId = nil
		end

		self._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.5, self._setFactor, nil, self, nil, EaseType.Linear)

		PostProcessingMgr.instance:setUnitPPValue("dofSampleScale", Vector4.one)
		PostProcessingMgr.instance:setUnitPPValue("dofRT3Scale", 2)
		self:_tryStopVoice()
	elseif viewName == ViewName.CharacterGetView or viewName == ViewName.CharacterSkinGetDetailView then
		if self._lightSpine then
			gohelper.setActive(self._lightSpine:getSpineGo(), false)
		end
	elseif viewName == ViewName.SummonView then
		self:_hideModelEffect()
	elseif viewName == ViewName.MainSwitchView and self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

function MainHeroView:_tryStopVoice()
	if not self._lightSpine or LimitedRoleController.instance:isPlayingAction() then
		-- block empty
	else
		self:_onStopVoice()
	end
end

function MainHeroView:_forceStopVoice()
	if self._lightSpine then
		self:_onStopVoice()
	end
end

function MainHeroView:_hide()
	self.viewContainer:_setVisible(false)
end

function MainHeroView:_onCloseView(viewName)
	if viewName == ViewName.SettingsView then
		MainHeroView.setPostProcessBlur()

		return
	end

	if viewName == ViewName.SummonView then
		self:_delayShowModelEffect()
	elseif viewName == ViewName.CharacterView and self._lightSpine and self._showInScene then
		self._lightSpine:setLayer(UnityLayer.Water)
	end

	if viewName == ViewName.StoryView then
		self:_onFinish()
	end

	if not self:_hasOpenFullView() then
		self:_activationSettings()
	end
end

function MainHeroView:_onCloseViewFinish(viewName)
	if self:_isLogout() then
		return
	end

	self:_setSpineScale()

	if ViewMgr.instance:isOpen(ViewName.SkinOffsetAdjustView) and viewName == ViewName.CharacterSwitchView then
		self.viewContainer:_setVisible(true)

		return
	end

	if viewName == ViewName.MainThumbnailView then
		TaskDispatcher.cancelTask(self._hide, self)
		self.viewContainer:_setVisible(true)
		self._animator:Play("mainview_in", 0, 0)

		if self._tweenId then
			ZProj.TweenHelper.KillById(self._tweenId)

			self._tweenId = nil
		end

		self._tweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, 0.5, self._setFactor, self._resetPostProcessValue, self, nil, EaseType.Linear)

		local heroId, skinId = CharacterSwitchListModel.instance:getMainHero()

		if self._curHeroId ~= heroId and heroId or self._curSkinId ~= skinId and skinId or gohelper.isNil(self._spineGo) then
			self._curHeroId = heroId
			self._curSkinId = skinId

			self:_updateHero(self._curHeroId, self._curSkinId)
		elseif self._lightSpine then
			local param = {
				heroPlayWeatherVoice = true,
				roleGo = self._lightSpine:getSpineGo(),
				heroId = self._heroId,
				sharedMaterial = self._spineMaterial,
				skinId = skinId
			}

			weatherController:changeRoleGo(param)
			WeatherController.instance:setLightModel(self._lightSpine)
		end
	elseif viewName == ViewName.CharacterGetView or viewName == ViewName.CharacterSkinGetDetailView then
		if self._lightSpine then
			gohelper.setActive(self._lightSpine:getSpineGo(), true)
		end
	elseif viewName == ViewName.CharacterView and self._lightSpine and self._showInScene then
		self._lightSpine:setLayer(UnityLayer.Unit)
	end
end

function MainHeroView:_setFactor(value)
	PostProcessingMgr.instance:setUnitPPValue("dofFactor", value)
end

function MainHeroView.setPostProcessBlur()
	PostProcessingMgr.instance:setUnitPPValue("dofFactor", 1)
	PostProcessingMgr.instance:setUnitPPValue("dofSampleScale", Vector4.one)
	PostProcessingMgr.instance:setUnitPPValue("dofRT3Scale", 2)
end

function MainHeroView.resetPostProcessBlur()
	PostProcessingMgr.instance:setUnitPPValue("dofFactor", 0)
	PostProcessingMgr.instance:setUnitPPValue("dofSampleScale", Vector4(7.18, 0.77, 3.26, 1))
	PostProcessingMgr.instance:setUnitPPValue("dofRT3Scale", 3)
end

function MainHeroView:_resetPostProcessValue()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	MainHeroView.resetPostProcessBlur()
end

function MainHeroView:_isLogout()
	return ViewMgr.instance:isOpen(ViewName.LoadingView)
end

function MainHeroView:onClose()
	if self._lightSpine then
		if not self._showInScene then
			self:_setStencil(true)
		end

		self._lightSpine:doDestroy()

		self._lightSpine = nil
	end

	self._click:RemoveClickDownListener()
	self._drag:RemoveDragBeginListener()
	self._drag:RemoveDragListener()
	self._drag:RemoveDragEndListener()

	if self._photoFrameBgLoader then
		self._photoFrameBgLoader:dispose()

		self._photoFrameBgLoader = nil
	end

	weatherController:setStateByString("Photo_album", "no")

	if self._skinInteraction then
		self._skinInteraction:onDestroy()
	end

	TaskDispatcher.cancelTask(self._hide, self)
	TaskDispatcher.cancelTask(self._showModelEffect, self)
	TaskDispatcher.cancelTask(self._hideLightSpineVisible, self)
	TaskDispatcher.cancelTask(self._setSpineScale, self)
	TaskDispatcher.cancelTask(self._delayInitLightSpine, self)
	TaskDispatcher.cancelTask(self._frameCheckVoiceEffect, self)
	self:_resetPostProcessValue()
	self:_clearEvents()
end

function MainHeroView:_clearEvents()
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenFullViewFinish, self._onOpenFullViewFinish, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenFullView, self._onOpenFullView, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseFullView, self._onCloseFullView, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.ReOpenWhileOpen, self._reOpenWhileOpen, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.removeEventCb(self, StoryController.instance, StoryEvent.Start, self._onStart, self)
	self.removeEventCb(self, StoryController.instance, StoryEvent.Finish, self._onFinish, self)
	self.removeEventCb(self, WeatherController.instance, WeatherEvent.PlayVoice, self._onWeatherPlayVoice, self)
	self.removeEventCb(self, WeatherController.instance, WeatherEvent.LoadPhotoFrameBg, self._onWeatherLoadPhotoFrameBg, self)
	self.removeEventCb(self, WeatherController.instance, WeatherEvent.OnRoleBlend, self._onWeatherOnRoleBlend, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onLoadingCloseView, self)
	self.removeEventCb(self, MainController.instance, MainEvent.ForceStopVoice, self._forceStopVoice, self)
	TaskDispatcher.cancelTask(self._delayCheckShowMain, self)
end

function MainHeroView:onCloseFinish()
	gohelper.destroy(self._golightspine)
end

function MainHeroView:getMaxTouchHeadNumber()
	return tonumber(lua_const.configList[32].value)
end

function MainHeroView:onDestroyView()
	self:_disableKeyword()
end

function MainHeroView:_clearTrackMainHeroInteractionData()
	self._track_main_hero_interaction_info = {
		main_hero_interaction_skin_id = false,
		main_hero_interaction_voice_id = false,
		main_hero_interaction_area_id = false
	}
end

function MainHeroView:_updateTrackInfoSkinId(skin_id)
	self._track_main_hero_interaction_info.main_hero_interaction_skin_id = skin_id
end

function MainHeroView:_updateTrackInfoAreaId(area_id)
	self._track_main_hero_interaction_info.main_hero_interaction_area_id = area_id
end

function MainHeroView:_trackMainHeroInteraction(voice_id)
	local data = self._track_main_hero_interaction_info

	if not data.main_hero_interaction_area_id or not data.main_hero_interaction_skin_id then
		return
	end

	data.main_hero_interaction_voice_id = tostring(voice_id)

	SDKDataTrackMgr.instance:trackMainHeroInteraction(data)
	self:_updateTrackInfoAreaId(nil)
end

return MainHeroView
