-- chunkname: @modules/logic/character/view/skin/CharacterPastSkinGainView.lua

module("modules.logic.character.view.skin.CharacterPastSkinGainView", package.seeall)

local CharacterPastSkinGainView = class("CharacterPastSkinGainView", BaseView)

function CharacterPastSkinGainView:onInitView()
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
	self._gonormalSkin = gohelper.findChild(self.viewGO, "root/left/#simage_bg/#txt_skinname/#go_normalSkin")
	self._btnswitch = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/#btn_switch")
	self._gonormalSkinEffect = gohelper.findChild(self.viewGO, "root/normalSkinEffect")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterPastSkinGainView:addEvents()
	self._btnswitch:AddClickListener(self._btnswitchOnClick, self)
end

function CharacterPastSkinGainView:removeEvents()
	self._btnswitch:RemoveClickListener()
end

function CharacterPastSkinGainView:_btnswitchOnClick()
	if not self._skinFinish then
		return
	end

	PopupController.instance._popupList._dataList = {}

	CharacterSwitchListModel.instance:setJumpShowHeroSkin(self._heroId, self._skinId)

	local param = {
		isSwitch = true,
		jumpTabs = {
			1
		}
	}

	MainController.instance:waitOpenMainThumbnailView(true)
	NavigateButtonsView.homeClick()
	MainController.instance:openMainThumbnailView(param, true)
end

function CharacterPastSkinGainView:_onBgClick()
	if not self._skinFinish then
		return
	end

	self:closeThis()
end

function CharacterPastSkinGainView:_showSwitchBtn()
	local popupList = PopupController.instance._popupList._dataList

	if popupList then
		if not #popupList then
			local count = 0

			gohelper.setActive(self._btnswitch.gameObject, count == 0)
		end
	end
end

function CharacterPastSkinGainView:_editableInitView()
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
	self._sp = CharacterSpName.s_createByView(self, gohelper.findChild(self.viewGO, "root/left/#simage_bg/#txt_skinname/sp")):bindName0(self._txtname):bindName0En(self._txtnameen):simpleBindSpNameWithBg()

	gohelper.setActive(self._btnswitch.gameObject, true)
	gohelper.setActive(self._gonormalSkin, true)
	gohelper.setActive(self.goRight, true)
	gohelper.setActive(self._btndress.gameObject, false)
	gohelper.setActive(self._goclothed, false)
end

function CharacterPastSkinGainView:onOpen()
	if self.playHeroVoice then
		self.playHeroVoice:dispose()
	end

	if self._uiSpine then
		self._uiSpine:stopVoice()
	end

	self._animFinish = false
	self._switchFinish = false
	self._skinFinish = false

	NavigateMgr.instance:addEscape(self.viewName, self._onBgClick, self)
	self:_refreshView()
	self:_playSkinAnimation()
	gohelper.setActive(self._txtname.gameObject, false)
	self:_showSwitchBtn()
end

function CharacterPastSkinGainView:_refreshView()
	self._skinId = self.viewParam.skinId
	self._skinCo = SkinConfig.instance:getSkinCo(self._skinId)
	self._heroId = self.viewParam.heroId or self._skinCo.characterId

	local heroConfig = HeroConfig.instance:getHeroCO(self._heroId)

	self:_setNameBgWidth(self._skinCo.characterSkin, (heroConfig or nil) and (heroConfig.name or ""))

	self._txtskinname.text = self._skinCo.characterSkin

	if heroConfig then
		self._sp:onUpdateMO({
			heroId = self._heroId
		}):setAsML_SpAndName0()
	else
		self._sp:setActiveNameOnly(false)
		self._sp:setActive(false)
	end

	self._uiSpine:setResPath(self._skinCo, self._onUISpineLoaded, self)
	self._simagesignature:LoadImage(ResUrl.getSignature(heroConfig.signature))
	UISpriteSetMgr.instance:setCharactergetSprite(self._imagecareericon, "charactercareer" .. heroConfig.career)
	UISpriteSetMgr.instance:setCharactergetSprite(self._imagecareerline, "line_" .. heroConfig.career)
	self._simagecareericon:LoadImage(ResUrl.getCharacterGetIcon("charactercareer_big_0" .. heroConfig.career))

	for i, starGO in ipairs(self._starList) do
		gohelper.setActive(starGO, i <= CharacterEnum.Star[heroConfig.rare])
	end
end

function CharacterPastSkinGainView:_onUISpineLoaded()
	local offsetStr = self._skinCo.skinGainViewLive2dOffset

	if string.nilorempty(offsetStr) then
		offsetStr = self._skinCo.characterViewOffset
	end

	local offsets = SkinConfig.instance:getSkinOffset(offsetStr)

	CharacterVoiceEnum.setSpineOffset(self._uiSpine, tonumber(offsets[1]), tonumber(offsets[2]))
	transformhelper.setLocalScale(self._golive2dcontainer.transform, tonumber(offsets[3]), tonumber(offsets[3]), tonumber(offsets[3]))
end

function CharacterPastSkinGainView:_loadedImage()
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

function CharacterPastSkinGainView:_onSingleItemLoaded()
	local offsets = SkinConfig.instance:getSkinOffset(self._skinCo.skinGetDetailViewIconOffset)

	recthelper.setAnchor(self._simagesingleItemIcon.transform, tonumber(offsets[1]), tonumber(offsets[2]))
	transformhelper.setLocalScale(self._simagesingleItemIcon.transform, tonumber(offsets[3]), tonumber(offsets[3]), tonumber(offsets[3]))
end

function CharacterPastSkinGainView:_playSkinAnimation()
	TaskDispatcher.cancelTask(self._skinAnimFinish, self)
	TaskDispatcher.runDelay(self._skinAnimFinish, self, 10)

	self._skinFinish = false

	self._animatorPlayer:Play("skin", self._skinAnimFinish, self)
	AudioMgr.instance:trigger(AudioEnum4_0.Past.play_ui_role_get_4_0)
end

function CharacterPastSkinGainView:_skinAnimFinish()
	TaskDispatcher.cancelTask(self._skinAnimFinish, self)
	self:_playVoice()

	self._skinFinish = true
end

function CharacterPastSkinGainView:_playVoice()
	local voiceType = self._skinCo.gainApproach == CharacterEnum.SkinGainApproach.Rank and CharacterEnum.VoiceType.GetSkin or CharacterEnum.VoiceType.Summon

	if not voiceType then
		return
	end

	local voiceConfigs = HeroModel.instance:getVoiceConfig(self._heroId, voiceType, nil, self._skinId)

	if not voiceConfigs or #voiceConfigs <= 0 then
		local voices = CharacterDataConfig.instance:getCharacterVoicesCo(self._heroId)

		voiceConfigs = {}

		if voices then
			for _, config in pairs(voices) do
				if config.type == voiceType and HeroModel.instance:_checkSkin(nil, config, self._skinId) then
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

function CharacterPastSkinGainView:_setNameBgWidth(skinName, name)
	self._nameBgRoot = gohelper.findChild(self.viewGO, "root/left/#simage_bg")
	self._nameBg = gohelper.findChild(self._nameBgRoot, "bg")

	local skinNameWidth = SLFramework.UGUI.GuiHelper.GetPreferredWidth(self._txtskinname, skinName)
	local nameWidth = SLFramework.UGUI.GuiHelper.GetPreferredWidth(self._txtname, name)
	local namePosX = recthelper.getAnchorX(self._txtname.transform) or 0
	local addWidth = nameWidth - math.abs(namePosX)
	local bgWidth = skinNameWidth + addWidth + 450

	recthelper.setWidth(self._nameBg.transform, bgWidth)
end

function CharacterPastSkinGainView:onClose()
	self._simagesignature:UnLoadImage()
end

function CharacterPastSkinGainView:onDestroyView()
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
	GameUtil.onDestroyViewMember(self, "_sp")
end

return CharacterPastSkinGainView
