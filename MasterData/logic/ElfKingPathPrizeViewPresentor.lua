-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elfkingpath/view/ElfKingPathPrizeViewPresentor.lua

module("logic.extensions.elfkingpath.view.ElfKingPathPrizeViewPresentor", package.seeall)

local ElfKingPathPrizeViewPresentor = class("ElfKingPathPrizeViewPresentor", ViewPresentor)

function ElfKingPathPrizeViewPresentor:ctor()
	ElfKingPathPrizeViewPresentor.super.ctor(self)
end

function ElfKingPathPrizeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ElfKingPathPrizeViewPresentor:dependWhatResources()
	return {
		"ui/views/elfkingpath/elfkingpathprizeview.prefab"
	}
end

function ElfKingPathPrizeViewPresentor:buildViews()
	return {
		ElfKingPathPrizeView.New()
	}
end

return ElfKingPathPrizeViewPresentor
