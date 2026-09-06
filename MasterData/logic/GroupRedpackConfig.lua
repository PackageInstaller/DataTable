-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/groupredpack/config/GroupRedpackConfig.lua

module("logic.extensions.groupredpack.config.GroupRedpackConfig", package.seeall)

local GroupRedpackConfig = class("GroupRedpackConfig", BaseConfig)

function GroupRedpackConfig:onInit()
	GroupRedpackConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function GroupRedpackConfig:getNames()
	return {
		"group_red_pack_activity",
		"group_red_pack_plan",
		"group_red_pack_slogan",
		"group_red_pack_bubble",
		"group_red_pack_cover",
		"group_red_pack_rank_prize"
	}
end

function GroupRedpackConfig:handleConfig(name, content)
	if name == "group_red_pack_activity" then
		self._groupRedpackActivity = content
	elseif name == "group_red_pack_plan" then
		self._groupRedpackPlan = content
	elseif name == "group_red_pack_slogan" then
		self._groupRedpackSlogan = content
	elseif name == "group_red_pack_bubble" then
		self._groupRedpackBubble = content
	elseif name == "group_red_pack_cover" then
		self._groupRedpackCover = content
	elseif name == "group_red_pack_rank_prize" then
		self._rankPrizeCfgs = content
	end
end

function GroupRedpackConfig:getGroupRedpackCfgsByActId(actId)
	return self._groupRedpackActivity[actId]
end

function GroupRedpackConfig:getGroupRedpackPlanCfgs(planId)
	return self._groupRedpackPlan[planId]
end

function GroupRedpackConfig:getGroupRedpackPlanCfgsById(planId, type)
	local cfgs = self:getGroupRedpackPlanCfgs(planId)

	if cfgs then
		return cfgs[type]
	end

	return nil
end

function GroupRedpackConfig:getGroupRedpackSloganNum(planId)
	return #self._groupRedpackSlogan[planId]
end

function GroupRedpackConfig:getGroupRedpackSloganCfgs(planId)
	return self._groupRedpackSlogan[planId]
end

function GroupRedpackConfig:getGroupRedpackSloganCfgsById(planId, id)
	local cfgs = self:getGroupRedpackSloganCfgs(planId)

	if cfgs then
		return cfgs[id]
	end

	return nil
end

function GroupRedpackConfig:getGroupRedpackBubbleCfgs(id)
	return self._groupRedpackBubble[id]
end

function GroupRedpackConfig:getGroupRedpackBubbleNum()
	return #self._groupRedpackBubble
end

function GroupRedpackConfig:getGroupRedpackCoverCfgs(planId)
	return self._groupRedpackCover[planId]
end

function GroupRedpackConfig:getGroupRedpackCoverCfgsById(planId, id)
	local cfgs = self:getGroupRedpackCoverCfgs(planId)

	if cfgs then
		return cfgs[id]
	end

	return nil
end

function GroupRedpackConfig:getGroupRedpackPetLen(planId, id)
	local cfgs = self:getGroupRedpackCoverCfgsById(planId, id)

	if cfgs then
		local petStr = string.split(cfgs.coverIds, ";")

		return #petStr
	end

	return 0
end

function GroupRedpackConfig:getRankCfgsByActId(actId)
	local list = {}

	for k, v in pairs(self._rankPrizeCfgs[actId]) do
		table.insert(list, v)
	end

	table.sort(list, function(a, b)
		return a.rankRange[1] < b.rankRange[1]
	end)

	return list
end

GroupRedpackConfig.instance = GroupRedpackConfig.New()

return GroupRedpackConfig
