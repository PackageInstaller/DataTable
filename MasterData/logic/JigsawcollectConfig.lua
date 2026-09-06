-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jigsawcollect/config/JigsawcollectConfig.lua

module("logic.extensions.jigsawcollect.config.JigsawcollectConfig", package.seeall)

local JigsawcollectConfig = class("JigsawcollectConfig", BaseConfig)

function JigsawcollectConfig:onInit()
	return
end

function JigsawcollectConfig:getNames()
	return {
		"jigsaw",
		"jigsaw_piece_plan",
		"jigsaw_daily_task_plan",
		"jigsaw_collect_prize_plan",
		"jigsaw_collect_plantype"
	}
end

function JigsawcollectConfig:handleConfig(name, content)
	if name == "jigsaw" then
		self._jigsawCfg = content
	elseif name == "jigsaw_piece_plan" then
		self._jigsaw_piece_planCfg = content
	elseif name == "jigsaw_daily_task_plan" then
		self._jigsaw_daily_task_planCfg = content
	elseif name == "jigsaw_collect_prize_plan" then
		self._jigsaw_collect_prize_planCfg = content
	elseif name == "jigsaw_collect_plantype" then
		self._jigsaw_collect_plantypeCfg = content
	end
end

function JigsawcollectConfig:getJigsawCfg(actId)
	return self._jigsawCfg[actId]
end

function JigsawcollectConfig:getPiecePlanCfgs(planId)
	return self._jigsaw_piece_planCfg[planId]
end

function JigsawcollectConfig:getTaskPlanCfgs(planId)
	return self._jigsaw_daily_task_planCfg[planId]
end

function JigsawcollectConfig:getCollectPrizePlanCfgs(planId)
	return self._jigsaw_collect_prize_planCfg[planId]
end

JigsawcollectConfig.instance = JigsawcollectConfig.New()

return JigsawcollectConfig
