-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinefuyaoclg/view/DivineFuYaoClgExtremeViewPresentor.lua

module("logic.extensions.divinefuyaoclg.view.DivineFuYaoClgExtremeViewPresentor", package.seeall)

local DivineFuYaoClgExtremeViewPresentor = class("DivineFuYaoClgExtremeViewPresentor", ViewPresentor)

function DivineFuYaoClgExtremeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineFuYaoClgExtremeViewPresentor:dependWhatResources()
	return {
		"ui/views/divinefuyaoclg/divinefuyaoclgextremeview.prefab"
	}
end

function DivineFuYaoClgExtremeViewPresentor:buildViews()
	return {
		DivineFuYaoClgExtremeView.New()
	}
end

return DivineFuYaoClgExtremeViewPresentor
