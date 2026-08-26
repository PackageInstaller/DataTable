-- chunkname: @modules/logic/survival/config/SurvivalTechConfig.lua

module("modules.logic.survival.config.SurvivalTechConfig", package.seeall)

local SurvivalTechConfig = class("SurvivalTechConfig", BaseConfig)

function SurvivalTechConfig:ctor()
	return
end

function SurvivalTechConfig:reqConfigNames()
	return {
		"survival_inside_tech",
		"survival_outside_tech"
	}
end

function SurvivalTechConfig:onConfigLoaded(configName, configTable)
	if configName == "" then
		-- block empty
	end
end

function SurvivalTechConfig:_parseOutSideTech()
	self.techDic = {}

	local list = lua_survival_outside_tech.configList

	for i, cfg in ipairs(list) do
		local belongRole = cfg.belongRole

		self.techDic[belongRole] = self.techDic[belongRole] or {}

		table.insert(self.techDic[belongRole], cfg)
	end

	for _, v in pairs(self.techDic) do
		table.sort(v, self.techCfgSort)
	end
end

function SurvivalTechConfig.techCfgSort(cfgA, cfgB)
	return cfgA.point < cfgB.point
end

function SurvivalTechConfig:getTechList(techId)
	if self.techDic == nil then
		self:_parseOutSideTech()
	end

	return self.techDic[techId]
end

function SurvivalTechConfig:getTechTabList()
	if self.techTabList == nil then
		self.techTabList = {}

		if self.techDic == nil then
			self:_parseOutSideTech()
		end

		for belongRole, v in pairs(self.techDic) do
			table.insert(self.techTabList, {
				belongRole = belongRole
			})
		end

		table.sort(self.techTabList, self.techTabListSort)
	end

	return self.techTabList
end

function SurvivalTechConfig.techTabListSort(infoA, infoB)
	return infoA.belongRole < infoB.belongRole
end

function SurvivalTechConfig:getInsideTechList()
	if self.techInsideList == nil then
		self.techInsideList = {}

		local list = lua_survival_inside_tech.configList

		for i, v in ipairs(list) do
			table.insert(self.techInsideList, v)
		end

		table.sort(self.techInsideList, self.techCfgSort)
	end

	return self.techInsideList
end

function SurvivalTechConfig:getTechInsideCost(teachCellId)
	if self.techInsideCost == nil then
		self.techInsideCost = {}
	end

	if self.techInsideCost[teachCellId] == nil then
		local str = lua_survival_inside_tech.configDict[teachCellId].cost
		local price = string.match(str, "^item#1:(.+)$")

		self.techInsideCost[teachCellId] = tonumber(price)
	end

	return self.techInsideCost[teachCellId]
end

function SurvivalTechConfig:haveUnlockTech(oldLevel, curLevel)
	local list = self:getInsideTechLevels()

	for i, v in ipairs(list) do
		if oldLevel < v and v <= curLevel then
			return true
		end
	end
end

function SurvivalTechConfig:getInsideTechLevels()
	if self.techLevels == nil then
		local dic = {}

		self.techLevels = {}

		local list = lua_survival_inside_tech.configList

		for i, cfg in ipairs(list) do
			local lv = cfg.needLv

			if not dic[lv] then
				table.insert(self.techLevels, lv)

				dic[lv] = true
			end
		end

		table.sort(self.techLevels, function(a, b)
			return a < b
		end)
	end

	return self.techLevels
end

SurvivalTechConfig.instance = SurvivalTechConfig.New()

return SurvivalTechConfig
