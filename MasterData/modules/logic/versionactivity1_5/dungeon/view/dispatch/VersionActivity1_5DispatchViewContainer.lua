-- chunkname: @modules/logic/versionactivity1_5/dungeon/view/dispatch/VersionActivity1_5DispatchViewContainer.lua

module("modules.logic.versionactivity1_5.dungeon.view.dispatch.VersionActivity1_5DispatchViewContainer", package.seeall)

local VersionActivity1_5DispatchViewContainer = class("VersionActivity1_5DispatchViewContainer", BaseViewContainer)

function VersionActivity1_5DispatchViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "container/left/#go_herocontainer/#scroll_hero"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "container/left/#go_herocontainer/#scroll_hero/Viewport/Content/#go_heroitem"
	scrollParam.cellClass = VersionActivity1_5DispatchHeroItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 4
	scrollParam.cellWidth = 154
	scrollParam.cellHeight = 164
	scrollParam.cellSpaceH = 25
	scrollParam.cellSpaceV = 25

	return {
		VersionActivity1_5DispatchView.New(),
		LuaListScrollView.New(VersionActivity1_5HeroListModel.instance, scrollParam)
	}
end

function VersionActivity1_5DispatchViewContainer:onContainerInit()
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_page_turn)
end

function VersionActivity1_5DispatchViewContainer:onContainerCloseFinish()
	VersionActivity1_5HeroListModel.instance:clear()
end

return VersionActivity1_5DispatchViewContainer
