-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/mississi/mission/MississiMissionFmtView.lua

module("logic.extensions.timelimitedchallenge.view.mississi.mission.MississiMissionFmtView", package.seeall)

local MississiMissionFmtView = class("MississiMissionFmtView", MissionFmtView)

function MississiMissionFmtView:_getCreepCos()
	local creepsMasterId = self:_getMonsterCo().creepsMasterId

	return (MississiConfig.instance:getCreepsCfg(checknumber(creepsMasterId)))
end

function MississiMissionFmtView:_getMonsterCo()
	local param = self._viewPresentor:getFirstParam()

	if param then
		local creepCfg = MississiConfig.instance:getCreepsMasterCfg(param.creepsMasterId)

		return creepCfg or {}
	end

	return {}
end

function MississiMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()
end

return MississiMissionFmtView
