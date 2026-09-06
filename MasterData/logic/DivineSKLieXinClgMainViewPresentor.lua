-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineskliexinclg/view/DivineSKLieXinClgMainViewPresentor.lua

module("logic.extensions.divineskliexinclg.view.DivineSKLieXinClgMainViewPresentor", package.seeall)

local DivineSKLieXinClgMainViewPresentor = class("DivineSKLieXinClgMainViewPresentor", ViewPresentor)

function DivineSKLieXinClgMainViewPresentor:ctor()
	DivineSKLieXinClgMainViewPresentor.super.ctor(self)
end

function DivineSKLieXinClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineSKLieXinClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/divineskliexinclg/divineskliexinclgmainview.prefab"
	}
end

function DivineSKLieXinClgMainViewPresentor:buildViews()
	return {
		DivineSKLieXinClgMainView.New()
	}
end

return DivineSKLieXinClgMainViewPresentor
