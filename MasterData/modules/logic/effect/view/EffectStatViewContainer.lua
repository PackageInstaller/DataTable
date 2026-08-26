-- chunkname: @modules/logic/effect/view/EffectStatViewContainer.lua

module("modules.logic.effect.view.EffectStatViewContainer", package.seeall)

local EffectStatViewContainer = class("EffectStatViewContainer", BaseViewContainer)

function EffectStatViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "view/scroll"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "view/scroll/item"
	scrollParam.cellClass = EffectStatItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 744
	scrollParam.cellHeight = 45
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 0

	table.insert(views, LuaListScrollView.New(EffectStatModel.instance, scrollParam))
	table.insert(views, EffectStatView.New())
	table.insert(views, ToggleListView.New(1, "view/toggles"))

	return views
end

function EffectStatViewContainer:onContainerInit()
	self.registerCallback(self, ViewEvent.ToSwitchTab, self._toSwitchTab, self)
end

function EffectStatViewContainer:onContainerDestroy()
	self.unregisterCallback(self, ViewEvent.ToSwitchTab, self._toSwitchTab, self)
end

function EffectStatViewContainer:_toSwitchTab(tabContainerId, toggleId)
	EffectStatModel.instance:switchTab(toggleId)
end

return EffectStatViewContainer
