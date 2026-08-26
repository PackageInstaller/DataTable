-- chunkname: @modules/logic/rouge2/map/model/rpcmo/Rouge2_NextLayerWeatherInfoMO.lua

module("modules.logic.rouge2.map.model.rpcmo.Rouge2_NextLayerWeatherInfoMO", package.seeall)

local Rouge2_NextLayerWeatherInfoMO = pureTable("Rouge2_NextLayerWeatherInfoMO")

function Rouge2_NextLayerWeatherInfoMO:init(info)
	self._layerId = info.layerId
	self._weatherInfoList, self._weatherInfoMap = GameUtil.rpcInfosToListAndMap(info.weatherInfo, Rouge2_LayerWeatherInfoMO, "_weatherId")
end

function Rouge2_NextLayerWeatherInfoMO:getWeatherInfoList()
	return self._weatherInfoList
end

function Rouge2_NextLayerWeatherInfoMO:getWeatherInfoMap()
	return self._weatherInfoMap
end

return Rouge2_NextLayerWeatherInfoMO
