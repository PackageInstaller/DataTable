-- chunkname: @modules/logic/fight/view/FightAssistRoleView.lua

module("modules.logic.fight.view.FightAssistRoleView", package.seeall)

local FightAssistRoleView = class("FightAssistRoleView", UserDataDispose)
local prefabPath = "ui/viewres/fight/fighttower/fightassistroleview.prefab"
local State = {
	Using = 3,
	CanUse = 2,
	CanNotUse = 1
}
local StateIdleAnim = {
	[State.CanNotUse] = "unfull_idle",
	[State.CanUse] = "canuse_idle",
	[State.Using] = "using_idle"
}
local SwitchAnim = {
	[State.CanNotUse] = {
		[State.CanUse] = "unfull_canuse"
	},
	[State.CanUse] = {
		[State.Using] = "canuse_using"
	},
	[State.Using] = {
		[State.CanNotUse] = "using_unfull",
		[State.CanUse] = "using_canuse"
	}
}
local AudioIdDict = {
	unfull_canuse = 20270004
}
local propertyId = UnityEngine.Shader.PropertyToID("_LerpOffset")

function FightAssistRoleView:init(goContainer)
	self:__onInit()

	self.goContainer = goContainer
	self.tweenValue = 0
	self.assistBoss = FightDataHelper.entityMgr:getAssistBoss()
	self.assistBossUid = self.assistBoss.uid

	loadAbAsset(prefabPath, false, self.onLoadCallback, self)
end

function FightAssistRoleView:onLoadCallback(assetItem)
	if assetItem.IsLoadSuccess then
		local oldAsstet = self._assetItem

		self._assetItem = assetItem

		self._assetItem:Retain()

		if oldAsstet then
			oldAsstet:Release()
		end

		self.instanceGo = gohelper.clone(self._assetItem:GetResource(prefabPath), self.goContainer)
		self.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.instanceGo)
		self.imageCareer = gohelper.findChildImage(self.instanceGo, "root/imgCareerIcon")
		self.goUnFull = gohelper.findChild(self.instanceGo, "root/unFull")
		self.goCanUse = gohelper.findChild(self.instanceGo, "root/canUse")
		self.goUsing = gohelper.findChild(self.instanceGo, "root/Using")

		gohelper.setActive(self.goUnFull, true)
		gohelper.setActive(self.goCanUse, true)
		gohelper.setActive(self.goUsing, true)

		self.simageBoss1 = gohelper.findChildSingleImage(self.goUnFull, "#simage_boss")
		self.trBoss1 = gohelper.findChildComponent(self.goUnFull, "#simage_boss", gohelper.Type_Transform)
		self.simageBoss2 = gohelper.findChildSingleImage(self.goCanUse, "#simage_boss")
		self.simageBoss3 = gohelper.findChildSingleImage(self.goUsing, "#simage_boss")
		self.rectBar = gohelper.findChildComponent(self.goUnFull, "#bar_mask/bar", gohelper.Type_RectTransform)
		self.rectTrDesc = gohelper.findChildComponent(self.goUnFull, "image_dec", gohelper.Type_RectTransform)

		local goClickArea = gohelper.findChild(self.instanceGo, "root/#btn_clickarea")

		self.longListener = SLFramework.UGUI.UILongPressListener.Get(goClickArea)

		self.longListener:SetLongPressTime({
			0.5,
			99999
		})
		self.longListener:AddLongPressListener(self.onLongPress, self)
		self.longListener:AddClickListener(self.onClick, self)
		self.addEventCb(self, FightController.instance, FightEvent.PowerChange, self.onPowerChange, self)
		self.addEventCb(self, FightController.instance, FightEvent.OnResetCard, self.onResetCard, self)
		self.addEventCb(self, FightController.instance, FightEvent.StageChanged, self.onStageChange, self)

		local assistBoss = FightDataHelper.entityMgr:getAssistBoss()
		local assistBossConfig = TowerComposeConfig.instance:getSupportCo(assistBoss.modelId)

		self.isPassive = assistBossConfig and assistBossConfig.activeType == 2

		self:refreshHeadIcon()
		self:refreshUI()
		self:playIdleAnim()
	end
end

function FightAssistRoleView:onStageChange(stage)
	if stage == FightStageMgr.StageType.Operate then
		self:tryChangeState()
	end
end

function FightAssistRoleView:tryChangeState()
	local preState = self.curState
	local curState = self:getCurState()
	local switchAnim = SwitchAnim[preState][curState]

	self:refreshUI()

	if switchAnim then
		self:playSwitchAnim(switchAnim)

		local audioId = AudioIdDict[switchAnim]

		if audioId then
			AudioMgr.instance:trigger(audioId)
		end
	else
		self:playIdleAnim()
	end
end

function FightAssistRoleView:onPowerChange(entityId, powerId)
	if entityId ~= self.assistBossUid then
		return
	end

	self:tryChangeState()
end

function FightAssistRoleView:onResetCard()
	self:tryChangeState()
end

function FightAssistRoleView:onLongPress()
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

function FightAssistRoleView:onClick()
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

	if self.isPassive then
		return
	end

	local curState = self:getCurState()

	if curState == State.Using then
		return
	end

	local useSkill = self:getCanUseSkill(true)

	if not useSkill then
		return
	end

	AudioMgr.instance:trigger(20270005)

	local op = FightDataHelper.operationDataMgr:newOperation()

	op:playAssistBossHandCard(useSkill.skillId)
	FightController.instance:dispatchEvent(FightEvent.AddPlayOperationData, op)
	FightController.instance:dispatchEvent(FightEvent.onNoActCostMoveFlowOver)
	FightController.instance:dispatchEvent(FightEvent.RefreshPlayCardRoundOp, op)
	FightController.instance:dispatchEvent(FightEvent.OnPlayAssistBossCardFlowDone, op)
	FightDataHelper.paTaMgr:playAssistBossSkill(useSkill)
	self:tryChangeState()
end

function FightAssistRoleView:refreshUI()
	self.curState = self:getCurState()

	self:refreshProgress()
	self:refreshHeadIconGray()
end

function FightAssistRoleView:playIdleAnim()
	local curState = self:getCurState()
	local idleAnim = StateIdleAnim[curState]

	if not idleAnim then
		logError("idle anim not exist ? " .. tostring(curState))

		idleAnim = StateIdleAnim[State.CanNotUse]
	end

	self.animatorPlayer:Play(idleAnim)
end

function FightAssistRoleView:playSwitchAnim(animName)
	self.animatorPlayer:Play(animName, self.playIdleAnim, self)
end

function FightAssistRoleView:clearTween()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end
end

FightAssistRoleView.TweenDuration = 0.3

function FightAssistRoleView:refreshProgress()
	self:clearTween()

	local curProgress = self:getCurProgress()

	self.tweenId = ZProj.TweenHelper.DOTweenFloat(self.tweenValue, curProgress, FightAssistRoleView.TweenDuration, self.onTweenFrameCallback, self.onTweenDoneCallback, self)
end

function FightAssistRoleView:getCurProgress()
	local skillInfo = FightDataHelper.paTaMgr:getCurAreaSkillInfo()

	if not skillInfo then
		logError("not found can use skill")

		return 1
	end

	local needPower = FightDataHelper.paTaMgr:getNeedPower(skillInfo)
	local power = FightDataHelper.paTaMgr:getAssistBossPower()

	if needPower < 1 then
		return 1
	end

	return power / needPower
end

FightAssistRoleView.MinAnchor = -116
FightAssistRoleView.MaxAnchor = 0

function FightAssistRoleView:directSetProgress(value)
	self.tweenValue = value

	local anchorY = Mathf.Lerp(FightAssistRoleView.MinAnchor, FightAssistRoleView.MaxAnchor, value)

	anchorY = Mathf.Clamp(anchorY, FightAssistRoleView.MinAnchor, FightAssistRoleView.MaxAnchor)

	recthelper.setAnchorY(self.rectBar, anchorY)
end

function FightAssistRoleView:onTweenFrameCallback(value)
	self:directSetProgress(value)
end

function FightAssistRoleView:onTweenDoneCallback()
	local curProgress = self:getCurProgress()

	self:directSetProgress(curProgress)

	self.tweenId = nil
end

function FightAssistRoleView:refreshHeadIcon()
	local assistRole = FightDataHelper.entityMgr:getAssistBoss()
	local skin = assistRole and assistRole.skin

	if skin then
		::label_18_0::

		local skinCo = FightConfig.instance:getSkinCO(skin)
		local headIcon = skinCo and skinCo.headIcon

		if string.nilorempty(headIcon) then
			return
		end

		local url = ResUrl.getHeadIconSmall(headIcon)

		self.simageBoss1:LoadImage(url)
		self.simageBoss2:LoadImage(url)
		self.simageBoss3:LoadImage(url)
		UISpriteSetMgr.instance:setCommonSprite(self.imageCareer, "sx_icon_" .. tostring(assistRole.career))
	end
end

function FightAssistRoleView:refreshHeadIconGray()
	local curState = self.curState
	local isGray = curState == State.CanNotUse
	local x, y, z = transformhelper.getLocalPos(self.trBoss1)

	transformhelper.setLocalPos(self.trBoss1, x, y, isGray and 1 or 0)
end

function FightAssistRoleView:getCurState()
	if self.isPassive then
		return State.Using
	end

	local useCardCount = FightDataHelper.paTaMgr:getUseCardCount()

	if useCardCount > 0 then
		return State.Using
	end

	if not self:getCanUseSkill() then
		return State.CanNotUse
	end

	return State.CanUse
end

function FightAssistRoleView:getCanUseSkill(floatError)
	local useSkill = FightDataHelper.paTaMgr:getCurAreaSkillInfo()

	if not useSkill then
		return
	end

	local needPower = FightDataHelper.paTaMgr:getNeedPower(useSkill)
	local power = FightDataHelper.paTaMgr:getAssistBossPower()

	if power < needPower then
		if floatError then
			GameFacade.showToast(ToastEnum.FightAssistRoleView_331018)
		end

		return
	end

	if not FightDataHelper.paTaMgr:canUseSkill() then
		return
	end

	local cd = FightDataHelper.paTaMgr:getCurCD()

	if cd and cd > 0 then
		if floatError then
			GameFacade.showToast(ToastEnum.FightAssistRoleView_30)
		end

		return
	end

	return useSkill
end

function FightAssistRoleView:destroy()
	removeAssetLoadCb(prefabPath, self._onLoadCallback, self)

	if self._assetItem then
		self._assetItem:Release()

		self._assetItem = nil
	end

	if self.simageBoss1 then
		self.simageBoss1:UnLoadImage()

		self.simageBoss1 = nil
	end

	if self.simageBoss2 then
		self.simageBoss2:UnLoadImage()

		self.simageBoss2 = nil
	end

	if self.simageBoss3 then
		self.simageBoss3:UnLoadImage()

		self.simageBoss3 = nil
	end

	if self.longListener then
		self.longListener:RemoveClickListener()
		self.longListener:RemoveLongPressListener()

		self.longListener = nil
	end

	if self.animatorPlayer then
		self.animatorPlayer:Stop()
	end

	self:clearTween()
	self:__onDispose()
end

return FightAssistRoleView
