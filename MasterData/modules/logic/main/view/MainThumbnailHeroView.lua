-- chunkname: @modules/logic/main/view/MainThumbnailHeroView.lua

module("modules.logic.main.view.MainThumbnailHeroView", package.seeall)

local MainThumbnailHeroView = class("MainThumbnailHeroView", BaseView)

function MainThumbnailHeroView:onInitView()
	self._golightspinecontrol = gohelper.findChild(self.viewGO, "#go_lightspinecontrol")
	self._gospinescale = gohelper.findChild(self.viewGO, "#go_spine_scale")
	self._golightspine = gohelper.findChild(self.viewGO, "#go_spine_scale/lightspine/#go_lightspine")
	self._txtanacn = gohelper.findChildText(self.viewGO, "bottom/#txt_ana_cn")
	self._txtanaen = gohelper.findChildText(self.viewGO, "bottom/#txt_ana_en")
	self._gocontentbg = gohelper.findChild(self.viewGO, "bottom/#go_contentbg")
	self._btnblock = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_block")
	self._goswitch = gohelper.findChild(self.viewGO, "#btn_switch")
	self._goswitchreddot = gohelper.findChild(self.viewGO, "#btn_switch/switchreddot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MainThumbnailHeroView:addEvents()
	self._btnblock:AddClickListener(self._btnblockOnClick, self)
end

function MainThumbnailHeroView:removeEvents()
	self._btnblock:RemoveClickListener()
end

local csTweenHelper = ZProj.TweenHelper

function MainThumbnailHeroView:_btnblockOnClick()
	if self._lightSpine then
		self._lightSpine:stopVoice()
	end

	self:_greetingFinish()
end

function MainThumbnailHeroView:onOpen()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenFullViewFinish, self._onOpenFullView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.ReOpenWhileOpen, self._reOpenWhileOpen, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseFullView, self._onCloseFullView, self)
	self.addEventCb(self, MainController.instance, MainEvent.OnSceneClose, self._onSceneClose, self)
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self)
	NavigateMgr.instance:addEscape(ViewName.MainThumbnailView, self._onEscBtnClick, self)

	local navView = self.viewContainer:getThumbnailNav()

	navView:setCloseCheck(self._navCloseCheck, self)
	self:_initGreeting()
	self:_initCamera()
	self:_initCapture()
	gohelper.setActive(self._goswitchreddot, false)

	if self:_checkShowRedDot() then
		gohelper.setActive(self._goswitch, false)
	end

	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._viewPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)

	self._viewPlayer:Play(self._needPlayGreeting and "open1" or "open2", self._onViewAnimDone, self)

	self._curHeroId, self._curSkinId = CharacterSwitchListModel.instance:getMainHero()

	if self._curHeroId and self._curSkinId then
		self:_updateHero(self._curHeroId, self._curSkinId)
	end

	self:_startForceUpdateCameraPos()
	self._cameraPlayer:Play(self._needPlayGreeting and "ani01" or "ani03", self._cameraInitAnimDone, self)

	if not PlayerModel.instance:getMainThumbnail() then
		PlayerRpc.instance:sendMarkMainThumbnailRequest()
	end
end

function MainThumbnailHeroView:_onScreenResize()
	MainThumbnailHeroView.setSpineScale(self._gospinescale)
end

function MainThumbnailHeroView:_cameraInitAnimDone()
	self:_removeForceUpdateCameraPos()

	if self._needPlayGreeting then
		self._needPlayGreeting = false

		self:_playGreetingVoices()
	else
		self:_showRedDot()
	end
end

function MainThumbnailHeroView:_initGreeting()
	self._needPlayGreeting = self.viewParam and self.viewParam.needPlayGreeting

	gohelper.setActive(self._btnblock.gameObject, self._needPlayGreeting)

	if self._needPlayGreeting then
		gohelper.setActive(self._goswitch, false)
		TaskDispatcher.runDelay(self._greetingFinish, self, 20)
	end
end

function MainThumbnailHeroView:_initCamera()
	if self._cameraPlayer then
		return
	end

	local path = self.viewContainer:getSetting().otherRes[3]
	local animatorInst = self.viewContainer._abLoader:getAssetItem(path):GetResource()

	CameraMgr.instance:setCameraRootAnimatorController(animatorInst)

	local targetGo = CameraMgr.instance:getCameraRootGO()

	self._cameraRootTrans = targetGo.transform
	self._cameraAnimator = CameraMgr.instance:getCameraRootAnimator()
	self._cameraPlayer = CameraMgr.instance:getCameraRootAnimatorPlayer()
end

function MainThumbnailHeroView:_onViewAnimDone()
	return
end

function MainThumbnailHeroView:_onCameraAnimDone()
	self:_removeForceUpdateCameraPos()

	if VirtualSummonScene.instance:isOpen() then
		return
	end

	CameraMgr.instance:getCameraTrace().EnableTrace = true
	CameraMgr.instance:getCameraTrace().EnableTrace = false
end

function MainThumbnailHeroView:_initCapture()
	if not self._needPlayGreeting then
		return
	end

	local targetGo = PostProcessingMgr.instance:getCaptureView()
	local animator = gohelper.onceAddComponent(targetGo, typeof(UnityEngine.Animator))
	local path = self.viewContainer:getSetting().otherRes[4]

	animator.runtimeAnimatorController = self.viewContainer._abLoader:getAssetItem(path):GetResource()

	local player = SLFramework.AnimatorPlayer.Get(targetGo)

	player:Play("captureview", self._onCaptureAnimDone, self)
end

function MainThumbnailHeroView:_onCaptureAnimDone()
	return
end

function MainThumbnailHeroView:_checkClose()
	if self._btnblock.gameObject.activeInHierarchy then
		return
	end

	if self._animator.enabled or self._cameraAnimator.enabled then
		return
	end

	return true
end

function MainThumbnailHeroView:_navCloseCheck()
	return self:_checkClose()
end

function MainThumbnailHeroView:_onEscBtnClick()
	if not self:_checkClose() then
		return
	end

	self:closeThis()
end

function MainThumbnailHeroView:_onSceneClose()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseFullView, self._onCloseFullView, self)
end

local weatherController = WeatherController.instance

function MainThumbnailHeroView:_editableInitView()
	self:_enableKeyword()

	local lightspineGo = gohelper.findChild(self._gospinescale, "lightspine")

	self._spineInitPosX = recthelper.getAnchorX(lightspineGo.transform)
	self._offsetXWithMainView = self._spineInitPosX - 42
	self._click = SLFramework.UGUI.UIClickListener.Get(self._golightspinecontrol)

	self._click:AddClickDownListener(self._clickDown, self)

	self._showInScene = true

	MainThumbnailHeroView.setSpineScale(self._gospinescale)
end

function MainThumbnailHeroView.setSpineScale(go)
	local scale = GameUtil.getAdapterScale()

	transformhelper.setLocalScale(go.transform, scale, scale, scale)
end

function MainThumbnailHeroView:_updateHero(heroId, skinId)
	self._anchorMinPos = nil
	self._anchorMaxPos = nil
	self._closeEffectList = nil
	self._tvOff = false
	self._heroId = heroId
	self._skinId = skinId

	local hero = HeroModel.instance:getByHeroId(self._heroId)

	if not hero then
		logError("_updateHero no hero:" .. tostring(heroId))

		return
	end

	local skinCo = SkinConfig.instance:getSkinCo(self._skinId or hero and hero.skin)

	if not skinCo then
		return
	end

	self._heroPhotoFrameBg = hero.config.photoFrameBg
	self._heroSkinConfig = skinCo
	self._heroSkinTriggerArea = {}

	if not self._lightSpine then
		local mainLightSpineGo = UnityEngine.GameObject.Find("UIRoot/HUD/MainView/#go_spine_scale/lightspine/#go_lightspine")

		if not gohelper.isNil(mainLightSpineGo) then
			gohelper.addChildPosStay(self._golightspine.transform.parent.gameObject, mainLightSpineGo)
			gohelper.destroy(self._golightspine)

			self._golightspine = mainLightSpineGo
		end

		self._lightSpine = LightModelAgent.Create(self._golightspine, true)
	end

	self:setSpineAnchorTween()

	self._defaultStencilValue = not string.nilorempty(skinCo.defaultStencilValue) and string.splitToNumber(skinCo.defaultStencilValue, "#") or nil

	self._lightSpine:setResPath(skinCo, self._onLightSpineLoaded, self)
	self._lightSpine:setInMainView()
end

function MainThumbnailHeroView:setSpineAnchorTween()
	if self.tweenId then
		csTweenHelper.KillById(self.tweenId)
	end

	local mainThumbnailViewOffset = self._heroSkinConfig.mainThumbnailViewOffset

	if string.nilorempty(mainThumbnailViewOffset) then
		return
	end

	local offset = SkinConfig.instance:getSkinOffset(mainThumbnailViewOffset)

	self.tweenId = csTweenHelper.DOAnchorPos(self._golightspine.transform, offset[1], offset[2], 0.4)
end

function MainThumbnailHeroView:resetSpineAnchorTween(force)
	if self.tweenId then
		csTweenHelper.KillById(self.tweenId)
	end

	if gohelper.isNil(self._golightspine) then
		return
	end

	local curHeroId, curSkinId = CharacterSwitchListModel.instance:getMainHero()
	local skinCo = SkinConfig.instance:getSkinCo(curSkinId)

	if not skinCo then
		return
	end

	local offsetParam = SkinConfig.instance:getSkinOffset(skinCo.mainViewOffset)

	if force then
		recthelper.setAnchor(self._golightspine.transform, offsetParam[1], offsetParam[2])

		local scale = tonumber(offsetParam[3])

		transformhelper.setLocalScale(self._golightspine.transform, scale, scale, scale)

		return
	end

	self.tweenId = csTweenHelper.DOAnchorPos(self._golightspine.transform, offsetParam[1], offsetParam[2], 0.4)
end

function MainThumbnailHeroView:_onLightSpineLoaded()
	if gohelper.isNil(self.viewGO) then
		return
	end

	self._spineGo = self._lightSpine:getSpineGo()
	self._spineTransform = self._spineGo.transform

	local renderer = self._lightSpine:getRenderer()
	local spineMaterial = renderer.sharedMaterial

	if self._defaultStencilValue then
		self._lightSpine:setStencilValues(self._defaultStencilValue[1], self._defaultStencilValue[2], self._defaultStencilValue[3])
	else
		self._lightSpine:setStencilRef(0)
	end

	WeatherController.instance:setLightModel(self._lightSpine)

	if not self._firstLoadSpine then
		self._firstLoadSpine = true

		weatherController:initRoleGo(self._spineGo, self._heroId, spineMaterial, false, self._skinId)
	else
		local param = {
			heroPlayWeatherVoice = true,
			roleGo = self._lightSpine:getSpineGo(),
			heroId = self._heroId,
			sharedMaterial = spineMaterial,
			skinId = self._skinId
		}

		weatherController:changeRoleGo(param)
	end
end

function MainThumbnailHeroView:_playGreetingVoices()
	local config = MainHeroView.getWelcomeLikeVoice(CharacterEnum.VoiceType.GreetingInThumbnail, self._heroId, self._skinId)

	config = config or MainHeroView.getWelcomeLikeVoice(CharacterEnum.VoiceType.MainViewWelcome, self._heroId, self._skinId)

	if not config then
		local greetingVoices = HeroModel.instance:getVoiceConfig(self._heroId, CharacterEnum.VoiceType.Greeting, nil, self._skinId)

		if greetingVoices and #greetingVoices > 0 then
			config = greetingVoices[1]
		end
	end

	if not config then
		logError("no greeting voice")

		return
	end

	if not self._lightSpine then
		logError("playGreetingVoices no lightSpine")

		return
	end

	self._lightSpine:playVoice(config, function()
		self:_greetingFinish()
	end, self._txtanacn, self._txtanaen, self._gocontentbg)
end

function MainThumbnailHeroView:_greetingFinish()
	if not self._btnblock.gameObject.activeInHierarchy then
		return
	end

	gohelper.setActive(self._btnblock.gameObject, false)
	TaskDispatcher.cancelTask(self._greetingFinish, self)
	MainController.instance:dispatchEvent(MainEvent.OnMainThumbnailGreetingFinish)
	self:_showRedDot()
end

function MainThumbnailHeroView:_showRedDot()
	gohelper.setActive(self._goswitch, true)

	if self._isShowRedDot then
		return
	end

	self._isShowRedDot = self:_checkShowRedDot()

	gohelper.setActive(self._goswitchreddot, self._isShowRedDot)

	if self._isShowRedDot then
		local animator = self._goswitch:GetComponent(typeof(UnityEngine.Animator))

		animator:Play("open", 0, 0)

		self._audioId = AudioMgr.instance:trigger(AudioEnum.UI.play_ui_main_banniang_icon)
	end
end

function MainThumbnailHeroView:_checkShowRedDot()
	self._characterShowRedDot = self:_checkCharacterShowRedDot() or self:_checkFightUiShowRedDot() or self:_isShowSceneUIReddot()

	return self._characterShowRedDot or RedDotModel.instance:isDotShow(RedDotEnum.DotNode.MainSceneSwitch, 0)
end

function MainThumbnailHeroView:_checkCharacterShowRedDot()
	local heroList = HeroModel.instance:getList()
	local value = PlayerModel.instance:getSimpleProperty(PlayerEnum.SimpleProperty.MainThumbnailViewSwitch)

	return #heroList >= 2 and value ~= "1"
end

function MainThumbnailHeroView:_checkFightUiShowRedDot()
	return FightUISwitchModel.instance:isNewUnlockStyle()
end

function MainThumbnailHeroView:_isShowSceneUIReddot()
	return ClickUISwitchModel.instance:hasReddot()
end

function MainThumbnailHeroView:_hideRedDot()
	if self._characterShowRedDot then
		self._characterShowRedDot = false

		local id = PlayerEnum.SimpleProperty.MainThumbnailViewSwitch
		local value = "1"

		PlayerModel.instance:forceSetSimpleProperty(id, value)
		PlayerRpc.instance:sendSetSimplePropertyRequest(id, value)
	end

	self._isShowRedDot = self:_checkShowRedDot()

	gohelper.setActive(self._goswitchreddot, self._isShowRedDot)
end

function MainThumbnailHeroView:isPlayingVoice()
	return self._lightSpine:isPlayingVoice() or self._tvOff
end

function MainThumbnailHeroView:isShowInScene()
	return self._showInScene
end

function MainThumbnailHeroView:_checkSpecialTouch(config, pos)
	local key = "triggerArea" .. config.param
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

		if startX <= pos.x and endX >= pos.x and startY >= pos.y and endY <= pos.y then
			return true
		end
	end

	return false
end

function MainThumbnailHeroView:_clickDown()
	return
end

function MainThumbnailHeroView:_doClickDown()
	if not self._showInScene then
		return
	end

	if gohelper.isNil(self._spineGo) then
		return
	end

	local pos = recthelper.screenPosToAnchorPos(GamepadController.instance:getMousePosition(), self._golightspinecontrol.transform)

	pos.x = pos.x - self._offsetXWithMainView

	if self._skinId == 303301 or self._skinId == 303302 then
		self:_clickTTT(pos)

		return
	end

	self:_clickDefault(pos)
end

function MainThumbnailHeroView:_clickTTT(pos)
	if not self:_checkPosInBound(pos) then
		return
	end

	local closeProb = CommonConfig.instance:getConstNum(ConstEnum.TTTCloseTv) / 100

	if not self._tvOff and closeProb > math.random() then
		local go = self._lightSpine:getSpineGo()

		self._tvOff = true

		TaskDispatcher.cancelTask(self._hideCloseEffects, self)

		self._closeEffectList = self._closeEffectList or self:getUserDataTb_()

		local mountroot = gohelper.findChild(go, "mountroot")
		local transform = mountroot.transform
		local childCount = transform.childCount

		for i = 1, childCount do
			local child = transform:GetChild(i - 1)

			for j = 1, child.childCount do
				local effectGo = child:GetChild(j - 1)

				if string.find(effectGo.name, "close") then
					gohelper.setActive(effectGo.gameObject, true)

					self._closeEffectList[i] = effectGo.gameObject
				else
					gohelper.setActive(effectGo.gameObject, false)
				end
			end
		end

		if self._lightSpine then
			self._lightSpine:stopVoice()
		end

		return
	end

	if self:_openTv() then
		return
	end

	self:_clickDefault(pos)
end

function MainThumbnailHeroView:_openTv()
	if self._tvOff then
		self._tvOff = false

		local go = self._lightSpine:getSpineGo()

		TaskDispatcher.cancelTask(self._hideCloseEffects, self)
		TaskDispatcher.runDelay(self._hideCloseEffects, self, 0.2)

		local mountroot = gohelper.findChild(go, "mountroot")
		local transform = mountroot.transform
		local childCount = transform.childCount

		for i = 1, childCount do
			local child = transform:GetChild(i - 1)

			for j = 1, child.childCount do
				local effectGo = child:GetChild(j - 1)

				if not string.find(effectGo.name, "close") then
					gohelper.setActive(effectGo.gameObject, true)
				end
			end
		end

		return true
	end
end

function MainThumbnailHeroView:_hideCloseEffects()
	for i, v in pairs(self._closeEffectList) do
		gohelper.setActive(v, false)
	end
end

function MainThumbnailHeroView:_clickDefault(pos)
	local specialConfig = self:_getSpecialTouch(pos)

	if specialConfig and math.random() > 0.5 then
		self:clickPlayVoice(specialConfig)

		return
	end

	local normalConfig = self:_getNormalTouch(pos)

	if normalConfig then
		self:clickPlayVoice(normalConfig)
	end
end

function MainThumbnailHeroView:_getSpecialTouch(pos)
	local specialVoices = HeroModel.instance:getVoiceConfig(self._heroId, CharacterEnum.VoiceType.MainViewSpecialTouch, function(config)
		return self._clickPlayConfig ~= config and self:_checkSpecialTouch(config, pos)
	end)

	if specialVoices and #specialVoices > 0 then
		return specialVoices[1]
	end
end

function MainThumbnailHeroView:_getNormalTouch(pos)
	if self:_checkPosInBound(pos) then
		local normalVoices = HeroModel.instance:getVoiceConfig(self._heroId, CharacterEnum.VoiceType.MainViewNormalTouch, function(config)
			return self._clickPlayConfig ~= config
		end)

		return self:getHeightWeight(normalVoices)
	end
end

function MainThumbnailHeroView:_checkPosInBound(pos)
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

function MainThumbnailHeroView:getHeightWeight(configList)
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

function MainThumbnailHeroView:clickPlayVoice(config)
	self._clickPlayConfig = config

	self:playVoice(config)
end

function MainThumbnailHeroView:playVoice(config)
	if not self._lightSpine then
		return
	end

	self._lightSpine:playVoice(config, function()
		self._interactionStartTime = Time.time
	end, self._txtanacn, self._txtanaen, self._gocontentbg)
end

function MainThumbnailHeroView:_enableKeyword()
	return
end

function MainThumbnailHeroView:_disableKeyword()
	return
end

function MainThumbnailHeroView:_onOpenFullView(viewName)
	if viewName ~= self:_getSwitchViewName() then
		self:_disableKeyword()
	end

	if self._lightSpine then
		self._lightSpine:stopVoice()
	end

	MainThumbnailHeroView.setCameraIdle()
end

function MainThumbnailHeroView.setCameraIdle()
	local animator = CameraMgr.instance:getCameraRootAnimator()

	if animator then
		animator.enabled = false
	end

	local targetGo = CameraMgr.instance:getCameraRootGO()

	transformhelper.setLocalPos(targetGo.transform, 0, 0, 0)

	CameraMgr.instance:getCameraTrace().EnableTrace = true
	CameraMgr.instance:getCameraTrace().EnableTrace = false

	local canvas = ViewMgr.instance:getUICanvas()

	canvas.enabled = false
	canvas.enabled = true
end

function MainThumbnailHeroView:_hideLightSpineVisible()
	return
end

function MainThumbnailHeroView:_onCloseFullView(viewName)
	if not ViewMgr.instance:hasOpenFullView() then
		self:_startForceUpdateCameraPos()

		if ViewMgr.instance:isOpen(self:_getSwitchViewName()) then
			self._cameraPlayer:Play("clip2", self._onCameraAnimDone, self)
		else
			self._cameraPlayer:Play("clip", self._onCameraAnimDone, self)
		end

		self:_enableKeyword()
		self:_openTv()
	end
end

function MainThumbnailHeroView:_reOpenWhileOpen(viewName)
	if ViewMgr.instance:isFull(viewName) then
		self:_onOpenFullView(viewName)
	end
end

function MainThumbnailHeroView:_setViewVisible(visible)
	recthelper.setAnchorY(self.viewGO.transform, visible and 0 or 10000)
	self.viewContainer:_setVisible(visible)
end

function MainThumbnailHeroView:_onOpenView(viewName)
	if viewName == self:_getSwitchViewName() then
		self:_setViewVisible(false)
		self:_startForceUpdateCameraPos()
		self._cameraPlayer:Play("ani02", self._onCameraAnimDone, self)
		self:resetSpineAnchorTween()

		if self._lightSpine then
			self._lightSpine:stopVoice()
		end
	elseif (viewName == ViewName.CharacterGetView or viewName == ViewName.CharacterSkinGetDetailView) and self._lightSpine then
		gohelper.setActive(self._lightSpine:getSpineGo(), false)
	end
end

function MainThumbnailHeroView:_startForceUpdateCameraPos()
	self:_removeForceUpdateCameraPos()
	LateUpdateBeat:Add(self._forceUpdateCameraPos, self)
end

function MainThumbnailHeroView:_removeForceUpdateCameraPos()
	LateUpdateBeat:Remove(self._forceUpdateCameraPos, self)
end

function MainThumbnailHeroView:_forceUpdateCameraPos()
	local trace = CameraMgr.instance:getCameraTrace()

	trace.EnableTrace = true
	trace.EnableTrace = false
	trace.enabled = false
end

function MainThumbnailHeroView:_getSwitchViewName()
	return ViewName.MainSwitchView
end

function MainThumbnailHeroView:_onCloseViewFinish(viewName)
	if self:_isLogout() then
		return
	end

	self:_showRedDot()

	if viewName == self:_getSwitchViewName() then
		self:_hideRedDot()
		self:_setViewVisible(true)
		self._viewPlayer:Play("open3", self._onViewAnimDone, self)
		self:_startForceUpdateCameraPos()
		self._cameraPlayer:Play("ani03", self._onCameraAnimDone, self)
		self:resetSpineAnchorTween(true)
		self:setSpineAnchorTween()

		local heroId, skinId = CharacterSwitchListModel.instance:getMainHero()

		if self._curHeroId ~= heroId and heroId or self._curSkinId ~= skinId and skinId or gohelper.isNil(self._lightSpine:getSpineGo()) then
			self._curHeroId = heroId
			self._curSkinId = skinId

			self:_updateHero(self._curHeroId, self._curSkinId)
		elseif self._lightSpine then
			local renderer = self._lightSpine:getRenderer()
			local spineMaterial = renderer.sharedMaterial
			local param = {
				heroPlayWeatherVoice = true,
				roleGo = self._lightSpine:getSpineGo(),
				heroId = self._heroId,
				sharedMaterial = spineMaterial,
				skinId = skinId
			}

			weatherController:changeRoleGo(param)
			WeatherController.instance:setLightModel(self._lightSpine)
		end
	elseif (viewName == ViewName.CharacterGetView or viewName == ViewName.CharacterSkinGetDetailView) and self._lightSpine then
		gohelper.setActive(self._lightSpine:getSpineGo(), true)
	end
end

function MainThumbnailHeroView:onCloseFinish()
	local go = UnityEngine.GameObject.Find("UIRoot/HUD/MainView/#go_spine_scale/lightspine")

	if gohelper.isNil(go) or gohelper.isNil(self._golightspine) then
		return
	end

	if go.transform.childCount > 0 then
		return
	end

	gohelper.addChildPosStay(go, self._golightspine)
end

function MainThumbnailHeroView:onClose()
	if self._lightSpine and not LimitedRoleController.instance:isPlayingAction() then
		self._lightSpine:stopVoice()
	end

	self._click:RemoveClickDownListener()

	if self._touchEventMgr then
		self._touchEventMgr:ClearAllCallback()

		self._touchEventMgr = nil
	end

	TaskDispatcher.cancelTask(self._hideCloseEffects, self)
	TaskDispatcher.cancelTask(self._greetingFinish, self)
	self:_removeForceUpdateCameraPos()
	self:resetSpineAnchorTween()

	if self:_isLogout() then
		MainThumbnailHeroView.setCameraIdle()
	else
		GameGCMgr.instance:dispatchEvent(GameGCEvent.CancelDelayFullGC)
		self._cameraPlayer:Play("ani02", self._onCameraAnimDone, self)
	end

	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseFullView, self._onCloseFullView, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)

	if self._audioId then
		AudioMgr.instance:stopPlayingID(self._audioId)

		self._audioId = nil
	end
end

function MainThumbnailHeroView:_isLogout()
	local loadingState = GameGlobalMgr.instance:getLoadingState()

	return loadingState and loadingState:getLoadingViewName()
end

function MainThumbnailHeroView:onDestroyView()
	self:_disableKeyword()
end

function MainThumbnailHeroView:getLightSpineGo()
	return self._golightspine
end

return MainThumbnailHeroView
