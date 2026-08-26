-- chunkname: @modules/logic/versionactivity3_7/travelgo/model/reward/TravelGoSkillReward.lua

module("modules.logic.versionactivity3_7.travelgo.model.reward.TravelGoSkillReward", package.seeall)

local TravelGoSkillReward = pureTable("TravelGoSkillReward", TravelGoRewardBase)

function TravelGoSkillReward:onSetData(param)
	local weights = {}

	for i, v in ipairs(param) do
		local weight = tonumber(v)

		table.insert(weights, weight)
	end

	local index = TravelGoController.instance:randomByWeight(weights)
	local rare = index
	local cfgs = TravelGoConfig.instance:getSkillsByRare(rare)

	weights = {}

	for i, cfg in ipairs(cfgs) do
		local weight = cfg.weight

		table.insert(weights, weight)
	end

	self.skillCfgList = {}

	for i = 1, 3 do
		if #cfgs <= 0 then
			break
		end

		index = TravelGoController.instance:randomByWeight(weights)

		table.insert(self.skillCfgList, cfgs[index])
		table.remove(cfgs, index)
		table.remove(weights, index)
	end
end

function TravelGoSkillReward:getSkillCfgList()
	return self.skillCfgList
end

function TravelGoSkillReward:setSelectSkill(index)
	self.selectSkill = index
end

function TravelGoSkillReward:getSelectSkillId()
	if not self.selectSkill then
		return
	end

	local cfg = self.skillCfgList[self.selectSkill]

	if not cfg then
		logError(string.format("TravelGoSkillReward:getSelectSkillId error, skillCfg is nil, selectSkill:%s", tostring(self.selectSkill)))
	end

	return cfg and cfg.skillId
end

function TravelGoSkillReward:giveRewards()
	local cfg = self.skillCfgList[self.selectSkill]
	local playerEntity = TravelGoController.instance.travelGoEntityMgr.playerEntity

	playerEntity.skill:addSkill(cfg.skillId)

	local selectSkillId = cfg.skillId
	local selectableSkills = {}

	for _, config in ipairs(self.skillCfgList) do
		if config then
			table.insert(selectableSkills, config.skillId)
		end
	end

	TravelGoStatHelper.instance:selectSkill(selectSkillId, selectableSkills)
end

function TravelGoSkillReward:getSelectSkillCfg()
	local skillId = self:getSelectSkillId()

	return lua_activity220_skill.configDict[skillId]
end

function TravelGoSkillReward:getRewardDesc()
	local cfg = self:getSelectSkillCfg()

	return (cfg or nil) and (cfg.name or "")
end

function TravelGoSkillReward:getRewardIcon()
	local cfg = self:getSelectSkillCfg()

	return cfg and cfg.icon
end

function TravelGoSkillReward:getRewardBkg()
	return "v3a7_xiaoruiannong_game_skillnamebg"
end

return TravelGoSkillReward
