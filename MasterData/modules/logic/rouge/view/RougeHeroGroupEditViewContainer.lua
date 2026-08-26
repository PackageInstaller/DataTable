-- chunkname: @modules/logic/rouge/view/RougeHeroGroupEditViewContainer.lua

module("modules.logic.rouge.view.RougeHeroGroupEditViewContainer", package.seeall)

local RougeHeroGroupEditViewContainer = class("RougeHeroGroupEditViewContainer", BaseViewContainer)

function RougeHeroGroupEditViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_rolecontainer/#scroll_card"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = RougeHeroGroupEditItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 5
	scrollParam.cellWidth = 200
	scrollParam.cellHeight = 450
	scrollParam.cellSpaceH = 12
	scrollParam.cellSpaceV = 10
	scrollParam.startSpace = 37

	local animationDelayTimes = {}

	for i = 1, 15 do
		animationDelayTimes[i] = math.ceil((i - 1) % 5) * 0.03
	end

	return {
		RougeHeroGroupEditView.New(),
		LuaListScrollViewWithAnimator.New(RougeHeroGroupEditListModel.instance, scrollParam, animationDelayTimes),
		self:getQuickEditScroll(),
		CommonRainEffectView.New("bg/#go_raincontainer"),
		TabViewGroup.New(1, "#go_btns")
	}
end

function RougeHeroGroupEditViewContainer:getQuickEditScroll()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_rolecontainer/#scroll_quickedit"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[2]
	scrollParam.cellClass = RougeHeroGroupQuickEditItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 5
	scrollParam.cellWidth = 200
	scrollParam.cellHeight = 450
	scrollParam.cellSpaceH = 12
	scrollParam.cellSpaceV = 10
	scrollParam.startSpace = 37

	local animationDelayTimes = {}

	for i = 1, 15 do
		animationDelayTimes[i] = math.ceil((i - 1) % 5) * 0.03
	end

	return LuaListScrollViewWithAnimator.New(RougeHeroGroupQuickEditListModel.instance, scrollParam, animationDelayTimes)
end

function RougeHeroGroupEditViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	self._navigateButtonView:setOverrideClose(self._overrideClose, self)
	self._navigateButtonView:setHelpId(HelpEnum.HelpId.RougeInitTeamViewHelp)

	return {
		self._navigateButtonView
	}
end

function RougeHeroGroupEditViewContainer:onContainerOpenFinish()
	self._navigateButtonView:resetOnCloseViewAudio(AudioEnum.HeroGroupUI.Play_UI_Team_Close)
	FightAudioMgr.instance:init()
end

function RougeHeroGroupEditViewContainer:onContainerOpen()
	HeroGroupController.instance:registerCallback(HeroGroupEvent.OnModifyHeroGroup, self._modifyHeroGroup, self)
end

function RougeHeroGroupEditViewContainer:checkSelectHeroResult()
	self:_modifyHeroGroup()
end

function RougeHeroGroupEditViewContainer:getQuickSelectHeroList()
	local list = {}
	local heroList = RougeHeroGroupQuickEditListModel.instance:getHeroUids()

	for i, heroUid in ipairs(heroList) do
		local heroMo = HeroModel.instance:getById(heroUid)

		if heroMo then
			table.insert(list, heroMo.heroId)
		end
	end

	return list
end

function RougeHeroGroupEditViewContainer:_modifyHeroGroup()
	if self.viewParam.heroGroupEditType == RougeEnum.HeroGroupEditType.SelectHero then
		local list = self:getQuickSelectHeroList()
		local callback = self.viewParam.selectHeroCallback
		local target = self.viewParam.selectHeroCallbackTarget

		if callback then
			self.viewParam.selectHeroCallback(target, list)
		end
	end
end

function RougeHeroGroupEditViewContainer:_onSelectEnd()
	ViewMgr.instance:closeView(ViewName.RougeHeroGroupEditView, nil, true)
end

function RougeHeroGroupEditViewContainer:onContainerClose()
	HeroGroupController.instance:unregisterCallback(HeroGroupEvent.OnModifyHeroGroup, self._modifyHeroGroup, self)
end

function RougeHeroGroupEditViewContainer:_checkClose()
	local function yesFunc()
		self:_closeHeroGroupEditView()

		local callback = self.viewParam.selectHeroCallback
		local target = self.viewParam.selectHeroCallbackTarget

		if callback then
			self.viewParam.selectHeroCallback(target)
		end
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.V1a6CachotMsgBox04, MsgBoxEnum.BoxType.Yes_No, yesFunc)
end

function RougeHeroGroupEditViewContainer:_closeHeroGroupEditView()
	ViewMgr.instance:closeView(ViewName.RougeHeroGroupEditView, nil, true)
end

function RougeHeroGroupEditViewContainer:_overrideClose()
	if self.viewParam.heroGroupEditType == RougeEnum.HeroGroupEditType.SelectHero then
		self:_checkClose()

		return
	end

	if ViewMgr.instance:isOpen(ViewName.CharacterLevelUpView) then
		ViewMgr.instance:closeView(ViewName.CharacterLevelUpView, nil, true)
	elseif ViewMgr.instance:isOpen(ViewName.RougeHeroGroupEditView) then
		ViewMgr.instance:closeView(ViewName.RougeHeroGroupEditView, nil, true)
	end
end

function RougeHeroGroupEditViewContainer:_setHomeBtnVisible(isVisible)
	local var_15_0 = {
		true,
		nil,
		true
	}

	var_15_0[2] = false

	self._navigateButtonView:setParam(var_15_0)
end

return RougeHeroGroupEditViewContainer
