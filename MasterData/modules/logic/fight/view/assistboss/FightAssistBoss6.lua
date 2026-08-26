-- chunkname: @modules/logic/fight/view/assistboss/FightAssistBoss6.lua

module("modules.logic.fight.view.assistboss.FightAssistBoss6", package.seeall)

local FightAssistBoss6 = class("FightAssistBoss6", FightAssistBossBase)

function FightAssistBoss6:setPrefabPath()
	self.prefabPath = "ui/viewres/assistboss/boss6.prefab"
end

FightAssistBoss6.PowerType = {
	Blue = 2,
	Red = 1
}
FightAssistBoss6.BuffTypeId2PowerType = {
	[130100111] = FightAssistBoss6.PowerType.Red,
	[130100112] = FightAssistBoss6.PowerType.Red,
	[130100113] = FightAssistBoss6.PowerType.Red,
	[130100121] = FightAssistBoss6.PowerType.Blue,
	[130100122] = FightAssistBoss6.PowerType.Blue,
	[130100123] = FightAssistBoss6.PowerType.Blue
}
FightAssistBoss6.Anim = {
	Open = "open",
	Close = "close",
	Idle = "idle",
	Loop = "loop"
}
FightAssistBoss6.MaxPower = 5
FightAssistBoss6.Radius = 58
FightAssistBoss6.AngleInterval = 45
FightAssistBoss6.InitAngle = -135
FightAssistBoss6.Radian = math.pi / 180
FightAssistBoss6.TweenAnimDuration = 0.5

function FightAssistBoss6:initView()
	FightAssistBoss6.super.initView(self)
	gohelper.setActive(self.goCD, false)

	self.goUnLight = gohelper.findChild(self.viewGo, "head/unlight")
	self.unLightHeadImage = gohelper.findChildImage(self.viewGo, "head/unlight/boss")
	self.unLightHeadSImage = gohelper.findChildSingleImage(self.viewGo, "head/unlight/boss")
	self.goLight = gohelper.findChild(self.viewGo, "head/light")
	self.goRedLightVx = gohelper.findChild(self.goLight, "light_red")
	self.goBlueLightVx = gohelper.findChild(self.goLight, "light_blue")
	self.lightHeadImage = gohelper.findChildImage(self.viewGo, "head/light/boss")
	self.lightHeadSImage = gohelper.findChildSingleImage(self.viewGo, "head/light/boss")
	self.goPointItem = gohelper.findChild(self.viewGo, "go_energy/go_point_item")

	gohelper.setActive(self.goPointItem, false)

	self.tempBuffList = {}
	self.powerItemPool = {}
	self.waitAddPowerBuffUidList = {}
	self.overFlowBuffDict = {}
	self.playRecycleAnimItemList = {}
	self.tweenAnimIng = false
	self.assistBoss = FightDataHelper.entityMgr:getAssistBoss()
	self.assistBossUid = self.assistBoss.uid

	self:refreshEmptyPower()
	self:refreshPowerCount()
end

function FightAssistBoss6:refreshEmptyPower()
	self.emptyPowerItemList = self.emptyPowerItemList or {}

	local _, maxPower = FightDataHelper.paTaMgr:getAssistBossServerPower()

	for i = 1, maxPower do
		local powerItem = self.emptyPowerItemList[i]

		if not powerItem then
			powerItem = self:createPowerItem(i)

			table.insert(self.emptyPowerItemList, powerItem)
			gohelper.setAsFirstSibling(powerItem.go)
		end

		local curAngle = self:getAngle(i)

		powerItem.initAngle = curAngle
		powerItem.curAngle = curAngle
		powerItem.targetAngle = curAngle

		gohelper.setActive(powerItem.go, true)

		local x, y = self:getAnchorPos(curAngle)

		recthelper.setAnchor(powerItem.rect, x, y)
	end

	for i = maxPower + 1, #self.emptyPowerItemList do
		local powerItem = table.remove(self.emptyPowerItemList)

		if powerItem then
			gohelper.destroy(powerItem.go, false)
		end
	end
end

function FightAssistBoss6:refreshPowerCount()
	self.powerItemList = self.powerItemList or {}

	tabletool.clear(self.tempBuffList)

	local buffList = self.assistBoss:getOrderedBuffList_ByTime(self.tempBuffList)
	local buffIndex = #buffList
	local powerType, buffUid
	local curPower, _ = FightDataHelper.paTaMgr:getAssistBossPower()

	for i = 1, curPower do
		powerType, buffIndex, buffUid = self:getNextPowerType(buffList, buffIndex)

		if powerType then
			local powerItem = self.powerItemList[i]

			if not powerItem then
				powerItem = self:createPowerItem(i, buffUid)

				table.insert(self.powerItemList, powerItem)
			end

			gohelper.setActive(powerItem.go, true)
			gohelper.setActive(powerItem.goRed, powerType == FightAssistBoss6.PowerType.Red)
			gohelper.setActive(powerItem.goBlue, powerType == FightAssistBoss6.PowerType.Blue)

			local curAngle = self:getAngle(i)

			powerItem.curAngle = curAngle
			powerItem.targetAngle = curAngle
			powerItem.initAngle = curAngle

			local x, y = self:getAnchorPos(curAngle)

			recthelper.setAnchor(powerItem.rect, x, y)
			powerItem.animatorPlayer:Play(FightAssistBoss6.Anim.Open)
		else
			logError(string.format("能量和buff个数不对应 .. %s / %s", i, curPower))

			buffIndex = 0
		end
	end

	self:refreshHeadImageColor()
end

function FightAssistBoss6:createPowerItem(index, buffUid)
	local powerItem

	if #self.powerItemPool > 0 then
		powerItem = table.remove(self.powerItemPool)
	else
		powerItem = self:getUserDataTb_()
		powerItem.go = gohelper.cloneInPlace(self.goPointItem)
		powerItem.rect = powerItem.go:GetComponent(gohelper.Type_RectTransform)
		powerItem.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(powerItem.go)
		powerItem.goRed = gohelper.findChild(powerItem.go, "red")
		powerItem.goBlue = gohelper.findChild(powerItem.go, "blue")
	end

	gohelper.setActive(powerItem.goRed, false)
	gohelper.setActive(powerItem.goBlue, false)

	powerItem.initAngle = self:getAngle(index)
	powerItem.targetAngle = powerItem.initAngle
	powerItem.curAngle = powerItem.initAngle
	powerItem.buffUid = buffUid

	return powerItem
end

function FightAssistBoss6:recyclePowerItem(powerItem)
	gohelper.setActive(powerItem.go, false)
	table.insert(self.powerItemPool, powerItem)
end

function FightAssistBoss6:getAngle(index)
	return FightAssistBoss6.InitAngle + (index - 1) * FightAssistBoss6.AngleInterval
end

function FightAssistBoss6:getAnchorPos(angle)
	local x = FightAssistBoss6.Radius * math.cos(angle * FightAssistBoss6.Radian)
	local y = FightAssistBoss6.Radius * math.sin(angle * FightAssistBoss6.Radian)

	return x, y
end

function FightAssistBoss6:addEvents()
	self.addEventCb(self, FightController.instance, FightEvent.OnAssistBossPowerChange, self.onAssistBossPowerChange, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnAssistBossCDChange, self.onAssistBossCDChange, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnResetCard, self.onResetCard, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnBuffUpdate, self.onBuffUpdate, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnPushBuffDeleteReason, self.onPushBuffDeleteReason, self)
	self.addEventCb(self, FightController.instance, FightEvent.StageChanged, self._onStageChange, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnStartSwitchAssistBoss, self.onStartSwitchAssistBoss, self)
end

function FightAssistBoss6:onStartSwitchAssistBoss(entityId)
	if entityId ~= self.assistBossUid then
		return
	end

	if self.tweenAnimIng then
		self:clearAddPowerTween()

		self.tweenAnimIng = false
	end

	self.assistBoss = FightDataHelper.entityMgr:getAssistBoss()

	self:refreshEmptyPower()
	self:refreshPowerCount()
end

function FightAssistBoss6:_onStageChange()
	local curStage = FightDataHelper.stageMgr:getCurStage()

	if curStage == FightStageMgr.StageType.Operate then
		tabletool.clear(self.overFlowBuffDict)
		self:refreshPower()
	end
end

function FightAssistBoss6:onPushBuffDeleteReason(entityId, buffUid, deleteType)
	if deleteType ~= FightEnum.BuffDeleteReason.Overflow then
		return
	end

	if self.assistBossUid ~= entityId then
		return
	end

	if not self:getPowerTypeByBuffUid(buffUid) then
		return
	end

	self.overFlowBuffDict[buffUid] = true
end

function FightAssistBoss6:onResetCard()
	if self.tweenAnimIng then
		return
	end

	self:refreshPower()
end

function FightAssistBoss6:onBuffUpdate(entityId, effectType, buffId, buffUid, effectConfig, buff)
	if self.assistBossUid ~= entityId then
		return
	end

	if effectType == FightEnum.EffectType.BUFFADD then
		self:doAddPower(buffId, buffUid)

		return
	elseif effectType == FightEnum.EffectType.BUFFDEL or effectType == FightEnum.EffectType.BUFFDELNOEFFECT then
		self:doRemovePower(buffId, buffUid)

		return
	end
end

function FightAssistBoss6:doRemovePower(buffId, buffUid)
	local powerType = self:getPowerType(buffId)

	if not powerType then
		return
	end

	local isOverFlow = self.overFlowBuffDict[buffUid]

	self.overFlowBuffDict[buffUid] = nil

	for index, powerItem in ipairs(self.powerItemList) do
		if powerItem.buffUid == buffUid then
			table.remove(self.powerItemList, index)
			table.insert(self.playRecycleAnimItemList, powerItem)

			local animName

			powerItem.animatorPlayer:Play(isOverFlow and "boom" or "close", self.onRecycleAnimComplete, self)
		end
	end
end

function FightAssistBoss6:onRecycleAnimComplete()
	local powerItem = table.remove(self.playRecycleAnimItemList, 1)

	if powerItem then
		self:recyclePowerItem(powerItem)
	end
end

function FightAssistBoss6:doAddPower(buffId, buffUid)
	local powerType = self:getPowerType(buffId)

	if not powerType then
		return
	end

	local firstPowerItem = self:createPowerItem(1, buffUid)

	gohelper.setActive(firstPowerItem.go, true)
	gohelper.setActive(firstPowerItem.goRed, powerType == FightAssistBoss6.PowerType.Red)
	gohelper.setActive(firstPowerItem.goBlue, powerType == FightAssistBoss6.PowerType.Blue)

	local x, y = self:getAnchorPos(firstPowerItem.initAngle)

	recthelper.setAnchor(firstPowerItem.rect, x, y)
	firstPowerItem.animatorPlayer:Play(FightAssistBoss6.Anim.Open)

	if #self.powerItemList < 1 then
		table.insert(self.powerItemList, 1, firstPowerItem)

		return
	end

	if self.tweenAnimIng then
		ZProj.TweenHelper.KillById(self.addPowerTweenId)

		self.addPowerTweenId = nil
	end

	local _, maxPower = FightDataHelper.paTaMgr:getAssistBossPower()

	for index, powerItem in ipairs(self.powerItemList) do
		powerItem.targetAngle = self:getAngle(math.min(maxPower, index + 1))
		powerItem.initAngle = powerItem.curAngle
	end

	table.insert(self.powerItemList, 1, firstPowerItem)

	self.tweenAnimIng = true
	self.addPowerTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, FightAssistBoss6.TweenAnimDuration, self.onAddPowerTweenFrameCallback, self.onAddPowerTweenDone, self)
end

function FightAssistBoss6:onAddPowerTweenFrameCallback(rate)
	for _, powerItem in ipairs(self.powerItemList) do
		local len = powerItem.targetAngle - powerItem.initAngle
		local curAngle = powerItem.initAngle + len * rate
		local x, y = self:getAnchorPos(curAngle)

		recthelper.setAnchor(powerItem.rect, x, y)

		powerItem.curAngle = curAngle
	end
end

function FightAssistBoss6:onAddPowerTweenDone()
	self.tweenAnimIng = false

	self:refreshPower()
end

function FightAssistBoss6:refreshHeadImage()
	local skin = self.assistBoss.originSkin
	local skinCo = FightConfig.instance:getSkinCO(skin)
	local icon = ResUrl.monsterHeadIcon(skinCo.headIcon)

	self.unLightHeadSImage:LoadImage(icon)
	self.lightHeadSImage:LoadImage(icon)
end

function FightAssistBoss6:refreshCD()
	gohelper.setActive(self.goCD, false)
end

function FightAssistBoss6:refreshPower(animName)
	if self.tweenAnimIng then
		return
	end

	for index, powerItem in ipairs(self.powerItemList) do
		local powerType = self:getPowerTypeByBuffUid(powerItem.buffUid)

		gohelper.setActive(powerItem.go, true)
		gohelper.setActive(powerItem.goRed, powerType == FightAssistBoss6.PowerType.Red)
		gohelper.setActive(powerItem.goBlue, powerType == FightAssistBoss6.PowerType.Blue)

		local angle = self:getAngle(index)

		powerItem.initAngle = angle
		powerItem.curAngle = angle
		powerItem.targetAngle = angle

		local x, y = self:getAnchorPos(angle)

		recthelper.setAnchor(powerItem.rect, x, y)

		if animName == FightAssistBoss6.Anim.Loop then
			powerItem.animatorPlayer:Play(powerType == FightAssistBoss6.PowerType.Red and "redloop" or "blueloop")
		else
			powerItem.animatorPlayer:Play(animName or FightAssistBoss6.Anim.Idle)
		end
	end

	self:refreshHeadImageColor()
end

function FightAssistBoss6:getNextPowerType(buffList, startIndex)
	startIndex = startIndex or #buffList

	for i = startIndex, 1, -1 do
		local buffMo = buffList[i]
		local co = buffMo and buffMo:getCO()
		local powerType = co and FightAssistBoss6.BuffTypeId2PowerType[co.typeId]

		if powerType then
			return powerType, i - 1, buffMo.uid
		end
	end
end

function FightAssistBoss6:refreshHeadImageColor()
	local useSkill = FightDataHelper.paTaMgr:getCurUseSkillInfo()

	if not useSkill then
		return self:refreshCanUse(false)
	end

	if self.assistBoss:hasBuffFeature(FightEnum.BuffType_Seal) then
		return self:refreshCanUse(false)
	end

	local inCd = self:checkInCd()

	if inCd then
		return self:refreshCanUse(false)
	end

	self:refreshCanUse(true)
end

function FightAssistBoss6:refreshCanUse(canUse)
	gohelper.setActive(self.goUnLight, not canUse)
	gohelper.setActive(self.goLight, canUse)

	if canUse then
		local redPowerCount, bluePowerCount = self:getPowerCount()

		gohelper.setActive(self.goRedLightVx, bluePowerCount < redPowerCount)
		gohelper.setActive(self.goBlueLightVx, redPowerCount <= bluePowerCount)
	end
end

function FightAssistBoss6:getPowerCount()
	if not self.assistBoss then
		return 0, 0
	end

	local redPowerCount, bluePowerCount = 0, 0

	tabletool.clear(self.tempBuffList)

	local buffList = self.assistBoss:getOrderedBuffList_ByTime(self.tempBuffList)

	for i = #buffList, 1, -1 do
		local buffMo = buffList[i]
		local co = buffMo and buffMo:getCO()
		local powerType = co and FightAssistBoss6.BuffTypeId2PowerType[co.typeId]

		if powerType == FightAssistBoss6.PowerType.Red then
			redPowerCount = redPowerCount + 1
		elseif powerType == FightAssistBoss6.PowerType.Blue then
			bluePowerCount = bluePowerCount + 1
		end
	end

	return redPowerCount, bluePowerCount
end

function FightAssistBoss6:playAssistBossCard()
	if self.tweenAnimIng then
		return
	end

	local playSuccess = FightAssistBoss6.super.playAssistBossCard(self)

	if playSuccess then
		self:refreshPower(FightAssistBoss6.Anim.Loop)
	end
end

function FightAssistBoss6:onLongPress()
	if self.tweenAnimIng then
		return
	end

	FightAssistBoss6.super.onLongPress(self)
end

function FightAssistBoss6:clearAddPowerTween()
	if self.addPowerTweenId then
		ZProj.TweenHelper.KillById(self.addPowerTweenId)

		self.addPowerTweenId = nil
	end
end

function FightAssistBoss6:destroy()
	self:clearAddPowerTween()

	self.tweenAnimIng = false

	FightAssistBoss6.super.destroy(self)
end

function FightAssistBoss6:getPowerType(buffId)
	local buffCo = lua_skill_buff.configDict[buffId]

	if not buffCo then
		return false
	end

	return FightAssistBoss6.BuffTypeId2PowerType[buffCo.typeId]
end

function FightAssistBoss6:getPowerTypeByBuffUid(buffUid)
	local buffMo = self.assistBoss:getBuffMO(buffUid)

	if not buffMo then
		return false
	end

	return self:getPowerType(buffMo.buffId)
end

return FightAssistBoss6
