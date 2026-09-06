-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newhandwelfare/view/NewhandwelfareenterViewPresentor.lua

module("logic.extensions.newhandwelfare.view.NewhandwelfareenterViewPresentor", package.seeall)

local NewhandwelfareenterViewPresentor = class("NewhandwelfareenterViewPresentor", ViewPresentor)

function NewhandwelfareenterViewPresentor:ctor()
	NewhandwelfareenterViewPresentor.super.ctor(self)
end

function NewhandwelfareenterViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NewhandwelfareenterViewPresentor:dependWhatResources()
	return {
		"ui/views/newhandwelfare/newhandwelfareenterview.prefab"
	}
end

function NewhandwelfareenterViewPresentor:buildViews()
	return {
		NewhandwelfareenterView.New()
	}
end

return NewhandwelfareenterViewPresentor
