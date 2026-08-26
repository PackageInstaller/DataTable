-- chunkname: @modules/logic/survival/model/map/SurvivalHexCellMo.lua

module("modules.logic.survival.model.map.SurvivalHexCellMo", package.seeall)

local SurvivalHexCellMo = class("SurvivalHexCellMo")

function SurvivalHexCellMo:init(data, mapType)
	self.pos = SurvivalHexNode.New(data.hex.hex.q, data.hex.hex.r)
	self.dir = data.hex.dir
	self.style = data.style

	local dict = lua_survival_walkable.configDict

	if dict[mapType] then
		self.co = dict[mapType][self.style] or nil
	end

	if not self.co then
		logError("可走格子配置不存在" .. tostring(mapType) .. " >> " .. tostring(self.style))
	end
end

return SurvivalHexCellMo
