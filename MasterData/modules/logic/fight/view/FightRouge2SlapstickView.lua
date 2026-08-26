-- chunkname: @modules/logic/fight/view/FightRouge2SlapstickView.lua

module("modules.logic.fight.view.FightRouge2SlapstickView", package.seeall)

local FightRouge2SlapstickView = class("FightRouge2SlapstickView", FightBaseView)
local State = {
	Using = 3,
	CanUse = 2,
	CantUse = 1
}
local StateAnim = {
	[State.CantUse] = "unfull_idle",
	[State.CanUse] = "canuse_idle",
	[State.Using] = "using_idle"
}
local SwitchAnim = {
	[State.CantUse] = {
		[State.CanUse] = "unfull_canuse"
	},
	[State.CanUse] = {
		[State.Using] = "canuse_using"
	},
	[State.Using] = {
		[State.CanUse] = "using_canuse",
		[State.CantUse] = "using_unfull"
	}
}
local TagType = {
	FanYing = 3,
	LiLiang = 2,
	AoMi = 4,
	Normal = 1
}
local MaxPower = 6

function FightRouge2SlapstickView:onInitView()
	self.goNormal = gohelper.findChild(self.viewGO, "#go_normal")
	self.goLiLiang = gohelper.findChild(self.viewGO, "#go_liliang")
	self.goFanYing = gohelper.findChild(self.viewGO, "#go_fanying")
	self.goAoMi = gohelper.findChild(self.viewGO, "#go_aomi")
	self.tag2Go = self:getUserDataTb_()
	self.tag2Go[TagType.Normal] = self.goNormal
	self.tag2Go[TagType.LiLiang] = self.goLiLiang
	self.tag2Go[TagType.FanYing] = self.goFanYing
	self.tag2Go[TagType.AoMi] = self.goAoMi
	self.goClickArea = gohelper.findChild(self.viewGO, "clickarea")
	self.longListener = SLFramework.UGUI.UILongPressListener.Get(self.goClickArea)

	self.longListener:SetLongPressTime({
		0.5,
		99999
	})
	self.longListener:AddLongPressListener(self.onLongPress, self)
	self.longListener:AddClickListener(self.onClick, self)
	self:initData()
	self:createNode()
end

function FightRouge2SlapstickView:addEvents()
	self.addEventCb(self, FightController.instance, FightEvent.PowerChange, self.onPowerChange, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnResetCard, self.onResetCard, self)
	self.addEventCb(self, FightController.instance, FightEvent.StageChanged, self.onStageChanged, self)
end

function FightRouge2SlapstickView:removeEvents()
	return
end

function FightRouge2SlapstickView:onStageChanged()
	self:refreshPoint()

	local preState = self.curState

	self.curState = self:getCurState()

	self:playSwitchAnim(preState, self.curState)
end

function FightRouge2SlapstickView:onResetCard()
	self:refreshPoint()

	local preState = self.curState

	self.curState = self:getCurState()

	self:playSwitchAnim(preState, self.curState)
end

function FightRouge2SlapstickView:onLongPress()
	if FightDataHelper.stateMgr:getIsAuto() then
		return
	end

	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Play then
		return
	end

	if FightDataHelper.operationDataMgr:isCardOpEnd() then
		return
	end

	if FightGameMgr.operateMgr:isOperating() then
		return
	end

	local useSkill = FightDataHelper.paTaMgr:getCurUseSkillInfo()
	local skillList = FightDataHelper.paTaMgr:getBossSkillInfoList()

	if not useSkill then
		useSkill = skillList[1]

		if not skillList[1] then
			logError("boss not found any one skill!")

			return
		end
	end

	local skillId = useSkill.skillId
	local skillCo = lua_skill.configDict[skillId]

	if not skillCo then
		logError("long press assist boss, skill not exist !!! id : " .. tostring(skillId))

		return
	end

	self.tempInfo = self.tempInfo or {}

	tabletool.clear(self.tempInfo)

	self.tempSkillIdList = self.tempSkillIdList or {}

	tabletool.clear(self.tempSkillIdList)

	for _, skillInfo in ipairs(skillList) do
		table.insert(self.tempSkillIdList, skillInfo.skillId)
	end

	self.tempInfo.super = skillCo.isBigSkill == 1
	self.tempInfo.skillIdList = self.tempSkillIdList
	self.tempInfo.skillIndex = 1
	self.tempInfo.userSkillId = useSkill.skillId

	local assistBoss = FightDataHelper.entityMgr:getAssistBoss()

	self.tempInfo.monsterName = assistBoss and assistBoss:getEntityName() or ""

	if assistBoss and self.tempInfo.super then
		ViewMgr.instance:openView(ViewName.TowerSkillTipView, self.tempInfo)
	else
		ViewMgr.instance:openView(ViewName.SkillTipView, self.tempInfo)
	end
end

function FightRouge2SlapstickView:onClick()
	if FightDataHelper.stateMgr:getIsAuto() then
		return
	end

	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Play then
		return
	end

	if FightDataHelper.operationDataMgr:isCardOpEnd() then
		return
	end

	if FightGameMgr.operateMgr:isOperating() then
		return
	end

	if self.curState ~= State.CanUse then
		return
	end

	AudioMgr.instance:trigger(335070)

	local useSkill = FightDataHelper.paTaMgr:getCurUseSkillInfo()
	local op = FightDataHelper.operationDataMgr:newOperation()

	op:playAssistBossHandCard(useSkill.skillId)
	FightController.instance:dispatchEvent(FightEvent.AddPlayOperationData, op)
	FightController.instance:dispatchEvent(FightEvent.onNoActCostMoveFlowOver)
	FightController.instance:dispatchEvent(FightEvent.RefreshPlayCardRoundOp, op)
	FightController.instance:dispatchEvent(FightEvent.OnPlayAssistBossCardFlowDone, op)
	FightDataHelper.paTaMgr:playAssistBossSkill(useSkill)
	self:refreshPoint()

	local preState = self.curState

	self.curState = self:getCurState()

	self:playSwitchAnim(preState, self.curState)
end

function FightRouge2SlapstickView:onPowerChange(entityId, powerId, oldNum, newNum)
	if powerId ~= FightEnum.PowerType.AssistBoss then
		return
	end

	local assistBoss = FightDataHelper.entityMgr:getAssistBoss()

	if not assistBoss or assistBoss.id ~= entityId then
		return
	end

	local curState = self:getCurState()

	if curState == self.curState then
		self:refreshPoint()

		return
	end

	self:refreshPoint()

	local preState = self.curState

	self.curState = curState

	self:playSwitchAnim(preState, self.curState)
end

function FightRouge2SlapstickView:playSwitchAnim(preState, curState)
	local animName = SwitchAnim[preState][curState]

	if animName then
		self.animatorPlayer:Play(animName, self.playIdleAnim, self)
	else
		self:playIdleAnim()
	end
end

function FightRouge2SlapstickView:initData()
	self.assistBossMo = FightDataHelper.entityMgr:getAssistBoss()
	self.skin = self.assistBossMo.skin
	self.skinCo = FightConfig.instance:getSkinCO(self.skin)

	for _, co in ipairs(lua_fight_rouge2_summoner.configList) do
		if co.skinId == self.skin then
			self.summonerCo = co

			break
		end
	end

	if not self.summonerCo then
		logError(string.format("召唤师表未找到皮肤id : %s 的配置", self.skin))

		self.summonerCo = lua_fight_rouge2_summoner.configList[1]
	end

	local _, configMaxPower = FightDataHelper.paTaMgr:getAssistBossServerPower()

	self.configMaxPower = configMaxPower
	self.tag = self.summonerCo.attributeTag
end

function FightRouge2SlapstickView:getCurTag()
	if self.tag == "101" then
		return TagType.LiLiang
	end

	if self.tag == "102" then
		return TagType.FanYing
	end

	if self.tag == "103" then
		return TagType.AoMi
	end

	return TagType.Normal
end

function FightRouge2SlapstickView:createNode()
	local tag = self:getCurTag()

	for _tag, go in pairs(self.tag2Go) do
		gohelper.setActive(go, _tag == tag)
	end

	local go = self.tag2Go[tag]

	self.simageBoss = gohelper.findChildSingleImage(go, "boss")

	self.simageBoss:LoadImage(ResUrl.monsterHeadIcon(self.skinCo.headIcon))

	self.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(go)
	self.goUnFull = gohelper.findChild(go, "#go_unFull")
	self.goCanUse = gohelper.findChild(go, "#go_canUse")
	self.goUsing = gohelper.findChild(go, "#go_using")
	self.state2Go = self:getUserDataTb_()
	self.state2Go[State.CantUse] = self.goUnFull
	self.state2Go[State.CanUse] = self.goCanUse
	self.state2Go[State.Using] = self.goUsing
	self.cantUsePointList = {}

	for i = 1, MaxPower do
		local pointGo = gohelper.findChild(self.goUnFull, "point" .. i)

		if i <= self.configMaxPower then
			table.insert(self.cantUsePointList, self:createPointItem(pointGo))
		else
			gohelper.setActive(pointGo, false)
		end
	end

	self.canUsePointList = {}

	for i = 1, MaxPower do
		local pointGo = gohelper.findChild(self.goCanUse, "point" .. i)

		if i <= self.configMaxPower then
			table.insert(self.canUsePointList, self:createPointItem(pointGo))
		else
			gohelper.setActive(pointGo, false)
		end
	end
end

function FightRouge2SlapstickView:createPointItem(goPoint)
	local pointItem = self:getUserDataTb_()

	pointItem.go = goPoint
	pointItem.goLight = gohelper.findChild(pointItem.go, "light")

	gohelper.setActive(pointItem.goLight, false)

	return pointItem
end

function FightRouge2SlapstickView:onOpen()
	self.curState = self:getCurState()

	self:refreshUI()
	self:refreshPoint()
	self:playIdleAnim()
end

function FightRouge2SlapstickView:refreshUI()
	return
end

function FightRouge2SlapstickView:refreshPoint()
	local curPower = self:getCurPower()

	for index, pointItem in ipairs(self.cantUsePointList) do
		gohelper.setActive(pointItem.goLight, index <= curPower)
	end

	for index, pointItem in ipairs(self.canUsePointList) do
		gohelper.setActive(pointItem.goLight, index <= curPower)
	end
end

function FightRouge2SlapstickView:playIdleAnim()
	self.animatorPlayer:Play(StateAnim[self.curState])
	self:refreshUI()
end

function FightRouge2SlapstickView:getCurState()
	local useCount = FightDataHelper.paTaMgr:getUseCardCount()

	if useCount > 0 then
		return State.Using
	end

	local cd = FightDataHelper.paTaMgr:getCurCD()

	if cd and cd > 0 then
		return State.CantUse
	end

	if not FightDataHelper.paTaMgr:canUseSkill() then
		return State.CantUse
	end

	local useSkill = FightDataHelper.paTaMgr:getCurUseSkillInfo()

	if not useSkill then
		return State.CantUse
	end

	local needPower = FightDataHelper.paTaMgr:getNeedPower(useSkill)
	local power = FightDataHelper.paTaMgr:getAssistBossPower()

	if power < needPower then
		return State.CantUse
	end

	return State.CanUse
end

function FightRouge2SlapstickView:getCurPower()
	return FightDataHelper.paTaMgr:getAssistBossPower()
end

function FightRouge2SlapstickView:onDestroyView()
	if self.longListener then
		self.longListener:RemoveClickListener()
		self.longListener:RemoveLongPressListener()

		self.longListener = nil
	end

	self.animatorPlayer:Stop()

	if self.simageBoss then
		self.simageBoss:UnLoadImage()

		self.simageBoss = nil
	end
end

return FightRouge2SlapstickView
