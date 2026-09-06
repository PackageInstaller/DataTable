-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lailisi/view/diana/DianalevelsViewPresentor.lua

module("logic.extensions.lailisi.view.diana.DianalevelsViewPresentor", package.seeall)

local DianalevelsViewPresentor = class("DianalevelsViewPresentor", ViewPresentor)

function DianalevelsViewPresentor:ctor()
	DianalevelsViewPresentor.super.ctor(self)
end

function DianalevelsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DianalevelsViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/diana/dianalevelsview.prefab"
	}
end

function DianalevelsViewPresentor:buildViews()
	return {
		DianalevelsView.New()
	}
end

return DianalevelsViewPresentor
