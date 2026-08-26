-- chunkname: @modules/logic/survival/model/map/SurvivalScenePropMo.lua

module("modules.logic.survival.model.map.SurvivalScenePropMo", package.seeall)

local SurvivalScenePropMo = pureTable("SurvivalScenePropMo")

function SurvivalScenePropMo:init(data)
	self.magmaStatus = data.magmaStatus
	self.radarPosition = SurvivalHexNode.New(data.radarHex.q, data.radarHex.r)
	self.teleportGate = data.teleportGate
	self.teleportGateHex = SurvivalHexNode.New(data.teleportGateHex.q, data.teleportGateHex.r)
	self.mode = data.mode
end

return SurvivalScenePropMo
