-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doushouqi/view/DoushouqirankViewPresentor.lua

module("logic.extensions.doushouqi.view.DoushouqirankViewPresentor", package.seeall)

local DoushouqirankViewPresentor = class("DoushouqirankViewPresentor", ViewPresentor)

function DoushouqirankViewPresentor:ctor()
	DoushouqirankViewPresentor.super.ctor(self)
end

function DoushouqirankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DoushouqirankViewPresentor:dependWhatResources()
	return {
		"ui/views/doushouqi/doushouqirankview.prefab"
	}
end

function DoushouqirankViewPresentor:buildViews()
	return {
		DoushouqirankView.New()
	}
end

return DoushouqirankViewPresentor
