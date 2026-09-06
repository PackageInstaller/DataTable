-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinegasiri/model/DivineGasiriFmtMo.lua

module("logic.extensions.divinegasiri.model.DivineGasiriFmtMo", package.seeall)

local DivineGasiriFmtMo = class("DivineKingOrderClgFmtMo", BaseCustomFmtMo)

function DivineGasiriFmtMo:initParams(actId, curStageId)
	self.activityId = actId

	local stageId = curStageId
	local cfg = DivineGasiriConfig.instance:getStageCfg(self.activityId, stageId)

	self.creepsMasterId = cfg.creepsMasterId
	self.masterCfg = DivineGasiriConfig.instance:getCreepMasterCfg(self.creepsMasterId)
	self.creeps = DivineGasiriConfig.instance:getCreepCfgs(self.creepsMasterId)
	self.isShowTab = false
	self.topTitleStr = self.masterCfg.name
end

function DivineGasiriFmtMo:getMonsterConfigList()
	return self.creeps
end

function DivineGasiriFmtMo:getFmtInfoConfig()
	return self.masterCfg
end

function DivineGasiriFmtMo:initFightHandler()
	self:setFightHandler(function()
		DivineGasiriController.instance:sendPM_DivineAresMomChallengeReq(self.activityId, self:getCurSimpleForm())
	end, nil)
end

return DivineGasiriFmtMo
