-- chunkname: @modules/logic/versionactivity2_6/dicehero/controller/effect/DiceHeroUpdateDiceBoxWork.lua

module("modules.logic.versionactivity2_6.dicehero.controller.effect.DiceHeroUpdateDiceBoxWork", package.seeall)

local DiceHeroUpdateDiceBoxWork = class("DiceHeroUpdateDiceBoxWork", DiceHeroBaseEffectWork)

function DiceHeroUpdateDiceBoxWork:onStart(context)
	local gameInfo = DiceHeroFightModel.instance:getGameData()

	gameInfo.diceBox:init(self._effectMo.diceBox)
	self:onDone(true)
end

return DiceHeroUpdateDiceBoxWork
