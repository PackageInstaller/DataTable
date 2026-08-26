-- chunkname: @modules/logic/weekwalk_2/view/WeekWalk_2HeartBuffViewContainer.lua

module("modules.logic.weekwalk_2.view.WeekWalk_2HeartBuffViewContainer", package.seeall)

local WeekWalk_2HeartBuffViewContainer = class("WeekWalk_2HeartBuffViewContainer", BaseViewContainer)

function WeekWalk_2HeartBuffViewContainer:buildViews()
	local scrollParam1 = ListScrollParam.New()

	scrollParam1.scrollGOPath = "Root/Left/Scroll View"
	scrollParam1.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam1.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam1.cellClass = WeekWalk_2HeartBuffItem
	scrollParam1.scrollDir = ScrollEnum.ScrollDirV
	scrollParam1.lineCount = 3
	scrollParam1.cellWidth = 240
	scrollParam1.cellHeight = 220

	local views = {}

	table.insert(views, WeekWalk_2HeartBuffView.New())
	table.insert(views, LuaListScrollView.New(WeekWalk_2BuffListModel.instance, scrollParam1))

	return views
end

function WeekWalk_2HeartBuffViewContainer:onContainerOpen()
	if self.viewParam then
		WeekWalk_2BuffListModel.instance:initBuffList(self.viewParam)
	end
end

function WeekWalk_2HeartBuffViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return WeekWalk_2HeartBuffViewContainer
