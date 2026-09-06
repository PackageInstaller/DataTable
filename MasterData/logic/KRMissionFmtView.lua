-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingroad/view/KRMissionFmtView.lua

module("logic.extensions.kingroad.view.KRMissionFmtView", package.seeall)

local KRMissionFmtView = class("KRMissionFmtView", MissionFmtView)

function KRMissionFmtView:_refreshFromation()
	local challengeLevel = checknumber(self._viewPresentor._openParam[1])
	local subKey = self._viewPresentor._openParam[1]
	local index = subKey + 1
	local teamId = KingRoadModel.instance:getTeamId(index)

	printInfo("当前teamId = ", teamId)
	self:_setFmtInfo(teamId)
end

return KRMissionFmtView
