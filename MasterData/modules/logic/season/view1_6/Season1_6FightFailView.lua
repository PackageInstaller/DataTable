-- chunkname: @modules/logic/season/view1_6/Season1_6FightFailView.lua

module("modules.logic.season.view1_6.Season1_6FightFailView", package.seeall)

local Season1_6FightFailView = class("Season1_6FightFailView", FightFailView)

function Season1_6FightFailView:onInitView()
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

function Season1_6FightFailView:addEvents()
	self._click:AddClickListener(self._onClickClose, self)
	self._btndata:AddClickListener(self._onClickData, self)
end

function Season1_6FightFailView:removeEvents()
	self._click:RemoveClickListener()
	self._btndata:RemoveClickListener()
end

function Season1_6FightFailView:_editableInitView()
	self._click = gohelper.getClick(self.viewGO)
	self.restrainItem = gohelper.findChild(self._goherotipslist, "item")

	gohelper.setActive(self.restrainItem, false)
	gohelper.setActive(self._goconditionitem, false)
	gohelper.setActive(self._gorestrain, false)
end

function Season1_6FightFailView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_settleaccounts_lose)
	FightController.instance:checkFightQuitTipViewClose()

	self.fightParam = FightModel.instance:getFightParam()
	self._episodeId = self.fightParam.episodeId
	self._chapterId = self.fightParam.chapterId
	self.episodeCo = lua_episode.configDict[self._episodeId]
	self.chapterCo = DungeonConfig.instance:getChapterCO(self._chapterId)
	self.battleCo = DungeonConfig.instance:getBattleCo(nil, FightModel.instance:getBattleId())

	NavigateMgr.instance:addEscape(ViewName.FightFailView, self._onClickClose, self)

	if self:_hideActiveGo() and self.episodeCo then
		gohelper.setActive(self._gopower, true)
	end

	self:refreshTips()
end

function Season1_6FightFailView:refreshTips()
	local _, counter = FightHelper.detectAttributeCounter()
	local showHeroCoList

	if #counter ~= 0 then
		showHeroCoList = self:getCounterHeroList(self.fightParam:getAllHeroMoList(), counter)
	end

	if showHeroCoList and #showHeroCoList ~= 0 and self.refreshRestrainContainer then
		self:refreshRestrainContainer(showHeroCoList)
	end

	local conditionCoList = self:getShowConditionsCoList()

	conditionCoList = SeasonConfig.instance:filterRule(conditionCoList)

	if conditionCoList and #conditionCoList ~= 0 then
		self:refreshConditionsContainer(conditionCoList)
	else
		gohelper.setActive(self._goconditions, false)
		self:refreshNormalContainer()
	end

	TaskDispatcher.runDelay(self.rebuildLayout, self, 0.01)
end

function Season1_6FightFailView:onClose()
	Season1_6FightFailView.super.onClose(self)
end

function Season1_6FightFailView:onDestroyView()
	Season1_6FightFailView.super.onDestroyView(self)
end

return Season1_6FightFailView
