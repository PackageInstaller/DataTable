-- chunkname: @modules/logic/social/view/InformPlayerTipViewContainer.lua

module("modules.logic.social.view.InformPlayerTipViewContainer", package.seeall)

local InformPlayerTipViewContainer = class("InformPlayerTipViewContainer", BaseViewContainer)

function InformPlayerTipViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "scroll_inform"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "scroll_inform/Viewport/#go_informContent/#go_informItem"
	scrollParam.cellClass = ReportTypeItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 4
	scrollParam.cellWidth = 280
	scrollParam.cellHeight = 40
	scrollParam.cellSpaceH = 37
	scrollParam.cellSpaceV = 33
	scrollParam.startSpace = 0

	return {
		InformPlayerTipView.New(),
		LuaListScrollView.New(ReportTypeListModel.instance, scrollParam)
	}
end

function InformPlayerTipViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

return InformPlayerTipViewContainer
