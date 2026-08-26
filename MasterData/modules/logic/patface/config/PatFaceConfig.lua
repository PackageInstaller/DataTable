-- chunkname: @modules/logic/patface/config/PatFaceConfig.lua

module("modules.logic.patface.config.PatFaceConfig", package.seeall)

local PatFaceConfig = class("PatFaceConfig", BaseConfig)

function PatFaceConfig:ctor()
	self._patFaceConfigList = {}
end

function PatFaceConfig:reqConfigNames()
	return {
		"pat_face"
	}
end

function PatFaceConfig:onConfigLoaded(configName, configTable)
	local funcName = string.format("%sConfigLoaded", configName)
	local configLoadedFunc = self[funcName]

	if configLoadedFunc then
		configLoadedFunc(self, configTable)
	end
end

local function patFaceSortFun(a, b)
	if not a.order then
		if not b.order then
			local bOrder = 0

			if a.order ~= bOrder then
				return a.order < bOrder
			end

			return a.id < b.id
		end
	end
end

function PatFaceConfig:pat_faceConfigLoaded(configTable)
	local tmpList = {}

	for _, cfg in ipairs(configTable.configList) do
		local id = cfg.id

		tmpList[#tmpList + 1] = {
			id = id,
			order = cfg.patFaceOrder,
			config = cfg
		}
	end

	table.sort(tmpList, patFaceSortFun)

	self._patFaceConfigList = tmpList
end

local function getCfg(id, canNil)
	local cfg

	if id then
		cfg = lua_pat_face.configDict[id]
	end

	if not cfg and not canNil then
		logError(string.format("PatFaceConfig:getCfg error, cfg is nil, id:%s", id))
	end

	return cfg
end

function PatFaceConfig:getPatFaceActivityId(id)
	local cfg = getCfg(id)

	return (cfg or nil) and cfg.patFaceActivityId
end

function PatFaceConfig:getPatFaceViewName(id)
	local cfg = getCfg(id)

	return (cfg or nil) and cfg.patFaceViewName
end

function PatFaceConfig:getPatFaceStoryId(id)
	local cfg = getCfg(id)

	return (cfg or nil) and cfg.patFaceStoryId
end

function PatFaceConfig:getPatFaceOrder(id)
	local cfg = getCfg(id)

	return (cfg or nil) and cfg.patFaceOrder
end

function PatFaceConfig:getPatFaceConfigList()
	return self._patFaceConfigList or {}
end

PatFaceConfig.instance = PatFaceConfig.New()

return PatFaceConfig
