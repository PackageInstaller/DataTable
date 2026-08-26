-- chunkname: @modules/logic/store/view/PackageStoreGoodsViewItem.lua

module("modules.logic.store.view.PackageStoreGoodsViewItem", package.seeall)

local PackageStoreGoodsViewItem = class("PackageStoreGoodsViewItem", LuaCompBase)

function PackageStoreGoodsViewItem:init(go)
	self:__onInit()

	self.viewGO = go
	self._gogoods = gohelper.findChild(self.viewGO, "go_goods")
	self._goicon = gohelper.findChild(self.viewGO, "go_goods/#go_icon")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PackageStoreGoodsViewItem:addEvents()
	return
end

function PackageStoreGoodsViewItem:removeEvents()
	return
end

function PackageStoreGoodsViewItem:_editableInitView()
	return
end

function PackageStoreGoodsViewItem:onUpdateMO(productParams)
	local materialType = tonumber(productParams[1])
	local materialId = productParams[2]
	local quantity = productParams[3]
	local itemConfig, itemIcon = ItemModel.instance:getItemConfigAndIcon(materialType, materialId, true)

	self._itemIcon = self._itemIcon or IconMgr.instance:getCommonPropItemIcon(self._goicon)

	self._itemIcon:setMOValue(materialType, materialId, quantity, nil, true)
	self._itemIcon:hideExpEquipState()
	self._itemIcon:isShowName(false)

	if self._itemIcon:isEquipIcon() then
		self._itemIcon:isShowEquipAndItemCount(true)
	end

	self._itemIcon:setCountFontSize(36)
	self._itemIcon:hideEquipLvAndBreak(true)
	self._itemIcon:showEquipRefineContainer(false)
	self._itemIcon:setScale(0.7)
	self._itemIcon:SetCountLocalY(43.6)
	self._itemIcon:SetCountBgHeight(25)
end

function PackageStoreGoodsViewItem:setActive(v)
	gohelper.setActive(self.viewGO, v)
end

function PackageStoreGoodsViewItem:onDestroyView()
	self:__onDispose()
end

return PackageStoreGoodsViewItem
