-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teachingdungeon/view/TeachingMissionFmtView.lua

module("logic.extensions.teachingdungeon.view.TeachingMissionFmtView", package.seeall)

local TeachingMissionFmtView = class("TeachingMissionFmtView", MissionFmtView)

function TeachingMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()
end

function TeachingMissionFmtView:_getCreepCos()
	return (TeachingDungeonConfig.instance:getCreepCfg())
end

function TeachingMissionFmtView:_getMonsterCo()
	return (TeachingDungeonConfig.instance:getMonsterCfg())
end

return TeachingMissionFmtView
