-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/config/ElizabethConfig.lua

module("logic.extensions.timelimitedchallenge.config.ElizabethConfig", package.seeall)

local ElizabethConfig = class("ElizabethConfig", BaseConfig)

function ElizabethConfig:onInit()
	ElizabethConfig.super.onInit(self)
end

function ElizabethConfig:getNames()
	return {
		"elizabeth_clg_buy_times",
		"elizabeth_clg_common",
		"elizabeth_clg_scale_prize",
		"elizabeth_clg_prize"
	}
end

function ElizabethConfig:handleConfig(name, content)
	if name == "elizabeth_clg_common" then
		self._commonCfg = content
	elseif name == "elizabeth_clg_buy_times" then
		self._buyTimesCfg = content
	elseif name == "elizabeth_clg_scale_prize" then
		self._scalePrizeCfg = content
	elseif name == "elizabeth_clg_prize" then
		self._prizeCfg = content
	end
end

function ElizabethConfig:getConstantValue(key, isToNumber)
	local value

	if self._commonCfg and self._commonCfg[key] then
		value = self._commonCfg[key].value
	end

	if isToNumber then
		return checknumber(value)
	else
		return value
	end
end

function ElizabethConfig:getPrizeCfgs(planId)
	if self._prizeCfg then
		local plan = self._prizeCfg[planId]
		local list = table.values(plan)

		table.sort(list, function(a, b)
			return a.prizeId < b.prizeId
		end)

		return list
	end
end

function ElizabethConfig:getBuyTimesCfg(planId, buyTimes)
	return self._buyTimesCfg[planId][buyTimes]
end

function ElizabethConfig:getBuyTimesCfgs(planId)
	return self._buyTimesCfg[planId]
end

function ElizabethConfig:getReliveConsume(planId, reliveTimes)
	return self:getConstantValue("REVIVE_COST")
end

function ElizabethConfig:getScalePrizeCfgs(planId)
	if self._scalePrizeCfg then
		local list = table.values(self._scalePrizeCfg[planId])

		table.sort(list, function(a, b)
			return a.scale < b.scale
		end)

		return list
	end

	return {}
end

ElizabethConfig.instance = ElizabethConfig.New()

return ElizabethConfig
