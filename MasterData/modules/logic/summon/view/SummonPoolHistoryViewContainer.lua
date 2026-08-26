-- chunkname: @modules/logic/summon/view/SummonPoolHistoryViewContainer.lua

module("modules.logic.summon.view.SummonPoolHistoryViewContainer", package.seeall)

local SummonPoolHistoryViewContainer = class("SummonPoolHistoryViewContainer", BaseViewContainer)

function SummonPoolHistoryViewContainer:buildViews()
	local views = {}

	table.insert(views, SummonPoolHistoryView.New())
	table.insert(views, self:_createScrollView())

	return views
end

function SummonPoolHistoryViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

function SummonPoolHistoryViewContainer:_createScrollView()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "allbg/left/scroll_pooltype"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "allbg/left/pooltypeitem"
	scrollParam.cellClass = SummonPoolHistoryTypeItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 380
	scrollParam.cellHeight = 116
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 8
	scrollParam.startSpace = 0

	local animationDelayTimes = {}

	for i = 1, 10 do
		animationDelayTimes[i] = (i - 1) * 0.03
	end

	return LuaListScrollViewWithAnimator.New(SummonPoolHistoryTypeListModel.instance, scrollParam, animationDelayTimes)
end

return SummonPoolHistoryViewContainer
