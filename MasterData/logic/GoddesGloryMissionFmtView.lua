-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessglory/view/GoddesGloryMissionFmtView.lua

module(..., package.seeall)

local GoddesGloryMissionFmtView = class("GoddesGloryMissionFmtView", MissionFmtView)

function GoddesGloryMissionFmtView:_getCreepCos()
	local eventInfo = self._viewPresentor._openParam[1]

	return GoddessGloryFmtModel.instance:getFightingCreeps(eventInfo.eventId)
end

function GoddesGloryMissionFmtView:_getMonsterCo()
	local eventInfo = self._viewPresentor._openParam[1]
	local eventCo = GoddessGloryConfig.instance:getEventCo(eventInfo.eventId)

	return GoddessGloryConfig.instance:getMonsterCo(eventCo.creepsMasterId)
end

function GoddesGloryMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()
end

return GoddesGloryMissionFmtView
