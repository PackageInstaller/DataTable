-- chunkname: @modules/logic/character/view/CharacterSkinGainView.lua

module("modules.logic.character.view.CharacterSkinGainView", package.seeall)

local CharacterSkinGainView = class("CharacterSkinGainView", BaseView)

function CharacterSkinGainView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "root/bgroot/#simage_bg")
	self._simagelefticon = gohelper.findChildSingleImage(self.viewGO, "root/bgroot/#simage_lefticon")
	self._simagerighticon = gohelper.findChildSingleImage(self.viewGO, "root/bgroot/#simage_righticon")
	self._goskincontainer = gohelper.findChild(self.viewGO, "root/bgroot/#go_skincontainer")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "root/bgroot/#go_skincontainer/#simage_icon")
	self._simagemask = gohelper.findChildSingleImage(self.viewGO, "root/bgroot/#simage_mask")
	self._imagecareericon = gohelper.findChildImage(self.viewGO, "root/bgroot/#image_careericon")
	self._imagecareerline = gohelper.findChildImage(self.viewGO, "root/bgroot/#image_careericon/#image_careerline")
	self._txtlinecn = gohelper.findChildText(self.viewGO, "root/bottom/#txt_line_cn")
	self._txtlineen = gohelper.findChildText(self.viewGO, "root/bottom/#txt_line_cn/#txt_line_en")
	self._simagesignature = gohelper.findChildSingleImage(self.viewGO, "root/left/#simage_bg/#simage_signature")
	self._txtskinname = gohelper.findChildText(self.viewGO, "root/left/#simage_bg/#txt_skinname")
	self._txtname = gohelper.findChildText(self.viewGO, "root/left/#simage_bg/#txt_skinname/#txt_name")
	self._txtnameen = gohelper.findChildText(self.viewGO, "root/left/#simage_bg/#txt_skinname/#txt_name/#txt_name_en")
	self._btndress = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/#btn_clothing")
	self._goclothed = gohelper.findChild(self.viewGO, "root/right/#go_clothed")
	self._gocontentbg = gohelper.findChild(self.viewGO, "root/bottom/#go_contentbg")
	self._txtanacn = gohelper.findChildText(self.viewGO, "root/bottom/#txt_ana_cn")
	self._txtanaen = gohelper.findChildText(self.viewGO, "root/bottom/#txt_ana_en")
	self._golive2dcontainer = gohelper.findChild(self.viewGO, "root/bgroot/#go_live2dcontainer/live2dcontainer/#go_live2d")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterSkinGainView:addEvents()
	self._btndress:AddClickListener(self._btndressOnClick, self)
end

function CharacterSkinGainView:removeEvents()
	self._btndress:RemoveClickListener()
end

function CharacterSkinGainView:_btndressOnClick()
	if not self._switchFinish then
		return
	end

	HeroRpc.instance:sendUseSkinRequest(self._skinCo.characterId, self._skinCo.id)
end

function CharacterSkinGainView:_onBgClick()
	if self._switchFinish then
		self:closeThis()
	elseif self._animFinish then
		self:_playSwitchAnimation()
	end
end

function CharacterSkinGainView:_editableInitView()
	UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")

	self._uiSpine = GuiModelAgent.Create(self._golive2dcontainer, true)

	self._uiSpine:setShareRT(CharacterVoiceEnum.RTShareType.Normal, self.viewName)

	self._bgClick = gohelper.getClickWithAudio(self.viewGO)

	self._bgClick:AddClickListener(self._onBgClick, self)
	self._simagebg:LoadImage("singlebg/characterskin/full/bg_huode.png")
	self._simagelefticon:LoadImage("singlebg/characterskin/bg_huode_leftup.png")
	self._simagerighticon:LoadImage("singlebg/characterskin/bg_huode_rightdown.png")
	self._simagemask:LoadImage("singlebg/characterskin/full/bg_huode_mask.png")

	self._simagecareericon = gohelper.findChildSingleImage(self.viewGO, "root/bgroot/#image_careericon_big")
	self.goRight = gohelper.findChild(self.viewGO, "root/right")
	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)

	local parentGO = gohelper.findChild(self.viewGO, "root/bgroot/videoplayer")

	self._videoPlayer, _ = VideoPlayerMgr.instance:createGoAndVideoPlayer(parentGO)

	self._videoPlayer:setEventListener(self._videoStatusUpdate, self)
	self._videoPlayer:loadMedia("character_get_start")

	self._gostarList = gohelper.findChild(self.viewGO, "root/effect/xingxing")
	self._starList = self:getUserDataTb_()

	for i = 1, 6 do
		local starGO = gohelper.findChild(self._gostarList, "star" .. i)

		table.insert(self._starList, starGO)
	end

	gohelper.setActive(self._gocontentbg, false)

	self._txtanacn.text = ""
	self._txtanaen.text = ""

	self.addEventCb(self, CharacterController.instance, CharacterEvent.successDressUpSkin, self._successDressUpSkin, self)
end

function CharacterSkinGainView:_videoStatusUpdate(path, status, errorCode)
	if status == VideoEnum.PlayerStatus.Started then
		AudioMgr.instance:trigger(AudioEnum.Summon.play_ui_skin_get)
	elseif status == VideoEnum.PlayerStatus.FinishedPlaying then
		self:_resetVideo()
	end
end

function CharacterSkinGainView:_resetVideo()
	if BootNativeUtil.isAndroid() or BootNativeUtil.isWindows() then
		self._videoPlayer:stop()
	else
		self._videoPlayer:stop()
	end
end

function CharacterSkinGainView:onUpdateParam()
	return
end

function CharacterSkinGainView:onOpen()
	if self.playHeroVoice then
		self.playHeroVoice:dispose()
	end

	if self._uiSpine then
		self._uiSpine:stopVoice()
	end

	self._animFinish = false
	self._switchFinish = false

	NavigateMgr.instance:addEscape(self.viewName, self._onBgClick, self)
	self:_refreshView()
	self:_playOpenAnimation()
end

function CharacterSkinGainView:_refreshView()
	self._skinCo = SkinConfig.instance:getSkinCo(self.viewParam.skinId)
	self._heroMo = HeroModel.instance:getByHeroId(self._skinCo.characterId)

	local heroConfig = HeroConfig.instance:getHeroCO(self._skinCo.characterId)

	self:_setNameBgWidth(self._skinCo.characterSkin, (heroConfig or nil) and (heroConfig.name or ""))

	self._txtskinname.text = self._skinCo.characterSkin

	if heroConfig then
		gohelper.setActive(self._txtname.gameObject, true)

		self._txtname.text = heroConfig.name
	else
		gohelper.setActive(self._txtname.gameObject, false)
	end

	self._txtnameen.text = heroConfig.nameEng

	self._uiSpine:setResPath(self._skinCo, self._onUISpineLoaded, self)
	self._simageicon:LoadImage(ResUrl.getHeadIconImg(self._skinCo.id), self._loadedImage, self)
	self._simagesignature:LoadImage(ResUrl.getSignature(heroConfig.signature))
	UISpriteSetMgr.instance:setCharactergetSprite(self._imagecareericon, "charactercareer" .. heroConfig.career)
	UISpriteSetMgr.instance:setCharactergetSprite(self._imagecareerline, "line_" .. heroConfig.career)
	self._simagecareericon:LoadImage(ResUrl.getCharacterGetIcon("charactercareer_big_0" .. heroConfig.career))

	for i, starGO in ipairs(self._starList) do
		gohelper.setActive(starGO, i <= CharacterEnum.Star[heroConfig.rare])
	end

	self:refreshDressStatus()
end

function CharacterSkinGainView:_onUISpineLoaded()
	local offsetStr = self._skinCo.skinGainViewLive2dOffset

	if string.nilorempty(offsetStr) then
		offsetStr = self._skinCo.characterViewOffset
	end

	local offsets = SkinConfig.instance:getSkinOffset(offsetStr)

	CharacterVoiceEnum.setSpineOffset(self._uiSpine, tonumber(offsets[1]), tonumber(offsets[2]))
	transformhelper.setLocalScale(self._golive2dcontainer.transform, tonumber(offsets[3]), tonumber(offsets[3]), tonumber(offsets[3]))
end

function CharacterSkinGainView:_loadedImage()
	ZProj.UGUIHelper.SetImageSize(self._simageicon.gameObject)

	local offsetStr = self._skinCo.skinGainViewImgOffset

	if not string.nilorempty(offsetStr) then
		local offsets = string.splitToNumber(offsetStr, "#")

		recthelper.setAnchor(self._goskincontainer.transform, tonumber(offsets[1]), tonumber(offsets[2]))
		transformhelper.setLocalScale(self._goskincontainer.transform, tonumber(offsets[3]), tonumber(offsets[3]), tonumber(offsets[3]))
	else
		recthelper.setAnchor(self._goskincontainer.transform, 0, 0)
		transformhelper.setLocalScale(self._goskincontainer.transform, 1, 1, 1)
	end
end

function CharacterSkinGainView:_onSingleItemLoaded()
	local offsets = SkinConfig.instance:getSkinOffset(self._skinCo.skinGetDetailViewIconOffset)

	recthelper.setAnchor(self._simagesingleItemIcon.transform, tonumber(offsets[1]), tonumber(offsets[2]))
	transformhelper.setLocalScale(self._simagesingleItemIcon.transform, tonumber(offsets[3]), tonumber(offsets[3]), tonumber(offsets[3]))
end

function CharacterSkinGainView:_playOpenAnimation()
	TaskDispatcher.cancelTask(self._openAnimFinish, self)
	TaskDispatcher.runDelay(self._openAnimFinish, self, 10)

	self._animFinish = false

	self._animatorPlayer:Play(UIAnimationName.Open, self._openAnimFinish, self)
	self._videoPlayer:playLoadMedia(false)
end

function CharacterSkinGainView:_playSwitchAnimation()
	TaskDispatcher.cancelTask(self._switchAnimFinish, self)
	TaskDispatcher.runDelay(self._switchAnimFinish, self, 10)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_skin_get_1)

	self._switchFinish = false
	self._animFinish = false

	self._animatorPlayer:Play(UIAnimationName.Switch, self._switchAnimFinish, self)
end

function CharacterSkinGainView:_openAnimFinish()
	TaskDispatcher.cancelTask(self._openAnimFinish, self)

	self._animFinish = true
end

function CharacterSkinGainView:_switchAnimFinish()
	TaskDispatcher.cancelTask(self._switchAnimFinish, self)
	self:_playVoice()

	self._switchFinish = true

	self:refreshDressStatus()
end

function CharacterSkinGainView:_successDressUpSkin()
	GameFacade.showToast(ToastEnum.CharacterSkinGain, HeroConfig.instance:getHeroCO(self._skinCo.characterId).name)
	self:refreshDressStatus()
end

function CharacterSkinGainView:_playVoice()
	local voiceType = self._skinCo.gainApproach == CharacterEnum.SkinGainApproach.Rank and CharacterEnum.VoiceType.GetSkin or CharacterEnum.VoiceType.Summon

	if not voiceType then
		return
	end

	local voiceConfigs = HeroModel.instance:getVoiceConfig(self._skinCo.characterId, voiceType, nil, self._skinCo.id)

	if not voiceConfigs or #voiceConfigs <= 0 then
		if not self._heroMo then
			GameFacade.showToast(ToastEnum.DontHaveCharacter)
		end

		local voices = CharacterDataConfig.instance:getCharacterVoicesCo(self._skinCo.characterId)

		voiceConfigs = {}

		if voices then
			for _, config in pairs(voices) do
				if config.type == voiceType and HeroModel.instance:_checkSkin(nil, config, self._skinCo.id) then
					table.insert(voiceConfigs, config)
				end
			end
		end
	end

	if not voiceConfigs or #voiceConfigs <= 0 then
		logNormal("没有对应的角色语音类型:" .. tostring(voiceType))

		return
	end

	local voiceConfig = voiceConfigs[math.random(#voiceConfigs)]

	self._uiSpine:playVoice(voiceConfig, nil, self._txtanacn, self._txtanaen, self._gocontentbg)
end

function CharacterSkinGainView:_setNameBgWidth(skinName, name)
	self._nameBgRoot = gohelper.findChild(self.viewGO, "root/left/#simage_bg")
	self._nameBg = gohelper.findChild(self._nameBgRoot, "bg")

	local skinNameWidth = SLFramework.UGUI.GuiHelper.GetPreferredWidth(self._txtskinname, skinName)
	local nameWidth = SLFramework.UGUI.GuiHelper.GetPreferredWidth(self._txtname, name)
	local namePosX = recthelper.getAnchorX(self._txtname.transform) or 0
	local addWidth = nameWidth - math.abs(namePosX)
	local bgWidth = skinNameWidth + addWidth + 450

	recthelper.setWidth(self._nameBg.transform, bgWidth)
end

function CharacterSkinGainView:refreshDressStatus()
	gohelper.setActive(self.goRight, self._heroMo)

	if not self._switchFinish then
		gohelper.setActive(self._btndress.gameObject, false)
		gohelper.setActive(self._goclothed, false)

		return
	end

	if self._heroMo then
		gohelper.setActive(self._btndress.gameObject, self._skinCo.id ~= self._heroMo.skin)
		gohelper.setActive(self._goclothed, self._skinCo.id == self._heroMo.skin)
	end
end

function CharacterSkinGainView:onClose()
	TaskDispatcher.cancelTask(self._switchAnimFinish, self)
	TaskDispatcher.cancelTask(self._openAnimFinish, self)
	self._simagesignature:UnLoadImage()
end

function CharacterSkinGainView:onDestroyView()
	if self._videoPlayer then
		if not BootNativeUtil.isIOS() then
			self._videoPlayer:stop()
		end

		self._videoPlayer:clear()

		self._videoPlayer = nil
	end

	if self._uiSpine then
		self._uiSpine:stopVoice()
		self._uiSpine:onDestroy()

		self._uiSpine = nil
	end

	if self.playHeroVoice then
		self.playHeroVoice:dispose()
	end

	if self._bgClick then
		self._bgClick:RemoveClickListener()
	end

	NavigateMgr.instance:removeEscape(self.viewName, self._onBgClick, self)
	self._simagebg:UnLoadImage()
	self._simagemask:UnLoadImage()
	self._simagelefticon:UnLoadImage()
	self._simagerighticon:UnLoadImage()
end

return CharacterSkinGainView
