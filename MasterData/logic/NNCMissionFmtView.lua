-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/niannianchall/view/NNCMissionFmtView.lua

module("logic.extensions.niannianchall.view.lightking.NNCMissionFmtView", package.seeall)

local NNCMissionFmtView = class("NNCMissionFmtView", MissionFmtView)

function NNCMissionFmtView:_getCreepCos()
	local stageId = NianNianChallModel.instance:getStageId()
	local stageCfg = NianNianChallConfig.instance:getStageCfg(stageId + 1)

	return (NianNianChallConfig.instance:getCreepsCfg(stageCfg.creepsMasterId))
end

function NNCMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()
end

return NNCMissionFmtView
