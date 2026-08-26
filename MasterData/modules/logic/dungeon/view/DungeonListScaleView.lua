-- chunkname: @modules/logic/dungeon/view/DungeonListScaleView.lua

module("modules.logic.dungeon.view.DungeonListScaleView", package.seeall)

local DungeonListScaleView = class("DungeonListScaleView", BaseView)

function DungeonListScaleView:onInitView()
	self._csScrollScale = SLFramework.UGUI.ListScrollScale.GetWithPath(self.viewGO, "chapterlist/#scroll_chapter")
end

function DungeonListScaleView:onDestroyView()
	self._csScrollScale = nil
end

return DungeonListScaleView
