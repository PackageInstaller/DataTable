-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tongbattle/view/formation/TongMissionFmtView.lua

module("logic.extensions.tongbattle.view.formation.TongMissionFmtView", package.seeall)

local TongMissionFmtView = class("TongMissionFmtView", MissionFmtView)

function TongMissionFmtView:_getMonsterCo()
	local params = self._viewPresentor:getFirstParam()

	if params then
		return TongBattleConfig.instance:getMasterTeamCfg(params.planId, params.chalType, params.stageId)
	end

	return nil
end

function TongMissionFmtView:_getCreepCos()
	local params = self._viewPresentor:getFirstParam()

	if params then
		local teamCfg = TongBattleConfig.instance:getMasterTeamCfg(params.planId, params.chalType, params.stageId)

		if teamCfg then
			return TongBattleConfig.instance:getMasterCreepsCfg(teamCfg.creepsMasterId)
		end
	end

	return nil
end

function TongMissionFmtView:_isTongDemonMission()
	local params = self._viewPresentor:getFirstParam()

	if params == nil then
		return false
	end

	if params.chalType ~= 3 and params.chalType ~= 4 then
		return false
	end

	return true
end

function TongMissionFmtView:_setRightSpeedAndPower(speed, power)
	TongMissionFmtView.super._setRightSpeedAndPower(self, speed, power)

	if not self:_isTongDemonMission() then
		return
	end

	self._speed.text = "？？？"
	self._powerTxt.text = "？？？"
end

function TongMissionFmtView:_onClickPower()
	if not self:_isTongDemonMission() then
		TongMissionFmtView.super._onClickPower(self)

		return
	end

	FloatWordMgr.instance:show("全员战斗力：？？？")
end

function TongMissionFmtView:_onClickSpeed()
	if not self:_isTongDemonMission() then
		TongMissionFmtView.super._onClickSpeed(self)

		return
	end

	FloatWordMgr.instance:show("全员速度：？？？")
end

function TongMissionFmtView:_selectItem(index)
	if not self:_isTongDemonMission() then
		TongMissionFmtView.super._selectItem(self, index)

		return
	end

	if self._infoSeats[index] then
		local param = clone(self._infoSeats[index])

		param.hideZdl = true

		CommonTipsMgr.instance:showPetTips(param)
	end
end

function TongMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()
end

return TongMissionFmtView
