-- chunkname: @modules/logic/versionactivity2_5/challenge/view/dungeon/Act183DungeonView_Animation.lua

module("modules.logic.versionactivity2_5.challenge.view.dungeon.Act183DungeonView_Animation", package.seeall)

local Act183DungeonView_Animation = class("Act183DungeonView_Animation", BaseView)
local FinishAnimDuration = 0.667
local RepressAnimDuration = 1.167

function Act183DungeonView_Animation:onInitView()
	self._gomiddle = gohelper.findChild(self.viewGO, "root/middle")
	self._goline1 = gohelper.findChild(self.viewGO, "root/#go_line1")
	self._goline2 = gohelper.findChild(self.viewGO, "root/#go_line2")
	self._goline3 = gohelper.findChild(self.viewGO, "root/#go_line3")
	self._gocompleted = gohelper.findChild(self.viewGO, "root/middle/#go_Completed")
	self._godailycompleted = gohelper.findChild(self.viewGO, "root/middle/#go_DailyCompleted")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act183DungeonView_Animation:addEvents()
	self.addEventCb(self, Act183Controller.instance, Act183Event.OnUpdateRepressInfo, self._onUpdateRepressInfo, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self.addEventCb(self, Act183Controller.instance, Act183Event.FightBossIfSubUnfinish, self._onFightBossIfSubUnfinish, self)
end

function Act183DungeonView_Animation:removeEvents()
	return
end

function Act183DungeonView_Animation:_editableInitView()
	self._lineEffectPool = self:getUserDataTb_()
	self._useLineEffectPool = self:getUserDataTb_()
	self._animcompleted = gohelper.onceAddComponent(self._gocompleted, gohelper.Type_Animator)
	self._animdailycompleted = gohelper.onceAddComponent(self._godailycompleted, gohelper.Type_Animator)

	self:_buildConfigToOrderAnimTypeMap()
	self:_buildConfigToTemplateMap()
end

function Act183DungeonView_Animation:_buildConfigToOrderAnimTypeMap()
	self._orderToAnimTypeMap = {}

	self:_addConfigToOrderAnimTypeMap(1, 2, Act183Enum.RuleEscapeAnimType.Left2Right)
	self:_addConfigToOrderAnimTypeMap(2, 1, Act183Enum.RuleEscapeAnimType.Right2Left)
	self:_addConfigToOrderAnimTypeMap(1, 3, Act183Enum.RuleEscapeAnimType.Top2Bottom)
	self:_addConfigToOrderAnimTypeMap(3, 1, Act183Enum.RuleEscapeAnimType.Bottom2Top)
	self:_addConfigToOrderAnimTypeMap(1, 4, Act183Enum.RuleEscapeAnimType.LeftTop2RightBottom)
	self:_addConfigToOrderAnimTypeMap(4, 1, Act183Enum.RuleEscapeAnimType.RightBottom2LeftTop)
	self:_addConfigToOrderAnimTypeMap(2, 3, Act183Enum.RuleEscapeAnimType.RightTop2LeftBottom)
	self:_addConfigToOrderAnimTypeMap(3, 2, Act183Enum.RuleEscapeAnimType.LeftBottom2RightTop)
	self:_addConfigToOrderAnimTypeMap(3, 4, Act183Enum.RuleEscapeAnimType.Left2Right)
	self:_addConfigToOrderAnimTypeMap(4, 3, Act183Enum.RuleEscapeAnimType.Right2Left)
	self:_addConfigToOrderAnimTypeMap(2, 4, Act183Enum.RuleEscapeAnimType.Top2Bottom)
	self:_addConfigToOrderAnimTypeMap(4, 2, Act183Enum.RuleEscapeAnimType.Bottom2Top)
	self:_addConfigToOrderAnimTypeMap(1, 101, Act183Enum.RuleEscapeAnimType.LeftTop2Center)
	self:_addConfigToOrderAnimTypeMap(2, 101, Act183Enum.RuleEscapeAnimType.RightTop2Center)
	self:_addConfigToOrderAnimTypeMap(3, 101, Act183Enum.RuleEscapeAnimType.LeftBottom2Center)
	self:_addConfigToOrderAnimTypeMap(4, 101, Act183Enum.RuleEscapeAnimType.RightBottom2Center)
end

function Act183DungeonView_Animation:_buildConfigToTemplateMap()
	self._lineTemplateMap = self:getUserDataTb_()

	self:_addConfigToTemplateMap(Act183Enum.RuleEscapeAnimType.Top2Bottom, self._goline1)
	self:_addConfigToTemplateMap(Act183Enum.RuleEscapeAnimType.Bottom2Top, self._goline1)
	self:_addConfigToTemplateMap(Act183Enum.RuleEscapeAnimType.Left2Right, self._goline2)
	self:_addConfigToTemplateMap(Act183Enum.RuleEscapeAnimType.Right2Left, self._goline2)
	self:_addConfigToTemplateMap(Act183Enum.RuleEscapeAnimType.LeftTop2RightBottom, self._goline3)
	self:_addConfigToTemplateMap(Act183Enum.RuleEscapeAnimType.RightTop2LeftBottom, self._goline3)
	self:_addConfigToTemplateMap(Act183Enum.RuleEscapeAnimType.LeftBottom2RightTop, self._goline3)
	self:_addConfigToTemplateMap(Act183Enum.RuleEscapeAnimType.RightBottom2LeftTop, self._goline3)
	self:_addConfigToTemplateMap(Act183Enum.RuleEscapeAnimType.LeftTop2Center, self._goline1)
	self:_addConfigToTemplateMap(Act183Enum.RuleEscapeAnimType.RightTop2Center, self._goline1)
	self:_addConfigToTemplateMap(Act183Enum.RuleEscapeAnimType.LeftBottom2Center, self._goline1)
	self:_addConfigToTemplateMap(Act183Enum.RuleEscapeAnimType.RightBottom2Center, self._goline1)
end

function Act183DungeonView_Animation:_addConfigToTemplateMap(animType, goline)
	self._lineTemplateMap[animType] = self:getUserDataTb_()

	table.insert(self._lineTemplateMap[animType], goline)
end

function Act183DungeonView_Animation:_addConfigToOrderAnimTypeMap(startOrder, endOrder, animType)
	local key = string.format("%s_%s", startOrder, endOrder)

	self._orderToAnimTypeMap[key] = animType
end

function Act183DungeonView_Animation:checkIfNeedPlayEffect()
	local isTop = ViewHelper.instance:checkViewOnTheTop(self.viewName)

	if not isTop or self:isRunningEffectFlow() then
		return
	end

	local finishedEpisodeId = Act183Model.instance:getNewFinishEpisodeId()

	if finishedEpisodeId ~= nil then
		if not FinishAnimDuration then
			local waitSeconds = 0

			self:destroyFlow()

			self._flow = FlowSequence.New()

			self._flow:addWork(FunctionWork.New(self._lockScreen, self, true))
			self._flow:addWork(FunctionWork.New(self.checkIfNeedPlayFinishEffect, self))
			self._flow:addWork(FunctionWork.New(self.checkIfNeedPlayGroupFinishEffect, self))
			self._flow:addWork(FunctionWork.New(self.checkIfNeedPlayGroupCategoryFinishAnim, self))
			self._flow:addWork(WorkWaitSeconds.New(waitSeconds))
			self._flow:addWork(FunctionWork.New(self.checkIfNeedPlayRepressEffect, self))
			self._flow:addWork(WorkWaitSeconds.New(RepressAnimDuration))
			self._flow:addWork(FunctionWork.New(self._recycleLines, self))
			self._flow:addWork(FunctionWork.New(self._lockScreen, self, false))
			self._flow:registerDoneListener(self._onPlayEffectDone, self)
			self._flow:start({
				episodeId = finishedEpisodeId
			})
		end
	end
end

function Act183DungeonView_Animation:isRunningEffectFlow()
	return self._flow and self._flow.status == WorkStatus.Running
end

function Act183DungeonView_Animation:_onPlayEffectDone()
	Act183Model.instance:clearBattleFinishedInfo()
end

function Act183DungeonView_Animation:destroyFlow()
	if self._flow then
		self._flow:destroy()

		self._flow = nil
	end
end

function Act183DungeonView_Animation:_lockScreen(lock)
	if lock then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("Act183DungeonView_Animation_PlayAnim")
	else
		UIBlockMgr.instance:endBlock("Act183DungeonView_Animation_PlayAnim")
		UIBlockMgrExtend.setNeedCircleMv(true)
	end
end

function Act183DungeonView_Animation:checkIfNeedPlayRepressEffect()
	local repressEpisodeId = Act183Model.instance:getRecordLastRepressEpisodeId()

	if not repressEpisodeId or repressEpisodeId == 0 then
		return
	end

	local repressEpisodeMo = Act183Model.instance:getEpisodeMoById(repressEpisodeId)

	self:_playRuleRepressEffect(repressEpisodeMo)
	Act183Model.instance:clearRecordLastRepressEpisodeId()
end

function Act183DungeonView_Animation:checkIfNeedPlayGroupFinishEffect()
	local newFinishGroupId = Act183Model.instance:getNewFinishGroupId()

	if not newFinishGroupId or self._lastFinishGroupId == newFinishGroupId then
		return
	end

	local newFinishGroupMo = Act183Model.instance:getGroupEpisodeMo(newFinishGroupId)
	local groupType = newFinishGroupMo and newFinishGroupMo:getGroupType()

	if groupType == Act183Enum.GroupType.Daily then
		gohelper.setActive(self._godailycompleted, true)
		self._animdailycompleted:Play("in", 0, 0)
	else
		gohelper.setActive(self._gocompleted, true)
		self._animcompleted:Play("in", 0, 0)
	end

	self._lastFinishGroupId = newFinishGroupId

	AudioMgr.instance:trigger(AudioEnum.UI.Act183_GroupFinished)
end

function Act183DungeonView_Animation:checkIfNeedPlayFinishEffect()
	local episodeId = Act183Model.instance:getNewFinishEpisodeId()

	if not episodeId or self._lastFinishEpisodeId == episodeId then
		return
	end

	Act183Controller.instance:dispatchEvent(Act183Event.EpisodeStartPlayFinishAnim, episodeId)

	self._lastFinishEpisodeId = episodeId
end

function Act183DungeonView_Animation:_onUpdateRepressInfo(episodeId, episodeMo)
	self:checkIfNeedPlayEffect()
end

function Act183DungeonView_Animation:_playRuleRepressEffect(repressEpisodeMo)
	local groupId = repressEpisodeMo:getGroupId()
	local groupMo = Act183Model.instance:getGroupEpisodeMo(groupId)

	if not groupMo then
		return
	end

	local unfinishEpisodes = self:_getUnfinishEpisodes(groupMo)

	if unfinishEpisodes then
		if not #unfinishEpisodes then
			local unfinishEpisodeCount = 0

			if unfinishEpisodeCount <= 0 then
				return
			end

			local startOrder = repressEpisodeMo:getConfigOrder()

			for _, unfinishEpisodeMo in ipairs(unfinishEpisodes) do
				local endOrder = unfinishEpisodeMo:getConfigOrder()

				self:_showRepressEffect(repressEpisodeMo, startOrder, endOrder)
			end

			AudioMgr.instance:trigger(AudioEnum.UI.Act183_EscapeRuleLineEffect)
		end
	end
end

function Act183DungeonView_Animation:_showRepressEffect(episodeMo, startOrder, endOrder)
	local key = string.format("%s_%s", startOrder, endOrder)
	local animType = self._orderToAnimTypeMap[key]

	if not animType then
		logError(string.format("镇压连线动画类型不存在 episodeId = %s, startOrder = %s, endOrder = %s", episodeMo:getEpisodeId(), startOrder, endOrder))

		return
	end

	local goline = self:_getOrCreateLine(animType)

	goline.name = key
	self._useLineEffectPool[animType] = self._useLineEffectPool[animType] or self:getUserDataTb_()

	table.insert(self._useLineEffectPool[animType], goline)
	self:_setLinePosAndRotation(startOrder, endOrder, goline)

	local line1 = gohelper.findChild(goline, "line1")
	local line2 = gohelper.findChild(goline, "line2")

	gohelper.setActive(line1, episodeMo:getRuleStatus(1) ~= Act183Enum.RuleStatus.Repress)
	gohelper.setActive(line2, episodeMo:getRuleStatus(2) ~= Act183Enum.RuleStatus.Repress)
end

function Act183DungeonView_Animation:_setLinePosAndRotation(startOrder, endOrder, goline)
	local episodeItamTab = self:getEpisodeItemTab()
	local fromEpisodeItem = episodeItamTab and episodeItamTab[startOrder]
	local toEpisodeItem = episodeItamTab and episodeItamTab[endOrder]

	if not fromEpisodeItem or not toEpisodeItem then
		return
	end

	local fromIconTran = fromEpisodeItem:getIconTran()
	local fromPosition = recthelper.rectToRelativeAnchorPos(fromIconTran.position, self._gomiddle.transform)
	local toIconTran = toEpisodeItem:getIconTran()
	local toPosition = recthelper.rectToRelativeAnchorPos(toIconTran.position, self._gomiddle.transform)

	gohelper.setActive(goline, true)
	recthelper.setAnchor(goline.transform, toPosition.x, toPosition.y)

	local rotationX, rotationY, rotationZ = self:_calcLineRotation(fromPosition, toPosition)

	transformhelper.setLocalRotation(goline.transform, rotationX, rotationY, rotationZ)
end

function Act183DungeonView_Animation:_calcLineRotation(fromPosition, toPosition)
	local dir = toPosition - fromPosition
	local angle = Mathf.Atan2(dir.y, dir.x) * Mathf.Rad2Deg

	angle = angle < 0 and angle + 360 or angle

	return 0, 0, angle
end

function Act183DungeonView_Animation:_getUnfinishEpisodes(groupMo)
	local unfinishSubEpisodes = {}
	local episodeList = groupMo:getEpisodeMos()

	for _, mo in ipairs(episodeList) do
		local isFinished = mo:isFinished()

		if not isFinished then
			table.insert(unfinishSubEpisodes, mo)
		end
	end

	return unfinishSubEpisodes
end

function Act183DungeonView_Animation:_getOrCreateLine(animType)
	local lineEffects = self._lineEffectPool[animType]

	if not lineEffects then
		lineEffects = self:getUserDataTb_()
		self._lineEffectPool[animType] = lineEffects
	end

	local goline = table.remove(lineEffects, 1)

	if not goline then
		local gotemplate = self._lineTemplateMap[animType]

		goline = gohelper.clone(gotemplate[1], self._gomiddle, "line_" .. animType)
	end

	return goline
end

function Act183DungeonView_Animation:_recycleLines()
	if self._useLineEffectPool then
		for animType, lineList in pairs(self._useLineEffectPool) do
			for i = #lineList, 1, -1 do
				local goline = table.remove(lineList, i)

				gohelper.setActive(goline, false)

				self._lineEffectPool[animType] = self._lineEffectPool[animType] or self:getUserDataTb_()

				table.insert(self._lineEffectPool[animType], goline)
			end
		end
	end
end

function Act183DungeonView_Animation:_onCloseViewFinish(viewName)
	if viewName == self.viewName then
		return
	end

	self:checkIfNeedPlayEffect()
end

function Act183DungeonView_Animation:checkIfNeedPlayGroupCategoryFinishAnim()
	local originUnfinishTaskMap = Act183Model.instance:getUnfinishTaskMap()

	if originUnfinishTaskMap then
		for groupId, groupTaskIds in pairs(originUnfinishTaskMap) do
			for i = #groupTaskIds, 1, -1 do
				local isTaskFinished = Act183Helper.isTaskFinished(groupTaskIds[i])

				if isTaskFinished then
					table.remove(groupTaskIds, i)
				end
			end

			if #groupTaskIds <= 0 then
				originUnfinishTaskMap[groupId] = nil

				Act183Controller.instance:dispatchEvent(Act183Event.OnGroupAllTaskFinished, groupId)
			end
		end
	end
end

function Act183DungeonView_Animation:_onFightBossIfSubUnfinish(episodeId)
	local episdoeMo = Act183Model.instance:getEpisodeMoById(episodeId)

	if not episdoeMo then
		return
	end

	self:destroyFlow()

	self._flow = FlowSequence.New()

	self._flow:addWork(FunctionWork.New(self._lockScreen, self, true))
	self._flow:addWork(FunctionWork.New(self._playRuleRepressEffect2BossEpisode, self, episdoeMo))
	self._flow:addWork(WorkWaitSeconds.New(RepressAnimDuration))
	self._flow:addWork(FunctionWork.New(self._recycleLines, self))
	self._flow:addWork(FunctionWork.New(self._lockScreen, self, false))
	self._flow:addWork(FunctionWork.New(self._onPlayFightBossEffectDone, self, episodeId))
	self._flow:start()
end

function Act183DungeonView_Animation:_playRuleRepressEffect2BossEpisode(episdoeMo)
	local groupMo = Act183Model.instance:getGroupEpisodeMo(episdoeMo:getGroupId())

	if not groupMo then
		return
	end

	local unlockSubEpisodeList = groupMo:getTargetTypeAndStatusEpisodes(Act183Enum.EpisodeType.Sub, Act183Enum.EpisodeStatus.Unlocked)
	local lockSubEpisodeList = groupMo:getTargetTypeAndStatusEpisodes(Act183Enum.EpisodeType.Sub, Act183Enum.EpisodeStatus.Locked)
	local unfinishSubEpisodeList = {}

	tabletool.addValues(unfinishSubEpisodeList, unlockSubEpisodeList)
	tabletool.addValues(unfinishSubEpisodeList, lockSubEpisodeList)

	local endOrder = episdoeMo:getConfigOrder()

	for _, subEpisodeMo in ipairs(unfinishSubEpisodeList) do
		local startOrder = subEpisodeMo:getConfigOrder()

		self:_showRepressEffect(subEpisodeMo, startOrder, endOrder)
		self:_showEscapeEffect(startOrder)
	end
end

function Act183DungeonView_Animation:_showEscapeEffect(episodeOrder)
	local episodeItemTab = self:getEpisodeItemTab()
	local episodeItem = episodeItemTab and episodeItemTab[episodeOrder]

	if not episodeItem then
		return
	end

	if episodeItem.playFakeRepressAnim then
		episodeItem:playFakeRepressAnim()
	end
end

function Act183DungeonView_Animation:_onPlayFightBossEffectDone(episodeId)
	Act183Controller.instance:dispatchEvent(Act183Event.OnPlayEffectDoneIfSubUnfinish, episodeId)
end

function Act183DungeonView_Animation:getEpisodeItemTab()
	local mainView = self.viewContainer:getMainView()

	return mainView and mainView:getEpisodeItemTab()
end

function Act183DungeonView_Animation:onClose()
	self:destroyFlow()
	self:_lockScreen(false)
	Act183Model.instance:clearBattleFinishedInfo()
end

return Act183DungeonView_Animation
