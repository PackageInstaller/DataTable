-- chunkname: @modules/logic/fight/view/stress/StressNormalBehavior.lua

module("modules.logic.fight.view.stress.StressNormalBehavior", package.seeall)

local StressNormalBehavior = class("StressNormalBehavior", StressBehaviorBase)

StressNormalBehavior.BehaviourAnimDuration = 1
StressNormalBehavior.Behaviour2AudioId = {
	[FightEnum.StressBehaviour.Meltdown] = 20211405,
	[FightEnum.StressBehaviour.Resolute] = 20211404
}

function StressNormalBehavior:initUI()
	self.stressText = gohelper.findChildText(self.instanceGo, "#txt_stress")
	self.goBlue = gohelper.findChild(self.instanceGo, "blue")
	self.goRed = gohelper.findChild(self.instanceGo, "red")
	self.goBroken = gohelper.findChild(self.instanceGo, "broken")
	self.goStaunch = gohelper.findChild(self.instanceGo, "staunch")
	self.click = gohelper.findChildClickWithDefaultAudio(self.instanceGo, "#go_clickarea")

	self.click:AddClickListener(self.onClickStress, self)

	self.statusDict = {}
	self.statusDict[FightEnum.Status.Positive] = self:createStatusItem(self.goBlue)
	self.statusDict[FightEnum.Status.Negative] = self:createStatusItem(self.goRed)
	self.animGoDict = self:getUserDataTb_()
	self.animGoDict[FightEnum.StressBehaviour.Meltdown] = self.goBroken
	self.animGoDict[FightEnum.StressBehaviour.Resolute] = self.goStaunch
end

function StressNormalBehavior:createStatusItem(go)
	local statusItem = self:getUserDataTb_()

	statusItem.go = go
	statusItem.txtStress = gohelper.findChildText(statusItem.go, "add/#txt_stress")
	statusItem.animator = statusItem.go:GetComponent(gohelper.Type_Animator)

	return statusItem
end

function StressNormalBehavior:onClickStress()
	local curStage = FightDataHelper.stageMgr:getCurStage()

	if curStage ~= FightStageMgr.StageType.Operate then
		return
	end

	local entityMo = self.entity:getMO()

	if entityMo.side == FightEnum.EntitySide.MySide then
		StressTipController.instance:openHeroStressTip(entityMo:getCO())
	else
		StressTipController.instance:openMonsterStressTip(entityMo:getCO())
	end
end

function StressNormalBehavior:refreshUI()
	self.stressText.text = self:getCurStress()

	self:updateStatus()
end

function StressNormalBehavior:updateStatus()
	self:resetGo()

	local curStress = self:getCurStress()
	local thresholdDict = FightEnum.MonsterId2StressThresholdDict[self.monsterId]

	self.status = FightHelper.getStressStatus(curStress, thresholdDict)

	if self.status then
		if self.status then
			gohelper.setActive(self.status.go, true)
		end
	end
end

function StressNormalBehavior:resetGo()
	gohelper.setActive(self.goBlue, false)
	gohelper.setActive(self.goRed, false)
	gohelper.setActive(self.goBroken, false)
	gohelper.setActive(self.goStaunch, false)
end

function StressNormalBehavior:onPowerChange(entityId, powerId, oldNum, newNum)
	if self.playBehaviouring then
		return
	end

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
	self:playStressValueChangeAnim()
end

function StressNormalBehavior:playStressValueChangeAnim()
	if self.playBehaviouring then
		return
	end

	if not self.status then
		return
	end

	local statusItem = self.statusDict[self.status]

	if statusItem then
		statusItem.animator:Play("up", 0, 0)

		statusItem.txtStress.text = self:getCurStress()
	else
		self:log(string.format("压力值item为nil。cur status : %s, cur stress : %s", self.status, self:getCurStress()))
	end
end

function StressNormalBehavior:triggerStressBehaviour(entityId, behavior)
	if self.entityId ~= entityId then
		return
	end

	if FightEnum.StressBehaviour.Resolute ~= behavior and FightEnum.StressBehaviour.Meltdown ~= behavior then
		return
	end

	self:resetGo()

	local animGo = self.animGoDict[behavior]
	local audioId = self.Behaviour2AudioId[behavior]

	if not animGo then
		self:log(string.format("没找到对应行为动画节点，behaviour is : %s", behavior))

		animGo = self.animGoDict[FightEnum.StressBehaviour.Meltdown]
		audioId = self.Behaviour2AudioId[FightEnum.StressBehaviour.Meltdown]
	end

	self.playBehaviouring = true

	gohelper.setActive(animGo, true)
	FightAudioMgr.instance:playAudio(audioId)
	TaskDispatcher.runDelay(self.onBehaviourDone, self, StressNormalBehavior.BehaviourAnimDuration)
end

function StressNormalBehavior:onBehaviourDone()
	self.playBehaviouring = false

	self:refreshUI()
	self:playStressValueChangeAnim()
end

function StressNormalBehavior:beforeDestroy()
	TaskDispatcher.cancelTask(self.onBehaviourDone, self)
	self.click:RemoveClickListener()

	self.click = nil

	self:__onDispose()
end

return StressNormalBehavior
