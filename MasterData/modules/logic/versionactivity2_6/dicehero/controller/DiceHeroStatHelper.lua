-- chunkname: @modules/logic/versionactivity2_6/dicehero/controller/DiceHeroStatHelper.lua

module("modules.logic.versionactivity2_6.dicehero.controller.DiceHeroStatHelper", package.seeall)

local DiceHeroStatHelper = class("DiceHeroStatHelper")

function DiceHeroStatHelper:ctor()
	self._useCardsRecords = {}
	self._gameBeginDt = 0
	self._talkBeginDt = 0
end

function DiceHeroStatHelper:resetGameDt()
	self._gameBeginDt = UnityEngine.Time.realtimeSinceStartup

	self:clearUseCard()
end

function DiceHeroStatHelper:resetTalkDt()
	self._talkBeginDt = UnityEngine.Time.realtimeSinceStartup
end

function DiceHeroStatHelper:clearUseCard()
	self._useCardsRecords = {}
end

function DiceHeroStatHelper:addUseCard(skillId)
	local fightData = DiceHeroFightModel.instance:getGameData()

	if not fightData then
		return
	end

	for _, info in ipairs(self._useCardsRecords) do
		if info.round == fightData.round then
			table.insert(info.skills, skillId)

			return
		end
	end

	table.insert(self._useCardsRecords, {
		round = fightData.round,
		skills = {
			skillId
		}
	})
end

function DiceHeroStatHelper:sendFightEnd(result, isFirst)
	local fightData = DiceHeroFightModel.instance:getGameData()
	local hpList = {}
	local shieldList = {}

	for _, enemyMo in ipairs(fightData.enemyHeros) do
		table.insert(hpList, enemyMo.hp)
		table.insert(shieldList, enemyMo.shield)
	end

	local var_6_0 = StatEnum.EventName.DiceHero_FightEnd
	local var_6_1 = {
		[StatEnum.EventProperties.DiceHero_ActId] = tostring(VersionActivity2_6Enum.ActivityId.DiceHero),
		[StatEnum.EventProperties.DiceHero_EpisodeId] = tostring(DiceHeroModel.instance.guideLevel),
		[StatEnum.EventProperties.DiceHero_OperTpye] = result and "settle" or "giveup",
		[StatEnum.EventProperties.DiceHero_UseTime] = UnityEngine.Time.realtimeSinceStartup - self._gameBeginDt
	}

	if fightData then
		var_6_1[StatEnum.EventProperties.DiceHero_RoundNum] = fightData.round or 0
	end

	var_6_1[StatEnum.EventProperties.DiceHero_Result] = tostring(result or DiceHeroEnum.GameStatu.None)
	var_6_1[StatEnum.EventProperties.DiceHero_IsFirst] = isFirst or false
	var_6_1[StatEnum.EventProperties.DiceHero_FightObj] = {
		hero = fightData.allyHero.id,
		relics = self:getClone(fightData.allyHero.relicIds),
		hp_init = fightData.initHp,
		hp = fightData.allyHero.hp,
		shield = fightData.allyHero.shield,
		enemy_hp = hpList,
		ememy_shield = shieldList
	}
	var_6_1[StatEnum.EventProperties.DiceHero_SkillInfo] = self._useCardsRecords

	StatController.instance:track(var_6_0, var_6_1)
end

function DiceHeroStatHelper:sendStoryEnd(isSettle, isFirst)
	StatController.instance:track(StatEnum.EventName.DiceHero_StoryEnd, {
		[StatEnum.EventProperties.DiceHero_ActId] = tostring(VersionActivity2_6Enum.ActivityId.DiceHero),
		[StatEnum.EventProperties.DiceHero_EpisodeId] = tostring(DiceHeroModel.instance.guideLevel),
		[StatEnum.EventProperties.DiceHero_OperTpye] = isSettle and "settle" or "giveup",
		[StatEnum.EventProperties.DiceHero_TalkId] = DiceHeroModel.instance.talkId,
		[StatEnum.EventProperties.DiceHero_StepId] = DiceHeroModel.instance.stepId,
		[StatEnum.EventProperties.DiceHero_UseTime] = UnityEngine.Time.realtimeSinceStartup - self._talkBeginDt,
		[StatEnum.EventProperties.DiceHero_IsFirst] = isFirst or false
	})
end

function DiceHeroStatHelper:sendReset()
	local gameData = DiceHeroModel.instance:getGameInfo(5)

	if not gameData then
		return
	end

	StatController.instance:track(StatEnum.EventName.DiceHero_Reset, {
		[StatEnum.EventProperties.DiceHero_ActId] = tostring(VersionActivity2_6Enum.ActivityId.DiceHero),
		[StatEnum.EventProperties.DiceHero_EpisodeId] = tostring(gameData.currLevel),
		[StatEnum.EventProperties.DiceHero_FightObj] = {
			hero = gameData.heroBaseInfo.id,
			hp = gameData.heroBaseInfo.hp,
			shield = gameData.heroBaseInfo.shield,
			relics = self:getClone(gameData.heroBaseInfo.relicIds)
		}
	})
end

function DiceHeroStatHelper:getClone(tb)
	local newT = {}

	for k, v in ipairs(tb) do
		newT[k] = v
	end

	return newT
end

DiceHeroStatHelper.instance = DiceHeroStatHelper.New()

return DiceHeroStatHelper
