-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/warriortower/view/WTMissionFmtView.lua

module("logic.extensions.mission.view.WTMissionFmtView", package.seeall)

local WTMissionFmtView = class("WTMissionFmtView", MissionFmtView)

function WTMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()
end

function WTMissionFmtView:_getCreepCos()
	local curLv = checknumber(self._viewPresentor._openParam[1])
	local towerId = WTowerModel.instance:getTowerId()
	local levelCfg = WTowerConfig.instance:getCfgById(curLv, towerId)

	return (WTowerConfig.instance:getCrpCfg(levelCfg.creepsMasterId))
end

function WTMissionFmtView:_getMonsterCo()
	local curLv = checknumber(self._viewPresentor._openParam[1])
	local towerId = WTowerModel.instance:getTowerId()
	local levelCfg = WTowerConfig.instance:getCfgById(curLv, towerId)

	return levelCfg or {}
end

return WTMissionFmtView
