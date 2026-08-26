-- chunkname: @modules/logic/versionactivity2_6/dicehero/controller/effect/DiceHeroDiceBoxFullWork.lua

module("modules.logic.versionactivity2_6.dicehero.controller.effect.DiceHeroDiceBoxFullWork", package.seeall)

local DiceHeroDiceBoxFullWork = class("DiceHeroDiceBoxFullWork", DiceHeroBaseEffectWork)

function DiceHeroDiceBoxFullWork:onStart(context)
	GameFacade.showToast(ToastEnum.DiceHeroDiceBoxFull)
	self:onDone(true)
end

return DiceHeroDiceBoxFullWork
