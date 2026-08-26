-- chunkname: @modules/logic/fight/view/preview/SkillEffectStatViewContainer.lua

module("modules.logic.fight.view.preview.SkillEffectStatViewContainer", package.seeall)

local SkillEffectStatViewContainer = class("SkillEffectStatViewContainer", BaseViewContainer)

function SkillEffectStatViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "view/scroll"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "view/scroll/item"
	scrollParam.cellClass = SkillEffectStatItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 744
	scrollParam.cellHeight = 45
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 0

	table.insert(views, LuaListScrollView.New(SkillEffectStatModel.instance, scrollParam))
	table.insert(views, SkillEffectStatView.New())
	table.insert(views, ToggleListView.New(1, "view/toggles"))

	return views
end

function SkillEffectStatViewContainer:onContainerInit()
	self.registerCallback(self, ViewEvent.ToSwitchTab, self._toSwitchTab, self)
end

function SkillEffectStatViewContainer:onContainerDestroy()
	self.unregisterCallback(self, ViewEvent.ToSwitchTab, self._toSwitchTab, self)
end

function SkillEffectStatViewContainer:_toSwitchTab(tabContainerId, toggleId)
	SkillEffectStatModel.instance:switchTab(toggleId)
end

return SkillEffectStatViewContainer
