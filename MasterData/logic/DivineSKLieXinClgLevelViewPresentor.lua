-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineskliexinclg/view/DivineSKLieXinClgLevelViewPresentor.lua

module("logic.extensions.divineskliexinclg.view.DivineSKLieXinClgLevelViewPresentor", package.seeall)

local DivineSKLieXinClgLevelViewPresentor = class("DivineSKLieXinClgLevelViewPresentor", ViewPresentor)

function DivineSKLieXinClgLevelViewPresentor:ctor()
	DivineSKLieXinClgLevelViewPresentor.super.ctor(self)
end

function DivineSKLieXinClgLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineSKLieXinClgLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/divineskliexinclg/divineskliexinclglevelview.prefab"
	}
end

function DivineSKLieXinClgLevelViewPresentor:buildViews()
	return {
		DivineSKLieXinClgLevelView.New()
	}
end

return DivineSKLieXinClgLevelViewPresentor
