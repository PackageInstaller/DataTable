-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitefuture/view/InfinfuMissionFmtView.lua

module("logic.extensions.infinitefuture.view.InfinfuMissionFmtView", package.seeall)

local InfinfuMissionFmtView = class("InfinfuMissionFmtView", MissionFmtView)

function InfinfuMissionFmtView:_getCreepCos()
	local params = self:getOpenParam()
	local creepsMasterId = checknumber(params[4])

	return (InfinitefutureConfig.instance:getCreepCfgs(creepsMasterId))
end

function InfinfuMissionFmtView:_getMonsterCo()
	local params = self:getOpenParam()
	local creepsMasterId = checknumber(params[4])

	return (InfinitefutureConfig.instance:getTeamCfg(creepsMasterId))
end

function InfinfuMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()
end

return InfinfuMissionFmtView
