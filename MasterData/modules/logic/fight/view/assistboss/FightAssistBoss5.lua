-- chunkname: @modules/logic/fight/view/assistboss/FightAssistBoss5.lua

module("modules.logic.fight.view.assistboss.FightAssistBoss5", package.seeall)

local FightAssistBoss5 = class("FightAssistBoss5", FightAssistBossBase)

function FightAssistBoss5:setPrefabPath()
	self.prefabPath = "ui/viewres/assistboss/boss5.prefab"
end

FightAssistBoss5.State = {
	Clicked = 3,
	CantClick = 1,
	CanClick = 2,
	SuZhen = 4
}
FightAssistBoss5.MaxPower = 5

function FightAssistBoss5:initView()
	FightAssistBoss5.super.initView(self)

	self.pointList = {}

	for i = 1, FightAssistBoss5.MaxPower do
		self:createPointItem(i)
	end

	self.goBgLevel1 = gohelper.findChild(self.viewGo, "head/bg/level1")
	self.goBgLevel2 = gohelper.findChild(self.viewGo, "head/bg/level2")
	self.goBgLevel3 = gohelper.findChild(self.viewGo, "head/bg/level3")
	self.goEffectLevel2 = gohelper.findChild(self.viewGo, "head/level2_eff")
	self.goEffectLevel3 = gohelper.findChild(self.viewGo, "head/level3_eff")
end

function FightAssistBoss5:addEvents()
	FightAssistBoss5.super.addEvents(self)
	self.addEventCb(self, FightController.instance, FightEvent.PowerMaxChange, self.onPowerMaxChange, self)
	self.addEventCb(self, FightController.instance, FightEvent.AddMagicCircile, self.refreshPower, self)
	self.addEventCb(self, FightController.instance, FightEvent.DeleteMagicCircile, self.refreshPower, self)
end

function FightAssistBoss5:onPowerMaxChange(entityId, powerId)
	local assistBoss = FightDataHelper.entityMgr:getAssistBoss()

	if not assistBoss then
		return
	end

	if assistBoss.uid ~= entityId then
		return
	end

	if powerId ~= FightEnum.PowerType.AssistBoss then
		return
	end

	self:refreshPower()
end

function FightAssistBoss5:createPointItem(index)
	local pointItem = self:getUserDataTb_()
	local go = gohelper.findChild(self.viewGo, "head/point" .. index)

	pointItem.go = go
	pointItem.goEnergy1 = gohelper.findChild(go, "energy1")
	pointItem.goEnergy2 = gohelper.findChild(go, "energy2")
	pointItem.goEnergy1Full = gohelper.findChild(pointItem.goEnergy1, "dark")
	pointItem.goEnergy1Light = gohelper.findChild(pointItem.goEnergy1, "light")
	pointItem.goEnergy2Full = gohelper.findChild(pointItem.goEnergy2, "light")

	table.insert(self.pointList, pointItem)

	return pointItem
end

function FightAssistBoss5:refreshPower()
	self:initRefreshFunc()

	local curState = self:getCurState()

	self:refreshBg(curState)
	self:refreshEffect(curState)
	self:refreshPointActive()

	local refreshFunc = self.refreshFuncDict[curState]

	if refreshFunc then
		refreshFunc(self)
	end

	self:refreshHeadImageColor()
end

function FightAssistBoss5:initRefreshFunc()
	self.refreshFuncDict = self.refreshFuncDict or {
		[FightAssistBoss5.State.CantClick] = self.refreshCantClickUI,
		[FightAssistBoss5.State.CanClick] = self.refreshCanClickUI,
		[FightAssistBoss5.State.Clicked] = self.refreshClickedUI,
		[FightAssistBoss5.State.SuZhen] = self.refreshSuZhenUI
	}
end

function FightAssistBoss5:getCurState()
	local magicData = FightModel.instance:getMagicCircleInfo()

	if magicData and magicData.magicCircleId == 1251001 then
		return FightAssistBoss5.State.SuZhen
	end

	local useCardCount = FightDataHelper.paTaMgr:getUseCardCount()

	if useCardCount and useCardCount > 0 then
		return FightAssistBoss5.State.Clicked
	end

	local useSkill = FightDataHelper.paTaMgr:getCurUseSkillInfo()

	if not useSkill then
		return FightAssistBoss5.State.CantClick
	end

	local needPower = FightDataHelper.paTaMgr:getNeedPower(useSkill)
	local power = FightDataHelper.paTaMgr:getAssistBossPower()

	if needPower <= power then
		return FightAssistBoss5.State.CanClick
	end

	return FightAssistBoss5.State.CantClick
end

function FightAssistBoss5:refreshBg(curState)
	gohelper.setActive(self.goBgLevel1, curState == FightAssistBoss5.State.CantClick)
	gohelper.setActive(self.goBgLevel2, curState == FightAssistBoss5.State.CanClick or curState == FightAssistBoss5.State.Clicked)
	gohelper.setActive(self.goBgLevel3, curState == FightAssistBoss5.State.SuZhen)
end

function FightAssistBoss5:refreshEffect(curState)
	gohelper.setActive(self.goEffectLevel2, curState == FightAssistBoss5.State.CanClick or curState == FightAssistBoss5.State.Clicked)
	gohelper.setActive(self.goEffectLevel3, curState == FightAssistBoss5.State.SuZhen)
end

function FightAssistBoss5:refreshPointActive()
	local _, maxPower = FightDataHelper.paTaMgr:getAssistBossServerPower()

	maxPower = math.min(FightAssistBoss5.MaxPower, maxPower)

	for i, pointItem in ipairs(self.pointList) do
		gohelper.setActive(pointItem.go, i <= maxPower)
	end
end

function FightAssistBoss5:refreshCantClickUI()
	local power = FightDataHelper.paTaMgr:getAssistBossServerPower()

	for i, pointItem in ipairs(self.pointList) do
		gohelper.setActive(pointItem.goEnergy1, true)
		gohelper.setActive(pointItem.goEnergy2, false)
		gohelper.setActive(pointItem.goEnergy1Light, false)
		gohelper.setActive(pointItem.goEnergy1Full, i <= power)
	end
end

function FightAssistBoss5:refreshCanClickUI()
	local power = FightDataHelper.paTaMgr:getAssistBossServerPower()

	for i, pointItem in ipairs(self.pointList) do
		gohelper.setActive(pointItem.goEnergy1, true)
		gohelper.setActive(pointItem.goEnergy2, false)
		gohelper.setActive(pointItem.goEnergy1Light, false)
		gohelper.setActive(pointItem.goEnergy1Full, i <= power)
	end
end

function FightAssistBoss5:refreshClickedUI()
	local power = FightDataHelper.paTaMgr:getAssistBossServerPower()

	for i, pointItem in ipairs(self.pointList) do
		gohelper.setActive(pointItem.goEnergy1, true)
		gohelper.setActive(pointItem.goEnergy2, false)
		gohelper.setActive(pointItem.goEnergy1Light, i <= power)
		gohelper.setActive(pointItem.goEnergy1Full, i <= power)
	end
end

function FightAssistBoss5:refreshSuZhenUI()
	local power = FightDataHelper.paTaMgr:getAssistBossServerPower()

	for i, pointItem in ipairs(self.pointList) do
		gohelper.setActive(pointItem.goEnergy1, false)
		gohelper.setActive(pointItem.goEnergy2, true)
		gohelper.setActive(pointItem.goEnergy2Full, i <= power)
	end
end

function FightAssistBoss5:refreshCD()
	local curState = self:getCurState()

	if curState == FightAssistBoss5.State.SuZhen then
		gohelper.setActive(self.goCD, false)
		self:refreshHeadImageColor()

		return
	end

	FightAssistBoss5.super.refreshCD(self)
end

function FightAssistBoss5:refreshHeadImageColor()
	local curState = self:getCurState()

	if curState == FightAssistBoss5.State.SuZhen then
		self.headImage.color = Color.white

		return
	end

	FightAssistBoss5.super.refreshHeadImageColor(self)
end

function FightAssistBoss5:refreshHeadImage()
	self.headSImage:LoadImage(ResUrl.monsterHeadIcon(6304101), self.onImageLoaded, self)
end

function FightAssistBoss5:onImageLoaded()
	self.headImage:SetNativeSize()
end

return FightAssistBoss5
