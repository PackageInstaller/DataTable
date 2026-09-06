-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hoshigami/config/HoshigamiConfig.lua

module("logic.extensions.hoshigami.config.HoshigamiConfig", package.seeall)

local HoshigamiConfig = class("HoshigamiConfig", BaseConfig)

function HoshigamiConfig:onInit()
	return
end

function HoshigamiConfig:getNames()
	return {
		"hoshigami",
		"hoshigami_main_prop_plan",
		"hoshigami_lv_plan",
		"hoshigami_suit",
		"hoshigami_common",
		"hoshigami_recommend",
		"hoshigami_suit_info"
	}
end

function HoshigamiConfig:handleConfig(name, content)
	if name == "hoshigami_main_prop_plan" then
		self._hoshigami_main_prop_planCfg = content
	elseif name == "hoshigami_lv_plan" then
		self._hoshigami_lv_planCfg = content
	elseif name == "hoshigami_suit" then
		self._hoshigami_suitCfg = content
	elseif name == "hoshigami_common" then
		self._hoshigami_commonCfg = content
	elseif name == "hoshigami" then
		self._hoshigamiCfg = content
	elseif name == "hoshigami_recommend" then
		self._hoshigami_recommendCfg = content
	elseif name == "hoshigami_suit_info" then
		self._hoshigami_suit_infoCfg = content
	end
end

function HoshigamiConfig:getHoshigamiCfgs()
	return self._hoshigamiCfg
end

function HoshigamiConfig:getHoshigamiCfg(id)
	return self._hoshigamiCfg[id]
end

function HoshigamiConfig:getMainPropPlan(id)
	return self._hoshigami_main_prop_planCfg[id]
end

function HoshigamiConfig:getLvStrenCfg(id)
	return self._hoshigami_lv_planCfg[id]
end

function HoshigamiConfig:getUpgradeCostMatId()
	return checknumber(self._hoshigami_commonCfg.UPGRADE_ITEM_ID.value)
end

function HoshigamiConfig:getRecommend(raceId)
	return self._hoshigami_recommendCfg[raceId]
end

function HoshigamiConfig:getSuitCfg(typeId)
	return self._hoshigami_suitCfg[typeId]
end

function HoshigamiConfig:getSuitCfgByNum(typeId, num)
	return self._hoshigami_suitCfg[typeId][num]
end

function HoshigamiConfig:getRefundRatio()
	return checknumber(self._hoshigami_commonCfg.REFUND_RATIO.value)
end

function HoshigamiConfig:getMaxPrefabSuitNum()
	return checknumber(self._hoshigami_commonCfg.PREFAB_SUIT_MAX_QUANITY.value)
end

function HoshigamiConfig:getSuitInfo(typeId)
	return self._hoshigami_suit_infoCfg[typeId]
end

HoshigamiConfig.instance = HoshigamiConfig.New()

return HoshigamiConfig
