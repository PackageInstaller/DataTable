-- chunkname: @modules/logic/versionactivity2_6/dicehero/controller/work/DiceHeroLastStepWork.lua

module("modules.logic.versionactivity2_6.dicehero.controller.work.DiceHeroLastStepWork", package.seeall)

local DiceHeroLastStepWork = class("DiceHeroLastStepWork", BaseWork)

function DiceHeroLastStepWork:ctor(fight)
	self.fight = fight
end

function DiceHeroLastStepWork:onStart(context)
	local gameData = DiceHeroFightModel.instance:getGameData()

	gameData:init(self.fight)

	DiceHeroFightModel.instance.tempRoundEnd = true

	local isGameNotEnd = DiceHeroFightModel.instance.finishResult == DiceHeroEnum.GameStatu.None

	self:onDone(true)

	if isGameNotEnd then
		DiceHeroController.instance:dispatchEvent(DiceHeroEvent.RoundEnd)
	end

	DiceHeroFightModel.instance.tempRoundEnd = false
end

return DiceHeroLastStepWork
