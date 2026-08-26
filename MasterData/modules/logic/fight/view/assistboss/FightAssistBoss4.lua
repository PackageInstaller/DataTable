-- chunkname: @modules/logic/fight/view/assistboss/FightAssistBoss4.lua

module("modules.logic.fight.view.assistboss.FightAssistBoss4", package.seeall)

local FightAssistBoss4 = class("FightAssistBoss4", FightAssistBossBase)

function FightAssistBoss4:setPrefabPath()
	self.prefabPath = "ui/viewres/assistboss/boss4.prefab"
end

function FightAssistBoss4:initView()
	FightAssistBoss4.super.initView(self)

	self.goCanUseFrame = gohelper.findChild(self.viewGo, "head/canuse_frame")
	self.goBg = gohelper.findChild(self.viewGo, "head/bg")
	self.pointList = {}

	self:createPointItem(gohelper.findChild(self.viewGo, "head/point1"))
	self:createPointItem(gohelper.findChild(self.viewGo, "head/point2"))
	self:createPointItem(gohelper.findChild(self.viewGo, "head/point3"))
end

function FightAssistBoss4:addEvents()
	FightAssistBoss4.super.addEvents(self)
	self.addEventCb(self, FightController.instance, FightEvent.OnBuffUpdate, self.onBuffUpdate, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnMySideRoundEnd, self.onMySideRoundEnd, self)
	self.addEventCb(self, FightController.instance, FightEvent.StageChanged, self.stageChange, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnSkillPlayFinish, self.onSkillPlayFinish, self)
end

function FightAssistBoss4:createPointItem(goPoint)
	local pointItem = self:getUserDataTb_()

	pointItem.go = goPoint
	pointItem.goUsing = gohelper.findChild(goPoint, "canuse")
	pointItem.goOver = gohelper.findChild(goPoint, "over")
	pointItem.energyImage = gohelper.findChildImage(goPoint, "energybg/energy")
	pointItem.goFull = gohelper.findChild(goPoint, "full")
	pointItem.energyImage.fillAmount = 0

	table.insert(self.pointList, pointItem)
	self:resetPointItem(pointItem)

	return pointItem
end

function FightAssistBoss4:resetPointItem(pointItem)
	gohelper.setActive(pointItem.goFull, false)
	gohelper.setActive(pointItem.goUsing, false)
	gohelper.setActive(pointItem.goOver, false)
end

function FightAssistBoss4:refreshPower()
	self:killTween()

	local power, maxPower = FightDataHelper.paTaMgr:getAssistBossServerPower()
	local beforeRate = self:getBeforePowerRate()
	local targetRate = power / maxPower

	self.tweenId = ZProj.TweenHelper.DOTweenFloat(beforeRate, targetRate, FightAssistBossBase.Duration, self.onBoss4FrameCallback, self.onTweenDone, self, nil, EaseType.Linear)

	self:refreshOver()
	self:refreshUsing()
	self:refreshHeadImageColor()
	self:refreshCanUse()
end

function FightAssistBoss4:getBeforePowerRate()
	local rate = 0

	rate = rate + self.pointList[1].energyImage.fillAmount / 2
	rate = rate + self.pointList[2].energyImage.fillAmount / 2

	return rate
end

function FightAssistBoss4:onBoss4FrameCallback(value)
	local index

	if value <= 0.5 then
		index = 1
	else
		index = 2
		value = value - 0.5
	end

	value = value * 2

	local pointItem = self.pointList[index]

	pointItem.energyImage.fillAmount = value

	gohelper.setActive(pointItem.goFull, value >= 1)
end

function FightAssistBoss4:onTweenDone()
	local power, maxPower = FightDataHelper.paTaMgr:getAssistBossServerPower()
	local srcRate = power / maxPower
	local rate = srcRate

	rate = srcRate <= 0.5 and rate * 2 or 1
	self.pointList[1].energyImage.fillAmount = rate

	gohelper.setActive(self.pointList[1].goFull, rate >= 1)

	rate = srcRate - 0.5
	rate = (srcRate - 0.5) * 2
	self.pointList[2].energyImage.fillAmount = math.max((srcRate - 0.5) * 2, 0)

	gohelper.setActive(self.pointList[2].goFull, rate >= 1)
end

function FightAssistBoss4:refreshOver()
	local isOver = self:checkIsOver()

	for _, pointItem in ipairs(self.pointList) do
		gohelper.setActive(pointItem.goOver, isOver)
	end
end

function FightAssistBoss4:refreshUsing()
	local useCardCount = FightDataHelper.paTaMgr:getUseCardCount()

	for index, pointItem in ipairs(self.pointList) do
		gohelper.setActive(pointItem.goUsing, index <= useCardCount)
	end
end

FightAssistBoss4.OverColor = Color(0.7058823529411765, 0.7058823529411765, 0.7058823529411765)

function FightAssistBoss4:refreshHeadImageColor()
	local isOver = self:checkIsOver()

	ZProj.UGUIHelper.SetGrayscale(self.goBg, isOver)

	if isOver then
		self.headImage.color = FightAssistBoss4.OverColor or Color.white
	end
end

function FightAssistBoss4:refreshCanUse()
	gohelper.setActive(self.goCanUseFrame, self:canUseSkill() ~= nil)
end

function FightAssistBoss4:canUseSkill()
	local useSkill = FightAssistBoss4.super.canUseSkill(self)

	if not useSkill then
		return
	end

	if self:checkIsOver() then
		return
	end

	return useSkill
end

function FightAssistBoss4:refreshCD()
	return
end

FightAssistBoss4.OverBuffId = 12410011

function FightAssistBoss4:checkIsOver()
	local assistBoss = FightDataHelper.entityMgr:getAssistBoss()

	return assistBoss and assistBoss:hasBuffId(FightAssistBoss4.OverBuffId)
end

function FightAssistBoss4:onBuffUpdate(entityId, effectType, buffId, buffUid)
	local assistBoss = FightDataHelper.entityMgr:getAssistBoss()

	if not assistBoss then
		return
	end

	if assistBoss.uid ~= entityId then
		return
	end

	self:refreshOver()
	self:refreshHeadImageColor()
	self:refreshCanUse()

	if effectType == FightEnum.EffectType.BUFFADD and buffId == FightAssistBoss4.OverBuffId then
		AudioMgr.instance:trigger(20247004)
	end
end

function FightAssistBoss4:refreshSpecialPoint()
	local pointItem = self.pointList[3]

	if self:checkIsOver() then
		gohelper.setActive(pointItem.goOver, true)
		gohelper.setActive(pointItem.goFull, false)

		pointItem.energyImage.fillAmount = 0

		return
	end

	local power, maxPower = FightDataHelper.paTaMgr:getAssistBossServerPower()
	local full = power == maxPower

	pointItem.energyImage.fillAmount = full and 1 or 0

	gohelper.setActive(pointItem.goFull, full)
	gohelper.setActive(pointItem.goOver, false)
end

function FightAssistBoss4:onSkillPlayFinish(entity, skillId, fightStepData, timelineName)
	local infoList = FightDataHelper.paTaMgr:getBossSkillInfoList()
	local skillInfo = infoList and infoList[3]
	local lastSkillId = skillInfo and skillInfo.skillId

	if lastSkillId == skillId then
		self:refreshSpecialPoint()
	end
end

function FightAssistBoss4:stageChange()
	local curStage = FightDataHelper.stageMgr:getCurStage()

	if curStage == FightStageMgr.StageType.Operate then
		self:refreshSpecialPoint()
	end
end

function FightAssistBoss4:onMySideRoundEnd()
	return self:refreshSpecialPoint()
end

function FightAssistBoss4:playAssistBossCard()
	local playSuccess = FightAssistBoss4.super.playAssistBossCard(self)

	if playSuccess then
		AudioMgr.instance:trigger(20247003)
	end
end

return FightAssistBoss4
