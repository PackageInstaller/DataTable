-- chunkname: @modules/logic/fight/view/FightEnemyEntityAiUseCardView.lua

module("modules.logic.fight.view.FightEnemyEntityAiUseCardView", package.seeall)

local FightEnemyEntityAiUseCardView = class("FightEnemyEntityAiUseCardView", FightBaseView)

function FightEnemyEntityAiUseCardView:onConstructor(entityData)
	self.entityData = entityData
	self.entityId = entityData.id
	self.aiUseCardList = FightDataHelper.entityExMgr:getById(self.entityId).aiUseCardList
end

function FightEnemyEntityAiUseCardView:onInitView()
	self.itemObj = gohelper.findChild(self.viewGO, "item")
	self._opContainerCanvasGroup = gohelper.onceAddComponent(self.viewGO, typeof(UnityEngine.CanvasGroup))

	gohelper.setActive(self._opItemGO, false)

	self.itemList = self:com_registViewItemList(self.itemObj, FightEnemyEntityAiUseCardItemView, self.viewGO)
end

function FightEnemyEntityAiUseCardView:addEvents()
	self:com_registMsg(FightMsgId.RefreshEnemyAiUseCard, self.onRefreshEnemyAiUseCard)
	self:com_registMsg(FightMsgId.GetEnemyAiUseCardItemList, self.onGetEnemyAiUseCardItemList)
	self:com_registFightEvent(FightEvent.OnExPointChange, self.onExPointChange)
	self:com_registFightEvent(FightEvent.BeforePlayTimeline, self.beforePlaySkill)
	self:com_registFightEvent(FightEvent.OnMySideRoundEnd, self.onMySideRoundEnd)
	self:com_registFightEvent(FightEvent.GMHideFightView, self.checkGMHideUI)
	self:com_registFightEvent(FightEvent.OnStartSequenceFinish, self.onStartSequenceFinish)
	self:com_registFightEvent(FightEvent.OnRoundSequenceFinish, self.onRoundSequenceFinish)
end

function FightEnemyEntityAiUseCardView:onOpen()
	self.itemList:setDataList(self.aiUseCardList)
end

function FightEnemyEntityAiUseCardView:onRefreshEnemyAiUseCard()
	self.itemList:setDataList(self.aiUseCardList)
end

function FightEnemyEntityAiUseCardView:onGetEnemyAiUseCardItemList(entityId)
	if entityId ~= self.entityId then
		return
	end

	FightMsgMgr.replyMsg(FightMsgId.GetEnemyAiUseCardItemList, self.itemList)

	return self.itemList
end

function FightEnemyEntityAiUseCardView:showOpContainer(hideDelay)
	self:checkGMHideUI()

	if not gohelper.isNil(self._opContainerCanvasGroup) then
		self._opContainerCanvasGroup.alpha = 1
	end

	if hideDelay and hideDelay > 0 then
		self:com_registSingleTimer(self.hideOpContainer, hideDelay)
	end
end

function FightEnemyEntityAiUseCardView:hideOpContainer()
	if not gohelper.isNil(self._opContainerCanvasGroup) then
		self._opContainerCanvasGroup.alpha = 0
	end
end

function FightEnemyEntityAiUseCardView:onExPointChange()
	gohelper.setActive(self._opContainerCanvasGroup.gameObject, GMFightShowState.enemyOp)
end

function FightEnemyEntityAiUseCardView:checkGMHideUI()
	gohelper.setActive(self._opContainerCanvasGroup.gameObject, GMFightShowState.enemyOp)
end

function FightEnemyEntityAiUseCardView:beforePlaySkill()
	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.ClothSkill) then
		return
	end

	self:hideOpContainer()
end

function FightEnemyEntityAiUseCardView:onMySideRoundEnd()
	self:showOpContainer()
end

function FightEnemyEntityAiUseCardView:onStartSequenceFinish()
	self:showOpContainer()
end

function FightEnemyEntityAiUseCardView:onRoundSequenceFinish()
	self:showOpContainer()
end

return FightEnemyEntityAiUseCardView
