-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinefuyaoclg/view/DivineFuYaoClgMainViewPresentor.lua

module("logic.extensions.divinefuyaoclg.view.DivineFuYaoClgMainViewPresentor", package.seeall)

local DivineFuYaoClgMainViewPresentor = class("DivineFuYaoClgMainViewPresentor", ViewPresentor)

function DivineFuYaoClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineFuYaoClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/divinefuyaoclg/divinefuyaoclgmainview.prefab"
	}
end

function DivineFuYaoClgMainViewPresentor:buildViews()
	return {
		DivineFuYaoClgMainView.New()
	}
end

return DivineFuYaoClgMainViewPresentor
