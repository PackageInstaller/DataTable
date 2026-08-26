-- chunkname: @modules/logic/character/view/CharacterDataTitleView.lua

module("modules.logic.character.view.CharacterDataTitleView", package.seeall)

local CharacterDataTitleView = class("CharacterDataTitleView", BaseView)

function CharacterDataTitleView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "bg/simagebg/#simage_bg_uicanvas")
	self._simagecentericon = gohelper.findChildSingleImage(self.viewGO, "bg/simagebg/#simage_centericon")
	self._simagelefticon = gohelper.findChildSingleImage(self.viewGO, "bg/simagebg/#simage_lefticon")
	self._simagerighticon = gohelper.findChildSingleImage(self.viewGO, "bg/simagebg/#simage_righticon")
	self._simagerighticon2 = gohelper.findChildSingleImage(self.viewGO, "bg/simagebg/#simage_righticon2")
	self._simagemask = gohelper.findChildSingleImage(self.viewGO, "bg/simagebg/#simage_mask")
	self._btnuttuicon = gohelper.findChildButtonWithAudio(self.viewGO, "bg/#btn_uttuicon")
	self._btnskinswitch = gohelper.findChildButtonWithAudio(self.viewGO, "content/intro/#btn_skinswitch")
	self._simagesignature = gohelper.findChildSingleImage(self.viewGO, "content/intro/#simage_signature")
	self._gospine = gohelper.findChild(self.viewGO, "content/character/charactericoncontainer/#go_spine")
	self._txtname = gohelper.findChildText(self.viewGO, "content/intro/container/#txt_name")
	self._gohandbook = gohelper.findChild(self.viewGO, "content/intro/#go_handbook")
	self._careericon = gohelper.findChildImage(self.viewGO, "content/intro/container/#txt_name/#image_career")
	self._gostarlist = gohelper.findChild(self.viewGO, "content/intro/#go_handbook/#go_starList")
	self._goCharacterStaticContainer = gohelper.findChild(self.viewGO, "content/character/#simage_characterstaticskin")
	self._goCharacterDynamicContainer = gohelper.findChild(self.viewGO, "content/character/charactericoncontainer")
	self._txtintroduce = gohelper.findChildText(self.viewGO, "content/intro/#txt_introduce")
	self._txtmedium = gohelper.findChildText(self.viewGO, "content/intro/introduce2/#txt_medium")
	self._txtinspiration = gohelper.findChildText(self.viewGO, "content/intro/introduce2/#txt_inspiration")
	self._txtaroma = gohelper.findChildText(self.viewGO, "content/intro/introduce2/#txt_aroma")
	self._txtsize = gohelper.findChildText(self.viewGO, "content/intro/introduce2/#txt_size")
	self._imagefetter = gohelper.findChildImage(self.viewGO, "content/fetter/#image_fetter")
	self._txtfetter = gohelper.findChildText(self.viewGO, "content/fetter/#txt_fetter")
	self._gohasskin = gohelper.findChild(self.viewGO, "content/#pifu")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterDataTitleView:addEvents()
	self._btnuttuicon:AddClickListener(self._onUttuBtnClick, self)
end

function CharacterDataTitleView:removeEvents()
	self._btnuttuicon:RemoveClickListener()
end

function CharacterDataTitleView:_editableInitView()
	self._animbtnskinswitch = self._btnskinswitch:GetComponent(typeof(UnityEngine.Animator))

	self._simagebg:LoadImage(ResUrl.getCommonIcon("full/bg_fmand2"))
	self._simagecentericon:LoadImage(ResUrl.getCharacterDataIcon("bg_fm_circle.png"))
	self._simagelefticon:LoadImage(ResUrl.getCommonIcon("bg_leftdown"))
	self._simagerighticon:LoadImage(ResUrl.getCommonIcon("bg_rightdown"))
	self._simagerighticon2:LoadImage(ResUrl.getCommonIcon("bg_rightup"))
	self._simagemask:LoadImage(ResUrl.getCommonIcon("full/bg_noise2"))

	self._uiSpine = GuiModelAgent.Create(self._gospine, true)

	self._uiSpine:openBloomView(CharacterVoiceEnum.UIBloomView.CharacterDataView)
	self._uiSpine:setShareRT(CharacterVoiceEnum.RTShareType.BloomAuto)

	self.showStatusDraw = false

	gohelper.setActive(self._gohasskin, false)
end

function CharacterDataTitleView:onUpdateParam()
	self:_refreshUI()
	self:_setFaithValue()
end

function CharacterDataTitleView:_disableClipAlpha()
	UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
end

function CharacterDataTitleView:onOpen()
	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
	gohelper.setActive(self.viewGO, true)
	self:_refreshUI()
	TaskDispatcher.runDelay(self._playPercentAni, self, 0.5)

	if not self._uiSpine then
		return
	end

	self._uiSpine:setModelVisible(true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_role_cover_open_1)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self, LuaEventSystem.Low)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self, LuaEventSystem.Low)
end

function CharacterDataTitleView:_onOpenViewFinish(viewName)
	self:_setModelVisible(ViewHelper.instance:checkViewOnTheTop(ViewName.CharacterDataView))
end

function CharacterDataTitleView:_onCloseViewFinish(viewName)
	self:_setModelVisible(ViewHelper.instance:checkViewOnTheTop(ViewName.CharacterDataView))
end

function CharacterDataTitleView:_setModelVisible(value)
	if value then
		self._uiSpine:showModelEffect()
	else
		self._uiSpine:hideModelEffect()
	end
end

function CharacterDataTitleView:_refreshUI()
	if self._heroId and self._heroId == CharacterDataModel.instance:getCurHeroId() then
		return
	end

	self._heroId = CharacterDataModel.instance:getCurHeroId()

	if type(self.viewParam) == "table" then
		self.fromHandbookView = self.viewParam.fromHandbookView
		self.adjustStaticOffset = self.viewParam.adjustStaticOffset
	else
		self.fromHandbookView = false
		self.adjustStaticOffset = false
	end

	self.heroInfo = HeroModel.instance:getByHeroId(self._heroId)

	self:_initHandbookInfo()
	self:_initInfo()
	self:_initAdjustStaticOffsetInfo()
end

function CharacterDataTitleView:_initInfo()
	local heroinfo = self.heroInfo

	self._simagesignature:LoadImage(ResUrl.getSignature(heroinfo.config.signature), self._onSignatureImageLoad, self)

	self._txtname.text = self:_getFormatStr(heroinfo.config.name)

	local texts = CharacterDataConfig.instance:getCharacterDataCO(self._heroId, heroinfo.skin, CharacterEnum.CharacterDataItemType.Title, 1).text
	local textList = not string.nilorempty(texts) and string.split(texts, "\\&") or {}

	if textList[1] then
		self._txtintroduce.text = textList[1] or ""
	end

	self._txtmedium.text = self:_getTitleStr(textList[3])
	self._txtinspiration.text = self:_getTitleStr(textList[5])
	self._txtaroma.text = self:_getTitleStr(textList[4])
	self._txtsize.text = self:_getTitleStr(textList[2])

	self:_setFaithPercent(0)
	self:loadSpine()
end

function CharacterDataTitleView:_initHandbookInfo()
	gohelper.setActive(self._btnskinswitch.gameObject, self.fromHandbookView)
	gohelper.setActive(self._careericon.gameObject, self.fromHandbookView)
	gohelper.setActive(self._gohandbook, self.fromHandbookView)
	gohelper.setActive(self._goCharacterStaticContainer, self.showStatusDraw)
	gohelper.setActive(self._goCharacterDynamicContainer, not self.showStatusDraw)

	if self.fromHandbookView then
		self.simageStaticDraw = gohelper.getSingleImage(self._goCharacterStaticContainer)
		self._signatureClick = gohelper.getClickWithAudio(self._simagesignature.gameObject, AudioEnum.UI.play_ui_moor_open)

		self._signatureClick:AddClickListener(self.onSignatureOnClick, self)
		self._btnskinswitch:AddClickListener(self.onSkinSwitchBtnOnClick, self)
		gohelper.addUIClickAudio(self._btnskinswitch.gameObject, AudioEnum.UI.Play_UI_General_shutdown)

		self.starList = {}

		for i = 1, 6 do
			local starGo = gohelper.findChild(self._gostarlist, "star" .. i)

			table.insert(self.starList, starGo)
		end

		UISpriteSetMgr.instance:setCharactergetSprite(self._careericon, "charactercareer" .. self.heroInfo.config.career)

		for i = 1, 6 do
			gohelper.setActive(self.starList[i], i <= self.heroInfo.config.rare + 1)
		end

		self.haveSkinList = {}
		self.haveSkinDict = {}

		local skinMo = SkinInfoMO.New()

		skinMo:init({
			expireSec = 0,
			skin = self.heroInfo.config.skinId
		})
		table.insert(self.haveSkinList, skinMo)

		self.haveSkinDict[self.heroInfo.config.skinId] = true

		for _, tempSkinMo in ipairs(self.heroInfo.skinInfoList) do
			if not self.haveSkinDict[tempSkinMo.skin] then
				table.insert(self.haveSkinList, tempSkinMo)

				self.haveSkinDict[tempSkinMo.skin] = true
			end
		end

		self.currentShowSkinIndex = 0

		for i = 1, #self.haveSkinList do
			if self.haveSkinList[i].skin == self.heroInfo.skin then
				self.currentShowSkinIndex = i
			end
		end

		gohelper.setActive(self._gohasskin, self.currentShowSkinIndex ~= 1)
	end
end

function CharacterDataTitleView:_initAdjustStaticOffsetInfo()
	if self.adjustStaticOffset then
		gohelper.setActive(self._goCharacterStaticContainer, true)
		gohelper.setActive(self._goCharacterDynamicContainer, false)
		self:loadStaticDraw()
	end
end

function CharacterDataTitleView:loadSpine()
	if self.haveSkinList and self.haveSkinList[self.currentShowSkinIndex] then
		if not self.haveSkinList[self.currentShowSkinIndex].skin then
			local skinId = self.heroInfo.skin
			local skinCo = SkinConfig.instance:getSkinCo(skinId)

			self._uiSpine:setResPath(skinCo, self._onSpineLoaded, self)

			local offsetStr = skinCo.characterDataTitleViewOffset
			local offsets

			if string.nilorempty(offsetStr) then
				offsets = SkinConfig.instance:getSkinOffset(skinCo.characterViewOffset)
				offsets = SkinConfig.instance:getAfterRelativeOffset(501, offsets)
			else
				offsets = SkinConfig.instance:getSkinOffset(offsetStr)
			end

			CharacterVoiceEnum.setSpineOffset(self._uiSpine, tonumber(offsets[1]), tonumber(offsets[2]))
			transformhelper.setLocalScale(self._gospine.transform, offsets[3], offsets[3], offsets[3])
			self._uiSpine:setModelVisible(not self.showStatusDraw)
		end
	end
end

function CharacterDataTitleView:loadStaticDraw()
	if self.haveSkinList then
		if not self.haveSkinList[self.currentShowSkinIndex].skin then
			local skinId = self.heroInfo.skin
			local skinCo = SkinConfig.instance:getSkinCo(skinId)

			self.simageStaticDraw:LoadImage(ResUrl.getHeadIconImg(skinCo.drawing), function()
				ZProj.UGUIHelper.SetImageSize(self._goCharacterStaticContainer)

				local transform = self._goCharacterStaticContainer.transform
				local offsets = string.nilorempty(skinCo.characterTitleViewStaticOffset) and {
					-400,
					500,
					0.68
				} or string.splitToNumber(skinCo.characterTitleViewStaticOffset, "#")

				recthelper.setAnchor(transform, offsets[1], offsets[2])

				transform.localScale = Vector3.one * offsets[3]
			end)
		end
	end
end

function CharacterDataTitleView:_playPercentAni()
	local heroinfo = HeroModel.instance:getByHeroId(self._heroId)
	local percent = HeroConfig.instance:getFaithPercent(heroinfo.faith)[1]

	if percent > 0 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_role_cover_open_2)
	end

	self._faithTweenId = ZProj.TweenHelper.DOTweenFloat(0, percent, 0.34, self._setFaithPercent, self._setFaithValue, self, nil, EaseType.Linear)

	self:_disableClipAlpha()
end

function CharacterDataTitleView:_setFaithPercent(percent)
	self._txtfetter.text = percent > math.floor(percent) and string.format("%0.1f", percent * 100) .. "%" or percent * 100 .. "%"
	self._imagefetter.fillAmount = percent
end

function CharacterDataTitleView:_setFaithValue()
	local heroinfo = HeroModel.instance:getByHeroId(self._heroId)
	local percent = HeroConfig.instance:getFaithPercent(heroinfo.faith)[1]

	self:_setFaithPercent(percent)

	if self._faithTweenId then
		ZProj.TweenHelper.KillById(self._faithTweenId)

		self._faithTweenId = nil
	end
end

function CharacterDataTitleView:_onUttuBtnClick()
	ViewMgr.instance:openView(ViewName.CharacterDataUttuView)
end

function CharacterDataTitleView:_onSpineLoaded()
	return
end

function CharacterDataTitleView:_getTitleStr(content)
	if string.nilorempty(content) then
		return ""
	end

	content = string.gsub(content, "\n", "")

	local splitChar = string.find(content, "：") and "：" or ": "
	local descTab = string.split(content, splitChar)

	if #descTab > 1 then
		return descTab[2]
	else
		return content
	end
end

function CharacterDataTitleView:_getFormatStr(content)
	if string.nilorempty(content) then
		return ""
	end

	local startIndex = 1
	local jumpIndex = 1
	local hasPunctuation = false

	for index = 1, #content do
		local first = GameUtil.utf8sub(content, jumpIndex, 1)

		hasPunctuation = GameUtil.containsPunctuation(first)

		if not hasPunctuation then
			break
		end

		jumpIndex = jumpIndex + 1
	end

	if not hasPunctuation and startIndex < jumpIndex then
		local first = GameUtil.utf8sub(content, startIndex, jumpIndex - startIndex)
		local large = GameUtil.utf8sub(content, jumpIndex, 1)

		return string.format("%s<size=94>%s</size><space=-22><voffset=-0.05em> %s", first, large, (GameUtil.utf8len(content) >= 2 or nil) and GameUtil.utf8sub(content, jumpIndex + 1, GameUtil.utf8len(content) - jumpIndex + 1))
	else
		local first = GameUtil.utf8sub(content, 1, 1)

		return string.format("<size=94>%s</size><space=-22><voffset=-0.05em> %s", first, (GameUtil.utf8len(content) >= 2 or nil) and GameUtil.utf8sub(content, 2, GameUtil.utf8len(content) - 1))
	end
end

function CharacterDataTitleView:_onSignatureImageLoad()
	ZProj.UGUIHelper.SetImageSize(self._simagesignature.gameObject)
end

function CharacterDataTitleView:onSkinSwitchBtnOnClick()
	if self.fromHandbookView then
		if #self.haveSkinList == 1 then
			GameFacade.showToast(ToastEnum.CharacterDataTitle)

			return
		end

		self.currentShowSkinIndex = self.currentShowSkinIndex + 1

		if self.currentShowSkinIndex > #self.haveSkinList then
			self.currentShowSkinIndex = 1
		end

		if self.haveSkinList then
			if not self.haveSkinList[self.currentShowSkinIndex].skin then
				local skinId = self.heroInfo.skin
				local skinCo = SkinConfig.instance:getSkinCo(skinId)

				if skinCo.showDrawingSwitch == 0 then
					self.showStatusDraw = false

					gohelper.setActive(self._goCharacterStaticContainer, self.showStatusDraw)
					gohelper.setActive(self._goCharacterDynamicContainer, not self.showStatusDraw)
				end

				if self.showStatusDraw then
					self:loadStaticDraw()
				else
					self:loadSpine()
				end

				self._animbtnskinswitch:Play("skinswitch_click", 0, 0)
				gohelper.setActive(self._gohasskin, self.currentShowSkinIndex ~= 1)
			end
		end
	end
end

function CharacterDataTitleView:onSignatureOnClick()
	if self.fromHandbookView then
		if self.haveSkinList then
			if not self.haveSkinList[self.currentShowSkinIndex].skin then
				local skinId = self.heroInfo.skin
				local skinCo = SkinConfig.instance:getSkinCo(skinId)

				if skinCo.showDrawingSwitch == 0 then
					return
				end

				self.showStatusDraw = not self.showStatusDraw

				gohelper.setActive(self._goCharacterStaticContainer, self.showStatusDraw)
				gohelper.setActive(self._goCharacterDynamicContainer, not self.showStatusDraw)

				if self.showStatusDraw then
					self:loadStaticDraw()
				else
					self:loadSpine()
				end
			end
		end
	end
end

function CharacterDataTitleView:onClose()
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	TaskDispatcher.cancelTask(self._playPercentAni, self)

	if self._faithTweenId then
		ZProj.TweenHelper.KillById(self._faithTweenId)

		self._faithTweenId = nil
	end

	gohelper.setActive(self.viewGO, false)

	if not self._uiSpine then
		return
	end

	self._uiSpine:setModelVisible(false)
	self:_disableClipAlpha()
end

function CharacterDataTitleView:onDestroyView()
	self._simagebg:UnLoadImage()
	self._simagecentericon:UnLoadImage()
	self._simagelefticon:UnLoadImage()
	self._simagerighticon:UnLoadImage()
	self._simagerighticon2:UnLoadImage()
	self._simagemask:UnLoadImage()
	self._simagesignature:UnLoadImage()

	if self._uiSpine then
		self._uiSpine = nil
	end

	if self.fromHandbookView then
		self._btnskinswitch:RemoveClickListener()
	end

	if self._signatureClick then
		self._signatureClick:RemoveClickListener()
	end
end

return CharacterDataTitleView
