-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/waterdraktower/view/formation/WLTowerMissionFmtView.lua

module("logic.extensions.waterdraktower.view.formation.WLTowerMissionFmtView", package.seeall)

local WLTowerMissionFmtView = class("WLTowerMissionFmtView", MissionFmtView)

function WLTowerMissionFmtView:_getMonsterCo()
	local params = self:getFirstParam()

	if params then
		return WaterdraktowerConfig.instance:getTierChallengeCfgByStage(params.planId, params.towerType, params.tier, params.stage)
	end

	return nil
end

function WLTowerMissionFmtView:_getCreepCos()
	local params = self:getFirstParam()

	if params then
		local teamCfg = WaterdraktowerConfig.instance:getTierChallengeCfgByStage(params.planId, params.towerType, params.tier, params.stage)

		if teamCfg and checknumber(teamCfg.creepsMasterId) > 0 then
			return WaterdraktowerConfig.instance:getTierCreepsCfg(teamCfg.creepsMasterId)
		end
	end

	return nil
end

function WLTowerMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()

	self._powerTxt.text = "？？？"
	self._speed.text = "？？？"
end

function WLTowerMissionFmtView:_onClickPower()
	FloatWordMgr.instance:show("全员战斗力:？？？")
end

function WLTowerMissionFmtView:_onClickSpeed()
	FloatWordMgr.instance:show("全员速度:？？？")
end

function WLTowerMissionFmtView:_selectItem(index, isUp)
	if self._infoSeats[index] then
		local param = clone(self._infoSeats[index])

		param.hideZdl = true

		CommonTipsMgr.instance:showPetTips(param)
	end
end

return WLTowerMissionFmtView
