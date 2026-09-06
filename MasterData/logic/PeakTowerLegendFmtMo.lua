-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktower/model/PeakTowerLegendFmtMo.lua

module("logic.extensions.peaktower.model.PeakTowerLegendFmtMo", package.seeall)

local PeakTowerLegendFmtMo = class("PeakTowerLegendFmtMo", BaseCustomFmtMo)

function PeakTowerLegendFmtMo:initParams(activityId, weekId, floorId, stageId)
	self.activityId = activityId
	self.floorId = floorId
	self.stageId = stageId
	self._stageCfg = PeakTowerConfig.instance:getLegendStageCfg(self.activityId, weekId, self.floorId, self.stageId)
	self._cfgEnemy = PeakTowerConfig.instance:getTeamCfg(self._stageCfg.creepsMasterId)
	self._masterList = PeakTowerConfig.instance:getCreepsCfg(self._stageCfg.creepsMasterId)
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.ruleDesc

	self:setFormCondition(self._cfgEnemy.formCondition)
end

function PeakTowerLegendFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		PeakTowerController.instance:sendPM_PeakTowerLegendClgReq(self.activityId, simpleForm, self.floorId, self.stageId)
	end

	self:setFightHandler(handler, nil)
end

function PeakTowerLegendFmtMo:getMonsterConfigList()
	return self._masterList
end

function PeakTowerLegendFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

function PeakTowerLegendFmtMo:checkPetIsForbit(petMo, baseCheck)
	if PeakTowerModel.instance:isBanPetInLegendFloor(self.activityId, self.floorId, petMo.raceId) == true then
		return true
	end

	return false
end

function PeakTowerLegendFmtMo:showForbitPetAlert(petMo)
	if PeakTowerModel.instance:isBanPetInLegendFloor(self.activityId, self.floorId, petMo.raceId) == true then
		FloatWordMgr.instance:show(lang("该精灵已被封印"))
	end
end

return PeakTowerLegendFmtMo
