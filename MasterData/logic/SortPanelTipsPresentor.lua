-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/instruction/view/SortPanelTipsPresentor.lua

module("logic.extensions.common.instruction.view.SortPanelTipsPresentor", package.seeall)

local SortPanelTipsPresentor = class("SortPanelTipsPresentor", ViewPresentor)

function SortPanelTipsPresentor:ctor()
	SortPanelTipsPresentor.super.ctor(self)
end

function SortPanelTipsPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SortPanelTipsPresentor:dependWhatResources()
	return {
		"ui/views/common/sortpaneltipsview.prefab"
	}
end

function SortPanelTipsPresentor:buildViews()
	return {
		SortPanelTipsView.New()
	}
end

return SortPanelTipsPresentor
