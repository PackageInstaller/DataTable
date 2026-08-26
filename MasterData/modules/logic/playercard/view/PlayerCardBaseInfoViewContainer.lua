-- chunkname: @modules/logic/playercard/view/PlayerCardBaseInfoViewContainer.lua

module("modules.logic.playercard.view.PlayerCardBaseInfoViewContainer", package.seeall)

local PlayerCardBaseInfoViewContainer = class("PlayerCardBaseInfoViewContainer", BaseViewContainer)

function PlayerCardBaseInfoViewContainer:buildViews()
	local views = {}

	table.insert(views, PlayerCardBaseInfoView.New())

	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_base"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "#scroll_base/Viewport/Content/#go_baseInfoitem"
	scrollParam.cellClass = PlayerCardBaseInfoItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 528
	scrollParam.cellHeight = 112
	scrollParam.cellSpaceV = 19
	self._scrollView = LuaListScrollView.New(PlayerCardBaseInfoModel.instance, scrollParam)

	table.insert(views, self._scrollView)
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function PlayerCardBaseInfoViewContainer:buildTabViews(tabContainerId)
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

function PlayerCardBaseInfoViewContainer:_overrideClose()
	self:checkCloseFunc()
end

function PlayerCardBaseInfoViewContainer:checkCloseFunc()
	if not PlayerCardBaseInfoModel.instance:checkDiff() then
		GameFacade.showMessageBox(MessageBoxIdDefine.PlayerCardSelectTips, MsgBoxEnum.BoxType.Yes_No, PlayerCardBaseInfoViewContainer.yesCallback, PlayerCardBaseInfoViewContainer.cancel)
	else
		self:closeFunc()
	end
end

function PlayerCardBaseInfoViewContainer.yesCallback()
	PlayerCardBaseInfoModel.instance:confirmData()
	ViewMgr.instance:closeView(ViewName.PlayerCardBaseInfoView, nil, true)
end

function PlayerCardBaseInfoViewContainer.cancel()
	PlayerCardBaseInfoModel.instance:reselectData()
	ViewMgr.instance:closeView(ViewName.PlayerCardBaseInfoView, nil, true)
end

function PlayerCardBaseInfoViewContainer:closeFunc()
	ViewMgr.instance:closeView(ViewName.PlayerCardBaseInfoView, nil, true)
end

return PlayerCardBaseInfoViewContainer
