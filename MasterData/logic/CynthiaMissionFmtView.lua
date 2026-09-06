-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/cynthia/mission/CynthiaMissionFmtView.lua

module("logic.extensions.timelimitedchallenge.view.cynthia.mission.CynthiaMissionFmtView", package.seeall)

local CynthiaMissionFmtView = class("CynthiaMissionFmtView", MissionFmtView)

function CynthiaMissionFmtView:_getCreepCos()
	local creepsMasterId = self:_getMonsterCo().creepsMasterId

	return (CynthiaConfig.instance:getCreepsCfg(checknumber(creepsMasterId)))
end

function CynthiaMissionFmtView:_getMonsterCo()
	local params = self._viewPresentor:getFirstParam()

	if params then
		return params
	end

	return {}
end

function CynthiaMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()
end

return CynthiaMissionFmtView
