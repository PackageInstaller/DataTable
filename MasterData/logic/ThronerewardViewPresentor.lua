-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/throne/view/ThronerewardViewPresentor.lua

module("logic.extensions.throne.view.ThronerewardViewPresentor", package.seeall)

local ThronerewardViewPresentor = class("ThronerewardViewPresentor", ViewPresentor)

function ThronerewardViewPresentor:ctor()
	ThronerewardViewPresentor.super.ctor(self)
end

function ThronerewardViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ThronerewardViewPresentor:dependWhatResources()
	return {
		"ui/views/throne/thronerewardview.prefab"
	}
end

function ThronerewardViewPresentor:buildViews()
	return {
		ThronerewardView.New()
	}
end

return ThronerewardViewPresentor
