-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dress/view/DressselltipViewPresentor.lua

module("logic.extensions.dress.view.DressselltipViewPresentor", package.seeall)

local DressselltipViewPresentor = class("DressselltipViewPresentor", ViewPresentor)

function DressselltipViewPresentor:ctor()
	DressselltipViewPresentor.super.ctor(self)
end

function DressselltipViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DressselltipViewPresentor:dependWhatResources()
	return {
		"ui/views/dress/dressselltipview.prefab"
	}
end

function DressselltipViewPresentor:buildViews()
	return {
		DressselltipView.New()
	}
end

return DressselltipViewPresentor
