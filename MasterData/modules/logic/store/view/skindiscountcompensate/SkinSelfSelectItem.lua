-- chunkname: @modules/logic/store/view/skindiscountcompensate/SkinSelfSelectItem.lua

module("modules.logic.store.view.skindiscountcompensate.SkinSelfSelectItem", package.seeall)

local SkinSelfSelectItem = class("SkinSelfSelectItem", ListScrollCellExtend)

function SkinSelfSelectItem:onInitView()
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#simage_icon")
	self._btnView = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_View")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")
	self._simagesign = gohelper.findChildSingleImage(self.viewGO, "#simage_sign")
	self._txtskinname = gohelper.findChildText(self.viewGO, "#txt_skinname")
	self._txtname = gohelper.findChildText(self.viewGO, "#txt_skinname/#txt_name")
	self._goGet = gohelper.findChild(self.viewGO, "#go_Get")
	self._simageprop = gohelper.findChildSingleImage(self.viewGO, "#go_Get/#simage_prop")
	self._btnViewMask = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Get/#btn_ViewMask")
	self._goSelected = gohelper.findChild(self.viewGO, "#go_Selected")
	self._goGarment = gohelper.findChild(self.viewGO, "#go_Garment")
	self._goAdvance = gohelper.findChild(self.viewGO, "#go_Advance")
	self._goUnique = gohelper.findChild(self.viewGO, "#go_Unique")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SkinSelfSelectItem:addEvents()
	self._btnclick:AddClickListener(self._btnViewOnClick, self)
	self._btnViewMask:AddClickListener(self.onLongPressClick, self)
	self._btnView:AddClickListener(self.onLongPressClick, self)

	self.longPress = SLFramework.UGUI.UILongPressListener.Get(self._btnclick.gameObject)

	self.longPress:SetLongPressTime({
		0.4,
		99999
	})
	self.longPress:AddLongPressListener(self.onLongPressClick, self)
end

function SkinSelfSelectItem:removeEvents()
	self._btnclick:RemoveClickListener()
	self._btnViewMask:RemoveClickListener()
	self._btnView:RemoveClickListener()
	self.longPress:RemoveLongPressListener()
end

function SkinSelfSelectItem:_btnViewOnClick()
	local skinId = self.mo.id

	StoreController.instance:dispatchEvent(StoreEvent.DecorateSkinSelectItemClick, skinId, self.mo.index)
end

function SkinSelfSelectItem:onLongPressClick()
	if self.mo.type ~= SkinDiscountCompensateEnum.ItemType.Skin then
		return
	end

	local param = {}

	param.isShowHomeBtn = false
	param.skinId = self.mo.id

	CharacterController.instance:openCharacterSkinTipView(param)
end

function SkinSelfSelectItem:_editableInitView()
	self._goExchangeItem = gohelper.findChild(self.viewGO, "image_Item")
	self._animator = gohelper.findChildComponent(self.viewGO, "", gohelper.Type_Animator)
	self._gotAnimator = gohelper.findChildComponent(self.viewGO, "#go_Get", gohelper.Type_Animator)
	self._goProp = gohelper.findChild(self.viewGO, "#go_prop")
	self._simageProp = gohelper.findChildSingleImage(self.viewGO, "#go_prop/#simage_prop")
	self._txtPropNum = gohelper.findChildTextMesh(self.viewGO, "#go_prop/txt_Num")
	self._simageUniqueBg = gohelper.findChildSingleImage(self.viewGO, "#go_Unique/#simage_iconbg")
	self._simageUniqueIcon = gohelper.findChildSingleImage(self.viewGO, "#go_Unique/#simage_icon_1")
	self._simagedreesing = gohelper.findChildSingleImage(self.viewGO, "#simage_dreesing")
	self._skinRareGoList = self:getUserDataTb_()
	self._skinRareGoList[CharacterEnum.SkinRare.Garment] = self._goGarment
	self._skinRareGoList[CharacterEnum.SkinRare.Advanced] = self._goAdvance
	self._skinRareGoList[CharacterEnum.SkinRare.Unique] = self._goUnique
end

function SkinSelfSelectItem:_editableAddEvents()
	return
end

function SkinSelfSelectItem:_editableRemoveEvents()
	return
end

function SkinSelfSelectItem:onUpdateMO(mo)
	if mo == nil or mo.id == nil then
		return
	end

	self.mo = mo

	local isSkin = mo.type == SkinDiscountCompensateEnum.ItemType.Skin

	gohelper.setActive(self._btnView, isSkin)
	gohelper.setActive(self._simageicon, isSkin)
	gohelper.setActive(self._simagesign, isSkin)

	for _, rareGo in pairs(self._skinRareGoList) do
		gohelper.setActive(rareGo, isSkin)
	end

	gohelper.setActive(self._goGet, isSkin)
	gohelper.setActive(self._txtskinname, isSkin)
	gohelper.setActive(self._goProp, not isSkin)
	gohelper.setActive(self._simagedreesing, isSkin)

	if not isSkin then
		local itemPram = self.mo.itemParam
		local config, icon = ItemModel.instance:getItemConfigAndIcon(itemPram[1], itemPram[2], true)

		self._simageProp:LoadImage(icon)

		self._txtPropNum.text = string.format("<size=70>×</size>%s", itemPram[3])

		return
	end

	local skinId = self.mo.id
	local skinConfig = SkinConfig.instance:getSkinCo(skinId)
	local heroConfig = HeroConfig.instance:getHeroCO(skinConfig.characterId)

	self._txtname.text = heroConfig.name
	self._txtskinname.text = skinConfig.name

	local haveSkin = HeroModel.instance:checkHasSkin(skinId)

	gohelper.setActive(self._goGet, haveSkin)

	local isUnique = skinConfig.skinLevel == CharacterEnum.SkinRare.Unique

	if isUnique then
		self._simageUniqueIcon:LoadImage(ResUrl.getHeadSkinIconUnique(skinId))
		self._simageUniqueBg:LoadImage(ResUrl.getCharacterSkinIcon(skinId))
	else
		self._simageicon:LoadImage(ResUrl.getStoreSkin(skinId))
	end

	gohelper.setActive(self._simageicon, not isUnique)

	self.haveSkin = haveSkin

	if haveSkin then
		local compensateParam = string.splitToNumber(skinConfig.compensate, "#")

		if not compensateParam or not compensateParam[3] then
			-- block empty
		end
	end

	self:refreshGotAnim(haveSkin)
	self:refreshRare(skinConfig.skinLevel)
	self:refreshSign(isUnique, skinConfig.skinSignature)
end

function SkinSelfSelectItem:refreshSign(isUnique, resPath)
	gohelper.setActive(self._simagesign, not isUnique)
	gohelper.setActive(self._simagedreesing, isUnique)

	if isUnique then
		local name = not string.nilorempty(resPath) and resPath or "img_dressing2"
		local signTexturePath = ResUrl.getSignature(string.format("color/%s", name))

		self._simagedreesing:LoadImage(signTexturePath)
	end
end

function SkinSelfSelectItem:refreshRare(rare)
	if rare == nil or rare == CharacterEnum.SkinRare.None then
		logError("皮肤品级未配置,使用默认配置 请检查 id: " .. tostring(self.mo.id))

		rare = CharacterEnum.SkinRare.Garment
	end

	if not self._skinRareGoList[rare] then
		logError("item缺少对应品级节点,使用默认配置 请检查 id: " .. tostring(self.mo.id) .. " skinLevel: " .. tostring(rare))

		rare = CharacterEnum.SkinRare.Garment
	end

	for index, rareGo in pairs(self._skinRareGoList) do
		gohelper.setActive(rareGo, index == rare)
	end
end

function SkinSelfSelectItem:getAnimator()
	return self._animator
end

function SkinSelfSelectItem:onSelect(isSelect)
	gohelper.setActive(self._goSelected, isSelect)
end

SkinSelfSelectItem.GotAnimTime = 4

function SkinSelfSelectItem:refreshGotAnim(isGot)
	local animName = isGot and "got" or "idle"
	local normalizeTime = 0.5

	self._gotAnimator:Play(animName, 0, normalizeTime)

	self._gotAnimator.speed = 0
end

function SkinSelfSelectItem:onDestroyView()
	self._simageicon:UnLoadImage()
	tabletool.clear(self._skinRareGoList)
end

return SkinSelfSelectItem
