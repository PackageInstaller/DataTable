-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/talent/config/TalentConfig.lua

module("logic.extensions.talent.config.TalentConfig", package.seeall)

local TalentConfig = class("TalentConfig", BaseConfig)
local talents_items = {
	[20001] = GameEnum.GeniusType.qianzainanfeng,
	[20002] = GameEnum.GeniusType.wanzhongzhumu,
	[20003] = GameEnum.GeniusType.wangzhewudi
}
local geniusToRate = {
	[GameEnum.GeniusType.yiwushichu] = "yi_wu_shi_chu",
	[GameEnum.GeniusType.shifenchangjian] = "shi_fen_chang_jian",
	[GameEnum.GeniusType.bailitiaoyi] = "bai_li_tiao_yi",
	[GameEnum.GeniusType.qianzainanfeng] = "qian_zai_nan_feng",
	[GameEnum.GeniusType.wanzhongzhumu] = "wan_zhong_zhu_mu",
	[GameEnum.GeniusType.wangzhewudi] = "wang_zhe_wu_di"
}

function TalentConfig:onInit()
	TalentConfig.super.onInit(self)

	self._starConfig = nil
	self._typeConfig = nil
	self._upgradeConfig = nil
end

function TalentConfig:getNames()
	return {
		"genius_star_config",
		"genius_type_config",
		"genius_upgrade_strategy_client"
	}
end

function TalentConfig:handleConfig(name, content)
	if name == "genius_star_config" then
		self._starConfig = content
	elseif name == "genius_type_config" then
		self._typeConfig = content
	elseif name == "genius_upgrade_strategy_client" then
		self._upgradeConfig = content
	end
end

function TalentConfig:getTalentItemType(itemId)
	return talents_items[checknumber(itemId)]
end

function TalentConfig:GetStarMinMax(value)
	for i = #self._starConfig, 1, -1 do
		if value >= self._starConfig[i].geniusMinValue then
			return self._starConfig[i].strengthenMinValue, self._starConfig[i].strengthenMaxValue
		end
	end

	return 0, 0
end

function TalentConfig:GetStar(value)
	for i = #self._starConfig, 1, -1 do
		if value >= self._starConfig[i].geniusMinValue then
			return i
		end
	end

	return 0
end

function TalentConfig:GetGeniusType(starCount)
	for i = #self._typeConfig, 0, -1 do
		if starCount >= self._typeConfig[i].minTotalStar then
			return i
		end
	end

	return 0
end

function TalentConfig:GetGeniusMaxValue()
	return self._starConfig[#self._starConfig].geniusMaxValue
end

function TalentConfig:GetUpgradeCost(geniusType)
	return self._typeConfig[geniusType].cost
end

function TalentConfig:GetGeniusName(geniusType)
	return self._typeConfig[geniusType].name
end

function TalentConfig:GetGeniusMaxType()
	return self._typeConfig[#self._typeConfig].geniusType
end

function TalentConfig:GetUpgradeRate(geniusType, geniusUpgradeId, upgradeCount)
	local configs = self._upgradeConfig[geniusUpgradeId]

	assert(configs, string.format("geniusUpgradeId:%d 未配置", geniusUpgradeId))

	upgradeCount = upgradeCount + 1
	upgradeCount = upgradeCount > #configs and #configs or upgradeCount

	return configs[upgradeCount][geniusToRate[geniusType]]
end

TalentConfig.instance = TalentConfig.New()

return TalentConfig
