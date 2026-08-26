-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotHeroGroupEditViewContainer.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotHeroGroupEditViewContainer", package.seeall)

local V1a6_CachotHeroGroupEditViewContainer = class("V1a6_CachotHeroGroupEditViewContainer", BaseViewContainer)

function V1a6_CachotHeroGroupEditViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_rolecontainer/#scroll_card"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = V1a6_CachotHeroGroupEditItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 5
	scrollParam.cellWidth = 200
	scrollParam.cellHeight = 440
	scrollParam.cellSpaceH = 12
	scrollParam.cellSpaceV = 10
	scrollParam.startSpace = 37

	local animationDelayTimes = {}

	for i = 1, 15 do
		animationDelayTimes[i] = math.ceil((i - 1) % 5) * 0.03
	end

	return {
		V1a6_CachotHeroGroupEditView.New(),
		LuaListScrollViewWithAnimator.New(V1a6_CachotHeroGroupEditListModel.instance, scrollParam, animationDelayTimes),
		self:getQuickEditScroll(),
		CommonRainEffectView.New("bg/#go_raincontainer"),
		TabViewGroup.New(1, "#go_btns")
	}
end

function V1a6_CachotHeroGroupEditViewContainer:getQuickEditScroll()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_rolecontainer/#scroll_quickedit"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[2]
	scrollParam.cellClass = V1a6_CachotHeroGroupEditItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 5
	scrollParam.cellWidth = 200
	scrollParam.cellHeight = 440
	scrollParam.cellSpaceH = 12
	scrollParam.cellSpaceV = 10
	scrollParam.startSpace = 37

	local animationDelayTimes = {}

	for i = 1, 15 do
		animationDelayTimes[i] = math.ceil((i - 1) % 5) * 0.03
	end

	return LuaListScrollViewWithAnimator.New(HeroGroupQuickEditListModel.instance, scrollParam, animationDelayTimes)
end

function V1a6_CachotHeroGroupEditViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		true
	}, HelpEnum.HelpId.Cachot1_6HeroGroupHelp)

	self._navigateButtonView:setOverrideClose(self._overrideClose, self)

	return {
		self._navigateButtonView
	}
end

function V1a6_CachotHeroGroupEditViewContainer:onContainerOpenFinish()
	self._navigateButtonView:resetOnCloseViewAudio(AudioEnum.HeroGroupUI.Play_UI_Team_Close)
	FightAudioMgr.instance:init()
end

function V1a6_CachotHeroGroupEditViewContainer:onContainerOpen()
	HeroGroupController.instance:registerCallback(HeroGroupEvent.OnModifyHeroGroup, self._modifyHeroGroup, self)
end

function V1a6_CachotHeroGroupEditViewContainer:_modifyHeroGroup()
	if self.viewParam.selectHeroFromEvent then
		local heroList = V1a6_CachotHeroSingleGroupModel.instance:getList()
		local mo = heroList[1]
		local heroUid = mo.heroUid
		local heroMo = HeroModel.instance:getById(tostring(heroUid))

		if not heroMo then
			return
		end

		RogueRpc.instance:sendRogueEventSelectRequest(V1a6_CachotEnum.ActivityId, self.viewParam.eventMo.eventId, heroMo.heroId, self._onSelectEnd, self)
		V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.SelectHero, heroMo)
	end
end

function V1a6_CachotHeroGroupEditViewContainer:_onSelectEnd()
	ViewMgr.instance:closeView(ViewName.V1a6_CachotHeroGroupEditView, nil, true)
end

function V1a6_CachotHeroGroupEditViewContainer:onContainerClose()
	HeroGroupController.instance:unregisterCallback(HeroGroupEvent.OnModifyHeroGroup, self._modifyHeroGroup, self)
end

function V1a6_CachotHeroGroupEditViewContainer:_checkClose()
	local function yesFunc()
		self:_sendEndEventRequest()
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.V1a6CachotMsgBox04, MsgBoxEnum.BoxType.Yes_No, yesFunc)
end

function V1a6_CachotHeroGroupEditViewContainer:_sendEndEventRequest()
	RogueRpc.instance:sendRogueEventEndRequest(V1a6_CachotEnum.ActivityId, self.viewParam.eventMo.eventId, self._closeHeroGroupEditView, self)
end

function V1a6_CachotHeroGroupEditViewContainer:_closeHeroGroupEditView()
	ViewMgr.instance:closeView(ViewName.V1a6_CachotHeroGroupEditView, nil, true)
end

function V1a6_CachotHeroGroupEditViewContainer:_overrideClose()
	if self.viewParam.heroGroupEditType == V1a6_CachotEnum.HeroGroupEditType.Event then
		self:_checkClose()

		return
	end

	if ViewMgr.instance:isOpen(ViewName.CharacterLevelUpView) then
		ViewMgr.instance:closeView(ViewName.CharacterLevelUpView, nil, true)
	elseif ViewMgr.instance:isOpen(ViewName.V1a6_CachotHeroGroupEditView) then
		ViewMgr.instance:closeView(ViewName.V1a6_CachotHeroGroupEditView, nil, true)
	end
end

function V1a6_CachotHeroGroupEditViewContainer:_setHomeBtnVisible(isVisible)
	self._navigateButtonView:setParam({
		true,
		isVisible,
		true
	})
end

return V1a6_CachotHeroGroupEditViewContainer
