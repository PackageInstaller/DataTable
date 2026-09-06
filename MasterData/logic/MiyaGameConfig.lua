-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/config/MiyaGameConfig.lua

module("logic.extensions.timelimitedchallenge.config.MiyaGameConfig", package.seeall)

local MiyaGameConfig = class("MiyaGameConfig", BaseConfig)

function MiyaGameConfig:onInit()
	MiyaGameConfig.super.onInit(self)

	self._cofignameCfg = nil

	local list = self:getNames()

	self._nameDic = {}

	for _, v in ipairs(list) do
		self._nameDic[v] = true
	end
end

function MiyaGameConfig:getNames()
	return {
		"timed_challenge_miya_difficulty",
		"timed_challenge_miya_mode",
		"timed_challenge_miya_params",
		"timed_challenge_miya_normal_monster",
		"timed_challenge_miya_normal_creeps",
		"timed_challenge_miya_boss_monster",
		"timed_challenge_miya_boss_creeps",
		"timed_challenge_miya_find_difference",
		"timed_challenge_miya_quiz",
		"timed_challenge_miya_question",
		"timed_challenge_miya_awaken_goods"
	}
end

function MiyaGameConfig:handleConfig(name, content)
	if self._nameDic[name] ~= nil then
		self._nameDic[name] = content
	end
end

function MiyaGameConfig:getNormalMonsterCfg(monsterId)
	local t = self._nameDic.timed_challenge_miya_normal_monster

	return t[monsterId]
end

function MiyaGameConfig:getNormalCreepsCfg(monsterId)
	local t = self._nameDic.timed_challenge_miya_normal_creeps

	return t[monsterId]
end

function MiyaGameConfig:getBossMonsterCfg(monsterId)
	local t = self._nameDic.timed_challenge_miya_boss_monster

	return t[monsterId]
end

function MiyaGameConfig:getBossMonsterCfgList()
	local t = self._nameDic.timed_challenge_miya_boss_monster

	return t.dataList
end

function MiyaGameConfig:getBossCreepsCfg(monsterId)
	local t = self._nameDic.timed_challenge_miya_boss_creeps

	return t[monsterId]
end

function MiyaGameConfig:getConstantValue(key)
	local t = self._nameDic.timed_challenge_miya_params

	if t[key] then
		return t[key].value
	end
end

function MiyaGameConfig:getRandomQuizCfg(difficulty)
	local t = self._nameDic.timed_challenge_miya_quiz
	local weightedEdges = {}

	for _, v in ipairs(t.dataList) do
		if v.difficulty == difficulty then
			table.insert(weightedEdges, Vector2.New(v.quizId, v.weight))
		end
	end

	local quizId = GameUtil.getRandomEdge(weightedEdges)

	return t[quizId]
end

function MiyaGameConfig:getQuizCfg(quizId)
	local t = self._nameDic.timed_challenge_miya_quiz

	return t[quizId]
end

function MiyaGameConfig:getFindFaultCfg(id)
	local t = self._nameDic.timed_challenge_miya_find_difference

	return t[id]
end

function MiyaGameConfig:getRandomFindfaultCfg(difficulty)
	local t = self._nameDic.timed_challenge_miya_find_difference
	local weightedEdges = {}

	for _, v in ipairs(t.dataList) do
		if v.difficulty == difficulty then
			table.insert(weightedEdges, Vector2.New(v.pictureId, v.weight))
		end
	end

	local pictureId = GameUtil.getRandomEdge(weightedEdges)

	return t[pictureId]
end

function MiyaGameConfig:getRandomQuestionIds(quizId, n)
	local t = self._nameDic.timed_challenge_miya_question
	local questionList = {}

	for _, v in ipairs(t.dataList) do
		if v.quizId == quizId then
			table.insert(questionList, v)
		end
	end

	GameUtil.permuteArray(questionList)

	for i = n + 1, #questionList do
		questionList[i] = nil
	end

	return questionList
end

function MiyaGameConfig:getDifficultyCfgs()
	local t = self._nameDic.timed_challenge_miya_difficulty

	return t.dataList
end

function MiyaGameConfig:getDifficultyCfg(difficulty)
	local t = self._nameDic.timed_challenge_miya_difficulty

	return t[difficulty]
end

function MiyaGameConfig:getModeCfg(modeId)
	local t = self._nameDic.timed_challenge_miya_mode

	return t[modeId]
end

function MiyaGameConfig:getGoodCfgs()
	local t = self._nameDic.timed_challenge_miya_awaken_goods

	return t.dataList
end

MiyaGameConfig.instance = MiyaGameConfig.New()

return MiyaGameConfig
