-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/twindragonchallenge/view/TwinDragonChallengeMissionFmtView.lua

module("logic.extensions.twindragonchallenge.view.TwinDragonChallengeMissionFmtView", package.seeall)

local TwinDragonChallengeMissionFmtView = class("TwinDragonChallengeMissionFmtView", MissionFmtView)

function TwinDragonChallengeMissionFmtView:onEnter()
	self._stageCfg = self:getFirstParam()

	TwinDragonChallengeMissionFmtView.super.onEnter(self)
end

function TwinDragonChallengeMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()
end

function TwinDragonChallengeMissionFmtView:_getCreepCos()
	local _teamInfo = IntegrationChallengeConfig.instance:getCreepsById(self._stageCfg.creepsMasterId)

	return _teamInfo or {}
end

return TwinDragonChallengeMissionFmtView
