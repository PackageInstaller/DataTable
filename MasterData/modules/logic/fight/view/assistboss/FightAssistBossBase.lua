-- chunkname: @modules/logic/fight/view/assistboss/FightAssistBossBase.lua

module("modules.logic.fight.view.assistboss.FightAssistBossBase", package.seeall)

local FightAssistBossBase = class("FightAssistBossBase", UserDataDispose)

FightAssistBossBase.InCDColor = Color(0.5019607843137255, 0.5019607843137255, 0.5019607843137255)

function FightAssistBossBase:init(goContainer)
	self:__onInit()

	self.goContainer = goContainer
	self.loadDone = false

	self:setPrefabPath()
	self:loadRes()
end

function FightAssistBossBase:setPrefabPath()
	self.prefabPath = "ui/viewres/assistboss/boss0.prefab"
end

function FightAssistBossBase:loadRes()
	self.loader = PrefabInstantiate.Create(self.goContainer)

	self.loader:startLoad(self.prefabPath, self.onResLoaded, self)
end

function FightAssistBossBase:onResLoaded()
	self.loadDone = true
	self.viewGo = self.loader:getInstGO()

	self:initView()
	self:addEvents()
	self:refreshUI()
end

function FightAssistBossBase:initView()
	self.headImage = gohelper.findChildImage(self.viewGo, "head/boss")
	self.headSImage = gohelper.findChildSingleImage(self.viewGo, "head/boss")
	self.goCD = gohelper.findChild(self.viewGo, "cd")
	self.txtCD = gohelper.findChildText(self.viewGo, "cd/cdbg/#txt_cd")

	local goClickArea = gohelper.findChild(self.viewGo, "clickarea")

	self.longListener = SLFramework.UGUI.UILongPressListener.Get(goClickArea)

	self.longListener:SetLongPressTime({
		0.5,
		99999
	})
	self.longListener:AddLongPressListener(self.onLongPress, self)
	self.longListener:AddClickListener(self.playAssistBossCard, self)
end

function FightAssistBossBase:addEvents()
	self.addEventCb(self, FightController.instance, FightEvent.OnAssistBossPowerChange, self.onAssistBossPowerChange, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnAssistBossCDChange, self.onAssistBossCDChange, self)
	self.addEventCb(self, FightController.instance, FightEvent.PowerChange, self.onPowerChange, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnResetCard, self.onResetCard, self)
end

function FightAssistBossBase:refreshUI()
	if not self.loadDone then
		return
	end

	self:refreshHeadImage()
	self:refreshPower()
	self:refreshCD()
end

function FightAssistBossBase:onAssistBossPowerChange()
	self:refreshPower()
end

function FightAssistBossBase:onAssistBossCDChange()
	self:refreshCD()
end

function FightAssistBossBase:onPowerChange(entityId, powerId, oldNum, newNum)
	if powerId ~= FightEnum.PowerType.AssistBoss then
		return
	end

	local assistBoss = FightDataHelper.entityMgr:getAssistBoss()

	if not assistBoss or assistBoss.id ~= entityId then
		return
	end

	self:refreshPower()
end

function FightAssistBossBase:onResetCard()
	self:refreshPower()
	self:refreshCD()
end

function FightAssistBossBase:refreshHeadImage()
	local assistBoss = FightDataHelper.entityMgr:getAssistBoss()
	local skin = assistBoss.originSkin
	local skinCo = FightConfig.instance:getSkinCO(skin)

	self.headSImage:LoadImage(ResUrl.monsterHeadIcon(skinCo.headIcon))
end

function FightAssistBossBase:refreshPower()
	self:refreshHeadImageColor()
end

function FightAssistBossBase:checkInCd()
	local cd = FightDataHelper.paTaMgr:getCurCD()

	return cd and cd > 0
end

function FightAssistBossBase:refreshCD()
	local inCd = self:checkInCd()

	gohelper.setActive(self.goCD, inCd)

	if inCd then
		self.txtCD.text = tostring(FightDataHelper.paTaMgr:getCurCD())
	end

	self:refreshHeadImageColor()
end

function FightAssistBossBase:refreshHeadImageColor()
	local useSkill = FightDataHelper.paTaMgr:getCurUseSkillInfo()

	if not useSkill then
		self.headImage.color = FightAssistBossBase.InCDColor

		return
	end

	local inCd = self:checkInCd()

	if inCd then
		self.headImage.color = FightAssistBossBase.InCDColor

		return
	end

	self.headImage.color = Color.white
end

function FightAssistBossBase:onLongPress()
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

	for index, skillInfo in ipairs(skillList) do
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

function FightAssistBossBase:playAssistBossCard()
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

	local useSkill = self:canUseSkill()

	if not useSkill then
		return
	end

	local op = FightDataHelper.operationDataMgr:newOperation()

	op:playAssistBossHandCard(useSkill.skillId)
	FightController.instance:dispatchEvent(FightEvent.AddPlayOperationData, op)
	FightController.instance:dispatchEvent(FightEvent.onNoActCostMoveFlowOver)
	FightController.instance:dispatchEvent(FightEvent.RefreshPlayCardRoundOp, op)
	FightController.instance:dispatchEvent(FightEvent.OnPlayAssistBossCardFlowDone, op)
	FightDataHelper.paTaMgr:playAssistBossSkill(useSkill)
	FightController.instance:dispatchEvent(FightEvent.OnAssistBossPowerChange)
	FightController.instance:dispatchEvent(FightEvent.OnAssistBossCDChange)

	return true
end

function FightAssistBossBase:canUseSkill()
	if FightDataHelper.lockOperateMgr:isLock() then
		return
	end

	if FightViewHandCard.blockOperate then
		return
	end

	if not FightDataHelper.paTaMgr:canUseSkill() then
		return
	end

	local cd = FightDataHelper.paTaMgr:getCurCD()

	if cd and cd > 0 then
		return
	end

	local useSkill = FightDataHelper.paTaMgr:getCurUseSkillInfo()

	if not useSkill then
		return
	end

	local needPower = FightDataHelper.paTaMgr:getNeedPower(useSkill)
	local power = FightDataHelper.paTaMgr:getAssistBossPower()

	if power < needPower then
		return
	end

	return useSkill
end

FightAssistBossBase.Duration = 0.5

function FightAssistBossBase:setFillAmount(image, targetValue)
	self:killTween()

	if not image then
		self.curImage = nil

		return
	end

	local curValue = image.fillAmount

	self.curImage = image
	self.tweenId = ZProj.TweenHelper.DOTweenFloat(curValue, targetValue, FightAssistBossBase.Duration, self.onFrameCallback, nil, self, nil, EaseType.Linear)
end

function FightAssistBossBase:onFrameCallback(value)
	self.curImage.fillAmount = value
end

function FightAssistBossBase:killTween()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)
	end
end

function FightAssistBossBase:destroy()
	self:killTween()

	if self.headSImage then
		self.headSImage:UnLoadImage()
	end

	if self.loader then
		self.loader:dispose()

		self.loader = nil
	end

	if self.longListener then
		self.longListener:RemoveClickListener()
		self.longListener:RemoveLongPressListener()

		self.longListener = nil
	end

	self.loadDone = false

	self:__onDispose()
end

return FightAssistBossBase
