-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mangtower/view/MangTower1v1MissionFmtView.lua

module("logic.extensions.mission.view.MangTower1v1MissionFmtView", package.seeall)

local MangTower1v1MissionFmtView = class("MangTower1v1MissionFmtView", MissionFmtView)

function MangTower1v1MissionFmtView:_getCreepCos()
	local params = self._viewPresentor:getFirstParam()
	local cCfg

	if params then
		local creepsMasterId = params.creepsMasterIds

		cCfg = MangTowerConfig.instance:getCreepCfg(checknumber(creepsMasterId[1]))
	end

	return cCfg
end

function MangTower1v1MissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()
end

return MangTower1v1MissionFmtView
