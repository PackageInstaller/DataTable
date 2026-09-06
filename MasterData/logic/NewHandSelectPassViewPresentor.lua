-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newhandwelfare/view/NewHandSelectPassViewPresentor.lua

module("logic.extensions.newhandwelfare.view.NewHandSelectPassViewPresentor", package.seeall)

local NewHandSelectPassViewPresentor = class("NewHandSelectPassViewPresentor", ViewPresentor)

function NewHandSelectPassViewPresentor:ctor()
	NewHandSelectPassViewPresentor.super.ctor(self)
end

function NewHandSelectPassViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function NewHandSelectPassViewPresentor:dependWhatResources()
	return {
		"ui/views/newhandwelfare/newhandselectpassview.prefab"
	}
end

function NewHandSelectPassViewPresentor:buildViews()
	return {
		NewHandSelectPassView.New()
	}
end

return NewHandSelectPassViewPresentor
