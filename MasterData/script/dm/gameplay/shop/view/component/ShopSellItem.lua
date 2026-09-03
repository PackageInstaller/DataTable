-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/shop/view/component/ShopSellItem.lua

ShopSellItem = class("ShopSellItem", objectlua.Object, _M)

function ShopSellItem:initialize()
	super.initialize(self)
	self:initMember()
end

function ShopSellItem:setInfo(data, view)
	self._data = data
	self._view = view
	self._name = self._view:getChildByFullName("good_name")
	self._iconLayout = self._view:getChildByFullName("icon_panel")

	self:refreshInfo()
end

function ShopSellItem:initMember()
	self._data = nil
	self._view = nil
	self._iconLayout = nil
end

function ShopSellItem:getView()
	return self._view
end

function ShopSellItem:refreshInfo()
	self._iconLayout:removeAllChildren()
	self._name:setString(self._data.item:getName())
	GameStyle:setQualityText(self._name, self._data.item:getQuality())

	local icon = IconFactory:createIcon({
		id = self._data.item:getId(),
		amount = self._data.amount
	})

	icon:addTo(self._iconLayout):center(self._iconLayout:getContentSize())
	icon:setScale(0.8)
end
