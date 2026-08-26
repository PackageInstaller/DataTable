-- chunkname: @modules/logic/survival/model/shelter/SurvivalIntrudeBoxMo.lua

module("modules.logic.survival.model.shelter.SurvivalIntrudeBoxMo", package.seeall)

local SurvivalIntrudeBoxMo = pureTable("SurvivalIntrudeBoxMo")

function SurvivalIntrudeBoxMo:init(data)
	self.templateId = data.templateId
	self.fight = SurvivalIntrudeFightMo.New()

	self.fight:init(data.fight)
end

function SurvivalIntrudeBoxMo:getNextBossCreateDay(curDay)
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local fight = weekInfo:getMonsterFight()

	return fight.beginTime
end

return SurvivalIntrudeBoxMo
