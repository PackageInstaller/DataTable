-- chunkname: @modules/logic/sp01/sign/view/V2a9_LoginSign_FullViewContainer.lua

module("modules.logic.sp01.sign.view.V2a9_LoginSign_FullViewContainer", package.seeall)

local V2a9_LoginSign_FullViewContainer = class("V2a9_LoginSign_FullViewContainer", Activity101SignViewBaseContainer)

function V2a9_LoginSign_FullViewContainer:onModifyListScrollParam(refListScrollParam)
	refListScrollParam.cellClass = V2a9_LoginSignItem
	refListScrollParam.scrollGOPath = "Root/#scroll_ItemList"
	refListScrollParam.cellWidth = 220
	refListScrollParam.cellHeight = 600
	refListScrollParam.cellSpaceH = -16
end

function V2a9_LoginSign_FullViewContainer:onGetMainViewClassType()
	return V2a9_LoginSign_FullView
end

function V2a9_LoginSign_FullViewContainer:onBuildViews()
	return {
		self:getMainView(),
		(TabViewGroup.New(1, "#go_topleft"))
	}
end

function V2a9_LoginSign_FullViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			false,
			false
		})
	}
end

return V2a9_LoginSign_FullViewContainer
