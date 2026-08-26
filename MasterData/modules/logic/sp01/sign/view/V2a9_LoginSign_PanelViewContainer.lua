-- chunkname: @modules/logic/sp01/sign/view/V2a9_LoginSign_PanelViewContainer.lua

module("modules.logic.sp01.sign.view.V2a9_LoginSign_PanelViewContainer", package.seeall)

local V2a9_LoginSign_PanelViewContainer = class("V2a9_LoginSign_PanelViewContainer", Activity101SignViewBaseContainer)

function V2a9_LoginSign_PanelViewContainer:onModifyListScrollParam(refListScrollParam)
	refListScrollParam.cellClass = V2a9_LoginSignItem
	refListScrollParam.scrollGOPath = "Root/#scroll_ItemList"
	refListScrollParam.cellWidth = 220
	refListScrollParam.cellHeight = 600
	refListScrollParam.cellSpaceH = -16
end

function V2a9_LoginSign_PanelViewContainer:onGetMainViewClassType()
	return V2a9_LoginSign_PanelView
end

function V2a9_LoginSign_PanelViewContainer:onBuildViews()
	return {
		(self:getMainView())
	}
end

return V2a9_LoginSign_PanelViewContainer
