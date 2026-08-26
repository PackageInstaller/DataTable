-- chunkname: @modules/logic/playercard/view/PlayerCardProgressViewContainer.lua

module("modules.logic.playercard.view.PlayerCardProgressViewContainer", package.seeall)

local PlayerCardProgressViewContainer = class("PlayerCardProgressViewContainer", BaseViewContainer)

function PlayerCardProgressViewContainer:buildViews()
	local views = {}

	table.insert(views, PlayerCardProgressView.New())

	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_progress"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "#scroll_progress/Viewport/Content/#go_progressitem"
	scrollParam.cellClass = PlayerCardProgressItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 2
	scrollParam.cellWidth = 260
	scrollParam.cellHeight = 224
	scrollParam.cellSpaceH = 11
	scrollParam.cellSpaceV = 11
	self._scrollView = LuaListScrollView.New(PlayerCardProgressModel.instance, scrollParam)

	table.insert(views, self._scrollView)
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function PlayerCardProgressViewContainer:buildTabViews(tabContainerId)
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

function PlayerCardProgressViewContainer:_overrideClose()
	self:checkCloseFunc()
end

function PlayerCardProgressViewContainer:checkCloseFunc()
	if PlayerCardProgressModel.instance:checkDiff() then
		GameFacade.showMessageBox(MessageBoxIdDefine.PlayerCardSelectTips, MsgBoxEnum.BoxType.Yes_No, PlayerCardProgressViewContainer.yesCallback, PlayerCardProgressViewContainer.cancel)
	else
		self:closeFunc()
	end
end

function PlayerCardProgressViewContainer.yesCallback()
	PlayerCardProgressModel.instance:confirmData()
	ViewMgr.instance:closeView(ViewName.PlayerCardProgressView, nil, true)
end

function PlayerCardProgressViewContainer.cancel()
	PlayerCardProgressModel.instance:reselectData()
	ViewMgr.instance:closeView(ViewName.PlayerCardProgressView, nil, true)
end

function PlayerCardProgressViewContainer:closeFunc()
	ViewMgr.instance:closeView(ViewName.PlayerCardProgressView, nil, true)
end

return PlayerCardProgressViewContainer
