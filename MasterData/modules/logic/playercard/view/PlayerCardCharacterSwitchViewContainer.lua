-- chunkname: @modules/logic/playercard/view/PlayerCardCharacterSwitchViewContainer.lua

module("modules.logic.playercard.view.PlayerCardCharacterSwitchViewContainer", package.seeall)

local PlayerCardCharacterSwitchViewContainer = class("PlayerCardCharacterSwitchViewContainer", BaseViewContainer)

function PlayerCardCharacterSwitchViewContainer:buildViews()
	local views = {}

	table.insert(views, PlayerCardCharacterSwitchView.New())

	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_characterswitchview/characterswitchview/right/mask/#scroll_card"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = PlayerCardCharacterSwitchItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 3
	scrollParam.cellWidth = 170
	scrollParam.cellHeight = 208
	scrollParam.cellSpaceH = 5
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 5
	scrollParam.endSpace = 0
	self.scrollView = LuaListScrollView.New(PlayerCardCharacterSwitchListModel.instance, scrollParam)

	table.insert(views, self.scrollView)
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function PlayerCardCharacterSwitchViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		self.navigateView:setOverrideClose(self._overrideClose, self)

		return {
			self.navigateView
		}
	end
end

function PlayerCardCharacterSwitchViewContainer:_overrideClose()
	if not PlayerCardModel.instance:checkHeroDiff() then
		GameFacade.showMessageBox(MessageBoxIdDefine.PlayerCardSelectTips, MsgBoxEnum.BoxType.Yes_No, PlayerCardCharacterSwitchViewContainer.yesCallback, PlayerCardCharacterSwitchViewContainer.cancel)
	else
		self:closeFunc()
	end
end

function PlayerCardCharacterSwitchViewContainer.cancel()
	local playercardinfo = PlayerCardModel.instance:getCardInfo()
	local heroId, skinId, _, isL2d = playercardinfo:getMainHero()
	local param = {
		heroId = heroId,
		skinId = skinId
	}

	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.RefreshSwitchView, param)
	ViewMgr.instance:closeView(ViewName.PlayerCardCharacterSwitchView, nil, true)
end

function PlayerCardCharacterSwitchViewContainer.yesCallback()
	local heroId, skinId = PlayerCardModel.instance:getSelectHero()

	PlayerCardCharacterSwitchListModel.instance:changeMainHero(heroId, skinId)
end

function PlayerCardCharacterSwitchViewContainer:closeFunc()
	ViewMgr.instance:closeView(ViewName.PlayerCardCharacterSwitchView, nil, true)
end

return PlayerCardCharacterSwitchViewContainer
