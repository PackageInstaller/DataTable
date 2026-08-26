-- chunkname: @modules/logic/rouge2/map/model/rpcmo/Rouge2_LayerWeatherInfoMO.lua

module("modules.logic.rouge2.map.model.rpcmo.Rouge2_LayerWeatherInfoMO", package.seeall)

local Rouge2_LayerWeatherInfoMO = pureTable("Rouge2_LayerWeatherInfoMO")

function Rouge2_LayerWeatherInfoMO:init(info)
	self._weatherId = info.weatherId
	self._weatherRuleIdList = info.weatherRuleId
end

function Rouge2_LayerWeatherInfoMO:getWeatherId()
	return self._weatherId
end

function Rouge2_LayerWeatherInfoMO:getWeatherRuleIdList()
	return self._weatherRuleIdList
end

return Rouge2_LayerWeatherInfoMO
