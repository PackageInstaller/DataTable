-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/payoff/model/PayModel.lua

PayModel = class("PayModel", objectlua.Object)

PayModel:has("_payId", {
	is = "rw"
})
PayModel:has("_productId", {
	is = "rw"
})
PayModel:has("_sDKSource", {
	is = "rw"
})
PayModel:has("_price", {
	is = "rw"
})
PayModel:has("_vIPExp", {
	is = "rw"
})
PayModel:has("_name", {
	is = "rw"
})
PayModel:has("_isContinue", {
	is = "rw"
})
PayModel:has("_mapId", {
	is = "rw"
})
PayModel:has("_symbol", {
	is = "rw"
})
PayModel:has("_aDSymbol", {
	is = "rw"
})

function PayModel:initialize(id)
	self._payId = id
	self._payConfig = ConfigReader:getRecordById("Pay", id)
end

function PayModel:sync(id)
	return
end

function PayModel:getProductId()
	return self._payConfig.ProductId
end

function PayModel:getSDKSource()
	return self._payConfig.SDKSource
end

function PayModel:getPrice()
	return self._payConfig.Price
end

function PayModel:getVIPExp()
	return self._payConfig.VIPExp
end

function PayModel:getName()
	return Strings:get(self._payConfig.Name)
end

function PayModel:getIsContinue()
	return self._payConfig.IsContinue
end

function PayModel:getMapId()
	return self._payConfig.MapId
end

function PayModel:getSymbol()
	return self._payConfig.Symbol
end

function PayModel:getADSymbol()
	return self._payConfig.ADSymbol
end
