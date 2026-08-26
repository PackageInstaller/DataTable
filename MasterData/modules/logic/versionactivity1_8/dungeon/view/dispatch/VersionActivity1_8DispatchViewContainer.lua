-- chunkname: @modules/logic/versionactivity1_8/dungeon/view/dispatch/VersionActivity1_8DispatchViewContainer.lua

module("modules.logic.versionactivity1_8.dungeon.view.dispatch.VersionActivity1_8DispatchViewContainer", package.seeall)

local VersionActivity1_8DispatchViewContainer = class("VersionActivity1_8DispatchViewContainer", BaseViewContainer)

function VersionActivity1_8DispatchViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "container/left/#go_herocontainer/#scroll_hero"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "container/left/#go_herocontainer/#scroll_hero/Viewport/Content/#go_heroitem"
	scrollParam.cellClass = VersionActivity1_8DispatchHeroItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 4
	scrollParam.cellWidth = 185
	scrollParam.cellHeight = 164
	scrollParam.cellSpaceV = 25
	scrollParam.startSpace = 26
	scrollParam.endSpace = 26

	return {
		VersionActivity1_8DispatchView.New(),
		LuaListScrollView.New(DispatchHeroListModel.instance, scrollParam)
	}
end

function VersionActivity1_8DispatchViewContainer:onContainerInit()
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_page_turn)
end

function VersionActivity1_8DispatchViewContainer:onContainerCloseFinish()
	DispatchHeroListModel.instance:clear()
end

return VersionActivity1_8DispatchViewContainer
