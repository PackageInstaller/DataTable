-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elfkingpath/view/ElfKingPathFmtExViewPresentor.lua

module("logic.extensions.elfkingpath.view.ElfKingPathFmtExViewPresentor", package.seeall)

local ElfKingPathFmtExViewPresentor = class("ElfKingPathFmtExViewPresentor", ViewPresentor)

function ElfKingPathFmtExViewPresentor:ctor()
	ElfKingPathFmtExViewPresentor.super.ctor(self)
end

function ElfKingPathFmtExViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ElfKingPathFmtExViewPresentor:dependWhatResources()
	return {
		"ui/views/elfkingpath/elfkingpathfmtexview.prefab"
	}
end

function ElfKingPathFmtExViewPresentor:buildViews()
	return {
		ElfKingPathFmtExView.New()
	}
end

return ElfKingPathFmtExViewPresentor
