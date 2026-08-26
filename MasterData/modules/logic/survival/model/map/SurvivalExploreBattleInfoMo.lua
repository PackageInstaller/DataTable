-- chunkname: @modules/logic/survival/model/map/SurvivalExploreBattleInfoMo.lua

module("modules.logic.survival.model.map.SurvivalExploreBattleInfoMo", package.seeall)

local SurvivalExploreBattleInfoMo = pureTable("SurvivalExploreBattleInfoMo")

function SurvivalExploreBattleInfoMo:init(data)
	self.unitId = data.unitId
	self.battleId = data.battleId
	self.status = data.status
end

return SurvivalExploreBattleInfoMo
