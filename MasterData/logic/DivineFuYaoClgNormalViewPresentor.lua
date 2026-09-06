-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinefuyaoclg/view/DivineFuYaoClgNormalViewPresentor.lua

module("logic.extensions.divinefuyaoclg.view.DivineFuYaoClgNormalViewPresentor", package.seeall)

local DivineFuYaoClgNormalViewPresentor = class("DivineFuYaoClgNormalViewPresentor", ViewPresentor)

function DivineFuYaoClgNormalViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineFuYaoClgNormalViewPresentor:dependWhatResources()
	return {
		"ui/views/divinefuyaoclg/divinefuyaoclgnormalview.prefab"
	}
end

function DivineFuYaoClgNormalViewPresentor:buildViews()
	return {
		DivineFuYaoClgNormalView.New()
	}
end

return DivineFuYaoClgNormalViewPresentor
