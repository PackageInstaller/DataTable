-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingorderclg/config/DivineKingOrderClgConfig.lua

module("logic.extensions.divinekingorderclg.config.DivineKingOrderClgConfig", package.seeall)

local DivineKingOrderClgConfig = class("DivineKingOrderClgConfig", BaseConfig)

function DivineKingOrderClgConfig:onInit()
	DivineKingOrderClgConfig.super.onInit(self)
end

function DivineKingOrderClgConfig:getNames()
	return {
		"divine_king_order_clg",
		"divine_king_order_clg_creeps_master",
		"divine_king_order_clg_creeps",
		"divine_king_order_clg_kong_buff",
		"divine_king_order_clg_stage",
		"divine_king_order_clg_water_buff"
	}
end

function DivineKingOrderClgConfig:handleConfig(name, content)
	if name == "divine_king_order_clg" then
		self._actCfgs = content
	elseif name == "divine_king_order_clg_creeps_master" then
		self._creepMasterCfgs = content
	elseif name == "divine_king_order_clg_creeps" then
		self._creepCfgs = content
	elseif name == "divine_king_order_clg_kong_buff" then
		self._kongBuffCfgs = {}

		for _, cfg in ipairs(content.dataList) do
			if not self._kongBuffCfgs[cfg.activityId] then
				local actCfgs = {}

				table.insert(actCfgs, cfg)

				self._kongBuffCfgs[cfg.activityId] = actCfgs
			end
		end

		for _, cfgs in pairs(self._kongBuffCfgs) do
			table.sort(cfgs, function(a, b)
				return a.soulCount < b.soulCount
			end)
		end
	elseif name == "divine_king_order_clg_stage" then
		self._stageCfgs = content
	elseif name == "divine_king_order_clg_water_buff" then
		self._waterBuffCfgs = {}

		for _, cfg in ipairs(content.dataList) do
			if not self._waterBuffCfgs[cfg.activityId] then
				local actCfgs = {}

				table.insert(actCfgs, cfg)

				self._waterBuffCfgs[cfg.activityId] = actCfgs
			end
		end

		for _, cfgs in pairs(self._waterBuffCfgs) do
			table.sort(cfgs, function(a, b)
				return a.soulCount < b.soulCount
			end)
		end
	end
end

function DivineKingOrderClgConfig:getActCfg(actId)
	return self._actCfgs[actId]
end

function DivineKingOrderClgConfig:getWaterBuffCfgs(actId)
	return self._waterBuffCfgs[actId]
end

function DivineKingOrderClgConfig:getWaterBuffDesc(actId, buffNum)
	local desc = "无"
	local buffCfgs = self:getWaterBuffCfgs(actId)

	if buffCfgs then
		for _, cfg in pairs(buffCfgs) do
			if buffNum < cfg.soulCount then
				break
			end

			desc = cfg.desc
		end
	end

	return desc
end

function DivineKingOrderClgConfig:getKongBuffCfgs(actId)
	return self._kongBuffCfgs[actId]
end

function DivineKingOrderClgConfig:getKongBuffDesc(actId, buffNum)
	local desc = "无"
	local buffCfgs = self:getKongBuffCfgs(actId)

	if buffCfgs then
		for _, cfg in pairs(buffCfgs) do
			if buffNum < cfg.soulCount then
				break
			end

			desc = cfg.desc
		end
	end

	return desc
end

function DivineKingOrderClgConfig:getStageCfgs(actId)
	return self._stageCfgs[actId]
end

function DivineKingOrderClgConfig:getStageCfgById(actId, stageId)
	return self._stageCfgs[actId] and self._stageCfgs[actId][stageId]
end

function DivineKingOrderClgConfig:getMaxStage(actId)
	local stageCfgs = self:getStageCfgs(actId)

	if stageCfgs then
		local maxStage = 0

		for _, cfg in pairs(stageCfgs) do
			if cfg then
				maxStage = maxStage + 1
			end
		end

		return maxStage
	end

	return 0
end

function DivineKingOrderClgConfig:getCreepMasterCfg(creepId)
	return self._creepMasterCfgs[creepId]
end

function DivineKingOrderClgConfig:getCreepCfgs(creepId)
	return self._creepCfgs[creepId]
end

DivineKingOrderClgConfig.instance = DivineKingOrderClgConfig.New()

return DivineKingOrderClgConfig
