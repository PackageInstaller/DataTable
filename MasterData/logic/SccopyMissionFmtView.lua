-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scenariocopy/view/SccopyMissionFmtView.lua

module("logic.extensions.scenariocopy.view.SccopyMissionFmtView", package.seeall)

local SccopyMissionFmtView = class("SccopyMissionFmtView", MissionFmtView)

function SccopyMissionFmtView:onEnter()
	SccopyMissionFmtView.super.onEnter(self)
end

function SccopyMissionFmtView:onExit()
	SccopyMissionFmtView.super.onExit(self)
end

function SccopyMissionFmtView:_getCreepCos()
	local stageCfg = ScenariocopyModel.instance:getStageCfg()

	return (ScenariocopyConfig.instance:getCreepsById(stageCfg.creepsMasterId))
end

function SccopyMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()
end

function SccopyMissionFmtView:_setRightSpeedAndPower(speed, power)
	SccopyMissionFmtView.super._setRightSpeedAndPower(self, speed, power)

	if ScenariocopyModel.instance:getIsTrial() then
		self._speed.text = "？？？"
		self._powerTxt.text = "？？？"
	end
end

function SccopyMissionFmtView:_selectItem(index)
	if ScenariocopyModel.instance:getIsTrial() then
		if self._infoSeats[index] then
			local param = clone(self._infoSeats[index])

			param.hideZdl = true

			CommonTipsMgr.instance:showPetTips(param)
		end
	else
		SccopyMissionFmtView.super._selectItem(self, index)
	end
end

return SccopyMissionFmtView
