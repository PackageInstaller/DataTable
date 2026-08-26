-- chunkname: @modules/logic/fight/view/FightViewClothSkillMgrView.lua

module("modules.logic.fight.view.FightViewClothSkillMgrView", package.seeall)

local FightViewClothSkillMgrView = class("FightViewClothSkillMgrView", BaseViewExtended)

function FightViewClothSkillMgrView:onInitView()
	self._heroSkillGO = gohelper.findChild(self.viewGO, "root/heroSkill")
	self._goSimple = gohelper.findChild(self._heroSkillGO, "#go_simple")
	self._rogueSkillRoot = gohelper.findChild(self.viewGO, "root/rogueSkillRoot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightViewClothSkillMgrView:addEvents()
	self.addEventCb(self, FightController.instance, FightEvent.BeforeEnterStepBehaviour, self._onBeforeEnterStepBehaviour, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnRestartStageBefore, self._onRestartStage, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnSwitchPlaneClearAsset, self._onSwitchPlaneClearAsset, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self.onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self.onCloseView, self)
end

function FightViewClothSkillMgrView:removeEvents()
	return
end

function FightViewClothSkillMgrView:onOpenView(viewName)
	return
end

function FightViewClothSkillMgrView:onCloseView(viewName)
	return
end

function FightViewClothSkillMgrView:_editableInitView()
	return
end

function FightViewClothSkillMgrView:_onRestartStage()
	self:killAllChildView()
end

function FightViewClothSkillMgrView:_onSwitchPlaneClearAsset()
	self:killAllChildView()
end

function FightViewClothSkillMgrView:_onBeforeEnterStepBehaviour()
	local curChapterType = self:getCurChapterType()

	if curChapterType == DungeonEnum.ChapterType.Rouge then
		gohelper.setActive(self._goSimple, false)
		self:openSubView(FightViewRougeSkill, "ui/viewres/rouge/fight/rougeheroskillview.prefab", self._rogueSkillRoot)

		return
	end

	if FightDataHelper.fieldMgr:isRouge2() then
		gohelper.setActive(self._goSimple, false)
		self:openSubView(FightViewRougeSkill2_3_7, "ui/viewres/fight/fight_rouge2/fight_rouge2_effectview.prefab", self._rogueSkillRoot)

		return
	end

	if curChapterType == DungeonEnum.ChapterType.ToughBattle then
		local goRoot = self.viewContainer.rightElementLayoutView:getElementContainer(FightRightElementEnum.Elements.CharSupport)

		self:openSubView(FightToughBattleSkillView, "ui/viewres/fight/charsupportlist.prefab", goRoot)
		self.viewContainer.rightElementLayoutView:showElement(FightRightElementEnum.Elements.CharSupport)
	end

	local myTeamData = FightDataHelper.teamDataMgr.myData

	if myTeamData.itemSkillInfos then
		gohelper.setActive(self._goSimple, false)

		return
	end

	local shouTaoData = FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.ShowTaoFuBen]

	if shouTaoData then
		gohelper.setActive(self._goSimple, false)

		return
	end

	self:openSubView(FightViewClothSkill, self.viewGO)
end

function FightViewClothSkillMgrView:getCurChapterType()
	local fightParam = FightModel.instance:getFightParam()

	if not fightParam then
		return
	end

	local chapterId = fightParam.chapterId
	local chapterCo = DungeonConfig.instance:getChapterCO(chapterId)

	return chapterCo and chapterCo.type
end

function FightViewClothSkillMgrView:checkIsToughBattle()
	local fightParam = FightModel.instance:getFightParam()

	if not fightParam then
		return
	end

	local chapterId = fightParam.chapterId
	local chapterCo = DungeonConfig.instance:getChapterCO(chapterId)

	if not chapterCo or chapterCo.type ~= DungeonEnum.ChapterType.ToughBattle then
		return
	end
end

function FightViewClothSkillMgrView:onRefreshViewParam()
	return
end

function FightViewClothSkillMgrView:onOpen()
	return
end

function FightViewClothSkillMgrView:onClose()
	return
end

function FightViewClothSkillMgrView:onDestroyView()
	return
end

return FightViewClothSkillMgrView
