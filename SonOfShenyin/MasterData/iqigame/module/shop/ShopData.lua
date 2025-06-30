-- chunkname: @IQIGame\\Module\\Shop\\ShopData.lua

local ShopCommodityData = require("IQIGame.Module.Shop.ShopCommodityData")

ShopData = {}

function ShopData.New()
	local o = Clone(ShopData)

	return o
end

function ShopData:_InitData()
	self.itemDic = {}
end

function ShopData:Initialize(ShopCfg)
	self:_InitData()

	self.shopCfgData = ShopCfg
	self.id = self.shopCfgData.Id

	self:Refresh()
end

function ShopData:Refresh()
	local commodityCfgs = ShopModule.findByCommodityByShopId(self.id)

	for i = 1, #commodityCfgs do
		local commodityCfg = commodityCfgs[i]
		local ShopCommodityData = ShopCommodityData.New(commodityCfg, self.id)

		self.itemDic[commodityCfg.Id] = ShopCommodityData
	end
end
