-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dress/config/DressConfig.lua

module("logic.extensions.dress.config.DressConfig", package.seeall)

local DressConfig = class("DressConfig", BaseConfig)

function DressConfig:onInit()
	self:onReset()
end

function DressConfig:onReset()
	self._dressCfgs = nil
	self._tabsCfgs = nil
	self._suitCfgs = nil
	self._boySkeId = nil
	self._girlSuitId = nil
	self._boySuitId = nil
	self._changeCostMatstr = nil
end

DressConfig.ShopShowTags = {
	[0] = lang("荐"),
	lang("热"),
	(lang("新"))
}

function DressConfig:getNames()
	return {
		"dress",
		"dress_suit",
		"dress_shop_tab_define",
		"clothes_common_config"
	}
end

function DressConfig:handleConfig(name, content)
	if name == "dress" then
		self._dressCfgs = content
	elseif name == "dress_shop_tab_define" then
		self._tabsCfgs = content
	elseif name == "clothes_common_config" then
		if content.SKELETON_0 then
			self._girlSkeId = tonumber(content.SKELETON_0.value)
		end

		if content.SKELETON_1 then
			self._boySkeId = tonumber(content.SKELETON_1.value)
		end

		if content.DEFAULTSUIT_0 then
			self._girlSuitId = tonumber(content.DEFAULTSUIT_0.value)
		end

		if content.DEFAULTSUIT_1 then
			self._boySuitId = tonumber(content.DEFAULTSUIT_1.value)
		end

		if content.TRANSFORM_GENDER_CONSUME then
			self._changeCostMatstr = content.TRANSFORM_GENDER_CONSUME.value
		end

		self._clothes_common_config = content
	elseif name == "dress_suit" then
		self._suitCfgs = content
	end
end

function DressConfig:getAllConfig()
	return self._dressCfgs
end

function DressConfig:getDressCfgById(defineId)
	if defineId == nil or self._dressCfgs == nil then
		return
	end

	return self._dressCfgs[defineId]
end

function DressConfig:getAllSuitCfgs()
	return self._suitCfgs.dataList
end

function DressConfig:getSuitCfgById(defineId)
	if defineId == nil or self._suitCfgs == nil then
		return
	end

	return self._suitCfgs[defineId]
end

function DressConfig:getSuitInclude(defineId)
	local cfg = self:getSuitCfgById(defineId)

	return cfg.include
end

function DressConfig:getGirlSkeId()
	return self._girlSkeId or 1
end

function DressConfig:getBoySkeId()
	return self._boySkeId or 2
end

function DressConfig:getBoySuitId()
	return self._boySuitId or 2
end

function DressConfig:getGrilSuitId()
	return self._girlSuitId or 1
end

function DressConfig:getChangeSexCostMatStr()
	return self._changeCostMatstr or "8:1:1000"
end

function DressConfig:getCommonCfgValue(key)
	if self._clothes_common_config and self._clothes_common_config[key] then
		return self._clothes_common_config[key].value
	end
end

function DressConfig:getAllTabCfgs()
	return self._tabsCfgs
end

DressConfig.instance = DressConfig.New()

return DressConfig
