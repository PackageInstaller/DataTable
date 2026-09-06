-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/moonking/view/formation/MoonKingMissionFmtView.lua

module("logic.extensions.moonking.view.formation.MoonKingMissionFmtView", package.seeall)

local MoonKingMissionFmtView = class("MoonKingMissionFmtView", MissionFmtView)

function MoonKingMissionFmtView:_getMonsterCo()
	local params = self._viewPresentor:getFirstParam()

	if params then
		return MoonKingConfig.instance:getMasterTeamCfg(params.masterId)
	end

	return nil
end

function MoonKingMissionFmtView:_getCreepCos()
	local params = self._viewPresentor:getFirstParam()

	if params then
		return MoonKingConfig.instance:getMasterCreepsCfg(params.masterId)
	end

	return nil
end

function MoonKingMissionFmtView:_setRightSpeedAndPower(speed, power)
	MoonKingMissionFmtView.super._setRightSpeedAndPower(self, speed, power)

	self._speed.text = "？？？"
	self._powerTxt.text = "？？？"
end

function MoonKingMissionFmtView:_onClickPower()
	FloatWordMgr.instance:show("全员战斗力：？？？")
end

function MoonKingMissionFmtView:_onClickSpeed()
	FloatWordMgr.instance:show("全员速度：？？？")
end

function MoonKingMissionFmtView:_selectItem(index)
	if self._infoSeats[index] then
		local param = clone(self._infoSeats[index])

		param.hideZdl = true

		CommonTipsMgr.instance:showPetTips(param)
	end
end

function MoonKingMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()
end

return MoonKingMissionFmtView
