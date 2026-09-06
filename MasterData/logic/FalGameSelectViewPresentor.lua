-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/landlords/view/FalGameSelectViewPresentor.lua

module("logic.extensions.landlords.view.FalGameSelectViewPresentor", package.seeall)

local FalGameSelectViewPresentor = class("FalGameSelectViewPresentor", ViewPresentor)

function FalGameSelectViewPresentor:ctor()
	FalGameSelectViewPresentor.super.ctor(self)
end

function FalGameSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FalGameSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/landlords/falgameselectview.prefab"
	}
end

function FalGameSelectViewPresentor:buildViews()
	return {
		FalGameSelectView.New()
	}
end

return FalGameSelectViewPresentor
