-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/shop/service/ShopService.lua

ShopService = class("ShopService", Service, _M)

function ShopService:initialize()
	super.initialize(self)
end

function ShopService:dispose()
	super.dispose(self)
end

function ShopService:requestGetShops(params, blockUI, callback)
	local request = self:newRequest(10101, params, callback)

	self:sendRequest(request, blockUI)
end

function ShopService:requestGetShop(params, blockUI, callback)
	local request = self:newRequest(10102, params, callback)

	self:sendRequest(request, blockUI)
end

function ShopService:requestBuy(params, blockUI, callback)
	local request = self:newRequest(10103, params, callback)

	self:sendRequest(request, blockUI)
end

function ShopService:requestRefresh(params, blockUI, callback)
	local request = self:newRequest(10104, params, callback)

	self:sendRequest(request, blockUI)
end

function ShopService:requestAutoSell(params, blockUI, callback)
	local request = self:newRequest(10105, params, callback)

	self:sendRequest(request, blockUI)
end

function ShopService:requestDebrisSell(params, blockUI, callback)
	local request = self:newRequest(10213, params, callback)

	self:sendRequest(request, blockUI)
end

function ShopService:requestBuyPackageShop(params, callback)
	local request = self:newRequest(10107, params, callback)

	self:sendRequest(request, blockUI)
end

function ShopService:requestBuyPackageShopCount(params, callback)
	local request = self:newRequest(10111, params, callback)

	self:sendRequest(request, blockUI)
end

function ShopService:requestGetPackageShop(params, callback)
	local request = self:newRequest(10108, params, callback)

	self:sendRequest(request, blockUI)
end

function ShopService:requestBuySurfaceShop(params, callback)
	local request = self:newRequest(10109, params, callback)

	self:sendRequest(request, blockUI)
end

function ShopService:requestGetSurfaceShop(params, callback)
	local request = self:newRequest(10110, params, callback)

	self:sendRequest(request, blockUI)
end
