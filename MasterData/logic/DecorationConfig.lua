-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/config/DecorationConfig.lua

module("logic.extensions.equipment.config.DecorationConfig", package.seeall)

local DecorationConfig = class("DecorationConfig", BaseConfig)

function DecorationConfig:onInit()
	DecorationConfig.super.onInit(self)

	self.decorationCfg = nil
	self.mainAttriCfg = nil
	self.strategyCfg = nil
	self.sttMatInfoList = nil
	self.openFuncId = 2302
	self.maxQualityNum = 5
	self.maxOneClickNum = 8
	self.maxOneClickTips = ""
	self.costDecoRatio = 60
	self.strtQuaPlan = 0
	self.recyQuaPlan = 0
end

function DecorationConfig:getNames()
	return {
		"decoration_config",
		"decoration_main_prop_strategy",
		"decoration_lv_strategy",
		"decoration_common_config"
	}
end

function DecorationConfig:handleConfig(name, content)
	if name == "decoration_config" then
		self.decorationCfg = content
	elseif name == "decoration_main_prop_strategy" then
		self.mainAttriCfg = content
	elseif name == "decoration_lv_strategy" then
		self.strategyCfg = content
	elseif name == "decoration_common_config" then
		self.sttMatInfoList = self:SetStrengtheningMaterial(content.UPGRADE_MATERIAL_IDS.value, content.UPGRADE_MATERIAL_EXPS.value)

		if content.FUNC_OPEN_ID then
			self.openFuncId = tonumber(content.FUNC_OPEN_ID.value)
		end

		if content.COST_DECORATION_EXP_PERCENT then
			self.costDecoRatio = tonumber(content.COST_DECORATION_EXP_PERCENT.value)
		end

		if content.DECOMPOSE_TIPS_QUALITY then
			self.maxQualityNum = tonumber(content.DECOMPOSE_TIPS_QUALITY.value)
		end

		if content.MAX_ONECLICK_LIMIT then
			self.maxOneClickNum = tonumber(content.MAX_ONECLICK_LIMIT.value)
		end

		if content.MAX_ONECLICK_TIPS then
			self.maxOneClickTips = content.MAX_ONECLICK_TIPS.value
		end

		if content.STRENGTHEN_QUALITY_PLAN then
			self.strtQuaPlan = tonumber(content.STRENGTHEN_QUALITY_PLAN.value)
		end

		if content.RECYCLE_QUALITY_PLAN then
			self.recyQuaPlan = tonumber(content.RECYCLE_QUALITY_PLAN.value)
		end
	end
end

function DecorationConfig:GetDecorationCfgById(defineId)
	if defineId == nil or self.decorationCfg == nil then
		return
	end

	return self.decorationCfg[checknumber(defineId)]
end

function DecorationConfig:GetMainAttriCfgs(planId)
	if planId == nil or self.mainAttriCfg == nil then
		return
	end

	return self.mainAttriCfg[checknumber(planId)]
end

function DecorationConfig:GetStrategyPlanId(planId, str)
	if checknumber(planId) < 1 or self.mainAttriCfg == nil or string.nilorempty(str) then
		return
	end

	local list = self.mainAttriCfg[checknumber(planId)]

	if list == nil or list[str] == nil then
		return
	end

	return list[str].levelStrategy
end

function DecorationConfig:GetStrategyCfgs(planId, level)
	if planId == nil or self.strategyCfg == nil then
		return
	end

	local list = self.strategyCfg[checknumber(planId)]

	if level == nil then
		return list
	end

	return list[checknumber(level)]
end

function DecorationConfig:GetStrengtheningMaterial()
	return self.sttMatInfoList
end

function DecorationConfig:GetOpenFuncId()
	return self.openFuncId or 2302
end

function DecorationConfig:GetMaxQualityNum()
	return self.maxQualityNum or 4
end

function DecorationConfig:GetMaxOneClickNum()
	return self.maxOneClickNum or 7
end

function DecorationConfig:GetMaxOneClickTips()
	return self.maxOneClickTips
end

function DecorationConfig:GetCostDecoRatio()
	return self.costDecoRatio
end

function DecorationConfig:GetStrtQuaPlanId()
	return checknumber(self.strtQuaPlan)
end

function DecorationConfig:GetRecyQuaPlanId()
	return checknumber(self.recyQuaPlan)
end

function DecorationConfig:SetStrengtheningMaterial(keyStr, valueStr)
	if string.nilorempty(keyStr) or string.nilorempty(valueStr) then
		return
	end

	local keyList = string.split(keyStr, ",")

	if keyList == nil or #keyList == 0 then
		return
	end

	local valueList = string.split(valueStr, ",")
	local sttMatList = {}

	for i = 1, #keyList do
		if not string.nilorempty(keyList[i]) then
			table.insert(sttMatList, {
				matId = tonumber(keyList[i]),
				matExp = (not string.nilorempty(valueList[i]) or nil) and tonumber(valueList[i])
			})
		end
	end

	return sttMatList
end

DecorationConfig.instance = DecorationConfig.New()

return DecorationConfig
