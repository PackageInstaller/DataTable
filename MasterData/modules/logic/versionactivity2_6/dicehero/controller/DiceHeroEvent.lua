-- chunkname: @modules/logic/versionactivity2_6/dicehero/controller/DiceHeroEvent.lua

module("modules.logic.versionactivity2_6.dicehero.controller.DiceHeroEvent", package.seeall)

local DiceHeroEvent = _M
local _get = GameUtil.getUniqueTb()

DiceHeroEvent.OneClickClaimReward = _get()
DiceHeroEvent.InfoUpdate = _get()
DiceHeroEvent.ConfirmDice = _get()
DiceHeroEvent.RerollDice = _get()
DiceHeroEvent.StepStart = _get()
DiceHeroEvent.StepEnd = _get()
DiceHeroEvent.SkillCardSelectChange = _get()
DiceHeroEvent.SkillCardDiceChange = _get()
DiceHeroEvent.EnemySelectChange = _get()
DiceHeroEvent.RoundEnd = _get()
DiceHeroEvent.OnDamage = _get()
DiceHeroEvent.DiceHeroGuideRoundInfo = _get()

return DiceHeroEvent
