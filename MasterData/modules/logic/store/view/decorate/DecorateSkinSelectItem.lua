-- chunkname: @modules/logic/store/view/decorate/DecorateSkinSelectItem.lua

module("modules.logic.store.view.decorate.DecorateSkinSelectItem", package.seeall)

local DecorateSkinSelectItem = class("DecorateSkinSelectItem", ListScrollCellExtend)

function DecorateSkinSelectItem:onInitView()
	self.simageHero = gohelper.findChildSingleImage(self.viewGO, "mask/#simage_hero")
	self.txtName = gohelper.findChildTextMesh(self.viewGO, "#txt_name")
	self.txtSkin = gohelper.findChildTextMesh(self.viewGO, "#txt_skin")
	self.goSelected = gohelper.findChild(self.viewGO, "#go_selected")
	self.goOwned = gohelper.findChild(self.viewGO, "#go_owned")
	self.goClick = gohelper.findChild(self.viewGO, "#btn_click")
end

function DecorateSkinSelectItem:addEventListeners()
	self.longPress = SLFramework.UGUI.UILongPressListener.Get(self.goClick)

	self.longPress:SetLongPressTime({
		0.4,
		99999
	})
	self.longPress:AddLongPressListener(self.onLongPressClick, self)
	self.longPress:AddClickListener(self.onClickItem, self)
end

function DecorateSkinSelectItem:removeEventListeners()
	self.longPress:RemoveLongPressListener()
	self.longPress:RemoveClickListener()
end

function DecorateSkinSelectItem:onLongPressClick()
	local param = {}

	param.isShowHomeBtn = false
	param.skinId = self.mo.id

	CharacterController.instance:openCharacterSkinTipView(param)
end

function DecorateSkinSelectItem:onClickItem()
	DecorateSkinSelectListModel.instance:selectCell(self._index, true)

	local skinId = self.mo.id

	StoreController.instance:dispatchEvent(StoreEvent.DecorateSkinSelectItemClick, skinId)
end

function DecorateSkinSelectItem:onSelect(isSelect)
	gohelper.setActive(self.goSelected, isSelect)
end

function DecorateSkinSelectItem:onUpdateMO(mo)
	self.mo = mo

	local skinId = self.mo.id
	local skinConfig = SkinConfig.instance:getSkinCo(skinId)
	local heroConfig = HeroConfig.instance:getHeroCO(skinConfig.characterId)

	self.txtName.text = heroConfig.name
	self.txtSkin.text = skinConfig.des

	local isOwned = self.mo.isOwned == 1

	gohelper.setActive(self.goOwned, isOwned)
	self.simageHero:LoadImage(ResUrl.getStoreSkin(skinId))
end

function DecorateSkinSelectItem:onDestroy()
	self.simageHero:UnLoadImage()
end

return DecorateSkinSelectItem
