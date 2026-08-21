-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/retrieve/view/RetrieveRoleShowViewView.lua

module("logic.extensions.retrieve.view.RetrieveRoleShowViewView", package.seeall)

local M = class("RetrieveRoleShowViewView", ViewComponent)
local qualityMaps = {
	[GameEnum.QualityEnum.S] = "js_quality_s",
	[GameEnum.QualityEnum.A] = "js_quality_a",
	[GameEnum.QualityEnum.B] = "js_quality_b",
	[GameEnum.QualityEnum.C] = "js_quality_c"
}
local relationMaps = {
	[GameEnum.ColorTypeEnum.Red] = "jscjdd_bf_0001_04",
	[GameEnum.ColorTypeEnum.Blue] = "jscjdd_bf_0001_02",
	[GameEnum.ColorTypeEnum.Green] = "jscjdd_bf_0001_03",
	[GameEnum.ColorTypeEnum.Gray] = "jscjdd_bf_0001_01"
}
local careerMaps = {
	[GameEnum.CareerEnum.Sentinel] = "ck_career_201",
	[GameEnum.CareerEnum.Assault] = "ck_career_202",
	[GameEnum.CareerEnum.Sniper] = "ck_career_203",
	[GameEnum.CareerEnum.Super] = "ck_career_204",
	[GameEnum.CareerEnum.Heavy] = "ck_career_205",
	[GameEnum.CareerEnum.Cure] = "ck_career_206"
}
local bgMaps = {
	[GameEnum.QualityEnum.S] = "jscjdd_bg_0001_s",
	[GameEnum.QualityEnum.A] = "jscjdd_bg_0001_a",
	[GameEnum.QualityEnum.B] = "jscjdd_bg_0001_b",
	[GameEnum.QualityEnum.C] = "jscjdd_bg_0001_c"
}
local soundEffectMap = {
	[GameEnum.QualityEnum.S] = CriwareAudioEnum.ui_chouka_role_s,
	[GameEnum.QualityEnum.A] = CriwareAudioEnum.ui_chouka_role_a,
	[GameEnum.QualityEnum.B] = CriwareAudioEnum.ui_chouka_role_b
}
local kNeedClips = {
	"chouka_loop"
}
local kGetRoleUI3dLight = 14

function M:buildUI()
	self._btnJump = self:getBtn("retrieve_role_show_view_-2035451616")
	self._btnClick = self:getBtn("0&empty_mask_tips_29887572")
	self._imgQuality = self:getImage("retrieve_role_show_view_1034924622")
	self._imgRelation = self:getImage("retrieve_role_show_view_312236598")
	self._imgCareer = self:getImage("retrieve_role_show_view_-51135658")
	self._txtName = self:getText("retrieve_role_show_view_-1539104098")
	self._txtContent = self:getText("retrieve_role_show_view_1259872899")
	self._hintGo = self:getGo("retrieve_role_show_view_-291748032")
	self._imgBg = self:getBigBg("retrieve_role_show_view_-1807724159")
	self._heroImgGo = self:getGo("retrieve_role_show_view_377394448")
	self._heroRawImg = self._heroImgGo:GetComponent(UIComponentType.RawImage)
	self._photoUnit = PhotoModel.Get(self._heroImgGo)

	self._photoUnit:clear()

	self._bottomRightGo = self:getGo("retrieve_role_show_view_1631378156")
	self._imgIcon = self:getImage("retrieve_role_show_view_-387352261")
	self._txtName2 = self:getText("retrieve_role_show_view_472328653")
	self._txtNum = self:getText("retrieve_role_show_view_-1107397791")
	self._heroLoader = MultiResLoader.New()
	self._directorSetter = PlayableDirectorSetter.New()
end

function M:destroyUI()
	if self._photoUnit then
		self._photoUnit:clear()
	end

	self._photoUnit = nil
end

function M:bindEvents()
	self._btnClick:AddClickListener(self._onClickBtnClick, self)
	RetrieveDispatcher:addEventListener(RetrieveEventType.Show_Hero_Info, self._onShowHeroInfo, self)
	self:registerLocalNotify(EventType.FW_VIEW_ANIMATION_DONE_EVENT, self._handleViewAniDoneEvent, self)
end

function M:unbindEvents()
	self._btnClick:RemoveClickListener()
	RetrieveDispatcher:removeEventListener(RetrieveEventType.Show_Hero_Info, self._onShowHeroInfo, self)
	self:unregisterLocalNotify(EventType.FW_VIEW_ANIMATION_DONE_EVENT, self._handleViewAniDoneEvent, self)
end

function M:_handleViewAniDoneEvent(key, tagName, reason)
	if tagName == "show_jump" then
		self._canClickClose = true

		RetrieveDispatcher:dispatchEvent(RetrieveEventType.Show_Lottery_UI_Finish)
	elseif tagName == "close" then
		-- block empty
	end
end

function M:onEnter()
	goutil.setActive(self._bottomRightGo, false)

	self._guiAnimation = self._viewPresentor:getGuiAnimation()

	RetrieveFacade.instance:registerShowRoleView(self)
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_RetrieveMainView)
	VolumeMgr.instance:turnOn(VolumeName.GetRole)
	LightMgr.instance:turnOn(kGetRoleUI3dLight)

	local data = self:getFirstParam()

	self:_onShowHeroInfo(nil, data)
end

function M:onExitFinished()
	self._imgBg:ClearImage()
end

function M:_onShowHeroInfo(evt, data)
	self._data = data

	self:_initData(data)

	if self._changeHeroEffectGo and not goutil.isNil(self._changeHeroEffectGo) then
		goutil.setActive(self._changeHeroEffectGo, false)
	end

	self._guiAnimation:ClearAllBinding()
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:SetAniTime(0)

	local showName = self._isSuperCard and "s_open" or "normal_open"

	self._guiAnimation:PlayAniByName(showName, Astral.GUITimeLineMode.TimeToStart)

	self._isPlayShowAnim = false

	self:_loadHeroRes()
	RetrieveDispatcher:dispatchEvent(RetrieveEventType.Open_Get_Role_UI)
end

function M:_loadHeroRes()
	local characterCO = self._characterCO

	self._modelCode = characterCO.modelId

	local modelCO = ModelConfig.instance:getModelConfig(self._modelCode)

	if not modelCO then
		return
	end

	self._heroLoader:clear()

	local resPath = GameUrl.getMainSceneMeshModelUrl(modelCO.mainSceneResName)
	local idleAnimClip = GameUrl.getMainSceneMeshModelClipUrl(modelCO.mainSceneResName, MainPerformEnum.AnimFullName.ChoukaIdle)

	self._heroLoader:addResPath(resPath)
	self._heroLoader:addResPath(idleAnimClip)

	self._qualitApperPath = GameUrl.getChoukaAppearVfx(CommEnum.QuaLotteryBg[characterCO.quality])

	self._heroLoader:addResPath(self._qualitApperPath)
	self:_loadEnterShowRes()
	self._heroLoader:load(self._onAllHeroLoaded, false, self)
end

function M:_loadEnterShowRes()
	self._enterShowTimelinePath = MainScenePerformUtil.getHeroEnterShowTimelinePath(self._modelCode)

	if self._enterShowTimelinePath then
		self._heroLoader:addResPath(self._enterShowTimelinePath)
	else
		printError("模型ID：", self._modelCode, "缺少入场镜头动效", "检查角色获得入场动效是否存在")
	end
end

function M:getHeroResource(resPath)
	return self._heroLoader:getResource(resPath)
end

function M:_onAllHeroLoaded()
	if not self._heroLoader:isAllSuccess() and enableErrorLog then
		printError("preload hero resource failed!", self._data.heroId)
	end

	self._canClickClose = false

	local characterCO = self._characterCO
	local modelCO = ModelConfig.instance:getModelConfig(characterCO.modelId)
	local idleAnimClip = GameUrl.getMainSceneMeshModelClipUrl(modelCO.mainSceneResName, MainPerformEnum.AnimFullName.ChoukaIdle)
	local resPath = GameUrl.getMainSceneMeshModelUrl(modelCO.mainSceneResName)

	self._photoUnit:setRTDepth(0)

	local heroModelGo = false

	if SceneFace.instance:isCurScene(SceneType.Retrieve) then
		local sceneFlow = SceneFace.instance:getCurSceneFlow()

		if sceneFlow then
			heroModelGo = sceneFlow.resMgr:getHeroGo(self._curIndex)

			if not heroModelGo or goutil.isNil(heroModelGo) then
				return
			end
		end
	end

	self._photoUnit:setModelLoadCallback(function(handler, inst, res)
		local magicalCloth = SpaceX.MagicaCloth2Utils.Get(inst.gameObject)

		magicalCloth:SetEnableAllMagicaCloth(false)
		Astral.TransformUtil.SetLocalPos(inst.transform, 0, 0, 0)
		Astral.TransformUtil.SetLocalRotation(inst.transform, 0, 180, 0)

		local _animationPlayer = AnimationPlayer.Get(inst.gameObject)
		local _animState = MainPerformEnum.AnimFullName.ChoukaIdle
		local animClipRes = self:getHeroResource(idleAnimClip)

		if animClipRes then
			local animClip = animClipRes:GetMainAsset()

			_animationPlayer:ReplaceClip(_animState, animClip)
			_animationPlayer:PlayAnimation(_animState, true, true)
			_animationPlayer:Evaluate()
		end

		local lookAtIkAdpter = LookAtIKAdpter.Get(inst.gameObject)

		lookAtIkAdpter:SetBodyWeight(0)
		lookAtIkAdpter:EnableLookAt(false)

		lookAtIkAdpter.enabled = false

		self:_playEneterShow(inst)
		self:showEnterAnim()
	end, self)

	local rtSizeX, rtSizeY, antiAliasing = self:_getRTSizeAndAA()

	if heroModelGo then
		self._photoUnit:ShowTarget(heroModelGo, rtSizeX, rtSizeY, nil, antiAliasing)
	else
		self._photoUnit:updateResWithSize(resPath, nil, rtSizeX, rtSizeY, nil, antiAliasing)
	end

	self._photoUnit:setCameraTag(SceneTag.RTCamera)
	self._photoUnit:setCameraPostProcessing(true, SceneLayer.UI3D_Value)
	self._photoUnit:setRotation(0, 0, 0)
	self._photoUnit:setCameraFov(20)

	if not self._enterShowTimelinePath then
		self._photoUnit:setCameraPosition(0.47, 1.34, -3.11)
	end

	self:_refreshPosition(true)
end

function M:_getRTSizeAndAA()
	local rtQuality = GfxModel.instance:getRTQuality()
	local rtSizeX, rtSizeY, antiAliasing = PhotoCacheMgr.SIZE_FULL_WIDTH, PhotoCacheMgr.SIZE_FULL_HEIGHT, 0

	if rtQuality == GfxConst.RTQuality.Low then
		rtSizeX = PhotoCacheMgr.SIZE_FULL_L_WIDTH
		rtSizeY = PhotoCacheMgr.SIZE_FULL_L_HEIGHT
		antiAliasing = 0
	elseif rtQuality == GfxConst.RTQuality.Middle then
		rtSizeX = PhotoCacheMgr.SIZE_FULL_WIDTH
		rtSizeY = PhotoCacheMgr.SIZE_FULL_HEIGHT
		antiAliasing = 2
	elseif rtQuality == GfxConst.RTQuality.High then
		rtSizeX = PhotoCacheMgr.SIZE_FULL_WIDTH
		rtSizeY = PhotoCacheMgr.SIZE_FULL_HEIGHT
		antiAliasing = 4
	end

	return rtSizeX, rtSizeY, antiAliasing
end

function M:_playEneterShow()
	local changeHeroEffectRes = self._heroLoader:getResource(self._qualitApperPath)

	if changeHeroEffectRes then
		self._changeHeroEffectGo = goutil.clone(changeHeroEffectRes:GetMainAsset())

		goutil.addChildToParent(self._changeHeroEffectGo, self._photoUnit:getTargetContainer())
		Astral.GameObjectUtil.SetLayerRecursively(self._changeHeroEffectGo, SceneLayer.UI3D_Value)
		goutil.setActive(self._changeHeroEffectGo, false)
	end

	if self._enterShowTimelinePath then
		local enterShowRes = self._heroLoader:getResource(self._enterShowTimelinePath)

		self._enterShowGo = goutil.clone(enterShowRes:GetMainAsset())

		goutil.addChildToParent(self._enterShowGo, self._photoUnit:getTargetContainer())

		local _animator = self._photoUnit:getRTCamera().gameObject:GetComponent(ComponentType.Animator)

		if goutil.isNil(_animator) then
			_animator = self._photoUnit:getRTCamera().gameObject:AddComponent(ComponentType.Animator)
		end

		self._directorSetter:Build(self._enterShowGo)
		self._directorSetter:SetWrapMode(UnityEngine.Playables.DirectorWrapMode.None)
		self._directorSetter:AddListener(self._handleTimelineStop, self)
		self._directorSetter:SetGenericBinding(RetrieveEnum.RTCameraTrack, _animator)

		self._timelineListener = TimelineEventListener.Get(self._enterShowGo)

		self._timelineListener:AddListener(self._onTimelineEvent, self)
		self._directorSetter:Play()

		self._isPlayShowAnim = true
	else
		printWarn("不存在镜头timeline,直接播放UI出现动效。")
		self:_handleLotteryEnterShowUI()
	end
end

function M:_onTimelineEvent(eventName, param)
	if not self._isPlayShowAnim then
		return
	end

	if eventName == RetrieveEnum.EventStopped then
		self:_onTimelineStop()
	elseif eventName == RetrieveEnum.LotteryEnterShowUI then
		self:_handleLotteryEnterShowUI()
	end
end

function M:_onTimelineStop()
	RetrieveDispatcher:dispatchEvent(RetrieveEventType.Enter_Show_Finish)
end

function M:_handleLotteryEnterShowUI()
	self._guiAnimation:ClearAllBinding()
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:SetAniTime(0)

	local showName = self._isSuperCard and "s_show" or "normal_show"

	self._guiAnimation:PlayAniByName(showName, Astral.GUITimeLineMode.TimeToStart)
	CriwareAudioFacade.instance:playSEById(soundEffectMap[self._characterCO.quality])

	if not self._isSuperCard then
		-- block empty
	end

	if self._changeHeroEffectGo then
		goutil.setActive(self._changeHeroEffectGo, false)
		goutil.setActive(self._changeHeroEffectGo, true)
	end
end

function M:_refreshPosition(turnOn)
	local producer = self._photoUnit:getProducer()

	if self._photoUnit and producer then
		if not turnOn then
			local pos = PhotoUtil.GetPosition(producer.counter)

			GameUtils.setPos(producer.producerContainer, pos.x, pos.y, pos.z)
		else
			GameUtils.setPos(producer.producerContainer, 500, 500, 0)
		end
	end
end

function M:_initData(data)
	local heroId = data.heroId
	local conversion = data.conversion or false
	local characterCO = CharacterConfig.instance:getCfgInfoByID(heroId)

	self._curIndex = data.index

	local isNew = data.isNew

	self._characterCO = characterCO

	if characterCO then
		local isSuperCard = characterCO.quality == GameEnum.QualityEnum.S

		self._isSuperCard = isSuperCard
		self._heroRawImg.color = Color.New(1, 1, 1, isSuperCard and 1 or 0)

		IconLoader.setSprite(self._imgQuality, IconType.DynSpriteAtlas_RetrieveMainView, qualityMaps[characterCO.quality])
		IconLoader.setSprite(self._imgRelation, IconType.DynSpriteAtlas_RetrieveMainView, relationMaps[characterCO.colorType])
		IconLoader.setSprite(self._imgCareer, IconType.DynSpriteAtlas_RetrieveMainView, careerMaps[characterCO.career])

		local heroInfoCO = PastInfoConfig.instance:getCharacterInfo(heroId)

		self._txtName.text = heroInfoCO and heroInfoCO.name or ""

		if isSuperCard or isNew then
			local keyword = RetrieveConfig.instance:getConfigByKey(ConfigName.LotteryKeyWord, characterCO.modelId)
			local content = keyword and keyword.hint or ""

			self._txtContent.text = content

			if keyword and keyword.hint and keyword.hint ~= "" then
				goutil.setActive(self._hintGo, true)
			else
				goutil.setActive(self._hintGo, false)
			end
		else
			goutil.setActive(self._hintGo, false)

			self._txtContent.text = ""
		end

		local bgPath = GameUrl.getRetrieveBigDynamic(bgMaps[characterCO.quality])

		self._imgBg:SetImage(bgPath, self._onBgLoadFinsh, self)
	end

	local converData = self:_getXinMaoData(conversion)

	if converData then
		goutil.setActive(self._bottomRightGo, true)

		local itemData = ItemData.New({
			itemId = converData.code,
			count = converData.num
		})

		IconLoader.setSprite(self._imgIcon, IconType.ItemIcon, itemData:getIcon())

		self._txtName2.text = itemData:getName()
		self._txtNum.text = "x" .. tostring(itemData:getCount())
	else
		goutil.setActive(self._bottomRightGo, false)
	end
end

function M:_getXinMaoData(conversion)
	if not conversion then
		return false
	end

	for _, v in pairs(conversion) do
		local converData = v

		if converData.code ~= GameEnum.CurrencyCodeEnum.InspirationS and converData.code ~= GameEnum.CurrencyCodeEnum.InspirationA then
			return converData
		end
	end

	return false
end

function M:showEnterAnim()
	local data = self._data
	local VoiceResKey = string.format("speech_%s_chouka", data.heroId)

	CriwareAudioFacade.instance:playVoiceByName(VoiceResKey)
end

function M:onExit()
	self:_stopAnim()
	VolumeMgr.instance:turnOff(VolumeName.GetRole)
	LightMgr.instance:turnOff(kGetRoleUI3dLight)
	RetrieveFacade.instance:unregisterShowRoleView()
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_RetrieveMainView)
	CriwareAudioFacade.instance:stopVoice()

	if SceneFace.instance:isCurScene(SceneType.Retrieve) then
		local sceneFlow = SceneFace.instance:getCurSceneFlow()

		if sceneFlow then
			sceneFlow.resMgr:clearHero()
		end
	end
end

function M:_stopAnim()
	if self._enterShowGo and not goutil.isNil(self._enterShowGo) then
		goutil.destroy(self._enterShowGo)
	end

	self._enterShowGo = false

	if self._changeHeroEffectGo and not goutil.isNil(self._changeHeroEffectGo) then
		goutil.destroy(self._changeHeroEffectGo)
	end

	self._changeHeroEffectGo = false

	if self._photoUnit then
		self:_refreshPosition(false)
		self._photoUnit:clear()
	end

	if self._heroLoader then
		self._heroLoader:clear()
	end

	if self._directorSetter then
		self._directorSetter:Clear()
	end

	if self._timelineListener and not goutil.isNil(self._timelineListener) then
		self._timelineListener:RemoveListener()
	end

	self._timelineListener = nil
end

function M:_onClickBtnClick()
	if self._data.showType == RetrieveEnum.ShowRoleType.Other and self._canClickClose then
		self._canClickClose = false

		self:close()
	end
end

return M
