-- chunkname: @modules/logic/fight/view/stress/StressAct183Behavior.lua

module("modules.logic.fight.view.stress.StressAct183Behavior", package.seeall)

local StressAct183Behavior = class("StressAct183Behavior", StressBehaviorBase)

StressAct183Behavior.StressThreshold = 49

function StressAct183Behavior:initUI()
	self.stressText = gohelper.findChildText(self.instanceGo, "#txt_stress")
	self.goYellow = gohelper.findChild(self.instanceGo, "yellow")
	self.goBroken = gohelper.findChild(self.instanceGo, "broken")
	self.click = gohelper.findChildClickWithDefaultAudio(self.instanceGo, "#go_clickarea")

	self.click:AddClickListener(self.onClickStress, self)
end

function StressAct183Behavior:onClickStress()
	local curStage = FightDataHelper.stageMgr:getCurStage()

	if curStage ~= FightStageMgr.StageType.Operate then
		return
	end

	local customData = FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Act183]

	if customData then
		local identityList = customData.stressIdentity[self.entityId]

		if identityList then
			StressTipController.instance:openAct183StressTip(identityList)

			return
		end
	end

	local entityMo = self.entity:getMO()
	local co = entityMo:getCO()
	local monsterTemplateCo = co and lua_monster_skill_template.configDict[co.skillTemplate]
	local identityId = monsterTemplateCo and monsterTemplateCo.identity

	if not identityId then
		return
	end

	StressTipController.instance:openAct183StressTip({
		identityId
	})
end

function StressAct183Behavior:refreshUI()
	self.stressText.text = self:getCurStress()

	self:updateStatus()
end

function StressAct183Behavior:updateStatus()
	local curStress = self:getCurStress()

	gohelper.setActive(self.goYellow, curStress <= self.StressThreshold)
	gohelper.setActive(self.goBroken, curStress > self.StressThreshold)
end

function StressAct183Behavior:resetGo()
	gohelper.setActive(self.goYellow, false)
	gohelper.setActive(self.goBroken, false)
end

function StressAct183Behavior:onPowerChange(entityId, powerId, oldNum, newNum)
	if self.entityId ~= entityId then
		return
	end

	if FightEnum.PowerType.Stress ~= powerId then
		return
	end

	if oldNum == newNum then
		return
	end

	self:refreshUI()
end

function StressAct183Behavior:beforeDestroy()
	self.click:RemoveClickListener()

	self.click = nil

	self:__onDispose()
end

return StressAct183Behavior
