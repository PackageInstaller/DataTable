-- chunkname: @modules/logic/store/view/decorate/DecorateSkinListItem.lua

module("modules.logic.store.view.decorate.DecorateSkinListItem", package.seeall)

local DecorateSkinListItem = class("DecorateSkinListItem", ListScrollCellExtend)

function DecorateSkinListItem:onInitView()
	self.simageHero = gohelper.findChildSingleImage(self.viewGO, "mask/#simage_hero")
	self.txtName = gohelper.findChildTextMesh(self.viewGO, "#txt_name")
	self.txtSkin = gohelper.findChildTextMesh(self.viewGO, "#txt_skin")
	self.goSelected = gohelper.findChild(self.viewGO, "#go_selected")
	self.goOwned = gohelper.findChild(self.viewGO, "#go_owned")
	self.btnClick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")

	gohelper.setActive(self.goSelected, false)
end

function DecorateSkinListItem:addEventListeners()
	self.addClickCb(self, self.btnClick, self.onClickItem, self)
end

function DecorateSkinListItem:removeEventListeners()
	self:removeClickCb(self.btnClick)
end

function DecorateSkinListItem:onClickItem()
	local param = {}

	param.isShowHomeBtn = false
	param.skinId = self.mo.id

	CharacterController.instance:openCharacterSkinTipView(param)
end

function DecorateSkinListItem:onUpdateMO(mo)
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

function DecorateSkinListItem:onDestroy()
	self.simageHero:UnLoadImage()
end

return DecorateSkinListItem
