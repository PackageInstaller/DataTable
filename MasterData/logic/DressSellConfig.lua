-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dressactivityshop/config/DressSellConfig.lua

module("logic.extensions.dressactivityshop.config.DressSellConfig", package.seeall)

local DressSellConfig = class("DressSellConfig", BaseConfig)

function DressSellConfig:onInit()
	DressSellConfig.super.onInit(self)
end

function DressSellConfig:getNames()
	return {
		"dress_sell",
		"dress_discount",
		"dress_discount_plan",
		"dress_discount_collect"
	}
end

function DressSellConfig:handleConfig(name, content)
	if name == "dress_sell" then
		self._actCfgs = content
	elseif name == "dress_discount" then
		self._dress_discountCfg = content
	elseif name == "dress_discount_plan" then
		self._dress_discount_planCfg = content
	elseif name == "dress_discount_collect" then
		self._dress_discount_collectCfg = content
	end
end

function DressSellConfig:getActfgsByActId(actId)
	return self._actCfgs[actId]
end

function DressSellConfig:getDiscountCfgById(actId, id)
	if self._dress_discountCfg[actId] then
		return self._dress_discountCfg[actId][id]
	end

	return {}
end

function DressSellConfig:getDiscountPlanCfgs(planId)
	return self._dress_discount_planCfg[planId]
end

function DressSellConfig:getDiscountCollectCfgs(actId)
	return self._dress_discount_collectCfg[actId] or {}
end

function DressSellConfig:getDiscountCollectCfg(activityId, id)
	return self._dress_discount_collectCfg[activityId][id]
end

DressSellConfig.instance = DressSellConfig.New()

return DressSellConfig
