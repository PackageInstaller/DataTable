-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summontower/view/SummontowerMissionFmtView.lua

module("logic.extensions.formation.view.SummontowerMissionFmtView", package.seeall)

local SummontowerMissionFmtView = class("SummontowerMissionFmtView", MissionFmtView)

function SummontowerMissionFmtView:_getCreepCos()
	local gridData = self._viewPresentor._openParam[1]

	return SummontowerFmtModel.instance:getFightingCreeps(gridData)
end

function SummontowerMissionFmtView:_getMonsterCo()
	return nil
end

function SummontowerMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()
end

return SummontowerMissionFmtView
