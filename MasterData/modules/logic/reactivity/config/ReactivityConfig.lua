-- chunkname: @modules/logic/reactivity/config/ReactivityConfig.lua

module("modules.logic.reactivity.config.ReactivityConfig", package.seeall)

local ReactivityConfig = class("ReactivityConfig", BaseConfig)

function ReactivityConfig:ctor()
	self._retroItemConvertConfig = nil
end

function ReactivityConfig:reqConfigNames()
	return {
		"retro_item_convert"
	}
end

function ReactivityConfig:onConfigLoaded(configName, configTable)
	if configName == "retro_item_convert" then
		self._retroItemConvertConfig = configTable
	end
end

function ReactivityConfig:getItemConvertList()
	return self._retroItemConvertConfig.configList
end

function ReactivityConfig:getItemConvertCO(typeId, itemId)
	local co = self._retroItemConvertConfig.configDict[typeId]

	if not co then
		return
	end

	return co[itemId]
end

function ReactivityConfig:checkItemNeedConvert(typeId, itemId)
	local convertCo = self:getItemConvertCO(typeId, itemId)

	if not convertCo then
		return false
	end

	local productItemOwnQuantity = ItemModel.instance:getItemQuantity(typeId, itemId)

	return productItemOwnQuantity >= convertCo.limit, convertCo.price
end

ReactivityConfig.instance = ReactivityConfig.New()

return ReactivityConfig
