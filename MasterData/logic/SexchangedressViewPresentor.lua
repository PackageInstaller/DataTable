-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dress/view/SexchangedressViewPresentor.lua

module("logic.extensions.dress.view.SexchangedressViewPresentor", package.seeall)

local SexchangedressViewPresentor = class("SexchangedressViewPresentor", ViewPresentor)

function SexchangedressViewPresentor:ctor()
	SexchangedressViewPresentor.super.ctor(self)
end

function SexchangedressViewPresentor:attachToWhichRoot()
	return ViewRootType.Notify
end

function SexchangedressViewPresentor:dependWhatResources()
	return {
		"ui/views/dress/sexchangedressview.prefab"
	}
end

function SexchangedressViewPresentor:buildViews()
	return {
		SexchangedressView.New()
	}
end

return SexchangedressViewPresentor
