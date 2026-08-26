-- chunkname: @modules/logic/fight/mgr/FightCheckCrashMgr.lua

module("modules.logic.fight.mgr.FightCheckCrashMgr", package.seeall)

local FightCheckCrashMgr = class("FightCheckCrashMgr", FightBaseClass)

function FightCheckCrashMgr:onConstructor()
	self.ingoreViewNameDic = {
		[ViewName.StoryView] = true,
		[ViewName.FightSpecialTipView] = true,
		[ViewName.FightFocusView] = true,
		[ViewName.GuideView] = true,
		[ViewName.FightGuideView] = true,
		[ViewName.FightTechniqueGuideView] = true,
		[ViewName.HelpView] = true,
		[ViewName.FightSystemFightNoticeView] = true
	}
end

function FightCheckCrashMgr:startCheck()
	self.timer = self:com_registRepeatTimer(self.tick, 5, -1)

	self:com_registEvent(ViewMgr.instance, ViewEvent.OnCloseView, self.onCloseView)
	self:com_registFightEvent(FightEvent.FightDialogEnd, self.onFightDialogEnd)
	self:com_registFightEvent(FightEvent.StageChanged, self.onStageChanged)
end

function FightCheckCrashMgr:onCloseView(viewName)
	if self.ingoreViewNameDic[viewName] then
		self.lastCounter = -1
	end
end

function FightCheckCrashMgr:onFightDialogEnd()
	self.lastCounter = -1
end

function FightCheckCrashMgr:onStageChanged(stage)
	if stage == FightStageMgr.StageType.Play then
		self.play2Operating = false
		self.lastCounter = -1
	end
end

function FightCheckCrashMgr:tick()
	if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
		return
	end

	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Operate then
		return
	end

	if self.play2Operating then
		return
	end

	if self.lastCounter ~= FightObject.Counter then
		self.lastCounter = FightObject.Counter

		return
	end

	if FightViewDialog.playingDialog then
		return
	end

	for viewName, _ in pairs(self.ingoreViewNameDic) do
		if ViewMgr.instance:isOpen(viewName) then
			return
		end
	end

	for entityId, entity in pairs(FightGameMgr.entityMgr.entityDic) do
		if entity.skill then
			local workComp = entity.skill.workComp

			if workComp then
				local aliveWorkList = workComp:getAliveWorkList()

				if #aliveWorkList > 0 then
					for _, work in ipairs(aliveWorkList) do
						work:registFinishCallback(self.onTimelineWorkFinish, self)
					end

					return
				end
			end
		end
	end

	logError("战斗可能卡住了,强刷下战场")

	if FightModel.instance:isFinish() then
		self.timer.isDone = true

		FightRpc.instance:sendEndFightRequest(false)

		return
	end

	self:forceRefreshFight()
end

function FightCheckCrashMgr:forceRefreshFight()
	local flow = self:com_registFlowSequence()

	flow:registWork(FightWorkRefreshFightAfterCrash)
	flow:registWork(FightWorkPlay2Operate)
	flow:registFinishCallback(self.onRefreshAfterCrash, self)
	flow:start()
end

function FightCheckCrashMgr:onRefreshAfterCrash()
	self.lastCounter = -1
end

function FightCheckCrashMgr:onTimelineWorkFinish(work)
	self.lastCounter = -1
end

function FightCheckCrashMgr:play2Operate()
	self.play2Operating = true
end

function FightCheckCrashMgr:playEndFight()
	self:killComponent(FightTimerComponent)
	self:killComponent(FightEventComponent)
	self:killComponent(FightMsgComponent)
end

function FightCheckCrashMgr:onDestructor()
	return
end

return FightCheckCrashMgr
