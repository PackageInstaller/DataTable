-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/packdiscount/config/PackDiscountConfig.lua

module("logic.extensions.packdiscount.config.PackDiscountConfig", package.seeall)

local PackDiscountConfig = class("PackDiscountConfig", BaseConfig)

function PackDiscountConfig:onInit()
	PackDiscountConfig.super.onInit(self)
end

function PackDiscountConfig:getNames()
	return {
		"pack_discount_pack",
		"pack_discount_item"
	}
end

function PackDiscountConfig:handleConfig(name, content)
	if name == "pack_discount_pack" then
		self._discountPackCfg = content
	elseif name == "pack_discount_item" then
		self._discountItemCfg = content
	end
end

function PackDiscountConfig:getDiscountPackCfg(activityId)
	return self._discountPackCfg[activityId]
end

function PackDiscountConfig:getDiscountItemCfg(activityId)
	local packItems = self:getDiscountPackCfg(activityId).packItems
	local itemsCfg = {}

	for _, itemId in pairs(packItems) do
		if self._discountItemCfg[itemId] then
			table.insert(itemsCfg, self._discountItemCfg[itemId])
		end
	end

	return itemsCfg
end

function PackDiscountConfig:getDiscountItemCfgById(itemId)
	return self._discountItemCfg[itemId]
end

PackDiscountConfig.instance = PackDiscountConfig.New()

return PackDiscountConfig
