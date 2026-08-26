-- chunkname: @modules/logic/signin/view/SignInViewContainer.lua

module("modules.logic.signin.view.SignInViewContainer", package.seeall)

local SignInViewContainer = class("SignInViewContainer", BaseViewContainer)

function SignInViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "rightContent/monthdetail/scroll_item"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = SignInListItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 7
	scrollParam.cellWidth = 110
	scrollParam.cellHeight = 144
	scrollParam.cellSpaceH = 8.3
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 0
	scrollParam.endSpace = 0
	scrollParam.minUpdateCountInFrame = 100

	table.insert(views, LuaListScrollView.New(SignInListModel.instance, scrollParam))
	table.insert(views, TabViewGroup.New(1, "#go_btns"))
	table.insert(views, SignInView.New())

	return views
end

function SignInViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local view = NavigateButtonsView.New({
			false,
			false,
			false
		})

		view:setOverrideClose(self.overrideOnCloseClick, self)

		return {
			view
		}
	end
end

function SignInViewContainer:overrideOnCloseClick()
	SignInController.instance:dispatchEvent(SignInEvent.CloseSignInView)
end

return SignInViewContainer
