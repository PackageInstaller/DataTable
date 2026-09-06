-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/flowergoddess/config/FlowerGoddessConfig.lua

module("logic.extensions.flowergoddess.config.FlowerGoddessConfig", package.seeall)

local FlowerGoddessConfig = class("FlowerGoddessConfig", BaseConfig)

function FlowerGoddessConfig:onInit()
	FlowerGoddessConfig.super.onInit(self)
end

function FlowerGoddessConfig:getNames()
	return {
		"send_goddess_flower",
		"send_goddess_flower_plan",
		"send_goddess_flower_goddess",
		"send_goddess_flower_progress_prize"
	}
end

function FlowerGoddessConfig:handleConfig(name, content)
	if name == "send_goddess_flower" then
		self._gfCfgs = content
	elseif name == "send_goddess_flower_plan" then
		self._gfPlanCfgs = content
	elseif name == "send_goddess_flower_goddess" then
		self._gfGoddessCfgs = content
	elseif name == "send_goddess_flower_progress_prize" then
		self._gfProCfgs = content
	end
end

function FlowerGoddessConfig:getGfCfg(actId)
	if not self._gfCfgs[actId] then
		return self._gfCfgs[actId]
	end
end

function FlowerGoddessConfig:getGfPlanCfg(actId)
	local gfCfg = self:getGfCfg(actId)

	if not gfCfg.flowerPlanId then
		if not self._gfPlanCfgs[gfCfg.flowerPlanId] then
			return {}
		end
	end
end

function FlowerGoddessConfig:getGfPlanData(actId, flowerId)
	local gfPlanCfg = self:getGfPlanCfg(actId)

	if not gfPlanCfg[flowerId] then
		return gfPlanCfg[flowerId]
	end
end

function FlowerGoddessConfig:getGfGoddessCfg(actId)
	local gfCfg = self:getGfCfg(actId)

	if not gfCfg.goddessPlanId then
		if not self._gfGoddessCfgs[gfCfg.goddessPlanId] then
			return {}
		end
	end
end

function FlowerGoddessConfig:getGfProCfg(actId)
	local gfCfg = self:getGfCfg(actId)

	if not gfCfg.progressPrizePlanId then
		if not self._gfProCfgs[gfCfg.progressPrizePlanId] then
			return {}
		end
	end
end

FlowerGoddessConfig.instance = FlowerGoddessConfig.New()

return FlowerGoddessConfig
