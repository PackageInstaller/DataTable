-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sendflower/view/CharmvalueViewPresentor.lua

module("logic.extensions.sendflower.view.CharmvalueViewPresentor", package.seeall)

local CharmvalueViewPresentor = class("CharmvalueViewPresentor", ViewPresentor)

function CharmvalueViewPresentor:ctor()
	CharmvalueViewPresentor.super.ctor(self)
end

function CharmvalueViewPresentor:attachToWhichRoot()
	return ViewRootType.Notify
end

function CharmvalueViewPresentor:dependWhatResources()
	return {
		"ui/views/sendflower/charmvalueview.prefab"
	}
end

function CharmvalueViewPresentor:buildViews()
	return {
		CharmvalueView.New()
	}
end

return CharmvalueViewPresentor
