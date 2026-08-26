-- chunkname: @modules/logic/seasonver/act123/view2_0/Season123_2_0FightFailView.lua

module("modules.logic.seasonver.act123.view2_0.Season123_2_0FightFailView", package.seeall)

local Season123_2_0FightFailView = class("Season123_2_0FightFailView", FightFailView)

function Season123_2_0FightFailView:onInitView()
	self._gopower = gohelper.findChild(self.viewGO, "#go_power")
	self._btndata = gohelper.findChildButtonWithAudio(self.viewGO, "#go_power/#btn_data")
	self._gotips = gohelper.findChild(self.viewGO, "scroll/Viewport/#go_tips")
	self._gorestrain = gohelper.findChild(self.viewGO, "scroll/Viewport/#go_tips/#go_restrain")
	self._goherotipslist = gohelper.findChild(self.viewGO, "scroll/Viewport/#go_tips/#go_restrain/#go_herotipslist")
	self._goconditions = gohelper.findChild(self.viewGO, "scroll/Viewport/#go_tips/#go_conditions")
	self._goconditionitem = gohelper.findChild(self.viewGO, "scroll/Viewport/#go_tips/#go_conditions/#go_item")
	self._txtextratips = gohelper.findChildText(self.viewGO, "scroll/Viewport/#go_tips/#go_conditions/#go_item/#txt_extratips")
	self._gonormaltip = gohelper.findChild(self.viewGO, "scroll/Viewport/#go_tips/#go_normaltip")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_2_0FightFailView:addEvents()
	self._click:AddClickListener(self._onClickClose, self)
	self._btndata:AddClickListener(self._onClickData, self)
end

function Season123_2_0FightFailView:removeEvents()
	self._click:RemoveClickListener()
	self._btndata:RemoveClickListener()
end

function Season123_2_0FightFailView:_editableInitView()
	self._click = gohelper.getClick(self.viewGO)
	self.restrainItem = gohelper.findChild(self._goherotipslist, "item")

	gohelper.setActive(self.restrainItem, false)
	gohelper.setActive(self._goconditionitem, false)
	gohelper.setActive(self._gorestrain, false)
end

function Season123_2_0FightFailView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_settleaccounts_lose)
	FightController.instance:checkFightQuitTipViewClose()

	self.fightParam = FightModel.instance:getFightParam()
	self._episodeId = self.fightParam.episodeId
	self._chapterId = self.fightParam.chapterId
	self.episodeCo = lua_episode.configDict[self._episodeId]
	self.chapterCo = DungeonConfig.instance:getChapterCO(self._chapterId)
	self.battleCo = DungeonConfig.instance:getBattleCo(nil, FightModel.instance:getBattleId())

	NavigateMgr.instance:addEscape(self.viewName, self._onClickClose, self)

	if self:_hideActiveGo() and self.episodeCo then
		gohelper.setActive(self._gopower, true)
	end

	self:refreshTips()
end

function Season123_2_0FightFailView:refreshTips()
	local _, counter = FightHelper.detectAttributeCounter()
	local showHeroCoList

	if #counter ~= 0 then
		showHeroCoList = self:getCounterHeroList(self.fightParam:getAllHeroMoList(), counter)
	end

	if showHeroCoList and #showHeroCoList ~= 0 and self.refreshRestrainContainer then
		self:refreshRestrainContainer(showHeroCoList)
	end

	local conditionCoList = self:getShowConditionsCoList()
	local fightBattleContext = Season123Model.instance:getBattleContext()

	if fightBattleContext then
		conditionCoList = Season123HeroGroupModel.filterRule(fightBattleContext.actId, conditionCoList)

		if fightBattleContext.stage then
			conditionCoList = Season123Config.instance:filterRule(conditionCoList, fightBattleContext.stage)
		end
	end

	if conditionCoList and #conditionCoList ~= 0 then
		self:refreshConditionsContainer(conditionCoList)
	else
		gohelper.setActive(self._goconditions, false)
		self:refreshNormalContainer()
	end

	TaskDispatcher.runDelay(self.rebuildLayout, self, 0.01)
end

function Season123_2_0FightFailView:onClose()
	Season123_2_0FightFailView.super.onClose(self)
end

function Season123_2_0FightFailView:onDestroyView()
	Season123_2_0FightFailView.super.onDestroyView(self)
end

return Season123_2_0FightFailView
