-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinefuyaoclg/view/DivineFuYaoClgExtResultPopViewPresentor.lua

module("logic.extensions.divinefuyaoclg.view.DivineFuYaoClgExtResultPopViewPresentor", package.seeall)

local DivineFuYaoClgExtResultPopViewPresentor = class("DivineFuYaoClgExtResultPopViewPresentor", ViewPresentor)

function DivineFuYaoClgExtResultPopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineFuYaoClgExtResultPopViewPresentor:dependWhatResources()
	return {
		"ui/views/divinefuyaoclg/divinefuyaoclgextresultpopview.prefab"
	}
end

function DivineFuYaoClgExtResultPopViewPresentor:buildViews()
	return {
		DivineFuYaoClgExtResultPopView.New()
	}
end

return DivineFuYaoClgExtResultPopViewPresentor
