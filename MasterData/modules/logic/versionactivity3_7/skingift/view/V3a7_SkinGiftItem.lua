-- chunkname: @modules/logic/versionactivity3_7/skingift/view/V3a7_SkinGiftItem.lua

module("modules.logic.versionactivity3_7.skingift.view.V3a7_SkinGiftItem", package.seeall)

local V3a7_SkinGiftItem = class("V3a7_SkinGiftItem", LuaCompBase)
local csAnimatorPlayer = SLFramework.AnimatorPlayer

function V3a7_SkinGiftItem:init(go)
	self.viewGO = go
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_NormalSkin/image_bg")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#go_NormalSkin/#simage_icon")
	self._goNormalSkin = gohelper.findChild(self.viewGO, "#go_NormalSkin")
	self._advanceImagebg = gohelper.findChildSingleImage(self.viewGO, "#go_AdvancedSkin/#simage_bg")
	self._advanceImageicon = gohelper.findChildSingleImage(self.viewGO, "#go_AdvancedSkin/#simage_icon")
	self._advanceImage1 = gohelper.findChildSingleImage(self.viewGO, "#go_AdvancedSkin/#image_D")
	self._advanceImage2 = gohelper.findChildSingleImage(self.viewGO, "#go_AdvancedSkin/#image_A")
	self._goAdvanceSkin = gohelper.findChild(self.viewGO, "#go_AdvancedSkin")
	self._goUniqueSkinsImage = gohelper.findChild(self.viewGO, "#go_UniqueSkin/#simage_icon")
	self._goUniqueSkin = gohelper.findChild(self.viewGO, "#go_UniqueSkin")
	self._uniqueSingleImageicon = gohelper.findChildSingleImage(self.viewGO, "#go_UniqueSkin/#simage_icon")
	self._uniqueImagebg = gohelper.findChildSingleImage(self.viewGO, "#go_UniqueSkin/#simage_iconbg")
	self._goUniqueSkinBubble = gohelper.findChild(self.viewGO, "#go_UniqueSkin/#simage_bubble")
	self._xtIconbg = gohelper.findChild(self.viewGO, "#go_UniqueSkin/#xingti_iconbg")
	self._goLinkageLetterG = gohelper.findChild(self.viewGO, "#go_Linkage/#simage_g")
	self._goLinkageLetterA = gohelper.findChild(self.viewGO, "#go_Linkage/#image_A")
	self._goLinkageBgG = gohelper.findChildSingleImage(self.viewGO, "#go_Linkage/#simage_bg")
	self._goLinkageBgA = gohelper.findChildSingleImage(self.viewGO, "#go_Linkage/#simage_bgA")
	self._gocost = gohelper.findChild(self.viewGO, "cost")
	self._gocostline = gohelper.findChild(self.viewGO, "cost/line")
	self._goprice = gohelper.findChild(self.viewGO, "cost/#go_price")
	self._goowned = gohelper.findChild(self.viewGO, "cost/#go_owned")
	self._txtoriginalprice = gohelper.findChildText(self.viewGO, "cost/#txt_original_price")
	self._goCharge = gohelper.findChild(self.viewGO, "cost/#go_charge")
	self._txtCharge = gohelper.findChildText(self.viewGO, "cost/#go_charge/txt_chargeNum")
	self._txtOriginalCharge = gohelper.findChildText(self.viewGO, "cost/#go_charge/txt_originalChargeNum")
	self._goremaintime = gohelper.findChild(self.viewGO, "#go_tag/#go_remaintime")
	self._txtremaintime = gohelper.findChildText(self.viewGO, "#go_tag/#go_remaintime/bg/icon/#txt_remaintime")
	self._gotag = gohelper.findChild(self.viewGO, "#go_tag")
	self._gonewtag = gohelper.findChild(self.viewGO, "#go_newtag")
	self._godiscount = gohelper.findChild(self.viewGO, "#go_tag/#go_discount")
	self._txtdiscount = gohelper.findChildText(self.viewGO, "#go_tag/#go_discount/#txt_discount")
	self._godeduction = gohelper.findChild(self.viewGO, "#go_tag/#go_deduction")
	self._txtdeduction = gohelper.findChildTextMesh(self.viewGO, "#go_tag/#go_deduction/txt_materialNum")
	self._goSkinTips = gohelper.findChild(self.viewGO, "#go_SkinTips")
	self._imgProp = gohelper.findChildImage(self.viewGO, "#go_SkinTips/image/#txt_Tips/#txt_Num/#image_Prop")
	self._txtPropNum = gohelper.findChildTextMesh(self.viewGO, "#go_SkinTips/image/#txt_Tips/#txt_Num")
	self._goSpecial = gohelper.findChild(self.viewGO, "#go_Special")
	self.goSelect = gohelper.findChild(self.viewGO, "#go_select")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a7_SkinGiftItem:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getCharacterSkinIcon("img_card_bg"))

	self._txtmaterialNum = gohelper.findChildText(self._goprice, "txt_materialNum")
	self._simagematerial = gohelper.findChildImage(self._goprice, "simage_material")
	self._goLinkage = gohelper.findChild(self.viewGO, "#go_Linkage")
	self._goLinkageLogo = gohelper.findChild(self.viewGO, "#go_Linkage/image_Logo")
	self._linkage_simageicon = gohelper.findChildSingleImage(self._goLinkage, "#simage_icon")
	self._btnGO = gohelper.findChild(self.viewGO, "clickArea")
	self._btn = gohelper.getClickWithAudio(self._btnGO, AudioEnum.UI.play_ui_rolesopen)

	self._btn:AddClickListener(self._onClick, self)

	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self.viewGOTrs = self.viewGO.transform
	self.parentViewGO = self.viewGO.transform.parent.gameObject
	self._costAnimPlayer = csAnimatorPlayer.Get(self._gocost)
	self._costAnimator = self._costAnimPlayer.animator
	self.txtSkinName = gohelper.findChildTextMesh(self.viewGO, "#txt_skinName")
	self.txtHeroName = gohelper.findChildTextMesh(self.viewGO, "#txt_heroName")
	self._gohasget = gohelper.findChild(self.viewGO, "#go_hasget")
end

function V3a7_SkinGiftItem:addEventListeners()
	self._btn:AddClickListener(self.onClickItem, self)
end

function V3a7_SkinGiftItem:removeEventListeners()
	self._btn:RemoveClickListener()
end

function V3a7_SkinGiftItem:onClickItem()
	CharacterController.instance:openCharacterSkinTipView({
		skinId = self._skinId
	})
end

function V3a7_SkinGiftItem:setInfo(skinId)
	self._skinId = skinId

	self:refreshInfo()
end

function V3a7_SkinGiftItem:hideUnuseNode()
	gohelper.setActive(self._gotag, false)
	gohelper.setActive(self._gonewtag, false)
	gohelper.setActive(self._goSkinTips, false)
	gohelper.setActive(self.goSelect, false)
	gohelper.setActive(self._gocost, false)
	gohelper.setActive(self._goSpecial, false)
end

function V3a7_SkinGiftItem:refreshInfo()
	self:hideUnuseNode()

	local skinConfig = SkinConfig.instance:getSkinCo(self._skinId)
	local isNormalSkin = false
	local isAdvanceSkin = not V3a7_SkinGiftEnum.UniqueSkinDic[skinConfig.id]
	local isUniqueSkin = V3a7_SkinGiftEnum.UniqueSkinDic[skinConfig.id] == true
	local isShowLinkageSkin = false
	local isShowNormalSkin = not isShowLinkageSkin and isNormalSkin
	local isShowAdvancedSkin = not isShowLinkageSkin and isAdvanceSkin
	local isShowUniqueSkin = not isShowLinkageSkin and isUniqueSkin

	self:clearSpine()
	gohelper.setActive(self._goNormalSkin, isShowNormalSkin)
	gohelper.setActive(self._goAdvanceSkin, isShowAdvancedSkin)
	gohelper.setActive(self._goUniqueSkin, isShowUniqueSkin)
	gohelper.setActive(self._goLinkage, isShowLinkageSkin)

	if isShowUniqueSkin then
		self:_onUpdateMO_uniqueSkin()
	else
		local imageIcon

		if isShowLinkageSkin then
			imageIcon = self._linkage_simageicon

			gohelper.setActive(self._goLinkageBgA, isAdvanceSkin)
			gohelper.setActive(self._goLinkageBgG, isNormalSkin)
			gohelper.setActive(self._goLinkageLetterA, isAdvanceSkin)
			gohelper.setActive(self._goLinkageLetterG, isNormalSkin)
		else
			imageIcon = isShowAdvancedSkin and self._advanceImageicon or self._simageicon
		end

		imageIcon:LoadImage(ResUrl.getHeadSkinIconMiddle(self._skinId))
	end

	self.txtSkinName.text = skinConfig.name

	local heroConfig = HeroConfig.instance:getHeroCO(skinConfig.characterId)

	self.txtHeroName.text = heroConfig.name

	local hasGet = HeroModel.instance:checkHasSkin(self._skinId)

	gohelper.setActive(self._gohasget, hasGet)
end

function V3a7_SkinGiftItem:_onUpdateMO_uniqueSkin()
	gohelper.setActive(self._xtIconbg, false)
	gohelper.setActive(self._goUniqueSkinBubble, false)
	self._uniqueImagebg:LoadImage(ResUrl.getCharacterSkinIcon(self._skinId))
	self._uniqueSingleImageicon:LoadImage(ResUrl.getHeadSkinIconUnique(self._skinId))
end

function V3a7_SkinGiftItem:clearSpine()
	GameUtil.doClearMember(self, "_skinSpine")
	GameUtil.doClearMember(self, "_skinSpine2")
end

function V3a7_SkinGiftItem:onDestroy()
	self._simagebg:UnLoadImage()
	self._uniqueSingleImageicon:UnLoadImage()
	self._uniqueImagebg:UnLoadImage()
	self:clearSpine()
end

return V3a7_SkinGiftItem
