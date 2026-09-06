-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/crazypartner/model/CrazyPartnerFightInfo.lua

module("logic.extensions.crazypartner.model.CrazyPartnerFightInfo", package.seeall)

local CrazyPartnerFightInfo = class("CrazyPartnerFightInfo")

function CrazyPartnerFightInfo:ctor(difficulty)
	self.difficulty = difficulty
	self.currentDamage = 0
	self.currentChallengeId = CrazyPartnerConfig.instance:getChallengeId()
	self.currentPlan = CrazyPartnerConfig.instance:getPlanConf(self.currentChallengeId, self.difficulty)
	self.currentScorePlanId = self.currentPlan.scorePlanId
	self.currentSystemPetPlanId = self.currentPlan.systemPetPlanId
	self.currentCreepsMasterId = self.currentPlan.creepsMasterId
	self.currentBuffId = CrazyPartnerConfig.instance:getTeamConfs(self.currentCreepsMasterId).clientBufferId
	self.currentScore = 0
	self.scoreConfs = CrazyPartnerConfig.instance:getDamageConfs(self.currentScorePlanId)
	self.scoreArray = {}

	for _, conf in pairs(self.scoreConfs) do
		table.insert(self.scoreArray, conf.damage)
	end

	table.sort(self.scoreArray, function(a, b)
		return a < b
	end)
end

function CrazyPartnerFightInfo:update(msg)
	self.currentDamage = msg.damage
	self.currentScore = 0
	self.taskState = msg.taskInfo

	for _, score in ipairs(self.scoreArray) do
		local conf = self.scoreConfs[score]

		if self.currentDamage >= conf.damage then
			self.currentScore = conf.score
		end
	end
end

function CrazyPartnerFightInfo:getDescString()
	local content = ""

	for i, score in ipairs(self.scoreArray) do
		local curConf = self.scoreConfs[score]
		local nextScore = self.scoreArray[i + 1]
		local nextConf = self.scoreConfs[nextScore]
		local splitsStr = i % 2 == 0 and "\n" or "\n"

		content = nextConf and string.format("%s%s-%s：%d积分%s", content, StringUtil.numberToString(curConf.damage), StringUtil.numberToString(nextConf.damage), curConf.score, splitsStr) or string.format("%s%s以上：%d积分%s", content, StringUtil.numberToString(curConf.damage), curConf.score, splitsStr)
	end

	return content
end

return CrazyPartnerFightInfo
