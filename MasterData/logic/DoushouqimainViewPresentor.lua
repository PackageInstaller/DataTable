-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doushouqi/view/DoushouqimainViewPresentor.lua

module("logic.extensions.doushouqi.view.DoushouqimainViewPresentor", package.seeall)

local DoushouqimainViewPresentor = class("DoushouqimainViewPresentor", ViewPresentor)

function DoushouqimainViewPresentor:ctor()
	DoushouqimainViewPresentor.super.ctor(self)
end

function DoushouqimainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DoushouqimainViewPresentor:dependWhatResources()
	return {
		"ui/views/doushouqi/doushouqimainview.prefab"
	}
end

function DoushouqimainViewPresentor:buildViews()
	return {
		DoushouqimainView.New()
	}
end

return DoushouqimainViewPresentor
