-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shop/config/ShopConfig.lua

module("logic.extensions.shop.config.ShopConfig", package.seeall)

local ShopConfig = class("ShopConfig", BaseConfig)

function ShopConfig:onInit()
	ShopConfig.super.onInit(self)

	self._shopCfg = nil
	self._chargeCfg = nil
	self.activityShopCfgs = nil
end

function ShopConfig:getNames()
	return {
		"shop_charge",
		"shop",
		"activity_shop",
		"activity_shop_page_open"
	}
end

function ShopConfig:handleConfig(name, content)
	if name == "shop_charge" then
		self._chargeCfg = content
	elseif name == "shop" then
		self._shopCfg = content
	elseif name == "activity_shop" then
		self.activityShopCfgs = content
	elseif name == "activity_shop_page_open" then
		self._activity_shop_page_openCfg = content
	end
end

function ShopConfig:getChargeCfgById(id)
	return self._chargeCfg[id]
end

function ShopConfig:GetShopCfgById(id)
	if self._shopCfg and self._shopCfg[id] then
		return self._shopCfg[id]
	end
end

ShopConfig.instance = ShopConfig.New()

return ShopConfig
