-- chunkname: @modules/logic/versionactivity2_6/dicehero/defines/DiceHeroStatEnum.lua

module("modules.logic.versionactivity2_6.dicehero.defines.DiceHeroStatEnum", package.seeall)

local DiceHeroStatEnum = pureTable("DiceHeroStatEnum")

function DiceHeroStatEnum.initEnum(StatEnum)
	StatEnum.EventName.DiceHero_FightEnd = "dicehero_fight_end"
	StatEnum.EventName.DiceHero_StoryEnd = "dicehero_story_end"
	StatEnum.EventName.DiceHero_Reset = "dicehero_endless_reset"
	StatEnum.EventProperties.DiceHero_ActId = "activity_id"
	StatEnum.EventProperties.DiceHero_EpisodeId = "episodeid"
	StatEnum.EventProperties.DiceHero_OperTpye = "operation_type"
	StatEnum.EventProperties.DiceHero_UseTime = "usetime"
	StatEnum.EventProperties.DiceHero_RoundNum = "round_num"
	StatEnum.EventProperties.DiceHero_Result = "result"
	StatEnum.EventProperties.DiceHero_IsFirst = "isfirst"
	StatEnum.EventProperties.DiceHero_FightObj = "dicehero_fight_obj"
	StatEnum.EventProperties.DiceHero_SkillInfo = "dicehero_skill_info"
	StatEnum.EventProperties.DiceHero_TalkId = "guideid"
	StatEnum.EventProperties.DiceHero_StepId = "stepid"
	StatEnum.PropertyTypes[StatEnum.EventProperties.DiceHero_ActId] = StatEnum.Type.String
	StatEnum.PropertyTypes[StatEnum.EventProperties.DiceHero_EpisodeId] = StatEnum.Type.String
	StatEnum.PropertyTypes[StatEnum.EventProperties.DiceHero_OperTpye] = StatEnum.Type.String
	StatEnum.PropertyTypes[StatEnum.EventProperties.DiceHero_UseTime] = StatEnum.Type.Number
	StatEnum.PropertyTypes[StatEnum.EventProperties.DiceHero_RoundNum] = StatEnum.Type.Number
	StatEnum.PropertyTypes[StatEnum.EventProperties.DiceHero_Result] = StatEnum.Type.String
	StatEnum.PropertyTypes[StatEnum.EventProperties.DiceHero_IsFirst] = StatEnum.Type.Boolean
	StatEnum.PropertyTypes[StatEnum.EventProperties.DiceHero_FightObj] = StatEnum.Type.List
	StatEnum.PropertyTypes[StatEnum.EventProperties.DiceHero_SkillInfo] = StatEnum.Type.Array
	StatEnum.PropertyTypes[StatEnum.EventProperties.DiceHero_TalkId] = StatEnum.Type.Number
	StatEnum.PropertyTypes[StatEnum.EventProperties.DiceHero_StepId] = StatEnum.Type.Number
end

return DiceHeroStatEnum
