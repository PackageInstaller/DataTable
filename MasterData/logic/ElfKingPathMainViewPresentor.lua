-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elfkingpath/view/ElfKingPathMainViewPresentor.lua

module("logic.extensions.elfkingpath.view.ElfKingPathMainViewPresentor", package.seeall)

local ElfKingPathMainViewPresentor = class("ElfKingPathMainViewPresentor", ViewPresentor)

function ElfKingPathMainViewPresentor:ctor()
	ElfKingPathMainViewPresentor.super.ctor(self)
end

function ElfKingPathMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ElfKingPathMainViewPresentor:dependWhatResources()
	return {
		"ui/views/elfkingpath/elfkingpathmainview.prefab"
	}
end

function ElfKingPathMainViewPresentor:buildViews()
	return {
		ElfKingPathMainView.New()
	}
end

return ElfKingPathMainViewPresentor
