-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newhandwelfare/view/NewhandawakengiftViewPresentor.lua

module("logic.extensions.newhandwelfare.view.NewhandawakengiftViewPresentor", package.seeall)

local NewhandawakengiftViewPresentor = class("NewhandawakengiftViewPresentor", ViewPresentor)

function NewhandawakengiftViewPresentor:ctor()
	NewhandawakengiftViewPresentor.super.ctor(self)
end

function NewhandawakengiftViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function NewhandawakengiftViewPresentor:dependWhatResources()
	return {
		"ui/views/newhandwelfare/newhandawakengiftview.prefab"
	}
end

function NewhandawakengiftViewPresentor:buildViews()
	return {
		NewhandawakengiftView.New()
	}
end

return NewhandawakengiftViewPresentor
