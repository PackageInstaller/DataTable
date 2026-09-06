-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/waterdraktower/view/mission/WaterDarkTowerMissionFmtView.lua

module("logic.extensions.waterdraktower.view.mission.WaterDarkTowerMissionFmtView", package.seeall)

local WaterDarkTowerMissionFmtView = class("WaterDarkTowerMissionFmtView", MissionFmtView)

function WaterDarkTowerMissionFmtView:onEnter()
	self._isHideZdl = true

	WaterDarkTowerMissionFmtView.super.onEnter(self)
end

function WaterDarkTowerMissionFmtView:_getCreepCos()
	local monsterCfg = self:_getMonsterCo()

	return WaterdraktowerConfig.instance:getCreepsCfg(monsterCfg.creepsMasterId)
end

function WaterDarkTowerMissionFmtView:_getMonsterCo()
	return self:getOpenParam()[2]
end

function WaterDarkTowerMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()

	if self._isHideZdl then
		self._powerTxt.text = "？？？"
		self._speed.text = "？？？"
	end
end

function WaterDarkTowerMissionFmtView:_onClickPower()
	if self._isHideZdl then
		FloatWordMgr.instance:show("全员战斗力:？？？")
	else
		WaterDarkTowerMissionFmtView.super._onClickPower(self)
	end
end

function WaterDarkTowerMissionFmtView:_onClickSpeed()
	if self._isHideZdl then
		FloatWordMgr.instance:show("全员速度:？？？")
	else
		WaterDarkTowerMissionFmtView.super._onClickSpeed(self)
	end
end

function WaterDarkTowerMissionFmtView:_selectItem(index, isUp)
	if self._isHideZdl then
		if self._infoSeats[index] then
			local param = clone(self._infoSeats[index])

			param.hideZdl = true

			CommonTipsMgr.instance:showPetTips(param)
		end
	else
		WaterDarkTowerMissionFmtView.super._selectItem(self, index, isUp)
	end
end

return WaterDarkTowerMissionFmtView
