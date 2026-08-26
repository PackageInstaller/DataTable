-- chunkname: @modules/logic/versionactivity2_6/dicehero/controller/effect/DiceHeroUpdateSkillCardWork.lua

module("modules.logic.versionactivity2_6.dicehero.controller.effect.DiceHeroUpdateSkillCardWork", package.seeall)

local DiceHeroUpdateSkillCardWork = class("DiceHeroUpdateSkillCardWork", DiceHeroBaseEffectWork)

function DiceHeroUpdateSkillCardWork:onStart(context)
	for k, v in pairs(DiceHeroHelper.instance._cardDict) do
		v:playRefreshAnim()
	end

	TaskDispatcher.runDelay(self._delayRefreshCard, self, 0.167)
end

function DiceHeroUpdateSkillCardWork:_delayRefreshCard()
	local gameInfo = DiceHeroFightModel.instance:getGameData()

	for _, v in ipairs(self._effectMo.skillCards) do
		local cardMo = gameInfo:getCardMoBySkillId(v.skillId)

		if cardMo then
			cardMo:init(v)
		end
	end

	self:onDone(true)
end

function DiceHeroUpdateSkillCardWork:clearWork()
	TaskDispatcher.cancelTask(self._delayRefreshCard, self)
end

return DiceHeroUpdateSkillCardWork
