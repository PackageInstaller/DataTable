-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recap2021/config/Recap2021Config.lua

module("logic.extensions.recap2021.config.Recap2021Config", package.seeall)

local Recap2021Config = class("Recap2021Config", BaseConfig)

function Recap2021Config:onInit()
	return
end

function Recap2021Config:getNames()
	return {
		"recap2021_base",
		"recap2021_letter_prize",
		"recap2021_edition",
		"recap2021_letter_content",
		"recap2021_person_lookback",
		"recap2021_person_lookback_tag",
		"recap2021_data_ids",
		"recap2021_edition_desc",
		"recap2021_person_lookback_detail",
		"recap2021_person_lookback_judge_plan",
		"recap2021_over_plan",
		"recap2021_person_lookback_battle_judge",
		"recap2021_person_random_word"
	}
end

function Recap2021Config:handleConfig(name, content)
	if name == "recap2021_base" then
		self._recap2021_base = content
	elseif name == "recap2021_letter_prize" then
		self._recap2021_letter_prize = content
	elseif name == "recap2021_edition" then
		self._recap2021_edition = content
	elseif name == "recap2021_letter_content" then
		self._recap2021_letter_content = content
	elseif name == "recap2021_person_lookback" then
		self._recap2021_person_lookback = content
	elseif name == "recap2021_person_lookback_tag" then
		self._recap2021_person_lookback_tag = content
	elseif name == "recap2021_data_ids" then
		self._recap2021_data_ids = content
	elseif name == "recap2021_edition_desc" then
		self._recap2021_edition_desc = content
	elseif name == "recap2021_person_lookback_detail" then
		self._recap2021_person_lookback_detail = content
	elseif name == "recap2021_person_lookback_judge_plan" then
		self._recap2021_person_lookback_judge_plan = content
	elseif name == "recap2021_over_plan" then
		self._recap2021_over_plan = content
	elseif name == "recap2021_person_lookback_battle_judge" then
		self._recap2021_person_lookback_battle_judge = content
	elseif name == "recap2021_person_random_word" then
		self._recap2021_person_random_word = content
	end
end

function Recap2021Config:getLetterPrizeCfgs()
	return self._recap2021_letter_prize.dataList
end

function Recap2021Config:getCommonValue(key, need2number)
	local value = self._recap2021_base[key].value

	if need2number then
		value = checkint(value)
	end

	return value
end

function Recap2021Config:getLetterCfg(planId)
	return self._recap2021_letter_content[planId]
end

function Recap2021Config:getPersonLookBackCfgs(planId)
	return self._recap2021_person_lookback[planId]
end

function Recap2021Config:getPersonLookBackTagCfgs(tagPlanId)
	return self._recap2021_person_lookback_tag[tagPlanId]
end

function Recap2021Config:getDataDescCfg(dataId)
	return self._recap2021_data_ids[dataId]
end

function Recap2021Config:getEditionCfgs()
	return self._recap2021_edition.dataList
end

function Recap2021Config:getEditionCfg(editionId)
	return self._recap2021_edition[editionId]
end

function Recap2021Config:getEditionDescCfgs(descPlanId)
	return self._recap2021_edition_desc[descPlanId]
end

function Recap2021Config:getPersonDetailCfgs(detailPlanId)
	return self._recap2021_person_lookback_detail[detailPlanId]
end

function Recap2021Config:getDataDesc(dataId)
	return self._recap2021_data_ids[dataId].desc
end

function Recap2021Config:getJudgeCfg(judgePlanId)
	return self._recap2021_person_lookback_judge_plan[judgePlanId]
end

function Recap2021Config:getOverPlanCfgs(overPlanId)
	return self._recap2021_over_plan[overPlanId]
end

function Recap2021Config:getBattleJudgeCfgs()
	return self._recap2021_person_lookback_battle_judge.dataList
end

function Recap2021Config:getPersonRandomWords()
	return self._recap2021_person_random_word.dataList
end

Recap2021Config.instance = Recap2021Config.New()

return Recap2021Config
