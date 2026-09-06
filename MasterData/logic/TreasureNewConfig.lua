-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasurenew/config/TreasureNewConfig.lua

module("logic.extensions.treasurenew.config.TreasureNewConfig", package.seeall)

local TreasureNewConfig = class("TreasureNewConfig", BaseConfig)

function TreasureNewConfig:onInit()
	self:onReset()
end

function TreasureNewConfig:onReset()
	self._targetCfgs = nil
	self._turnTableCfgs = nil
	self._mapCfgs = nil
end

function TreasureNewConfig:getNames()
	return {
		"treasure_new_target",
		"treasure_new_turntable",
		"treasure_new_map"
	}
end

function TreasureNewConfig:handleConfig(name, content)
	if name == "treasure_new_target" then
		self._targetCfgs = content
	elseif name == "treasure_new_turntable" then
		self._turnTableCfgs = {}

		for _, v in ipairs(content.dataList) do
			self._turnTableCfgs[v.turntableId] = self._turnTableCfgs[v.turntableId] or {}
			self._turnTableCfgs[v.turntableId][checkint(v.index) + 1] = v
		end
	elseif name == "treasure_new_map" then
		self._mapCfgs = {}

		for _, v in ipairs(content.dataList) do
			self._mapCfgs[v.materialId] = v
		end
	end
end

function TreasureNewConfig:getTargetCfgById(defineId)
	if defineId == nil or self._targetCfgs == nil then
		return
	end

	return self._targetCfgs[defineId]
end

function TreasureNewConfig:getTurnTableCfgsById(tableId)
	if tableId == nil or self._turnTableCfgs == nil then
		return
	end

	return self._turnTableCfgs[tableId]
end

function TreasureNewConfig:getMapCfgByMatId(matId)
	return self._mapCfgs[matId]
end

TreasureNewConfig.instance = TreasureNewConfig.New()

return TreasureNewConfig
