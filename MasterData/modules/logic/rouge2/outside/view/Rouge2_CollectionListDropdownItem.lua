-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_CollectionListDropdownItem.lua

module("modules.logic.rouge2.outside.view.Rouge2_CollectionListDropdownItem", package.seeall)

local Rouge2_CollectionListDropdownItem = class("Rouge2_CollectionListDropdownItem", ListScrollCellExtend)

function Rouge2_CollectionListDropdownItem:onInitView()
	self._simageruanpan = gohelper.findChildSingleImage(self.viewGO, "simage_ruanpan")
	self._imageruanpan = gohelper.findChildImage(self.viewGO, "simage_ruanpan")
	self._color = self._imageruanpan.color
end

function Rouge2_CollectionListDropdownItem:addEvents()
	self._click = gohelper.getClickWithDefaultAudio(self.viewGO)

	self._click:AddClickListener(self._onClick, self)
end

function Rouge2_CollectionListDropdownItem:removeEvents()
	self._click:RemoveClickListener()
end

function Rouge2_CollectionListDropdownItem:_editableRemoveEvents()
	return
end

function Rouge2_CollectionListDropdownItem:_onClick()
	RougeController.instance:dispatchEvent(RougeEvent.OnClickCollectionDropItem, self._mo)
end

function Rouge2_CollectionListDropdownItem:onUpdateMO(mo)
	self._mo = mo

	self._simageruanpan:LoadImage(RougeCollectionHelper.getCollectionIconUrl(self._mo.id), self._onLoadImage, self)
	self:_onLoadImage()
end

function Rouge2_CollectionListDropdownItem:_onLoadImage()
	local isUnlock = RougeFavoriteModel.instance:collectionIsUnlock(self._mo.id)

	self._color.a = isUnlock and 1 or 0.8
	self._imageruanpan.color = self._color
end

return Rouge2_CollectionListDropdownItem
