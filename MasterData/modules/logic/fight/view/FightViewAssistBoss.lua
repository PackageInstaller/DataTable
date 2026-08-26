-- chunkname: @modules/logic/fight/view/FightViewAssistBoss.lua

module("modules.logic.fight.view.FightViewAssistBoss", package.seeall)

local FightViewAssistBoss = class("FightViewAssistBoss", BaseView)

function FightViewAssistBoss:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightViewAssistBoss:addEvents()
	return
end

function FightViewAssistBoss:removeEvents()
	return
end

function FightViewAssistBoss:_editableInitView()
	self.assistBossId2Behaviour = {
		FightAssistBoss1,
		FightAssistBoss2,
		FightAssistBoss3,
		FightAssistBoss4,
		FightAssistBoss5,
		FightAssistBoss6
	}
end

function FightViewAssistBoss:onUpdateParam()
	self:onOpen()
end

function FightViewAssistBoss:onOpen()
	self:showPaTaUI()
	self:show3_3PaTaUI()
end

function FightViewAssistBoss:showPaTaUI()
	if not FightDataHelper.fieldMgr:isPaTa() then
		return
	end

	self:createAssistBossBehaviour()
	self:createAssistBossScore()
end

function FightViewAssistBoss:show3_3PaTaUI()
	if not FightDataHelper.fieldMgr:is3_3PaTa() then
		return
	end

	self:createAssistRoleComp()
	self:createPaTaComposeScoreComp()
	self:createPlaneComp()
end

function FightViewAssistBoss:createAssistRoleComp()
	local assistBoss = FightDataHelper.entityMgr:getAssistBoss()

	if not assistBoss then
		return
	end

	if not FightDataHelper.paTaMgr:checkIsAssistRole() then
		return
	end

	self.assistRoleComp = FightAssistRoleView.New()

	local enum = FightRightElementEnum.Elements.AssistRole
	local goAssistRole = self.viewContainer.rightElementLayoutView:getElementContainer(enum)

	self.assistRoleComp:init(goAssistRole)
	FightController.instance:dispatchEvent(FightEvent.RightElements_ShowElement, enum)
end

function FightViewAssistBoss:createPaTaComposeScoreComp()
	if not self:checkInTowerComposeBoss() then
		return
	end

	local enum = FightRightElementEnum.Elements.PaTaComposeScore
	local goPaTaComposeScore = self.viewContainer.rightElementLayoutView:getElementContainer(enum)

	self.paTaComposeScoreComp = FightPaTaComposeScoreComp.New()

	self.paTaComposeScoreComp:init(goPaTaComposeScore)
	FightController.instance:dispatchEvent(FightEvent.RightElements_ShowElement, enum)
end

function FightViewAssistBoss:checkInTowerComposeBoss()
	local customData = FightDataHelper.getCustomData(FightCustomData.CustomDataType.TowerCompose)
	local planeId = customData and customData.planeId

	if not planeId then
		return false
	end

	if planeId < 1 then
		return false
	end

	return true
end

function FightViewAssistBoss:createPlaneComp()
	local customData = FightDataHelper.getCustomData(FightCustomData.CustomDataType.TowerCompose)
	local maxPlaneId = customData and customData.maxPlaneId

	if not maxPlaneId then
		return
	end

	if maxPlaneId < 2 then
		return
	end

	local goContainer = gohelper.findChild(self.viewGO, "root/topLeftContent")

	self.planeComp = FightPaTaComposePlaneComp.New()

	self.planeComp:init(goContainer)
end

function FightViewAssistBoss:createAssistBossBehaviour()
	local assistBoss = FightDataHelper.entityMgr:getAssistBoss()

	if not assistBoss then
		return
	end

	if self.bossBehaviour then
		self.bossBehaviour:refreshUI()

		return
	end

	local bossId = assistBoss.modelId
	local behaviourCls = self.assistBossId2Behaviour[bossId]

	if not behaviourCls then
		logError(string.format("boss id : %s, 没有对应的处理逻辑", bossId))

		behaviourCls = FightAssistBoss0
	end

	self.bossBehaviour = behaviourCls.New()

	local enum = FightRightElementEnum.Elements.AssistBoss
	local goAssistBoss = self.viewContainer.rightElementLayoutView:getElementContainer(enum)

	self.bossBehaviour:init(goAssistBoss)
	FightController.instance:dispatchEvent(FightEvent.RightElements_ShowElement, enum)
end

function FightViewAssistBoss:createAssistBossScore()
	if not FightDataHelper.fieldMgr:isTowerLimited() then
		return
	end

	if self.scoreComp then
		self.scoreComp:refreshScore()

		return
	end

	self.scoreComp = FightAssistBossScoreView.New()

	local goAssistBoss = self.viewContainer.rightElementLayoutView:getElementContainer(FightRightElementEnum.Elements.AssistBossScore)

	self.scoreComp:init(goAssistBoss)
	self.viewContainer.rightElementLayoutView:showElement(FightRightElementEnum.Elements.AssistBossScore)
end

function FightViewAssistBoss:onDestroyView()
	if self.bossBehaviour then
		self.bossBehaviour:destroy()

		self.bossBehaviour = nil
	end

	if self.scoreComp then
		self.scoreComp:destroy()

		self.scoreComp = nil
	end

	if self.assistRoleComp then
		self.assistRoleComp:destroy()

		self.assistRoleComp = nil
	end

	if self.paTaComposeScoreComp then
		self.paTaComposeScoreComp:destroy()

		self.paTaComposeScoreComp = nil
	end

	if self.planeComp then
		self.planeComp:destroy()

		self.planeComp = nil
	end
end

return FightViewAssistBoss
