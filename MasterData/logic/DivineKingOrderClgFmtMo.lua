-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingorderclg/model/DivineKingOrderClgFmtMo.lua

module("logic.extensions.divinekingorderclg.model.DivineKingOrderClgFmtMo", package.seeall)

local DivineKingOrderClgFmtMo = class("DivineKingOrderClgFmtMo", BaseCustomFmtMo)

function DivineKingOrderClgFmtMo:initParams()
	self.activityId = DivineKingOrderClgModel.instance:getActivityId()

	local stageId = DivineKingOrderClgModel.instance:getCurStageId()
	local cfg = DivineKingOrderClgConfig.instance:getStageCfgById(self.activityId, stageId)

	self.creepsMasterId = cfg.creepsMasterId
	self.masterCfg = DivineKingOrderClgConfig.instance:getCreepMasterCfg(self.creepsMasterId)
	self.creeps = DivineKingOrderClgConfig.instance:getCreepCfgs(self.creepsMasterId)
	self.isShowTab = false
	self.topTitleStr = self.masterCfg.name
end

function DivineKingOrderClgFmtMo:getMonsterConfigList()
	return self.creeps
end

function DivineKingOrderClgFmtMo:getFmtInfoConfig()
	return self.masterCfg
end

function DivineKingOrderClgFmtMo:initFightHandler()
	self:setFightHandler(function()
		DivineKingOrderClgController.instance:checkAoqiGodFinish(self.activityId)
		BattleFacade.instance:startDivineKingOrderClg()
		DivineKingOrderClgController.instance:fight(self.activityId, self:getCurSimpleForm())
		UIJumper.instance:clear()
		UIJumper.instance:pushOneStack(ViewName.DivineKingOrderMainView)
		UIJumper.instance:pushOneStack(ViewName.DivineKingOrderStageView)
	end, nil)
end

function DivineKingOrderClgFmtMo:getExtendViewName()
	return ViewName.DivineKingOrderClgFormationExView
end

return DivineKingOrderClgFmtMo
