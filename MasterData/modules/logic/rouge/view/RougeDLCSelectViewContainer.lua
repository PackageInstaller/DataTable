-- chunkname: @modules/logic/rouge/view/RougeDLCSelectViewContainer.lua

module("modules.logic.rouge.view.RougeDLCSelectViewContainer", package.seeall)

local RougeDLCSelectViewContainer = class("RougeDLCSelectViewContainer", BaseViewContainer)

function RougeDLCSelectViewContainer:buildViews()
	local scrollParam = MixScrollParam.New()

	scrollParam.scrollGOPath = "#go_root/#scroll_dlcs"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "#go_root/#scroll_dlcs/Viewport/Content/#go_dlcitem"
	scrollParam.cellClass = RougeDLCSelectListItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.startSpace = 0
	scrollParam.endSpace = 0

	local views = {}

	table.insert(views, RougeDLCSelectView.New())
	table.insert(views, TabViewGroup.New(1, "#go_root/#go_topleft"))
	table.insert(views, LuaMixScrollView.New(RougeDLCSelectListModel.instance, scrollParam))

	return views
end

function RougeDLCSelectViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigateView
		}
	end
end

return RougeDLCSelectViewContainer
