-- chunkname: @modules/logic/fight/view/assistboss/FightAssistBoss3.lua

module("modules.logic.fight.view.assistboss.FightAssistBoss3", package.seeall)

local FightAssistBoss3 = class("FightAssistBoss3", FightAssistBossBase)

function FightAssistBoss3:setPrefabPath()
	self.prefabPath = "ui/viewres/assistboss/boss3.prefab"
end

function FightAssistBoss3:initView()
	FightAssistBoss3.super.initView(self)

	self.goStage1 = gohelper.findChild(self.viewGo, "head/stage1")
	self.goStage2 = gohelper.findChild(self.viewGo, "head/stage2")
	self.goStage3 = gohelper.findChild(self.viewGo, "head/stage3")
	self.stageList = self:getUserDataTb_()
	self.stageList[1] = self.goStage1
	self.stageList[2] = self.goStage2
	self.stageList[3] = self.goStage3
	self.goEnergy3 = gohelper.findChild(self.viewGo, "energy_3")
	self.goEnergy4 = gohelper.findChild(self.viewGo, "energy_4")
	self.imageEnergy3 = gohelper.findChildImage(self.viewGo, "energy_3/go_energy")
	self.imageEnergy4 = gohelper.findChildImage(self.viewGo, "energy_4/go_energy")
end

function FightAssistBoss3:addEvents()
	FightAssistBoss3.super.addEvents(self)
	self.addEventCb(self, FightController.instance, FightEvent.OnSwitchAssistBossSkill, self.onSwitchAssistBossSkill, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnSwitchAssistBossSpine, self.onSwitchAssistBossSpine, self)
end

function FightAssistBoss3:refreshUI()
	FightAssistBoss3.super.refreshUI(self)
	self:refreshEnergyType()
end

function FightAssistBoss3:refreshEnergyType()
	local infoList = FightDataHelper.paTaMgr:getBossSkillInfoList()
	local count = #infoList

	gohelper.setActive(self.goEnergy3, count == 3)
	gohelper.setActive(self.goEnergy4, count == 4)
end

function FightAssistBoss3:onSwitchAssistBossSkill()
	self:refreshEnergyType()
	self:refreshPower()
	self:refreshCD()
end

FightAssistBoss3.StageThresholdValue1 = 25
FightAssistBoss3.StageThresholdValue2 = 50
FightAssistBoss3.StageThresholdValue3 = 100

function FightAssistBoss3:refreshPower()
	FightAssistBoss3.super.refreshPower(self)

	local infoList = FightDataHelper.paTaMgr:getBossSkillInfoList()
	local count = infoList and #infoList
	local power, max = FightDataHelper.paTaMgr:getAssistBossPower()

	self:setFillAmount((count == 4 or nil) and self.imageEnergy4, power / max)

	local stage = 0

	stage = power < FightAssistBoss3.StageThresholdValue1 and 0 or power < FightAssistBoss3.StageThresholdValue2 and 1 or power < FightAssistBoss3.StageThresholdValue3 and 2 or 3

	for i, go in ipairs(self.stageList) do
		gohelper.setActive(go, i == stage)
	end
end

function FightAssistBoss3:onSwitchAssistBossSpine()
	self:refreshHeadImage()
end

return FightAssistBoss3
