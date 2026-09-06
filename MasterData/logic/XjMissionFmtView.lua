-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xingjiang/view/XjMissionFmtView.lua

module("logic.extensions.xingjiang.view.XjMissionFmtView", package.seeall)

local XjMissionFmtView = class("XjMissionFmtView", MissionFmtView)

function XjMissionFmtView:_getCreepCos()
	local params = self:getOpenParam()
	local creepsMasterId = checknumber(params[4])

	return (XingJiangConfig.instance:getCreepCfgs(creepsMasterId))
end

function XjMissionFmtView:_getMonsterCo()
	local params = self:getOpenParam()
	local creepsMasterId = checknumber(params[4])

	return (XingJiangConfig.instance:getTeamCfg(creepsMasterId))
end

function XjMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()
end

return XjMissionFmtView
