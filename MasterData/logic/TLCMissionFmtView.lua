-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/mission/TLCMissionFmtView.lua

module("logic.extensions.timelimitedchallenge.view.TLCMissionFmtView", package.seeall)

local TLCMissionFmtView = class("TLCMissionFmtView", MissionFmtView)

function TLCMissionFmtView:_getCreepCos()
	return self._info.creepCfg or {}
end

function TLCMissionFmtView:_getMonsterCo()
	return self._info.monsterCfg or {}
end

function TLCMissionFmtView:onEnter()
	self._info = TLChallengeController.instance:getMissionParams()

	TLCMissionFmtView.super.onEnter(self)
end

function TLCMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()

	self._powerTxt.text = "？？？"
	self._speed.text = "？？？"
end

function TLCMissionFmtView:_onClickPower()
	FloatWordMgr.instance:show("全员战斗力:？？？")
end

function TLCMissionFmtView:_onClickSpeed()
	FloatWordMgr.instance:show("全员速度:？？？")
end

function TLCMissionFmtView:_selectItem(index, isUp)
	if self._infoSeats[index] then
		local param = clone(self._infoSeats[index])

		param.hideZdl = true

		CommonTipsMgr.instance:showPetTips(param)
	end
end

return TLCMissionFmtView
