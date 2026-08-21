-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/util/BattleAudioUtil.lua

module("logic.battle.util.BattleAudioUtil", package.seeall)

local BattleAudioUtil = {}

BattleAudioUtil.VoiceEnum = {
	speech_hit_heavy_vo = "speech_%s_hit_heavy_vo",
	speech_hit_heavy = "speech_%s_hit_heavy",
	speech_shibai = "speech_%s_shibai",
	speech_lizhiqianghua = "speech_%s_lizhiqianghua",
	speech_shengli = "speech_%s_shengli",
	speech_hit_light = "speech_%s_hit_light",
	speech_dilizhi = "speech_%s_dilizhi",
	speech_shangzhen = "speech_%s_shangzhen",
	speech_xuanzhong = "speech_%s_xuanzhong",
	speech_death = "speech_%s_death",
	speech_gaolizhi = "speech_%s_gaolizhi"
}

local function playVoice(modelId, voiceEnum)
	local key = string.format(voiceEnum, modelId)

	if BattleLog.enableLog then
		BattleLog.log(string.format("BattleAudioUtil::play voice:%s", key))
	end

	CriwareAudioFacade.instance:playVoiceByName(key)
end

function BattleAudioUtil.playVoice(unit, voiceEnum)
	local modelId = unit.property:getModelCode()

	playVoice(modelId, voiceEnum)
end

function BattleAudioUtil.playVoiceByHeroId(heroId, voiceEnum)
	local entityCO = BattleConfigUtil.getEntityConfig(heroId)
	local modelId = entityCO.modelId

	playVoice(modelId, voiceEnum)
end

function BattleAudioUtil.stopVoice()
	if BattleLog.enableLog then
		BattleLog.log("BattleAudioUtil::stop voice")
	end

	CriwareAudioFacade.instance:stopVoice()
end

function BattleAudioUtil.playSEByName(seName, gameObject)
	CriwareAudioFacade.instance:playSEByName(seName, gameObject, nil, nil)
end

return BattleAudioUtil
