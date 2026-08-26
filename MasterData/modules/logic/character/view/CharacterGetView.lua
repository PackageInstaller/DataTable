-- chunkname: @modules/logic/character/view/CharacterGetView.lua

module("modules.logic.character.view.CharacterGetView", package.seeall)

local CharacterGetView = class("CharacterGetView", BaseView)

function CharacterGetView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_bg/#simage_bg")
	self._simageredcirclebg = gohelper.findChildSingleImage(self.viewGO, "#go_bg/#simage_redcirclebg")
	self._simagecircle = gohelper.findChildSingleImage(self.viewGO, "#go_bg/#simage_circle/circlewainew/circle")
	self._simagetxtbg = gohelper.findChildSingleImage(self.viewGO, "#go_bg/#simage_txtbg")
	self._imagecareericon = gohelper.findChildImage(self.viewGO, "#go_bg/#image_careericon")
	self._imagecareerline = gohelper.findChildImage(self.viewGO, "#go_bg/#image_careericon/#image_careerline")
	self._simagecareericon = gohelper.findChildSingleImage(self.viewGO, "#go_bg/#image_careericon_big")
	self._simagebgleft = gohelper.findChildSingleImage(self.viewGO, "#go_bg/leftbg")
	self._gospine = gohelper.findChild(self.viewGO, "charactercontainer/#go_spine")
	self._simageblackbg = gohelper.findChildSingleImage(self.viewGO, "introduce/#simage_blackbg")
	self._simagesignatureicon = gohelper.findChildSingleImage(self.viewGO, "introduce/#simage_signatureicon")
	self._simagesignature = gohelper.findChildSingleImage(self.viewGO, "introduce/#simage_signature")
	self._txtcharacterNameCn = gohelper.findChildText(self.viewGO, "introduce/#txt_characterNameCn")
	self._gostarList = gohelper.findChild(self.viewGO, "introduce/#go_starList")
	self._gobottomTalk = gohelper.findChild(self.viewGO, "#go_bottomTalk")
	self._txttalkcn = gohelper.findChildText(self.viewGO, "#go_bottomTalk/#txt_talkcn")
	self._txttalken = gohelper.findChildText(self.viewGO, "#go_bottomTalk/#txt_talken")
	self._btnskip = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_skip")
	self._gobgmask = gohelper.findChild(self.viewGO, "#go_bgmask")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterGetView:addEvents()
	self._btnskip:AddClickListener(self._btnskipOnClick, self)
end

function CharacterGetView:removeEvents()
	self._btnskip:RemoveClickListener()
end

function CharacterGetView:_btnskipOnClick()
	if self.isPlayLimitedVideo then
		self:_limitedVideoFinished()

		return
	end

	if self._isSummonTen then
		SummonController.instance:dispatchEvent(SummonEvent.onSummonSkip)
		AudioMgr.instance:trigger(AudioEnum.UI.Stop_UI_Bus)
		self:closeThis()
	elseif not self._animFinish then
		self:_skipAnim()
	end
end

function CharacterGetView:_skipAnim(needSkipAnim)
	if self._isSummon and not self._isSummonTen then
		gohelper.setActive(self._btnskip.gameObject, false)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Stop_UI_Bus)

	self._animSkip = true

	if needSkipAnim then
		self:_openAnimFinish()
	else
		self._animatorPlayer:Play("skip", self._openAnimFinish, self)
	end

	self:setFullScreenMaskVisible(false)
	self:stopDelayVideoOverTime()
	self:_resetVideo()
end

function CharacterGetView:_onBgClick()
	if self.isPlayLimitedVideo then
		gohelper.setActive(self._btnskip.gameObject, true)
	end

	if self._animFinish then
		local hasNewSkin = false

		if self._isRank then
			if self._startRank and self._startRank < self._newRank then
				for i = self._startRank + 1, self._newRank do
					if SkillConfig.instance:isGetNewSkin(self._heroId, i) then
						hasNewSkin = true
					end
				end
			else
				hasNewSkin = SkillConfig.instance:isGetNewSkin(self._heroId, self._newRank)
			end
		end

		if self._isRank and hasNewSkin then
			self:hideCurrentView()
			CharacterController.instance:dispatchEvent(CharacterEvent.showCharacterNewSkin)
		else
			self:closeThis()
		end
	elseif not self._animSkip and self._isSummon and self._duplicateCount > 0 then
		self:_skipAnim(true)
	end
end

function CharacterGetView:_editableInitView()
	self._animSkip = true
	self._gobg = gohelper.findChild(self.viewGO, "bg")
	self._gocontainer = gohelper.findChild(self.viewGO, "charactercontainer")
	self._bgClick = gohelper.getClickWithAudio(self._gobg)

	self._bgClick:AddClickListener(self._onBgClick, self)
	self._simagebg:LoadImage(ResUrl.getCommonViewBg("full/bg_characterget"))
	self._simageredcirclebg:LoadImage(ResUrl.getCharacterGetIcon("bg_yuan"))
	self._simagecircle:LoadImage(ResUrl.getCharacterGetIcon("bg_yuanchuan"))
	self._simageblackbg:LoadImage(ResUrl.getCharacterGetIcon("heisedi"))
	self._simagebgleft:LoadImage(ResUrl.getCharacterGetIcon("bg_wz"))

	self._uiSpine = GuiModelAgent.Create(self._gospine, true)

	self._uiSpine:setShareRT(CharacterVoiceEnum.RTShareType.Normal, self.viewName)

	self._starList = self:getUserDataTb_()

	for i = 1, 6 do
		local starGO = gohelper.findChild(self._gostarList, "star" .. i)

		table.insert(self._starList, starGO)
	end

	self._txttalkcn.text = ""
	self._txttalken.text = ""
	self._rankList = self:getUserDataTb_()
	self._goeffectstarList = gohelper.findChild(self.viewGO, "#go_bg/xingxing")
	self._effectstarList = self:getUserDataTb_()

	for i = 1, 6 do
		local starGO = gohelper.findChild(self._goeffectstarList, "star" .. i)

		table.insert(self._effectstarList, starGO)
	end

	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)
	self._animEventWrap = self._animator:GetComponent(typeof(ZProj.AnimationEventWrap))

	self._animEventWrap:AddEventListener("star", self._playStarAudio, self)
	self._animEventWrap:AddEventListener("skip", self._playSkip, self)

	self._videoGo = gohelper.findChild(self.viewGO, "#go_bg/videoplayer")

	self:setFullScreenMaskVisible(true)
end

function CharacterGetView:_initVideoPlayer()
	if not self._videoPlayer then
		self._videoPlayer, self._videoPlayerGO = VideoPlayerMgr.instance:createGoAndVideoPlayer(self._videoGo)
		self._videoPlayerGO = nil
	end
end

function CharacterGetView:setFullScreenMaskVisible(visible)
	gohelper.setActive(self._gobgmask, visible)
end

function CharacterGetView:_videoStatusUpdate(path, status, errorCode)
	if status == VideoEnum.PlayerStatus.Started or status == VideoEnum.PlayerStatus.FinishedSeeking or status == VideoEnum.PlayerStatus.Unpaused then
		self._animSkip = false

		self:setFullScreenMaskVisible(false)
		self._animatorPlayer:Play(UIAnimationName.Open, self._openAnimFinish, self)

		self._animator.speed = 1

		self._animator:Play(UIAnimationName.Idle, 1, 0)

		if self._rare < 3 then
			AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Get_Low_Hero)
		elseif self._rare < 5 then
			AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Get_Middle_Hero)
		else
			AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Get_High_Hero)
		end
	elseif status == VideoEnum.PlayerStatus.FinishedPlaying then
		if self._isSummon and not self._isSummonTen then
			gohelper.setActive(self._btnskip.gameObject, false)
		end

		self:setFullScreenMaskVisible(false)
		self:stopDelayVideoOverTime()
		self:_resetVideo()
	end
end

function CharacterGetView:_resetVideo()
	gohelper.setActive(self._videoGo, false)

	if not self._videoPlayer then
		return
	end

	if BootNativeUtil.isAndroid() or BootNativeUtil.isWindows() then
		self._videoPlayer:rewind(true)
	else
		self._videoPlayer:loadMedia("character_get_start")
	end
end

function CharacterGetView:_playSkip()
	self._animSkip = true

	logNormal("skip rare = " .. tostring(self._rare))

	if self._rare < 3 then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_LuckDraw_General_Last)
	elseif self._rare < 5 then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_LuckDraw_Medium_Last)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_LuckDraw_Special_Last)
	end
end

function CharacterGetView:_playStarAudio()
	if self._playedStar >= self._star then
		return
	end

	self._playedStar = self._playedStar + 1

	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_LuckDraw_Hero_Stars)
end

function CharacterGetView:_playOpenAnimation()
	TaskDispatcher.cancelTask(self._openAnimFinish, self)

	self._animator.enabled = true

	self._animator:Play(UIAnimationName.Open, 0, 0)
	self._animator:Play(UIAnimationName.Idle, 1, 0)

	self._animator.speed = 0

	self._animator:Update(0)
	self._animatorPlayer:Play(UIAnimationName.Open, self._openAnimFinish, self)
	gohelper.setActive(self._videoGo, true)
	self:_initVideoPlayer()
	self._videoPlayer:play("character_get_start", false, self._videoStatusUpdate, self)
	self._videoPlayer:rewind(false)
	TaskDispatcher.runDelay(self.handleVideoOverTime, self, 10)
end

function CharacterGetView:_openAnimFinish()
	self._animSkip = true

	TaskDispatcher.cancelTask(self._openAnimFinish, self)

	if gohelper.isNil(self._animator) then
		return
	end

	self._animator.enabled = true

	self._animator:Play(UIAnimationName.Loop, 0, 0)
	self._animator:Play(UIAnimationName.Voice, 1, 0)

	self._animFinish = true

	self:_tryPlayVoice()

	local config = HeroConfig.instance:getHeroCO(self._heroId)

	if not config then
		logError("找不到角色: " .. tostring(self._heroId))

		return
	end

	if self._isReplay or self.viewParam.hideToast then
		return
	end

	if self._isRank then
		GameFacade.showToast(ToastEnum.CharacterGet, config.name)
	elseif self.viewParam then
		local items = self.viewParam.items

		if items and #items > 0 then
			CharacterController.instance:showCharacterGetItemToast(items, self._heroId, self._duplicateCount)
		else
			CharacterController.instance:showCharacterGetToast(self._heroId, self._duplicateCount)
			CharacterController.instance:showCharacterGetTicket(self._heroId, self._summonTicketId)
		end
	end
end

function CharacterGetView:handleVideoOverTime()
	self:stopDelayVideoOverTime()
	self:setFullScreenMaskVisible(false)
	self:_resetVideo()
	gohelper.setActive(self._videoGo, false)
	self:_openAnimFinish()
end

function CharacterGetView:stopDelayVideoOverTime()
	TaskDispatcher.cancelTask(self.handleVideoOverTime, self)
end

function CharacterGetView:_loadSpine()
	local skinConfig

	if self._isRank then
		skinConfig = HeroModel.instance:getCurrentSkinConfig(self._heroId)
	else
		local heroConfig = HeroConfig.instance:getHeroCO(self._heroId)

		skinConfig = heroConfig and SkinConfig.instance:getSkinCo(heroConfig.skinId)
	end

	if skinConfig then
		self._skinConfig = skinConfig

		self._uiSpine:setResPath(skinConfig, self._onSpineLoaded, self)

		local offsets, isNil = SkinConfig.instance:getSkinOffset(skinConfig.characterGetViewOffset)

		if isNil then
			offsets, _ = SkinConfig.instance:getSkinOffset(skinConfig.characterViewOffset)
			offsets = SkinConfig.instance:getAfterRelativeOffset(505, offsets)
		end

		CharacterVoiceEnum.setSpineOffset(self._uiSpine, tonumber(offsets[1]), tonumber(offsets[2]))
		transformhelper.setLocalScale(self._gospine.transform, tonumber(offsets[3]), tonumber(offsets[3]), tonumber(offsets[3]))
	else
		logError("找不到角色皮肤: " .. tostring(self._heroId))
	end
end

function CharacterGetView:_refreshShow()
	local config = HeroConfig.instance:getHeroCO(self._heroId)

	if not config then
		logError("找不到角色: " .. tostring(self._heroId))

		return
	end

	if self._uiSpine then
		self._uiSpine:stopVoice()
	end

	gohelper.setActive(self._gobottomTalk, false)
	gohelper.setActive(self._btnskip.gameObject, self._isSummon and not SummonController.instance:isInSummonGuide())
	self:_loadSpine()

	self._txtcharacterNameCn.text = config.name

	self._simagecareericon:LoadImage(ResUrl.getCharacterGetIcon("charactercareer_big_0" .. config.career))
	UISpriteSetMgr.instance:setCharactergetSprite(self._imagecareericon, "charactercareer" .. config.career)
	UISpriteSetMgr.instance:setCharactergetSprite(self._imagecareerline, "line_" .. config.career)
	self._simagesignature:LoadImage(ResUrl.getSignature(config.signature, "characterget"), self._setSignatureImageSize, self)
	self._simagesignatureicon:LoadImage(ResUrl.getSignature("3011_2", "characterget"), self._setSignatureImageSize, self)

	self._playedStar = 0
	self._star = CharacterEnum.Star[config.rare]

	for i, starGO in ipairs(self._starList) do
		gohelper.setActive(starGO, i <= CharacterEnum.Star[config.rare])
	end

	for i, starGO in ipairs(self._effectstarList) do
		gohelper.setActive(starGO, i <= CharacterEnum.Star[config.rare])
	end

	self._simagetxtbg:LoadImage(ResUrl.getCharacterGetIcon("herorare_" .. config.rare))

	self._rare = config.rare

	gohelper.setActive(self._simagesignatureicon.gameObject, config.signature == "3011")
end

function CharacterGetView:_setSignatureImageSize()
	ZProj.UGUIHelper.SetImageSize(self._simagesignature.gameObject)
end

function CharacterGetView:_onSpineLoaded()
	self._spineLoaded = true

	self:_tryPlayVoice()
end

function CharacterGetView:_tryPlayVoice()
	if not self._animFinish or not self._spineLoaded then
		return
	end

	local voiceConfigs, voiceType

	voiceType = self._isRank and (SkillConfig.instance:isGetNewSkin(self._heroId, self._newRank) and CharacterEnum.VoiceType.GetSkin or CharacterEnum.VoiceType.BreakThrough) or CharacterEnum.VoiceType.Summon
	voiceConfigs = HeroModel.instance:getVoiceConfig(self._heroId, voiceType, nil, self._skinConfig and self._skinConfig.id)

	if not voiceConfigs or #voiceConfigs <= 0 then
		logNormal("没有对应的角色语音类型:" .. tostring(voiceType))

		return
	end

	local voiceConfig = voiceConfigs[math.random(#voiceConfigs)]

	self._uiSpine:playVoice(voiceConfig, nil, self._txttalkcn, self._txttalken, self._gobottomTalk)
end

function CharacterGetView:onOpen()
	gohelper.setActive(self._gocontainer, true)

	self._heroId = self.viewParam.heroId
	self._duplicateCount = self.viewParam.duplicateCount or 0
	self._callback = self.viewParam.callback
	self._callbackObj = self.viewParam.callbackObj
	self._callbackParam = self.viewParam.callbackParam
	self._isRank = self.viewParam.isRank
	self._newRank = self.viewParam.newRank
	self._startRank = self.viewParam.startRank
	self._isReplay = self.viewParam.isReplay
	self._isSummon = self.viewParam.isSummon
	self._isSummonTen = self.viewParam.isSummonTen
	self._skipVideo = self.viewParam.skipVideo
	self._summonTicketId = self.viewParam.summonTicketId
	self._mvSkinId = self.viewParam.mvSkinId

	if self.viewParam.openFromGuide then
		self._heroId = tonumber(self.viewParam.viewParam)

		HeroModel.instance:addGuideHero(self._heroId)
	end

	self._animFinish = false
	self._spineLoaded = false
	self.isPlayLimitedVideo = false
	self._goSkinDetailContainer = gohelper.findChild(self.viewGO, "characterskingetdetailview")

	gohelper.setActive(self._goSkinDetailContainer, false)
	self:_refreshShow()
	NavigateMgr.instance:addEscape(ViewName.CharacterGetView, self._onBgClick, self)

	if self._skipVideo then
		if self._mvSkinId then
			self:_playLimitedVideo(self._mvSkinId)
		else
			self:_skipAnim()
		end
	else
		self:_playOpenAnimation()
	end
end

function CharacterGetView:onUpdateParam()
	self._heroId = self.viewParam.heroId
	self._duplicateCount = self.viewParam.duplicateCount or 0
	self._callback = self.viewParam.callback
	self._callbackObj = self.viewParam.callbackObj
	self._callbackParam = self.viewParam.callbackParam
	self._isRank = self.viewParam.isRank
	self._newRank = self.viewParam.newRank
	self._isReplay = self.viewParam.isReplay
	self._isSummon = self.viewParam.isSummon
	self._isSummonTen = self.viewParam.isSummonTen
	self._skipVideo = self.viewParam.skipVideo
	self._spineLoaded = false
	self._animFinish = false
	self._mvSkinId = self.viewParam.mvSkinId
	self.isPlayLimitedVideo = false
	self._goSkinDetailContainer = gohelper.findChild(self.viewGO, "characterskingetdetailview")

	gohelper.setActive(self._goSkinDetailContainer, false)
	NavigateMgr.instance:addEscape(ViewName.CharacterGetView, self._onBgClick, self)
	self:_refreshShow()

	if self._skipVideo then
		if self._mvSkinId then
			self:_playLimitedVideo(self._mvSkinId)
		else
			self:_skipAnim()
		end
	else
		self:_playOpenAnimation()
	end
end

function CharacterGetView:hideCurrentView()
	self._animator:Play("characterget_skin")
end

function CharacterGetView:onClose()
	if self._isRank and self.viewContainer:isManualClose() then
		CharacterController.instance:openCharacterRankUpResultView(self._heroId)
	end

	TaskDispatcher.cancelTask(self._openAnimFinish, self)

	if self.viewParam.openFromGuide then
		HeroModel.instance:removeGuideHero(self._heroId)
	end

	if self._uiSpine then
		self._uiSpine:stopVoice()
	end

	gohelper.setActive(self._gocontainer, false)

	if self._callback then
		if self._callbackParam then
			self._callback(self._callbackObj, self._callbackParam)
		else
			self._callback(self._callbackObj)
		end
	end

	self:stopDelayVideoOverTime()
end

function CharacterGetView:_playLimitedVideo(mvSkinId)
	self._animator.enabled = true
	self._animator.speed = 0

	self._animator:Update(0)
	self._animator:Play(UIAnimationName.Open, 0, 0)
	self:setFullScreenMaskVisible(false)
	gohelper.setActive(self._videoGo, true)
	gohelper.setActive(self._btnskip.gameObject, false)
	self:_initVideoPlayer()

	self._limitedCO = lua_character_limited.configDict[mvSkinId]

	self._videoPlayer:play(self._limitedCO.entranceMv, false, self._limitedVideoStatusUpdate, self)

	self.isPlayLimitedVideo = true

	AudioBgmManager.instance:stopBgm(AudioBgmEnum.Layer.Summon)
	TaskDispatcher.runRepeat(self._stopMainBgm, self, 0.2, 100)
	TaskDispatcher.runDelay(self.handleVideoOverTime, self, self._limitedCO.mvtime)
end

function CharacterGetView:_stopMainBgm()
	AudioBgmManager.instance:stopBgm(AudioBgmEnum.Layer.Summon)
end

function CharacterGetView:_limitedVideoStatusUpdate(path, status, errorCode)
	if status == VideoEnum.PlayerStatus.Started and self._limitedCO and self._limitedCO.audio > 0 then
		AudioMgr.instance:trigger(self._limitedCO.audio)
	end

	if status == VideoEnum.PlayerStatus.FinishedPlaying then
		self:_limitedVideoFinished()
	end
end

function CharacterGetView:_limitedVideoFinished()
	if self._isSummon and not self._isSummonTen then
		gohelper.setActive(self._btnskip.gameObject, false)
	end

	if self._limitedCO and self._limitedCO.audio > 0 then
		AudioMgr.instance:trigger(self._limitedCO.stopAudio)
	end

	self.isPlayLimitedVideo = false
	self._animator.speed = 1

	self._animatorPlayer:Play("skip", self._openAnimFinish, self)
	self:setFullScreenMaskVisible(false)
	self:stopDelayVideoOverTime()
	self:_resetVideo()
	TaskDispatcher.cancelTask(self.handleVideoOverTime, self)
	AudioBgmManager.instance:playBgm(AudioBgmEnum.Layer.Summon)
end

function CharacterGetView:onDestroyView()
	self._bgClick:RemoveClickListener()
	self._simagebg:UnLoadImage()
	self._simageredcirclebg:UnLoadImage()
	self._simagecircle:UnLoadImage()
	self._simagetxtbg:UnLoadImage()
	self._simageblackbg:UnLoadImage()
	self._simagebgleft:UnLoadImage()
	self._simagecareericon:UnLoadImage()
	self._simagesignature:UnLoadImage()
	self._simagesignatureicon:UnLoadImage()
	TaskDispatcher.cancelTask(self._loadSpine, self)

	if self._uiSpine then
		self._uiSpine:onDestroy()

		self._uiSpine = nil
	end

	gohelper.setActive(self._gocontainer, true)
	gohelper.destroy(self._gocontainer)
	self._animEventWrap:RemoveAllEventListener()

	if self._videoPlayer then
		if not BootNativeUtil.isIOS() then
			self._videoPlayer:stop()
		end

		self._videoPlayer = nil
	end
end

return CharacterGetView
