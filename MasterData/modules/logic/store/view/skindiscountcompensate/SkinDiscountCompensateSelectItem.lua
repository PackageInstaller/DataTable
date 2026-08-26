-- chunkname: @modules/logic/store/view/skindiscountcompensate/SkinDiscountCompensateSelectItem.lua

module("modules.logic.store.view.skindiscountcompensate.SkinDiscountCompensateSelectItem", package.seeall)

local SkinDiscountCompensateSelectItem = class("SkinDiscountCompensateSelectItem", ListScrollCellExtend)

function SkinDiscountCompensateSelectItem:onInitView()
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

function SkinDiscountCompensateSelectItem:addEvents()
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

function SkinDiscountCompensateSelectItem:removeEvents()
	self._btnclick:RemoveClickListener()
	self._btnViewMask:RemoveClickListener()
	self._btnView:RemoveClickListener()
	self.longPress:RemoveLongPressListener()
end

function SkinDiscountCompensateSelectItem:_btnViewOnClick()
	local skinId = self.mo.id

	StoreController.instance:dispatchEvent(StoreEvent.DecorateSkinSelectItemClick, skinId, self.mo.index)
end

function SkinDiscountCompensateSelectItem:onLongPressClick()
	local param = {}

	param.isShowHomeBtn = false
	param.skinId = self.mo.id

	CharacterController.instance:openCharacterSkinTipView(param)
end

function SkinDiscountCompensateSelectItem:_editableInitView()
	self._txtNum = gohelper.findChildTextMesh(self.viewGO, "#go_Get/txt_Num")
	self._animator = gohelper.findChildComponent(self.viewGO, "", gohelper.Type_Animator)
	self._gotAnimator = gohelper.findChildComponent(self.viewGO, "#go_Get", gohelper.Type_Animator)
	self._simageUniqueBg = gohelper.findChildSingleImage(self.viewGO, "#go_Unique/#simage_iconbg")
	self._simageUniqueIcon = gohelper.findChildSingleImage(self.viewGO, "#go_Unique/#simage_icon_1")
	self._simagedreesing = gohelper.findChildSingleImage(self.viewGO, "#simage_dreesing")
	self._skinRareGoList = self:getUserDataTb_()
	self._skinRareGoList[CharacterEnum.SkinRare.Garment] = self._goGarment
	self._skinRareGoList[CharacterEnum.SkinRare.Advanced] = self._goAdvance
	self._skinRareGoList[CharacterEnum.SkinRare.Unique] = self._goUnique
end

function SkinDiscountCompensateSelectItem:_editableAddEvents()
	return
end

function SkinDiscountCompensateSelectItem:_editableRemoveEvents()
	return
end

function SkinDiscountCompensateSelectItem:onUpdateMO(mo)
	if mo == nil or mo.id == nil then
		return
	end

	self.mo = mo

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

		if compensateParam then
			if not compensateParam[3] then
				local num = 0

				self._txtNum.text = tostring(num)
			end
		end
	end

	self:refreshGotAnim(haveSkin)
	self:refreshRare(skinConfig.skinLevel)
	self:refreshSign(isUnique, skinConfig.skinSignature)
end

function SkinDiscountCompensateSelectItem:refreshSign(isUnique, resPath)
	gohelper.setActive(self._simagesign, not isUnique)
	gohelper.setActive(self._simagedreesing, isUnique)

	if isUnique then
		local name = not string.nilorempty(resPath) and resPath or "img_dressing2"
		local signTexturePath = ResUrl.getSignature(string.format("color/%s", name))

		self._simagedreesing:LoadImage(signTexturePath)
	end
end

function SkinDiscountCompensateSelectItem:refreshRare(rare)
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

function SkinDiscountCompensateSelectItem:getAnimator()
	return self._animator
end

function SkinDiscountCompensateSelectItem:onSelect(isSelect)
	gohelper.setActive(self._goSelected, isSelect)
end

SkinDiscountCompensateSelectItem.GotAnimTime = 4

function SkinDiscountCompensateSelectItem:refreshGotAnim(isGot)
	local animName = isGot and "got" or "idle"
	local normalizeTime = 0

	if isGot then
		local referenceTime = SkinDiscountCompensateListModel.instance:getReferenceTime() or 0
		local offsetTime = UnityEngine.Time.timeSinceLevelLoad - referenceTime
		local animTime = offsetTime % SkinDiscountCompensateSelectItem.GotAnimTime

		if animTime > 0 then
			normalizeTime = animTime / SkinDiscountCompensateSelectItem.GotAnimTime
		end
	end

	self._gotAnimator:Play(animName, 0, normalizeTime)
end

function SkinDiscountCompensateSelectItem:onDestroyView()
	self._simageicon:UnLoadImage()
	tabletool.clear(self._skinRareGoList)
end

return SkinDiscountCompensateSelectItem
