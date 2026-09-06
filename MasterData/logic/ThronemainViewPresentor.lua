-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/throne/view/ThronemainViewPresentor.lua

module("logic.extensions.throne.view.ThronemainViewPresentor", package.seeall)

local ThronemainViewPresentor = class("ThronemainViewPresentor", ViewWithGuidePresentor)

function ThronemainViewPresentor:ctor()
	ThronemainViewPresentor.super.ctor(self)
end

function ThronemainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ThronemainViewPresentor:dependWhatResources()
	return {
		"ui/views/throne/thronemainview.prefab"
	}
end

function ThronemainViewPresentor:buildViews()
	return {
		ThronemainView.New()
	}
end

return ThronemainViewPresentor
