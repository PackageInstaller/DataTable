-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newyeargoodsshop/config/NewyeargoodsshopConfig.lua

module("logic.extensions.newyeargoodsshop.config.NewyeargoodsshopConfig", package.seeall)

local NewyeargoodsshopConfig = class("NewyeargoodsshopConfig", BaseConfig)

function NewyeargoodsshopConfig:onInit()
	return
end

function NewyeargoodsshopConfig:getNames()
	return {
		"newyear_goods_shop"
	}
end

function NewyeargoodsshopConfig:handleConfig(name, content)
	if name == "newyear_goods_shop" then
		self._newyear_goods_shop = content
	end
end

function NewyeargoodsshopConfig:getActCfg(activityId)
	return self._newyear_goods_shop[activityId]
end

NewyeargoodsshopConfig.instance = NewyeargoodsshopConfig.New()

return NewyeargoodsshopConfig
