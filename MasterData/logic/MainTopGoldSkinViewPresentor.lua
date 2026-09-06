-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/MainTopGoldSkinViewPresentor.lua

module("logic.extensions.roleinfo.view.MainTopGoldSkinViewPresentor", package.seeall)

local MainTopGoldSkinViewPresentor = class("MainTopGoldSkinViewPresentor", ViewPresentor)

function MainTopGoldSkinViewPresentor:ctor()
	MainTopGoldSkinViewPresentor.super.ctor(self)
end

function MainTopGoldSkinViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MainTopGoldSkinViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/exteriorskin/maintopgoldskinview.prefab"
	}
end

function MainTopGoldSkinViewPresentor:buildViews()
	return {
		MainTopGoldSkinView.New()
	}
end

return MainTopGoldSkinViewPresentor
