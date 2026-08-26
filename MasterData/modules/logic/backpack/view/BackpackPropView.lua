-- chunkname: @modules/logic/backpack/view/BackpackPropView.lua

module("modules.logic.backpack.view.BackpackPropView", package.seeall)

local BackpackPropView = class("BackpackPropView", BaseView)

function BackpackPropView:onInitView()
	self._scrollprop = gohelper.findChildScrollRect(self.viewGO, "#scroll_prop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function BackpackPropView:addEvents()
	return
end

function BackpackPropView:removeEvents()
	return
end

function BackpackPropView:_editableInitView()
	BackpackController.instance:registerCallback(BackpackEvent.UpdateItemList, self._updateItemList, self)
end

function BackpackPropView:onUpdateParam()
	return
end

function BackpackPropView:onOpen()
	local id = BackpackModel.instance:getCurCategoryId() or ItemEnum.CategoryType.Material

	self.viewContainer:setCurrentSelectCategoryId(id)

	local itemList = BackpackModel.instance:getCategoryItemlist(id)

	BackpackPropListModel.instance:setCategoryPropItemList(itemList)
end

function BackpackPropView:_updateItemList()
	self._itemList = BackpackModel.instance:getBackpackList()

	BackpackModel.instance:setBackpackItemList(self._itemList)
	self:onOpen()
end

function BackpackPropView:onClose()
	return
end

function BackpackPropView:onDestroyView()
	BackpackController.instance:unregisterCallback(BackpackEvent.UpdateItemList, self._updateItemList, self)
end

return BackpackPropView
