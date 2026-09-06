-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nineplace/view/NineplaceuplvsuccessedPresentor.lua

module("logic.extensions.nineplace.view.NineplaceuplvsuccessedPresentor", package.seeall)

local NineplaceuplvsuccessedPresentor = class("NineplaceuplvsuccessedPresentor", ViewPresentor)

function NineplaceuplvsuccessedPresentor:ctor()
	NineplaceuplvsuccessedPresentor.super.ctor(self)
end

function NineplaceuplvsuccessedPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NineplaceuplvsuccessedPresentor:dependWhatResources()
	return {
		"ui/views/nineplace/nineplaceuplvsuccessedview.prefab"
	}
end

function NineplaceuplvsuccessedPresentor:buildViews()
	return {
		NineplaceuplvsuccessedView.New()
	}
end

return NineplaceuplvsuccessedPresentor
