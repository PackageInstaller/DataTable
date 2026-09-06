-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doushouqi/view/DoushouqirewardViewPresentor.lua

module("logic.extensions.doushouqi.view.DoushouqirewardViewPresentor", package.seeall)

local DoushouqirewardViewPresentor = class("DoushouqirewardViewPresentor", ViewPresentor)

function DoushouqirewardViewPresentor:ctor()
	DoushouqirewardViewPresentor.super.ctor(self)
end

function DoushouqirewardViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DoushouqirewardViewPresentor:dependWhatResources()
	return {
		"ui/views/doushouqi/doushouqirewardview.prefab"
	}
end

function DoushouqirewardViewPresentor:buildViews()
	return {
		DoushouqirewardView.New()
	}
end

return DoushouqirewardViewPresentor
