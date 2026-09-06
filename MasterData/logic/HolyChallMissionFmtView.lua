-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingway/view/holychallmission/HolyChallMissionFmtView.lua

module("logic.extensions.kingway.view.holychallmission.HolyChallMissionFmtView", package.seeall)

local HolyChallMissionFmtView = class("HolyChallMissionFmtView", MissionFmtView)

function HolyChallMissionFmtView:onEnter()
	self._data = self:getOpenParam()[1]

	HerotrialMissionFmtView.super.onEnter(self)
end

function HolyChallMissionFmtView:_getCreepCos()
	if self._data then
		local stageCfg = HolyChallConfig.instance:GetChallStageCfg(self._data.challengeId, self._data.stageId)
		local creepsMasterId = stageCfg.creepsMasterId

		return HolyChallConfig.instance:getCreepsById(creepsMasterId)
	end
end

function HolyChallMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()
end

return HolyChallMissionFmtView
