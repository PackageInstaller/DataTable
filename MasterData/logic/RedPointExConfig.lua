-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/redpointex/config/RedPointExConfig.lua

module("logic.extensions.redpointex.config.RedPointExConfig", package.seeall)

local RedPointExConfig = class("RedPointExConfig", BaseConfig)

function RedPointExConfig:onInit()
	return
end

function RedPointExConfig:onReset()
	return
end

function RedPointExConfig:getNames()
	return {
		"red_point_ex_cycle",
		"red_point_ex_once"
	}
end

function RedPointExConfig:handleConfig(name, content)
	if name == "red_point_ex_cycle" then
		self._rpeCycleCfg = content
		self._rpeCycleDataList = content.dataList

		self:_handleRpeCycleDataListToPoolByViewName(content.dataList)
	elseif name == "red_point_ex_once" then
		self._rpeOnceCfg = content
		self._rpeOnceDataList = content.dataList

		self:_handleRpeOnceDataListToPoolByViewName(content.dataList)
	end
end

function RedPointExConfig:isCycleRed(cycleRedId)
	return not not self._rpeCycleCfg[cycleRedId]
end

function RedPointExConfig:getRpeCycleCfg()
	return self._rpeCycleCfg
end

function RedPointExConfig:getRpeCycleData(cycleRedId)
	return self._rpeCycleCfg[cycleRedId]
end

function RedPointExConfig:getRpeCycleDataList()
	return self._rpeCycleDataList
end

function RedPointExConfig:getRpeCycleDataListByViewName(viewName)
	return self._rpeCycleDataListPool[viewName]
end

function RedPointExConfig:_handleRpeCycleDataListToPoolByViewName(dataList)
	self._rpeCycleDataListPool = {}

	for _, data in pairs(dataList) do
		if not string.nilorempty(data.viewName) then
			if self._rpeCycleDataListPool[data.viewName] == nil then
				self._rpeCycleDataListPool[data.viewName] = {}
			end

			table.insert(self._rpeCycleDataListPool[data.viewName], data)
		end
	end
end

function RedPointExConfig:isOnceRed(onceRedId)
	return not not self._rpeOnceCfg[onceRedId]
end

function RedPointExConfig:getRpeOnceCfg()
	return self._rpeOnceCfg
end

function RedPointExConfig:getRpeOnceData(onceRedId)
	return self._rpeOnceCfg[onceRedId]
end

function RedPointExConfig:getRpeOnceDataList()
	return self._rpeOnceDataList
end

function RedPointExConfig:getRpeOnceDataListByViewName(viewName)
	return self._rpeOnceDataListPool[viewName]
end

function RedPointExConfig:_handleRpeOnceDataListToPoolByViewName(dataList)
	self._rpeOnceDataListPool = {}

	for _, data in pairs(dataList) do
		if not string.nilorempty(data.viewName) then
			if self._rpeOnceDataListPool[data.viewName] == nil then
				self._rpeOnceDataListPool[data.viewName] = {}
			end

			table.insert(self._rpeOnceDataListPool[data.viewName], data)
		end
	end
end

RedPointExConfig.instance = RedPointExConfig.New()

return RedPointExConfig
