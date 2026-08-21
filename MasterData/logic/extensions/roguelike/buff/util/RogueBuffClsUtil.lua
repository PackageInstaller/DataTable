-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/buff/util/RogueBuffClsUtil.lua

module("logic.extensions.roguelike.buff.util.RogueBuffClsUtil", package.seeall)

local M = {}
local ClsMap

function M.getHandlerCls(buffName)
	local cls = M._getClsByName(buffName)

	return cls
end

function M._getClsByName(buffName)
	if ClsMap == nil then
		ClsMap = {
			AddBleedingPattern = RogueBuffHandler_AddBleedingPattern,
			Damage2Fighting = RogueBuffHandler_Damage2Fighting,
			Damage2HP = RogueBuffHandler_Damage2HP,
			FixedRoundDice = RogueBuffHandler_FixedRoundDice,
			ReduceHP = RogueBuffHandler_ReduceHP,
			HpReduceEffect = RogueBuffHandler_HpReduceEffect,
			ChangeFeaturesDice = RogueBuffHandler_ChangeFeaturesDice,
			ChangeMonster = RogueBuffHandler_ChangeMonster,
			AddMonsterFight = RogueBuffHandler_AddMonsterFight,
			AddMonsterHp = RogueBuffHandler_AddMonsterHp,
			Damage2Death = RogueBuffHandler_Damage2Death,
			HpReduce2Fight = RogueBuffHandler_HpReduce2Fight,
			RoundEnd2Death = RogueBuffHandler_RoundEnd2Death,
			RoundEnd2Injured = RogueBuffHandler_RoundEnd2Injured,
			RoundEndAddBleed = RogueBuffHandler_RoundEndAddBleed,
			RoundEndAddFight = RogueBuffHandler_RoundEndAddFight,
			RoundEndAddAttr = RogueBuffHandler_RoundEndAddAttr,
			Surplus2AvgEffect = RogueBuffHandler_Surplus2AvgEffect,
			Surplus2Damage = RogueBuffHandler_Surplus2Damage,
			AttackDamage = RogueBuffHandler_Surplus2AvgEffect,
			AddCardEntry = RogueBuffHandler_AddCardEntry,
			FightBigSuccessAddition = RogueBuffHandler_FightBigSuccessAddition,
			BigSuccessAddition = RogueBuffHandler_BigSuccessAddition,
			AddGambleTime = RogueBuffHandler_AddGambleTime,
			GambleDebuffCleanUp = RogueBuffHandler_GambleDebuffCleanUp,
			ChangeJudgeDifficulty = RogueBuffHandler_ChangeJudgeDifficulty,
			ByRoom = RogueConditionHandler_ByRoom,
			ByOwnMaxHero = RogueConditionHandler_ByOwnMaxHero,
			WhenJudgeStart = RogueConditionHandler_WhenJudgeStart,
			WhenJudgeEnd = RogueConditionHandler_WhenJudgeStart
		}
	end

	local cls = ClsMap[buffName]

	if not cls then
		print("没有对应配置", buffName)
	end

	return cls
end

return M
