-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dress/view/DressoutViewPresentor.lua

module("logic.extensions.dress.view.DressoutViewPresentor", package.seeall)

local DressoutViewPresentor = class("DressoutViewPresentor", ViewPresentor)

function DressoutViewPresentor:ctor()
	DressoutViewPresentor.super.ctor(self)
end

function DressoutViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DressoutViewPresentor:dependWhatResources()
	return {
		"ui/views/dress/dressoutview.prefab"
	}
end

function DressoutViewPresentor:buildViews()
	return {
		DressoutView.New()
	}
end

return DressoutViewPresentor
