-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mirrortrial/view/MirrortrialMissionFmtView.lua

module("logic.extensions.plotcopy.view.MirrortrialMissionFmtView", package.seeall)

local MirrortrialMissionFmtView = class("MirrortrialMissionFmtView", MissionFmtView)

function MirrortrialMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()
end

function MirrortrialMissionFmtView:_getCreepCos()
	local params = self:getOpenParam()

	if not params or not params[1] then
		return {}
	end

	local cfgStage = params[1]

	return (MirrorTrialConfig.instance:getCreepCfgsById(cfgStage.teamIds))
end

return MirrortrialMissionFmtView
