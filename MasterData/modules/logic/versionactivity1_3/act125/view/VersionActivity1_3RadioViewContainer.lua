-- chunkname: @modules/logic/versionactivity1_3/act125/view/VersionActivity1_3RadioViewContainer.lua

module("modules.logic.versionactivity1_3.act125.view.VersionActivity1_3RadioViewContainer", package.seeall)

local VersionActivity1_3RadioViewContainer = class("VersionActivity1_3RadioViewContainer", BaseViewContainer)

function VersionActivity1_3RadioViewContainer:buildViews()
	local channelScrollParam = ListScrollParam.New()

	channelScrollParam.scrollGOPath = "Middle/FMSlider/#scroll_FMChannelList"
	channelScrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	channelScrollParam.prefabUrl = "Middle/FMSlider/#scroll_FMChannelList/Viewport/Content/#go_radiochannelitem"
	channelScrollParam.cellClass = VersionActivity1_3RadioChannelItem
	channelScrollParam.scrollDir = ScrollEnum.ScrollDirH
	channelScrollParam.lineCount = 1
	channelScrollParam.cellWidth = 100
	channelScrollParam.cellHeight = 100
	channelScrollParam.cellSpaceH = 0
	channelScrollParam.startSpace = 210
	channelScrollParam.endSpace = 210
	self._channelScrollView = LuaListScrollView.New(V1A3_RadioChannelListModel.instance, channelScrollParam)

	return {
		VersionActivity1_3RadioView.New(),
		self._channelScrollView
	}
end

return VersionActivity1_3RadioViewContainer
