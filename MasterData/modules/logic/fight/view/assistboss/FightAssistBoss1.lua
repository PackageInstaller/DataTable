-- chunkname: @modules/logic/fight/view/assistboss/FightAssistBoss1.lua

module("modules.logic.fight.view.assistboss.FightAssistBoss1", package.seeall)

local FightAssistBoss1 = class("FightAssistBoss1", FightAssistBossBase)

function FightAssistBoss1:setPrefabPath()
	self.prefabPath = "ui/viewres/assistboss/boss1.prefab"
end

function FightAssistBoss1:initView()
	FightAssistBoss1.super.initView(self)

	self.energyImage = gohelper.findChildImage(self.viewGo, "head/energy")
	self.goEffect1 = gohelper.findChild(self.viewGo, "head/dec2")
	self.goEffect2 = gohelper.findChild(self.viewGo, "head/vx_eff")
end

function FightAssistBoss1:refreshPower()
	FightAssistBoss1.super.refreshPower(self)

	local power, max = FightDataHelper.paTaMgr:getAssistBossPower()

	self:setFillAmount(self.energyImage, power / max)
	self:refreshEffect()
end

function FightAssistBoss1:refreshCD()
	FightAssistBoss1.super.refreshCD(self)
	self:refreshEffect()
end

function FightAssistBoss1:refreshEffect()
	local showEffect = true
	local useSkill = FightDataHelper.paTaMgr:getCurUseSkillInfo()

	if not useSkill then
		showEffect = false

		gohelper.setActive(self.goEffect1, false)
		gohelper.setActive(self.goEffect2, showEffect)

		return
	end

	showEffect = not self:checkInCd()

	gohelper.setActive(self.goEffect1, showEffect)
	gohelper.setActive(self.goEffect2, showEffect)
end

return FightAssistBoss1
