-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/shop/model/Shop.lua

require("dm.gameplay.shop.model.ShopGroup")

Shop = class("Shop", objectlua.Object)

Shop:has("_shopList", {
	is = "rw"
})

function Shop:initialize()
	super.initialize(self)
	self:initMember()
end

function Shop:initMember()
	self._shopList = {}
end

function Shop:initSync(data)
	self:initMember()
	self:sync(data)
end

function Shop:sync(data)
	for id, v in pairs(data) do
		self._shopList[id] = self._shopList[id] or ShopGroup:new()

		self._shopList[id]:sync(v)
	end
end

function Shop:syncSpecialShop(data)
	if data.shopId then
		self._shopList[data.shopId] = self._shopList[data.shopId] or ShopGroup:new()

		self._shopList[data.shopId]:sync(data)
	end
end

function Shop:getShopGroupById(id)
	return self._shopList[tostring(id)]
end
