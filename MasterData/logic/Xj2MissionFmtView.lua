-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xingjiang/view/Xj2MissionFmtView.lua

module("logic.extensions.xingjiang.view.Xj2MissionFmtView", package.seeall)

local Xj2MissionFmtView = class("Xj2MissionFmtView", MissionFmtView)

function Xj2MissionFmtView:_getCreepCos()
	local params = self:getOpenParam()
	local creepsMasterId = checknumber(params[2])

	return (XingJiangConfig.instance:getCreep2Cfgs(creepsMasterId))
end

function Xj2MissionFmtView:_getMonsterCo()
	local params = self:getOpenParam()
	local creepsMasterId = checknumber(params[2])

	return (XingJiangConfig.instance:getTeam2Cfg(creepsMasterId))
end

function Xj2MissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()
end

return Xj2MissionFmtView
