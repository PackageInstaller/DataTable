-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sunranbattle/view/formation/SRMissionFmtView.lua

module("logic.extensions.sunranbattle.view.formation.SRMissionFmtView", package.seeall)

local SRMissionFmtView = class("SRMissionFmtView", MissionFmtView)

function SRMissionFmtView:_getMonsterCo()
	local params = self._viewPresentor:getFirstParam()

	if params then
		return SunranBattleConfig.instance:getMasterTeamCfg(params.masterId)
	end

	return nil
end

function SRMissionFmtView:_getCreepCos()
	local params = self._viewPresentor:getFirstParam()

	if params then
		return SunranBattleConfig.instance:getMasterCreepsCfg(params.masterId)
	end

	return nil
end

function SRMissionFmtView:_setRightSpeedAndPower(speed, power)
	SRMissionFmtView.super._setRightSpeedAndPower(self, speed, power)

	self._speed.text = "？？？"
	self._powerTxt.text = "？？？"
end

function SRMissionFmtView:_onClickPower()
	FloatWordMgr.instance:show("全员战斗力：？？？")
end

function SRMissionFmtView:_onClickSpeed()
	FloatWordMgr.instance:show("全员速度：？？？")
end

function SRMissionFmtView:_selectItem(index)
	if self._infoSeats[index] then
		local param = clone(self._infoSeats[index])

		param.hideZdl = true

		CommonTipsMgr.instance:showPetTips(param)
	end
end

function SRMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()
end

return SRMissionFmtView
