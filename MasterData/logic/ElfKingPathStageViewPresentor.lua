-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elfkingpath/view/ElfKingPathStageViewPresentor.lua

module("logic.extensions.elfkingpath.view.ElfKingPathStageViewPresentor", package.seeall)

local ElfKingPathStageViewPresentor = class("ElfKingPathStageViewPresentor", ViewPresentor)

function ElfKingPathStageViewPresentor:ctor()
	ElfKingPathStageViewPresentor.super.ctor(self)
end

function ElfKingPathStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ElfKingPathStageViewPresentor:dependWhatResources()
	return {
		"ui/views/elfkingpath/elfkingpathstageview.prefab"
	}
end

function ElfKingPathStageViewPresentor:buildViews()
	return {
		ElfKingPathStageView.New()
	}
end

return ElfKingPathStageViewPresentor
