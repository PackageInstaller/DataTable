-- chunkname: @modules/logic/characterskin/view/CharacterSkinLeftView.lua

module("modules.logic.characterskin.view.CharacterSkinLeftView", package.seeall)

local CharacterSkinLeftView = class("CharacterSkinLeftView", BaseView)

function CharacterSkinLeftView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._gozs = gohelper.findChild(self.viewGO, "zs")
	self._simagebgmask = gohelper.findChildSingleImage(self.viewGO, "#simage_bgmask")
	self._gosmallspine = gohelper.findChild(self.viewGO, "smalldynamiccontainer/#go_smallspine")
	self._simageskin = gohelper.findChildSingleImage(self.viewGO, "characterSpine/#go_skincontainer/#simage_skin")
	self._simagel2d = gohelper.findChildSingleImage(self.viewGO, "characterSpine/#go_skincontainer/#simage_l2d")
	self._gobigspine = gohelper.findChild(self.viewGO, "characterSpine/#go_skincontainer/#go_spinecontainer/#go_spine")
	self._simagesignature = gohelper.findChildSingleImage(self.viewGO, "desc/#simage_signature")
	self._simagesignatureicon = gohelper.findChildSingleImage(self.viewGO, "desc/#simage_signatureicon")
	self._txtcharacterName = gohelper.findChildText(self.viewGO, "desc/#txt_characterName")
	self._txtskinName = gohelper.findChildText(self.viewGO, "desc/#txt_skinName")
	self._txtskinNameEn = gohelper.findChildText(self.viewGO, "desc/#txt_skinName/#txt_skinNameEn")
	self._txtdesc = gohelper.findChildText(self.viewGO, "desc/#txt_desc")
	self._btnshowDetail = gohelper.findChildButtonWithAudio(self.viewGO, "desc/#txt_characterName/#btn_showDetail")
	self._btntag = gohelper.findChildButtonWithAudio(self.viewGO, "desc/#btn_tag")
	self._btnswitch = gohelper.findChildButtonWithAudio(self.viewGO, "desc/#btn_switch")
	self._btnvideo = gohelper.findChildButtonWithAudio(self.viewGO, "desc/#btn_video")
	self._txtswitch = gohelper.findChildText(self.viewGO, "desc/#btn_switch/#txt_switch")
	self._goLeftStoryInfo = gohelper.findChild(self.viewGO, "#go_left")
	self._scrollContent = gohelper.findChild(self.viewGO, "#go_left/#scroll_contentlist/viewport/content")
	self._textStoryDesc = gohelper.findChildText(self.viewGO, "#go_left/#scroll_contentlist/viewport/content/#txt_dec")
	self._imageStoryDescBg = gohelper.findChildSingleImage(self.viewGO, "#go_left/simage_leftbg")
	self._btnStoryDesc = gohelper.findChildButtonWithAudio(self.viewGO, "desc/#btn_detail")
	self._btnStoryReturn = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_storyReturn")
	self._goskinItemListRoot = gohelper.findChild(self.viewGO, "container/normal/skinSwitch/#scroll_skinSwitch")
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterSkinLeftView:addEvents()
	self._btnshowDetail:AddClickListener(self._btnshowDetailOnClick, self)
	self._btntag:AddClickListener(self._btntagOnClick, self)
	self._btnvideo:AddClickListener(self._btnvideoOnClick, self)
	self._btnswitch:AddClickListener(self._btnswitchOnClick, self)
	self._btnStoryDesc:AddClickListener(self._btnStoryOnClick, self)
	self._btnStoryReturn:AddClickListener(self._btnStoryReturnOnClick, self)
end

function CharacterSkinLeftView:removeEvents()
	self._btnshowDetail:RemoveClickListener()
	self._btntag:RemoveClickListener()
	self._btnvideo:RemoveClickListener()
	self._btnswitch:RemoveClickListener()
	self._btnStoryDesc:RemoveClickListener()
	self._btnStoryReturn:RemoveClickListener()
end

function CharacterSkinLeftView:onSwitchAnimDone()
	self:setShaderKeyWord(false)
end

function CharacterSkinLeftView:_btnswitchOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_switch_skin_l2d)

	self.showDynamicVertical = not self.showDynamicVertical

	if not self._isStoryMode then
		local isInStoryMode = self._enterStoryMode
		local switchAniName = isInStoryMode and "left_swicth" or "switch"

		self._animator:Play(switchAniName, 0, 0)
		self:setShaderKeyWord(true)
		self:refreshTxtSwitch()
		TaskDispatcher.runDelay(self.refreshBigVertical, self, 0.16)
		TaskDispatcher.runDelay(self.onSwitchAnimDone, self, 0.6)

		if self.heroCo then
			if self.skinCo then
				local skinId = self.skinCo.id

				CharacterController.instance:trackInteractiveSkinDetails(self.heroCo, skinId, StatEnum.ClickType.Switch)
			end
		end
	end
end

function CharacterSkinLeftView:_btnvideoOnClick()
	if not self.skinCo then
		return
	end

	local heroId = self.skinCo.characterId
	local skinId = self.skinCo.id
	local heroCfg = HeroConfig.instance:getHeroCO(heroId)

	if not heroCfg then
		return
	end

	local url = WebViewController.instance:getVideoUrl(heroId, skinId)

	logNormal("播放视频,当前英雄id:" .. heroId .. " 皮肤id: " .. skinId .. " url: " .. url)
	WebViewController.instance:openWebView(url, false, self.OnWebViewBack, self)
	CharacterController.instance:statCharacterSkinVideoData(heroId, heroCfg.name, skinId, self.skinCo.name)
end

function CharacterSkinLeftView:OnWebViewBack(errorType, msg)
	if errorType == WebViewEnum.WebViewCBType.Cb and msg == "webClose" then
		ViewMgr.instance:closeView(ViewName.WebView)
	end

	logNormal("URL Jump Callback msg" .. msg)
end

function CharacterSkinLeftView:_btntagOnClick()
	gohelper.setActive(self._btnvideo, false)

	local var_8_0 = {
		skinCo = self.skinCo
	}

	var_8_0.isInStoryMode = self._isStoryMode or self._enterStoryMode

	ViewMgr.instance:openView(ViewName.CharacterSkinTagView, var_8_0)

	if self.heroCo then
		if self.skinCo then
			local skinId = self.skinCo.id

			CharacterController.instance:trackInteractiveSkinDetails(self.heroCo, skinId, StatEnum.ClickType.Tag)
		end
	end
end

function CharacterSkinLeftView:_btnshowDetailOnClick()
	CharacterController.instance:openCharacterSkinFullScreenView(self.skinCo, false, (self.showDynamicVertical or nil) and (CharacterEnum.ShowSkinEnum.Dynamic or CharacterEnum.ShowSkinEnum.Static))

	if self.heroCo then
		if self.skinCo then
			local skinId = self.skinCo.id

			CharacterController.instance:trackInteractiveSkinDetails(self.heroCo, skinId, StatEnum.ClickType.Detail)
		end
	end
end

function CharacterSkinLeftView:_btnStoryOnClick()
	local goDrag = gohelper.findChild(self.viewGO, "drag")

	if goDrag then
		gohelper.setActive(goDrag, false)
	end

	self._enterStoryMode = true

	self:refreshSkinStoryMode(true)
end

function CharacterSkinLeftView:_btnStoryReturnOnClick()
	local goDrag = gohelper.findChild(self.viewGO, "drag")

	if goDrag then
		gohelper.setActive(goDrag, true)
	end

	self._enterStoryMode = false

	self:refreshSkinStoryMode(false)
end

function CharacterSkinLeftView:_onOpenView(viewName)
	if self.showDynamicVertical and viewName == ViewName.CharacterSkinFullScreenView then
		gohelper.setActive(self.goBigDynamicContainer, false)
	end
end

function CharacterSkinLeftView:_onCloseViewFinish(viewName)
	if ViewHelper.instance:checkViewOnTheTop(self.viewName) then
		self:setShaderKeyWord(false)
	end
end

function CharacterSkinLeftView:_onCloseView(viewName)
	if self.showDynamicVertical and viewName == ViewName.CharacterSkinFullScreenView then
		gohelper.setActive(self.goBigDynamicContainer, true)
	end

	if viewName == ViewName.CharacterSkinTagView then
		self:_refreshVideoBtnState(false)
	end
end

function CharacterSkinLeftView:_editableInitView()
	self.showDynamicVertical = false
	self.smallSpine = GuiSpine.Create(self._gosmallspine, false)
	self.goBigDynamicContainer = gohelper.findChild(self.viewGO, "characterSpine/#go_skincontainer/#go_spinecontainer")
	self.goBigStaticContainer = self._simageskin.gameObject

	self._simagebg:LoadImage(ResUrl.getCharacterSkinIcon("full/pifubeijing_012"))
	self._simagebgmask:LoadImage(ResUrl.getCharacterSkinIcon("mask"))
	self.addEventCb(self, CharacterController.instance, CharacterEvent.OnSwitchSkin, self.switchSkin, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.OnSwitchSkinVertical, self.switchSkinVertical, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
end

function CharacterSkinLeftView:onOpen()
	local var_16_0 = self.viewParam

	if self.viewParam then
		var_16_0 = LuaUtil.isTable(self.viewParam)
		var_16_0 = var_16_0 and self.viewParam.storyMode
	end

	self._isStoryMode = var_16_0

	self:refreshSkinStoryView(self._isStoryMode)
end

function CharacterSkinLeftView:refreshTxtSwitch()
	self._txtswitch.text = self.showDynamicVertical and luaLang("storeskinpreviewview_btnswitch") or "L2D"
end

function CharacterSkinLeftView:switchSkinVertical(isShowDynamic, viewName)
	if self.viewName == viewName then
		self.showDynamicVertical = isShowDynamic
	end
end

function CharacterSkinLeftView:switchSkin(skinCo, viewName)
	if self.viewName == viewName then
		self.skinCo = skinCo
		self.heroCo = HeroConfig.instance:getHeroCO(self.skinCo.characterId)

		self:refreshSkin()
	end
end

function CharacterSkinLeftView:refreshSignature()
	self._simagesignature:LoadImage(ResUrl.getSignature(self.heroCo.signature, "characterget"))

	if self.skinCo.signature == "3011" then
		self._simagesignatureicon:LoadImage(ResUrl.getSignature("3011_2", "characterget"))
		gohelper.setActive(self._simagesignatureicon.gameObject, true)
	else
		gohelper.setActive(self._simagesignatureicon.gameObject, false)
	end
end

function CharacterSkinLeftView:refreshSkin()
	self:resetRes()
	self:refreshSignature()
	self:refreshBigVertical()
	self:refreshSmallVertical()
	self:_refreshSkinInfo()

	if not self._isStoryMode then
		self:refreshSkinStoryView(self._isStoryMode)
		CharacterController.instance:dispatchEvent(CharacterEvent.OnSkinSwitchSpine, self.skinCo.id)
	end
end

function CharacterSkinLeftView:resetRes()
	if self.bigSpine then
		self.bigSpine:onDestroy()
	end

	self._simageskin:UnLoadImage()
	self._simagel2d:UnLoadImage()
end

function CharacterSkinLeftView:refreshBigVertical()
	gohelper.setActive(self.goBigDynamicContainer, self.showDynamicVertical)
	gohelper.setActive(self._simageskin.gameObject, not self.showDynamicVertical)

	if self.showDynamicVertical then
		if self.bigSpine == nil then
			self.bigSpine = GuiModelAgent.Create(self._gobigspine, true)

			self.bigSpine:setShareRT(CharacterVoiceEnum.RTShareType.Normal, self.viewName)
		end

		self.bigSpine:setResPath(self.skinCo, self.onBigSpineLoaded, self)
	else
		self._simageskin:LoadImage(ResUrl.getHeadIconImg(self.skinCo.id), self._loadedImage, self)
	end

	local live2dbg = self.skinCo.live2dbg

	if not string.nilorempty(live2dbg) then
		gohelper.setActive(self._simagel2d.gameObject, self.showDynamicVertical)
		gohelper.setActive(self._gozs, self.showDynamicVertical)
		self._simagel2d:LoadImage(ResUrl.getCharacterSkinLive2dBg(live2dbg))
	else
		gohelper.setActive(self._simagel2d.gameObject, false)
		gohelper.setActive(self._gozs, false)
	end
end

function CharacterSkinLeftView:_refreshSkinInfo()
	gohelper.setActive(self._btnswitch, self.skinCo.showSwitchBtn == 1)

	local heroCo = HeroConfig.instance:getHeroCO(self.skinCo.characterId)

	self._txtcharacterName.text = heroCo.name
	self._txtdesc.text = self.skinCo.skinDescription

	self:_refreshVideoBtnState(true)

	if string.nilorempty(self.skinCo.characterSkin) then
		gohelper.setActive(self._txtskinName.gameObject, false)
		gohelper.setActive(self._txtskinNameEn.gameObject, false)
	else
		gohelper.setActive(self._txtskinName.gameObject, true)
		gohelper.setActive(self._txtskinNameEn.gameObject, true)

		self._txtskinName.text = "— " .. self.skinCo.characterSkin
		self._txtskinNameEn.text = self.skinCo.characterSkinNameEng
	end

	gohelper.setActive(self._btntag.gameObject, not string.nilorempty(self.skinCo.storeTag))
	self:refreshTxtSwitch()
end

function CharacterSkinLeftView:_refreshVideoBtnState(sendEvent)
	local isReview = VersionValidator.instance:isInReviewing()
	local showVideo = not isReview and self.skinCo.isSkinVideo

	gohelper.setActive(self._btnvideo, showVideo)

	if showVideo and sendEvent then
		CharacterController.instance:dispatchEvent(CharacterEvent.onVideoBtnDisplay, self.viewContainer.viewName)
	end
end

function CharacterSkinLeftView:onBigSpineLoaded()
	self.bigSpine:setAllLayer(UnityLayer.SceneEffect)

	local offsetStr = self.skinCo.skinSwitchLive2dOffset

	if string.nilorempty(offsetStr) then
		offsetStr = self.skinCo.characterViewOffset
	end

	local offsets = SkinConfig.instance:getSkinOffset(offsetStr)

	CharacterVoiceEnum.setSpineOffset(self.bigSpine, tonumber(offsets[1]), tonumber(offsets[2]))
	transformhelper.setLocalScale(self._gobigspine.transform, tonumber(offsets[3]), tonumber(offsets[3]), tonumber(offsets[3]))
end

function CharacterSkinLeftView:_loadedImage()
	ZProj.UGUIHelper.SetImageSize(self._simageskin.gameObject)

	local offsetStr = self.skinCo.skinViewImgOffset

	if not string.nilorempty(offsetStr) then
		local offsets = string.splitToNumber(offsetStr, "#")

		recthelper.setAnchor(self._simageskin.transform, tonumber(offsets[1]), tonumber(offsets[2]))
		transformhelper.setLocalScale(self._simageskin.transform, tonumber(offsets[3]), tonumber(offsets[3]), tonumber(offsets[3]))
	else
		recthelper.setAnchor(self._simageskin.transform, -150, -150)
		transformhelper.setLocalScale(self._simageskin.transform, 0.6, 0.6, 0.6)
	end
end

function CharacterSkinLeftView:refreshSmallVertical()
	self.smallSpine:stopVoice()
	self.smallSpine:setResPath(ResUrl.getSpineUIPrefab(self.skinCo.spine), self.onSmallSpineLoaded, self, true)
end

function CharacterSkinLeftView:onSmallSpineLoaded()
	local offsets = SkinConfig.instance:getSkinOffset(self.skinCo.skinSpineOffset)

	recthelper.setAnchor(self._gosmallspine.transform, tonumber(offsets[1]), tonumber(offsets[2]))
	transformhelper.setLocalScale(self._gosmallspine.transform, tonumber(offsets[3]), tonumber(offsets[3]), tonumber(offsets[3]))
end

function CharacterSkinLeftView:refreshSkinStoryMode(active)
	self:refreshSkinStoryView(active)
	self:refreshSkinStoryModeAni(active)
end

function CharacterSkinLeftView:refreshSkinStoryView(active)
	local suitId = HandbookConfig.instance:getSkinSuitIdBySkinId(self.skinCo.id)

	if active then
		gohelper.setActive(self._goskinItemListRoot, false)
		gohelper.setActive(self._goLeftStoryInfo, true)

		self._textStoryDesc.text = self.skinCo.skinStory

		self._imageStoryDescBg:LoadImage(ResUrl.getCharacterSkinStoryBg(suitId))
		gohelper.setActive(self._btnStoryDesc.gameObject, false)

		if self._enterStoryMode then
			gohelper.setActive(self._btnStoryReturn.gameObject, true)
		end

		ZProj.UGUIHelper.RebuildLayout(self._scrollContent.transform)
		ZProj.UGUIHelper.RebuildLayout(self._textStoryDesc.transform)
	else
		gohelper.setActive(self._goskinItemListRoot, true)
		gohelper.setActive(self._goLeftStoryInfo, false)
		gohelper.setActive(self._btnStoryDesc.gameObject, suitId ~= nil)
		gohelper.setActive(self._btnStoryReturn.gameObject, false)
	end
end

function CharacterSkinLeftView:refreshSkinStoryModeAni(active)
	if active then
		self._animator:Play("left_open", 0, 0)
	else
		self._animator:Play("left_close", 0, 0)
	end
end

function CharacterSkinLeftView:onClose()
	self._simageskin:UnLoadImage()
	self._simagesignature:UnLoadImage()
	self._simagesignatureicon:UnLoadImage()
	self._simagel2d:UnLoadImage()
	self._imageStoryDescBg:UnLoadImage()

	if self.bigSpine then
		self.bigSpine:setModelVisible(false)
	end
end

function CharacterSkinLeftView:setShaderKeyWord(enable)
	if enable then
		UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
	else
		UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
	end
end

function CharacterSkinLeftView:onDestroyView()
	TaskDispatcher.cancelTask(self.onSwitchAnimDone, self)
	TaskDispatcher.cancelTask(self.refreshBigVertical, self)

	if self.smallSpine then
		self.smallSpine:stopVoice()

		self.smallSpine = nil
	end

	if self.bigSpine then
		self.bigSpine:onDestroy()

		self.bigSpine = nil
	end

	self._simagebg:UnLoadImage()
	self._simagebgmask:UnLoadImage()
end

return CharacterSkinLeftView
