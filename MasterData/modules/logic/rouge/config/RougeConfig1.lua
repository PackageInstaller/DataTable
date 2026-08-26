-- chunkname: @modules/logic/rouge/config/RougeConfig1.lua

module("modules.logic.rouge.config.RougeConfig1", package.seeall)

local RougeConfig1 = class("RougeConfig1", RougeConfig)

function RougeConfig1:season()
	return 1
end

function RougeConfig1:openUnlockId()
	return OpenEnum.UnlockFunc.Rouge1
end

function RougeConfig1:achievementJumpId()
	return (tonumber(lua_rouge_const.configDict[RougeEnum.Const.AchievementJumpId].value))
end

function RougeConfig1:getRougeDifficultyViewStyleIndex(difficulty)
	if not difficulty then
		return
	end

	local stepDifficulty = tonumber(self:getConstValueByID(11)) or 1
	local totalStyle = tonumber(self:getConstValueByID(12)) or 1
	local resultStyle = math.ceil(difficulty / stepDifficulty)

	return math.min(totalStyle, resultStyle)
end

function RougeConfig1:calcStyleCOPassiveSkillDescsList(styleCO)
	local descList = {
		styleCO.passiveSkillDescs
	}
	local index = 2
	local str = styleCO["passiveSkillDescs" .. tostring(index)]

	while str do
		descList[#descList + 1] = str
		index = index + 1
		str = styleCO["passiveSkillDescs" .. tostring(index)]
	end

	return descList
end

RougeConfig1.instance = RougeConfig1.New()

return RougeConfig1
