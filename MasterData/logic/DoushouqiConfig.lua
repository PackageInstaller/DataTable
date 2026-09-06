-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doushouqi/config/DoushouqiConfig.lua

module("logic.extensions.doushouqi.config.DoushouqiConfig", package.seeall)

local DoushouqiConfig = class("DoushouqiConfig", BaseConfig)

function DoushouqiConfig:onInit()
	return
end

function DoushouqiConfig:getNames()
	return {
		"beast_fighting_chess_prize",
		"beast_fighting_chess_skill",
		"beast_fighting_chess_rank_prize",
		"beast_fighting_chess_activity",
		"beast_fighting_chess_type",
		"beast_fighting_chess_res",
		"beast_fighting_game_rule"
	}
end

function DoushouqiConfig:handleConfig(name, content)
	if name == "beast_fighting_chess_prize" then
		self._beast_fighting_chess_prize = content
	elseif name == "beast_fighting_chess_skill" then
		self._beast_fighting_chess_skill = content
	elseif name == "beast_fighting_chess_rank_prize" then
		self._beast_fighting_chess_rank_prize = content
	elseif name == "beast_fighting_chess_activity" then
		self._beast_fighting_chess_activity = content
	elseif name == "beast_fighting_chess_type" then
		self._beast_fighting_chess_type = content
	elseif name == "beast_fighting_chess_res" then
		self._beast_fighting_chess_res = content
	elseif name == "beast_fighting_game_rule" then
		self._beast_fighting_game_rule = content
	end
end

function DoushouqiConfig:getActivityCfg(activityId)
	return self._beast_fighting_chess_activity[activityId]
end

function DoushouqiConfig:getWaitingMatchSec(activityId)
	return self._beast_fighting_chess_activity[activityId].waitingMatchSec
end

function DoushouqiConfig:getStartMatchRobotSec(activityId)
	return self._beast_fighting_chess_activity[activityId].startMatchRobotSec
end

function DoushouqiConfig:getSkillCfgs(activityId)
	return self._beast_fighting_chess_skill[activityId]
end

function DoushouqiConfig:getSkillCfg(activityId, skillId)
	return self._beast_fighting_chess_skill[activityId][skillId]
end

function DoushouqiConfig:getDoushouqiResCfg(level)
	return self._beast_fighting_chess_res[level]
end

function DoushouqiConfig:getDoushouqiResName(level)
	return self._beast_fighting_chess_res[level].resName
end

function DoushouqiConfig:getStepLimit(activityId)
	return self._beast_fighting_chess_activity[activityId].stepLimit
end

function DoushouqiConfig:getRoundSec(activityId)
	return self._beast_fighting_chess_activity[activityId].roundSec
end

function DoushouqiConfig:getRoundSecAfterHangUp(activityId)
	return self._beast_fighting_chess_activity[activityId].roundSecAfterHangUp
end

function DoushouqiConfig:getChessTypeName(activityId, typeId)
	return self._beast_fighting_chess_type[activityId][typeId].desc
end

function DoushouqiConfig:getChessTypeCfg(activityId, typeId)
	return self._beast_fighting_chess_type[activityId][typeId]
end

function DoushouqiConfig:getRobotName(activityId)
	return self._beast_fighting_chess_activity[activityId].robotName
end

function DoushouqiConfig:getPrizeCfgs(activityId, chessType)
	return self._beast_fighting_chess_prize[activityId][chessType]
end

function DoushouqiConfig:getPrizeCfg(activityId, chessType, prizeId)
	return self._beast_fighting_chess_prize[activityId][chessType][prizeId]
end

function DoushouqiConfig:getRankPrizeCfg(activityId, chessType, rank)
	for i, v in pairs(self._beast_fighting_chess_rank_prize[activityId][chessType]) do
		if rank >= v.rankRange[1] and rank <= v.rankRange[2] then
			return v
		end
	end

	return nil
end

function DoushouqiConfig:getImgRuleInfos()
	local ruleInfos = {}

	for i, v in ipairs(self._beast_fighting_game_rule.dataList) do
		local info = {
			url = GameUrl.getBigbgPngUrl(v.picturePath),
			desc = v.desc
		}

		table.insert(ruleInfos, info)
	end

	return ruleInfos
end

function DoushouqiConfig:getHangUpBanSec(activityId)
	return self:getActivityCfg(activityId).hangUpBanSec
end

DoushouqiConfig.instance = DoushouqiConfig.New()

return DoushouqiConfig
