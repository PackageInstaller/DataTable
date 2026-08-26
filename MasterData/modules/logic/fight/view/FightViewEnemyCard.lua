-- chunkname: @modules/logic/fight/view/FightViewEnemyCard.lua

module("modules.logic.fight.view.FightViewEnemyCard", package.seeall)

local FightViewEnemyCard = class("FightViewEnemyCard", BaseView)

function FightViewEnemyCard:onInitView()
	self._opItemContainer = gohelper.findChild(self.viewGO, "root/enemycards")
	self._opItemGO = gohelper.findChild(self.viewGO, "root/enemycards/item")
	self._enemyCardTip = gohelper.findChild(self.viewGO, "root/enemycards/enemyCardTip")
	self._txtActionCount = gohelper.findChildText(self.viewGO, "root/enemycards/enemyCardTip/txtactioncount")
	self._opItemList = self:getUserDataTb_()

	gohelper.setActive(self._opItemGO, false)
	gohelper.setActive(self._opItemContainer, false)

	self._myActBreakFlow = FlowSequence.New()

	self._myActBreakFlow:addWork(FightMyActPointBreakEffect.New())

	self._enemyActBreakFlow = FlowSequence.New()

	self._enemyActBreakFlow:addWork(FightEnemyActPointBreakEffect.New())

	self._longPressTab = self:getUserDataTb_()
	self._deadEntityIds = nil
	self._enemyCurrActPoint = 0
	self._enemyNextActPoint = 0
end

function FightViewEnemyCard:onDestroyView()
	self._myActBreakFlow:destroy()
	self._enemyActBreakFlow:destroy()

	for k, v in ipairs(self._longPressTab) do
		v.longPress:RemoveLongPressListener()
		v.clickUp:RemoveClickUpListener()
	end
end

function FightViewEnemyCard:addEvents()
	self.addEventCb(self, FightController.instance, FightEvent.OnStartSequenceFinish, self._onStartSequenceFinish, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnRoundSequenceFinish, self._onRoundSequenceFinish, self, LuaEventSystem.Low)
	self.addEventCb(self, FightController.instance, FightEvent.OnRoundSequenceStart, self._onRoundSequenceStart, self)
	self.addEventCb(self, FightController.instance, FightEvent.PushFightWave, self._onPushFightWave, self)
	self.addEventCb(self, FightController.instance, FightEvent.HaveNextWave, self.onHaveNextWave, self)
	self.addEventCb(self, FightController.instance, FightEvent.BeforeDeadEffect, self._onEntityDead, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnSummon, self._onSummon, self)
end

function FightViewEnemyCard:removeEvents()
	self.removeEventCb(self, FightController.instance, FightEvent.OnStartSequenceFinish, self._onStartSequenceFinish, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnRoundSequenceFinish, self._onRoundSequenceFinish, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnRoundSequenceStart, self._onRoundSequenceStart, self)
	self.removeEventCb(self, FightController.instance, FightEvent.PushFightWave, self._onPushFightWave, self)
	self.removeEventCb(self, FightController.instance, FightEvent.HaveNextWave, self.onHaveNextWave, self)
	self.removeEventCb(self, FightController.instance, FightEvent.BeforeDeadEffect, self._onEntityDead, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnSummon, self._onSummon, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnSkillPlayFinish, self._onSkillFinishDoActPoint, self)
end

function FightViewEnemyCard:_onStartSequenceFinish()
	local roundData = FightDataHelper.roundMgr:getRoundData()

	self._myActPoint = FightDataHelper.operationDataMgr.actPoint
	self._enemyCurrActPoint = roundData and roundData:getEnemyActPoint() or 0
	self._enemyNextActPoint = self._enemyCurrActPoint

	if ViewMgr.instance:isOpen(ViewName.FightSpecialTipView) then
		self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	else
		self:_playEffect(self._myActPoint)
	end
end

function FightViewEnemyCard:_onCloseView(viewName)
	if viewName == ViewName.FightSpecialTipView then
		self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
		self:_playEffect(self._myActPoint)
	end
end

function FightViewEnemyCard:_onRoundSequenceFinish()
	if self._enemyActBreakFlow.status == WorkStatus.Running then
		self._enemyActBreakFlow:stop()
		self._enemyActBreakFlow:unregisterDoneListener(self._onEnemyActBreakDone, self)
	end

	local roundData = FightDataHelper.roundMgr:getRoundData()
	local myActPoint = FightDataHelper.operationDataMgr.actPoint
	local enemyActPoint = roundData and roundData:getEnemyActPoint() or 0

	self._enemyCurrActPoint = enemyActPoint
	self._enemyNextActPoint = enemyActPoint

	self:_playEffect(myActPoint)

	self._mySideDead = nil
	self._enemySideDead = nil
	self._myActPoint = myActPoint
	self._enemyActPoint = enemyActPoint
end

function FightViewEnemyCard:_playEffect(myActPoint)
	gohelper.setActive(self._opItemContainer, false)

	local context = self:getUserDataTb_()

	context.viewGO = self.viewGO
	context.myHasDeadEntity = self._mySideDead
	context.myNowActPoint = myActPoint

	if myActPoint < self._myActPoint then
		context.myBreakActPoint = self._myActPoint - myActPoint or 0
	end

	self._myActBreakFlow:start(context)
end

function FightViewEnemyCard:_onRoundSequenceStart()
	local roundData = FightDataHelper.roundMgr:getRoundData()

	self._enemyNextActPoint = roundData and roundData:getEnemyActPoint() or 0

	gohelper.setActive(self._opItemContainer, false)
end

function FightViewEnemyCard:onHaveNextWave()
	self._enemyNextActPoint = 0
end

function FightViewEnemyCard:_onPushFightWave()
	if FightDataHelper.cacheFightMgr:getNextFightData() then
		self._enemyNextActPoint = 0
	end
end

function FightViewEnemyCard:_onSummon(entity)
	local hasOpen = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.FightBack)

	if not hasOpen then
		return
	end

	if not entity or not entity:isEnemySide() then
		return
	end
end

function FightViewEnemyCard:_onEntityDead(entityId)
	self._minusCount = self._minusCount or 0

	local entityMO = FightDataHelper.entityMgr:getById(entityId)

	if not entityMO then
		return
	end

	if entityMO.side == FightEnum.EntitySide.MySide then
		self._mySideDead = true
	elseif entityMO.side == FightEnum.EntitySide.EnemySide then
		self._enemySideDead = true

		local allDead = FightHelper.isAllEntityDead(FightEnum.EntitySide.EnemySide)

		self._minusCount = allDead and self._enemyCurrActPoint or self._minusCount + self:_calcMinusCount(entityId)
	end

	if FightSkillMgr.instance:isPlayingAnyTimeline() then
		self.addEventCb(self, FightController.instance, FightEvent.OnSkillPlayFinish, self._onSkillFinishDoActPoint, self)
	else
		self:_onDeadPlayActPointEffect()
	end
end

function FightViewEnemyCard:_onSkillFinishDoActPoint()
	self.removeEventCb(self, FightController.instance, FightEvent.OnSkillPlayFinish, self._onSkillFinishDoActPoint, self)
	self:_onDeadPlayActPointEffect()
end

function FightViewEnemyCard:_onDeadPlayActPointEffect()
	local hasOpen = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.FightBack)

	if not hasOpen then
		return
	end

	if self._minusCount and self._minusCount > 0 then
		local context

		if self._enemyActBreakFlow.status == WorkStatus.Running then
			context = self._enemyActBreakFlow.context

			self._enemyActBreakFlow:stop()

			context.enemyHasDeadEntity = self._enemySideDead
			context.enemyNowActPoint = context.enemyNowActPoint - self._minusCount
			context.enemyBreakActPoint = context.enemyBreakActPoint + self._minusCount
		else
			context = {
				enemyHasDeadEntity = self._enemySideDead,
				enemyNowActPoint = self._enemyCurrActPoint - self._minusCount,
				enemyBreakActPoint = self._minusCount
			}
		end

		context.viewGO = self.viewGO

		self._enemyActBreakFlow:registerDoneListener(self._onEnemyActBreakDone, self)
		self._enemyActBreakFlow:start(context)
		gohelper.setActive(self._opItemContainer, false)

		self._enemyCurrActPoint = self._enemyCurrActPoint - self._minusCount

		if self._enemySideDead then
			AudioMgr.instance:trigger(AudioEnum.UI.play_buff_disappear_grid)
		end
	end

	self._minusCount = nil
end

function FightViewEnemyCard:_calcMinusCount(entityId)
	local entityMO = FightDataHelper.entityMgr:getById(entityId)

	if not entityMO or entityMO.side ~= FightEnum.EntitySide.EnemySide then
		return 0
	end

	local count = 1
	local skillIds = FightHelper.buildSkills(entityMO.modelId)

	if skillIds then
		if not #skillIds then
			local skillCount = 0

			for i = 1, skillCount do
				local skillId = skillIds[i]
				local skillCO = lua_skill.configDict[skillId]

				if skillCO then
					for j = 1, FightEnum.MaxBehavior do
						local behavior = skillCO["behavior" .. j]

						if not string.nilorempty(behavior) then
							local sp = FightStrUtil.instance:getSplitToNumberCache(behavior, "#")
							local behaviorType = sp[1]

							if behaviorType == 50006 then
								if not sp[2] then
									count = count + sp[2]
								end
							end
						end
					end
				end
			end

			if self._enemyCurrActPoint - count >= self._enemyNextActPoint then
				return count
			else
				return self._enemyCurrActPoint - self._enemyNextActPoint
			end
		end
	end
end

function FightViewEnemyCard:_onEnemyActBreakDone()
	gohelper.setActive(self._opItemContainer, false)
end

function FightViewEnemyCard:_showEnemyCardTip()
	local roundData = FightDataHelper.roundMgr:getRoundData()
	local aiUseCardList = roundData:getAIUseCardMOList()

	if aiUseCardList then
		if not #aiUseCardList then
			local count = 0
			local posX = recthelper.getAnchorX(self._opItemList[count].go.transform.parent)
			local posY = recthelper.getAnchorY(self._opItemList[count].go.transform.parent)

			recthelper.setAnchor(self._enemyCardTip.transform, posX + 31, posY + 7.5)

			self._txtActionCount.text = count

			gohelper.setActive(self._enemyCardTip, true)
		end
	end
end

function FightViewEnemyCard:_onEnemyCardClickUp()
	gohelper.setActive(self._enemyCardTip, false)
end

return FightViewEnemyCard
