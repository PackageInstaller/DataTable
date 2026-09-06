-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/neweranuoya/view/NeweranuoyamainViewPresentor.lua

module("logic.extensions.neweranuoya.view.NeweranuoyamainViewPresentor", package.seeall)

local NeweranuoyamainViewPresentor = class("NeweranuoyamainViewPresentor", ViewPresentor)

function NeweranuoyamainViewPresentor:ctor()
	NeweranuoyamainViewPresentor.super.ctor(self)
end

function NeweranuoyamainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NeweranuoyamainViewPresentor:dependWhatResources()
	return {
		"ui/views/neweranuoya/neweranuoyamainview.prefab"
	}
end

function NeweranuoyamainViewPresentor:buildViews()
	return {
		NeweranuoyamainView.New()
	}
end

return NeweranuoyamainViewPresentor
