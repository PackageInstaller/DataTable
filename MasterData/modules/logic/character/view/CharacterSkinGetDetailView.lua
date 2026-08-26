-- chunkname: @modules/logic/character/view/CharacterSkinGetDetailView.lua

module("modules.logic.character.view.CharacterSkinGetDetailView", package.seeall)

local CharacterSkinGetDetailView = class("CharacterSkinGetDetailView", BaseView)

function CharacterSkinGetDetailView:onInitView()
	self._goContainer = gohelper.findChild(self.viewGO, "characterskingetdetailview")
	self._goclose = gohelper.findChild(self._goContainer, "#go_close")
	self._txtcharacterNameEn = gohelper.findChildText(self._goContainer, "#txt_characterNameEn")
	self._imagesingleItemBg = gohelper.findChildImage(self._goContainer, "characterSingleItem/#image_singleItemBg")
	self._simagesingleItemIcon = gohelper.findChildSingleImage(self._goContainer, "characterSingleItem/#simage_singleItemIcon")
	self._btnback = gohelper.findChildButtonWithAudio(self._goContainer, "#btn_back")
	self._simageskinbg = gohelper.findChildSingleImage(self._goContainer, "FullScreenGameObject/skinDetail/#simage_skinbg")
	self._simageskin = gohelper.findChildSingleImage(self._goContainer, "FullScreenGameObject/skinDetail/#simage_skin")
	self._txtskinName = gohelper.findChildText(self._goContainer, "FullScreenGameObject/skinDetail/#txt_skinName")
	self._txtskinNameEn = gohelper.findChildText(self._goContainer, "FullScreenGameObject/skinDetail/#txt_skinNameEn")
	self._txtskinDesc = gohelper.findChildText(self._goContainer, "FullScreenGameObject/skinDetail/#txt_skinDesc")
	self._simagecircle = gohelper.findChildSingleImage(self._goContainer, "circlebg/circlewai/#simage_circle")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterSkinGetDetailView:addEvents()
	self._btnback:AddClickListener(self._btnbackOnClick, self)
end

function CharacterSkinGetDetailView:removeEvents()
	self._btnback:RemoveClickListener()
end

function CharacterSkinGetDetailView:_btnbackOnClick()
	self.viewParam.isReplay = true

	ViewMgr.instance:openView(self.viewName, self.viewParam)
end

function CharacterSkinGetDetailView:_onBgClick()
	self:closeThis()
end

function CharacterSkinGetDetailView:_editableInitView()
	self._simagecircle:LoadImage(ResUrl.getCharacterGetIcon("bg_yuanchuan"))
end

function CharacterSkinGetDetailView:onUpdateParam()
	return
end

function CharacterSkinGetDetailView:onOpen()
	self.addEventCb(self, CharacterController.instance, CharacterEvent.showCharacterNewSkin, self.reallyOpenView, self)
end

function CharacterSkinGetDetailView:reallyOpenView()
	if HeroModel.instance:getCurrentSkinId(self.viewParam.heroId) == 304902 then
		AudioMgr.instance:trigger(AudioEnum.UI.kacakaca_audio)
	end

	gohelper.setActive(self._goContainer, true)

	self._bgClick = gohelper.getClickWithAudio(self._goclose)

	self._bgClick:AddClickListener(self._onBgClick, self)
	self:_setImage()
	self:_setText()
	self:_playOpenAnim()
	NavigateMgr.instance:addEscape(ViewName.CharacterGetView, self._onBgClick, self)
end

function CharacterSkinGetDetailView:_playOpenAnim()
	self._animator = self._goContainer:GetComponent(typeof(UnityEngine.Animator))

	self._animator:Play("characterget_skin2")
end

function CharacterSkinGetDetailView:_setImage()
	local itemIcon = CharacterDataConfig.instance:getCharacterDataCO(self.viewParam.heroId, HeroModel.instance:getCurrentSkinId(self.viewParam.heroId), CharacterEnum.CharacterDataItemType.Item, 1).icon
	local skinConfig = HeroModel.instance:getCurrentSkinConfig(self.viewParam.heroId)

	if itemIcon and itemIcon ~= "" then
		self._simagesingleItemIcon:LoadImage(ResUrl.getCharacterDataPic(itemIcon), function(self)
			local offsets = SkinConfig.instance:getSkinOffset(skinConfig.skinGetDetailViewIconOffset)

			recthelper.setAnchor(self._simagesingleItemIcon.transform, tonumber(offsets[1]), tonumber(offsets[2]))
			transformhelper.setLocalScale(self._simagesingleItemIcon.transform, tonumber(offsets[3]), tonumber(offsets[3]), tonumber(offsets[3]))
		end, self)

		if not skinConfig.skinGetColorbg then
			do
				local color = "#000000"

				SLFramework.UGUI.GuiHelper.SetColor(self._imagesingleItemBg, skinConfig.skinGetColorbg)
			end

			if skinConfig.skinGetBackIcon and skinConfig.skinGetBackIcon ~= "" then
				self._simageskinbg:LoadImage(ResUrl.getHeadSkinIconLarge(skinConfig.skinGetBackIcon))
			end

			if skinConfig.skinGetIcon and skinConfig.skinGetIcon ~= "" then
				self._simageskin:LoadImage(ResUrl.getHeadSkinIconMiddle(skinConfig.skinGetIcon))
			end
		end
	end
end

function CharacterSkinGetDetailView:_setText()
	local heroId = self.viewParam.heroId
	local skinConfig = HeroModel.instance:getCurrentSkinConfig(heroId)
	local heroConfig = HeroConfig.instance:getHeroCO(heroId)

	self._txtskinName.text = skinConfig.characterSkin
	self._txtskinNameEn.text = skinConfig.characterSkinNameEng
	self._txtskinDesc.text = skinConfig.skinDescription
	self._txtcharacterNameEn.text = heroConfig.nameEng
end

function CharacterSkinGetDetailView:_onSpineLoaded()
	return
end

function CharacterSkinGetDetailView:onClose()
	if self._bgClick then
		self._bgClick:RemoveClickListener()
	end

	self.removeEventCb(self, CharacterController.instance, CharacterEvent.showCharacterNewSkin, self.reallyOpenView, self)
end

function CharacterSkinGetDetailView:onDestroyView()
	self._simagesingleItemIcon:UnLoadImage()
	self._simageskinbg:UnLoadImage()
	self._simageskin:UnLoadImage()
	self._simagecircle:UnLoadImage()
end

return CharacterSkinGetDetailView
