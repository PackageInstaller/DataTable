-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/projectash/controller/ProjectAshController.lua

module("logic.extensions.projectash.controller.ProjectAshController", package.seeall)

local ProjectAshController = class("ProjectAshController", BaseController)

function ProjectAshController:ctor()
	return
end

function ProjectAshController:onInit()
	return
end

function ProjectAshController:isLeftLotteryPrizeCount(activityId)
	local cfgList = ProjectAshConfig.instance:getLotteryCfgList(activityId)

	if cfgList and #cfgList > 0 then
		for i, v in ipairs(cfgList) do
			local leftNum = v.limitTimes - ProjectAshModel.instance:getLotteryTimes(v.id)

			if leftNum > 0 then
				return true
			end
		end
	end

	return false
end

function ProjectAshController:getMyRewardStrList(myRank, activityId)
	if myRank <= 0 then
		return {}
	end

	local cfgList = ProjectAshConfig.instance:getRankPrizeCfgList(activityId)

	for i, v in ipairs(cfgList) do
		if v.rankRange and v.rankRange[1] and v.rankRange[2] and myRank >= v.rankRange[1] and myRank <= v.rankRange[2] then
			return MaterialMgr.changeItemStrArr(v.prize)
		end
	end

	return {}
end

function ProjectAshController:getNextCfg(stage2DamagePrizePlanId, myDamage)
	local cfgs = ProjectAshConfig.instance:getProgressPrizeCfgList(stage2DamagePrizePlanId)

	if cfgs and #cfgs > 0 then
		for i, v in ipairs(cfgs) do
			if myDamage < checknumber(v.progress) then
				return v
			end
		end

		return cfgs[#cfgs]
	end
end

function ProjectAshController:getStage2WorldPrizeMaxScore(activityId)
	local cfgActivity = ProjectAshConfig.instance:getActivityCfg(activityId)

	if cfgActivity then
		local list = ProjectAshConfig.instance:getProgressPrizeCfgList(cfgActivity.stage2WorldPrizePlanId)

		return checknumber(list[#list].progress)
	end

	return 0
end

ProjectAshController.instance = ProjectAshController.New()

return ProjectAshController
