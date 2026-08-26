-- chunkname: @modules/logic/player/view/ShowCharacterViewContainer.lua

module("modules.logic.player.view.ShowCharacterViewContainer", package.seeall)

local ShowCharacterViewContainer = class("ShowCharacterViewContainer", BaseViewContainer)

function ShowCharacterViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_rolecontainer/#scroll_card"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = ShowCharacterCardItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 7
	scrollParam.cellWidth = 267
	scrollParam.cellHeight = 550
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 0
	scrollParam.frameUpdateMs = 100

	local animationDelayTimes = {}

	for i = 1, 14 do
		animationDelayTimes[i] = math.ceil(i - 1) % 7 * 0.06
	end

	table.insert(views, LuaListScrollViewWithAnimator.New(CharacterBackpackCardListModel.instance, scrollParam, animationDelayTimes))
	table.insert(views, ShowCharacterView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function ShowCharacterViewContainer:buildTabViews(tabContainerId)
	self.navigationView = NavigateButtonsView.New({
		true,
		true,
		false
	}, 101, self.onClose, self.onClose, nil, self)

	return {
		self.navigationView
	}
end

function ShowCharacterViewContainer:onContainerOpenFinish()
	self.navigationView:resetCloseBtnAudioId(AudioEnum.UI.Play_UI_Player_Interface_Open)
	self.navigationView:resetHomeBtnAudioId(AudioEnum.UI.Play_UI_Player_Interface_Close)
end

function ShowCharacterViewContainer:onClose()
	local showHeroUniqueIds = PlayerModel.instance:getShowHeroUid()

	PlayerRpc.instance:sendSetShowHeroUniqueIdsRequest(showHeroUniqueIds)
end

return ShowCharacterViewContainer
