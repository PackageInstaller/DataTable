-- chunkname: @modules/logic/rouge/view/RougeCollectionListDropdownItem.lua

module("modules.logic.rouge.view.RougeCollectionListDropdownItem", package.seeall)

local RougeCollectionListDropdownItem = class("RougeCollectionListDropdownItem", ListScrollCellExtend)

function RougeCollectionListDropdownItem:onInitView()
	self._simageruanpan = gohelper.findChildSingleImage(self.viewGO, "simage_ruanpan")
	self._imageruanpan = gohelper.findChildImage(self.viewGO, "simage_ruanpan")
	self._color = self._imageruanpan.color
end

function RougeCollectionListDropdownItem:addEvents()
	self._click = gohelper.getClickWithDefaultAudio(self.viewGO)

	self._click:AddClickListener(self._onClick, self)
end

function RougeCollectionListDropdownItem:removeEvents()
	self._click:RemoveClickListener()
end

function RougeCollectionListDropdownItem:_editableRemoveEvents()
	return
end

function RougeCollectionListDropdownItem:_onClick()
	RougeController.instance:dispatchEvent(RougeEvent.OnClickCollectionDropItem, self._mo)
end

function RougeCollectionListDropdownItem:onUpdateMO(mo)
	self._mo = mo

	self._simageruanpan:LoadImage(RougeCollectionHelper.getCollectionIconUrl(self._mo.id), self._onLoadImage, self)
	self:_onLoadImage()
end

function RougeCollectionListDropdownItem:_onLoadImage()
	local isUnlock = RougeFavoriteModel.instance:collectionIsUnlock(self._mo.id)

	self._color.a = isUnlock and 1 or 0.8
	self._imageruanpan.color = self._color
end

return RougeCollectionListDropdownItem
