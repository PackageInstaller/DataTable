-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/tianmanking/TianmanKingMissionFmtView.lua

module("logic.extensions.timelimitedchallenge.view.tianmanking.TianmanKingMissionFmtView", package.seeall)

local TianmanKingMissionFmtView = class("TianmanKingMissionFmtView", MissionFmtView)

function TianmanKingMissionFmtView:onEnter()
	local _openParam = self:getOpenParam()

	self._challengeType, self._challengeId = _openParam[1], _openParam[2]

	TianmanKingMissionFmtView.super.onEnter(self)
end

function TianmanKingMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()

	self._speed.text = "？？？"
	self._powerTxt.text = "？？？"
end

function TianmanKingMissionFmtView:_getCreepCos()
	local _teamInfo = TianmanKingConfig.instance:getCreepByMasterId(self:_getMonsterCo().creepsMasterId)

	return _teamInfo or {}
end

function TianmanKingMissionFmtView:_getMonsterCo()
	local stageCfg = TianmanKingConfig.instance:getStageByTypeAndStage(self._challengeType, self._challengeId)

	return stageCfg or {}
end

function TianmanKingMissionFmtView:_selectItem(index)
	if self._infoSeats[index] then
		local param = clone(self._infoSeats[index])

		param.hideZdl = true

		CommonTipsMgr.instance:showPetTips(param)
	end
end

return TianmanKingMissionFmtView
