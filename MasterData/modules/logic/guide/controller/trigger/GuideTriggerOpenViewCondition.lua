-- chunkname: @modules/logic/guide/controller/trigger/GuideTriggerOpenViewCondition.lua

module("modules.logic.guide.controller.trigger.GuideTriggerOpenViewCondition", package.seeall)

local GuideTriggerOpenViewCondition = class("GuideTriggerOpenViewCondition", BaseGuideTrigger)

function GuideTriggerOpenViewCondition:ctor(triggerKey)
	GuideTriggerOpenViewCondition.super.ctor(self, triggerKey)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._onOpenView, self)
end

function GuideTriggerOpenViewCondition:assertGuideSatisfy(param, configParam)
	local paramList = string.split(configParam, "_")
	local viewName = paramList[1]
	local conditionFunc = paramList[2]
	local conditionParam = paramList[3]

	if param ~= viewName then
		return false
	end

	return GuideTriggerOpenViewCondition[conditionFunc](conditionParam)
end

function GuideTriggerOpenViewCondition:_onOpenView(viewName, viewParam)
	self:checkStartGuide(viewName)
end

function GuideTriggerOpenViewCondition.checkInEliminateEpisode(id)
	return EliminateTeamSelectionModel.instance:getSelectedEpisodeId() == tonumber(id)
end

function GuideTriggerOpenViewCondition.checkInWindows(id)
	return BootNativeUtil.isWindows() or BootNativeUtil.isMuMu()
end

function GuideTriggerOpenViewCondition.checkTowerMopUpOpen()
	local permanentPassLayerNum = TowerPermanentModel.instance:getCurPermanentPassLayer()
	local openLayerNum = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.MopUpOpenLayerNum)

	return permanentPassLayerNum >= tonumber(openLayerNum)
end

function GuideTriggerOpenViewCondition.checkTowerBossOpen()
	local permanentPassLayerNum = TowerPermanentModel.instance:getCurPermanentPassLayer()
	local openLayerNum = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BossTowerOpen)

	return permanentPassLayerNum >= tonumber(openLayerNum)
end

function GuideTriggerOpenViewCondition.checkTowerLimitOpen()
	local permanentPassLayerNum = TowerPermanentModel.instance:getCurPermanentPassLayer()
	local openLayerNum = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.TimeLimitOpenLayerNum)
	local result = permanentPassLayerNum >= tonumber(openLayerNum)

	if result then
		local mo = TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower()

		result = mo ~= nil
	end

	local curTimeLimitTowerOpenMo = TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower()
	local isBossGuideFinish = GuideModel.instance:isGuideFinish(TowerEnum.BossGuideId)

	return result and isBossGuideFinish and curTimeLimitTowerOpenMo
end

function GuideTriggerOpenViewCondition.checkTowerPermanentElite()
	return TowerPermanentModel.instance:checkNewLayerIsElite()
end

function GuideTriggerOpenViewCondition.checkMercenaryUnlock()
	local mercenaryUnlockCo = OdysseyConfig.instance:getConstConfig(OdysseyEnum.ConstId.MercenaryUnlock)

	return (OdysseyDungeonModel.instance:checkConditionCanUnlock(mercenaryUnlockCo.value))
end

function GuideTriggerOpenViewCondition.checkTowerComposeMaxPlane()
	local curThemeId, curLayerId = TowerComposeModel.instance:getCurThemeIdAndLayer()
	local towerEpisodeConfig = TowerComposeConfig.instance:getEpisodeConfig(curThemeId, curLayerId)

	return towerEpisodeConfig and towerEpisodeConfig.plane == 2
end

function GuideTriggerOpenViewCondition.checkTowerComposePlaneUnlockResearch()
	local recordFightParam = TowerComposeModel.instance:getRecordFightParam()
	local themeId = recordFightParam.themeId
	local layerId = recordFightParam.layerId
	local towerEpisodeConfig = TowerComposeConfig.instance:getEpisodeConfig(themeId, layerId)
	local isPlaneLayerUnlock = TowerComposeModel.instance:checkHasPlaneLayerUnlock(themeId)

	return towerEpisodeConfig.plane > 0 and isPlaneLayerUnlock
end

function GuideTriggerOpenViewCondition.checkTowerMaxPlaneUnlock()
	local curThemeId, curLayerId = TowerComposeModel.instance:getCurThemeIdAndLayer()
	local passLayerId = TowerComposeModel.instance:getThemePassLayer(curThemeId)

	return (TowerComposeModel.instance:isMaxPlaneLayerUnlock(curThemeId, passLayerId))
end

function GuideTriggerOpenViewCondition.checkTowerFirstPlaneUnlock()
	local curThemeId, curLayerId = TowerComposeModel.instance:getCurThemeIdAndLayer()
	local passLayerId = TowerComposeModel.instance:getThemePassLayer(curThemeId)
	local curUnlockPlaneLayerId, planeLayerIdList = TowerComposeModel.instance:getCurUnlockPlaneLayerId(curThemeId, passLayerId)

	return curUnlockPlaneLayerId > 0 and curUnlockPlaneLayerId == planeLayerIdList[1]
end

return GuideTriggerOpenViewCondition
