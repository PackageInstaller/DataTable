-- chunkname: @modules/logic/store/view/DecorateStoreSkinListItem.lua

module("modules.logic.store.view.DecorateStoreSkinListItem", package.seeall)

local DecorateStoreSkinListItem = class("DecorateStoreSkinListItem", ListScrollCellExtend)

function DecorateStoreSkinListItem:onInitView()
	self.simageHero = gohelper.findChildSingleImage(self.viewGO, "#simage_heroskin")
	self.goSelected = gohelper.findChild(self.viewGO, "#go_select")
	self.goOwned = gohelper.findChild(self.viewGO, "#go_owned")
	self.btnClick = gohelper.findChildButtonWithAudio(self.viewGO, "")

	gohelper.setActive(self.goSelected, false)
end

function DecorateStoreSkinListItem:addEventListeners()
	self.addClickCb(self, self.btnClick, self.onClickItem, self)
end

function DecorateStoreSkinListItem:removeEventListeners()
	self:removeClickCb(self.btnClick)
end

function DecorateStoreSkinListItem:onClickItem()
	if self.isSelect then
		return
	end

	DecorateStoreSkinListModel.instance:selectCell(self._index, true)

	local skinId = self.mo.id

	StoreController.instance:dispatchEvent(StoreEvent.DecorateStoreSkinSelectItemClick, skinId)
end

function DecorateStoreSkinListItem:onSelect(isSelect)
	self.isSelect = isSelect

	gohelper.setActive(self.goSelected, isSelect)
end

function DecorateStoreSkinListItem:onUpdateMO(mo)
	self.mo = mo

	local skinId = self.mo.id
	local isOwned = self.mo.isOwned == 1

	gohelper.setActive(self.goOwned, isOwned)
	self.simageHero:LoadImage(ResUrl.getHeroSkinPropIcon(skinId))
end

function DecorateStoreSkinListItem:onDestroy()
	self.simageHero:UnLoadImage()
end

return DecorateStoreSkinListItem
