-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/strength/config/SupplyConfig.lua

module("logic.extensions.strength.config.SupplyConfig", package.seeall)

local SupplyConfig = class("SupplyConfig", BaseConfig)

function SupplyConfig:onInit()
	SupplyConfig.super.onInit(self)
end

function SupplyConfig:getNames()
	return {
		"strength_daily_free_config",
		"strength_common_config",
		"strength_buy",
		"strength_buy_time",
		"basic_benefits_daily_prize",
		"basic_benefits_extra_prize"
	}
end

function SupplyConfig:handleConfig(name, content)
	if name == "strength_daily_free_config" then
		self.dailyFreeContent = content
	elseif name == "strength_common_config" then
		self.commonContent = content
	elseif name == "strength_buy" then
		self.supplyBuyContent = content
	elseif name == "strength_buy_time" then
		self.strength_buy_timeCfg = content
	elseif name == "basic_benefits_daily_prize" then
		self.basic_benefits_daily_prizeCfg = content
	elseif name == "basic_benefits_extra_prize" then
		self.basic_benefits_extra_prizeCfg = content
	end
end

function SupplyConfig:getBaseGiftList()
	return self.basic_benefits_daily_prizeCfg.dataList
end

function SupplyConfig:getBaseGiftData(index)
	return self.basic_benefits_daily_prizeCfg[index]
end

function SupplyConfig:getGiftByVipDetail(index)
	local data = {}

	for k, v in pairs(self.basic_benefits_extra_prizeCfg[index]) do
		data[k + 1] = v
	end

	return data
end

function SupplyConfig:getGiftByVip(index, vipLv)
	if self.basic_benefits_extra_prizeCfg[index] then
		return self.basic_benefits_extra_prizeCfg[index][vipLv]
	end
end

function SupplyConfig:getDailyCfgs()
	return self.dailyFreeContent.dataList
end

function SupplyConfig:getDailyCfgById(id)
	return self.dailyFreeContent[id]
end

function SupplyConfig:getTimePlanCfg(id)
	id = checknumber(id)

	return self.strength_buy_timeCfg[id]
end

function SupplyConfig:getCommonCfgs()
	return self.commonContent
end

function SupplyConfig:getCommonValue(key)
	if self.commonContent[key] then
		if not string.nilorempty(self.commonContent[key].value2) then
			return self.commonContent[key].value2
		else
			return self.commonContent[key].value
		end
	end
end

function SupplyConfig:getCommonCfgByPos(pos)
	return self.commonContent.dataList[pos]
end

function SupplyConfig:getSupplyBuyCfgs()
	return self.supplyBuyContent.dataList
end

function SupplyConfig:getSupplyBuyCfgById(times)
	return self.supplyBuyContent.dataList[times].consume
end

function SupplyConfig:getMatGetStrengthList()
	local matGetStrengthList = {}
	local strengthRecorverNumStr = self:getCommonValue("STRENGTH_RECOVERY_NUM")
	local strengthArr = string.split(strengthRecorverNumStr, "#")

	for i, v in ipairs(strengthArr) do
		table.insert(matGetStrengthList, checknumber(v))
	end

	return matGetStrengthList
end

SupplyConfig.instance = SupplyConfig.New()

return SupplyConfig
