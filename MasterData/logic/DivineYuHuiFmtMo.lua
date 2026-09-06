-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineyuhui/model/DivineYuHuiFmtMo.lua

module("logic.extensions.divineyuhui.model.DivineYuHuiFmtMo", package.seeall)

local DivineYuHuiFmtMo = class("DivineYuHuiFmtMo", BaseCustomFmtMo)

function DivineYuHuiFmtMo:updateCfg(activityId, stageId)
	self._proxyPool = {}
	self._activityId = checknumber(activityId)
	self._stageId = checknumber(stageId)
	self._creepsMasterId = DivineYuHuiConfig.instance:getCreepMasterId(activityId, stageId)
	self._masterData = DivineYuHuiConfig.instance:getMasterCfg(self._creepsMasterId)
	self._creepsCfg = DivineYuHuiConfig.instance:getCreepCfg(self._creepsMasterId)
	self._stageCfg = DivineYuHuiConfig.instance:getStageCfgByStageId(activityId, stageId)
	self.topTitleStr = self._masterData.name
	self.ruleDescStr = self._masterData.ruleDesc

	self:setFormCondition(self._masterData.formCondition)
end

function DivineYuHuiFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		DivineYuHuiController.instance:sendPM_DivineYuHuiClgChallengeReq(self._activityId, self._stageId, simpleForm)
	end, nil)
end

function DivineYuHuiFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function DivineYuHuiFmtMo:getFmtInfoConfig()
	return self._masterData
end

function DivineYuHuiFmtMo:getExtendViewName()
	return ViewName.DivineYuHuifmtView
end

function DivineYuHuiFmtMo:endDragBagPet()
	GlobalDispatcher:dispatch(GlobalNotify.DivineYuHuiPetBagEndGrag)
end

function DivineYuHuiFmtMo:getActivityId()
	return self._activityId
end

function DivineYuHuiFmtMo:getStageId()
	return self._stageId
end

function DivineYuHuiFmtMo:updateCellTop(cell, petMo)
	local luaCls = DivineYuHuiBuff
	local url = DivineYuHuiBuff.prefabUrl
	local proxy = MaterialMgr.getProxyWithOutPool(url, luaCls, cell)

	if proxy then
		self._proxyPool[cell] = proxy

		local buffList = DivineYuHuiModel.instance:getStageIdListByRaceId(self._activityId, petMo.raceId)

		if buffList and #buffList > 0 then
			proxy.binder:setBuff(buffList)
		else
			proxy.binder:clearBuff()
		end
	end
end

function DivineYuHuiFmtMo:clearCellTop(cell)
	DivineYuHuiFmtMo.super.clearCellTop(self, cell)

	local proxy = self._proxyPool[cell]

	if proxy then
		proxy.binder:clearBuff()
		goutil.destroy(proxy.binder:getBuffGo())

		self._proxyPool[cell] = nil
	end
end

return DivineYuHuiFmtMo
