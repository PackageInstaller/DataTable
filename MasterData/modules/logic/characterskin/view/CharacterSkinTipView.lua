-- chunkname: @modules/logic/characterskin/view/CharacterSkinTipView.lua

module("modules.logic.characterskin.view.CharacterSkinTipView", package.seeall)

local CharacterSkinTipView = class("CharacterSkinTipView", BaseView)

function CharacterSkinTipView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._gosmallspine = gohelper.findChild(self.viewGO, "smalldynamiccontainer/#go_smallspine")
	self._goskincontainer = gohelper.findChild(self.viewGO, "characterSpine/#go_skincontainer")
	self._simageskin = gohelper.findChildSingleImage(self.viewGO, "characterSpine/#go_skincontainer/#simage_skin")
	self._simagebgmask = gohelper.findChildSingleImage(self.viewGO, "#simage_bgmask")
	self._gogetIcon = gohelper.findChild(self.viewGO, "desc/#go_getIcon")
	self._simagesignature = gohelper.findChildSingleImage(self.viewGO, "desc/#simage_signature")
	self._simagesignatureicon = gohelper.findChildSingleImage(self.viewGO, "desc/#simage_signatureicon")
	self._txtcharacterName = gohelper.findChildText(self.viewGO, "desc/#txt_characterName")
	self._btnshowDetail = gohelper.findChildButtonWithAudio(self.viewGO, "desc/#txt_characterName/#btn_showDetail")
	self._txtskinName = gohelper.findChildText(self.viewGO, "desc/#txt_skinName")
	self._txtskinNameEn = gohelper.findChildText(self.viewGO, "desc/#txt_skinName/#txt_skinNameEn")
	self._txtdesc = gohelper.findChildText(self.viewGO, "desc/#txt_desc")
	self._simageskinSwitchBg = gohelper.findChildSingleImage(self.viewGO, "container/#simage_skinSwitchBg")
	self._simageskinicon = gohelper.findChildSingleImage(self.viewGO, "container/skinSwitch/skinmask/skinicon")
	self._gobtntopleft = gohelper.findChild(self.viewGO, "#go_btntopleft")
	self._viewAnim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterSkinTipView:addEvents()
	self._btnshowDetail:AddClickListener(self._btnshowDetailOnClick, self)
end

function CharacterSkinTipView:removeEvents()
	self._btnshowDetail:RemoveClickListener()
end

function CharacterSkinTipView:_btnshowDetailOnClick()
	CharacterController.instance:openCharacterSkinFullScreenView(self._skinCo)
end

function CharacterSkinTipView:_editableInitView()
	self._preDragAnchorPositionX = 0
	self._currentSelectSkinIndex = 0
	self._preSelectSkinIndex = 0
	self._minAnchorPositionX = 0
	self._minChangeAnchorPositionX = 10
end

function CharacterSkinTipView:onUpdateParam()
	self:refreshView()
end

function CharacterSkinTipView:onOpen()
	self._goSpine = GuiSpine.Create(self._gosmallspine, false)

	self._simagebg:LoadImage(ResUrl.getCharacterSkinIcon("full/pifubeijing_012"))
	self._simagebgmask:LoadImage(ResUrl.getCharacterSkinIcon("mask"))
	self._simageskinSwitchBg:LoadImage(ResUrl.getCharacterSkinIcon("img_yulan_bg"))
	self:refreshView()
end

function CharacterSkinTipView:onOpenFinish()
	self._viewAnim.enabled = true
end

function CharacterSkinTipView:refreshView()
	self._skinCo = SkinConfig.instance:getSkinCo(self.viewParam)
	self._heroCo = HeroConfig.instance:getHeroCO(self._skinCo.characterId)

	self._simagesignature:LoadImage(ResUrl.getSignature(self._heroCo.signature, "characterget"))
	self._simagesignatureicon:LoadImage(ResUrl.getSignature("3011_2", "characterget"))
	self._simageskinicon:LoadImage(ResUrl.getHeadSkinSmall(self.viewParam))
	self._simageskin:LoadImage(ResUrl.getHeadIconImg(self.viewParam), self._loadedImage, self)

	self._txtcharacterName.text = self._heroCo.name
	self._txtskinName.text = "— " .. self._skinCo.characterSkin
	self._txtskinNameEn.text = self._skinCo.characterSkinNameEng
	self._txtdesc.text = self._skinCo.skinDescription

	self._goSpine:stopVoice()
	self._goSpine:setResPath(ResUrl.getSpineUIPrefab(self._skinCo.spine), self._onSpineLoaded, self, true)

	local offsets = SkinConfig.instance:getSkinOffset(self._skinCo.skinSpineOffset)

	recthelper.setAnchor(self._gosmallspine.transform, tonumber(offsets[1]), tonumber(offsets[2]))
	transformhelper.setLocalScale(self._gosmallspine.transform, tonumber(offsets[3]), tonumber(offsets[3]), tonumber(offsets[3]))
	gohelper.setActive(self._simagesignatureicon.gameObject, self._heroCo.signature == "3011")
end

function CharacterSkinTipView:_loadedImage()
	gohelper.onceAddComponent(self._simageskin.gameObject, gohelper.Type_Image):SetNativeSize()

	local offsetStr = self._skinCo.skinViewImgOffset

	if not string.nilorempty(offsetStr) then
		local offsets = string.splitToNumber(offsetStr, "#")

		recthelper.setAnchor(self._goskincontainer.transform, tonumber(offsets[1]), tonumber(offsets[2]))
		transformhelper.setLocalScale(self._goskincontainer.transform, tonumber(offsets[3]), tonumber(offsets[3]), tonumber(offsets[3]))
	else
		recthelper.setAnchor(self._goskincontainer.transform, -150, -150)
		transformhelper.setLocalScale(self._goskincontainer.transform, 0.6, 0.6, 0.6)
	end
end

function CharacterSkinTipView:_onSpineLoaded()
	return
end

function CharacterSkinTipView:onClose()
	self._simageskin:UnLoadImage()
	self._simagesignature:UnLoadImage()
	self._simagesignatureicon:UnLoadImage()
end

function CharacterSkinTipView:onDestroyView()
	if self._goSpine then
		self._goSpine:stopVoice()

		self._goSpine = nil
	end

	self._simagebg:UnLoadImage()
	self._simageskinSwitchBg:UnLoadImage()
end

return CharacterSkinTipView
