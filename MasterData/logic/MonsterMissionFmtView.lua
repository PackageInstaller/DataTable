-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/MonsterMissionFmtView.lua

module(..., package.seeall)

local MonsterMissionFmtView = class("MonsterMissionFmtView", MissionFmtView)

function MonsterMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()
end

function MonsterMissionFmtView:_getCreepCos()
	local monsterId = self._viewPresentor._openParam[1]
	local cCfg = SceneConfig.instance:getMonsterFormation(monsterId)

	return cCfg or {}
end

function MonsterMissionFmtView:_getMonsterCo()
	local monsterId = self._viewPresentor._openParam[1]

	return (SceneConfig.instance:getMonsterMaskterCo(monsterId))
end

return MonsterMissionFmtView
