-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yirenpozhen/view/fmtview/HexagramMissionFmtView.lua

module("logic.extensions.yirenpozhen.view.fmtview.HexagramMissionFmtView", package.seeall)

local HexagramMissionFmtView = class("HexagramMissionFmtView", MissionFmtView)

function HexagramMissionFmtView:_getCreepCos()
	local params = self._viewPresentor:getFirstParam()
	local cCfg

	if params then
		local creepsMasterId = params.creepsMasterId

		cCfg = YirenPozhenConfig.instance:getMonsterCfg(checknumber(creepsMasterId))
	end

	return cCfg
end

function HexagramMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()
end

return HexagramMissionFmtView
