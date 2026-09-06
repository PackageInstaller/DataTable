-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dress/view/SexchangetipViewPresentor.lua

module("logic.extensions.dress.view.SexchangetipViewPresentor", package.seeall)

local SexchangetipViewPresentor = class("SexchangetipViewPresentor", ViewPresentor)

function SexchangetipViewPresentor:ctor()
	SexchangetipViewPresentor.super.ctor(self)
end

function SexchangetipViewPresentor:attachToWhichRoot()
	return ViewRootType.Notify
end

function SexchangetipViewPresentor:dependWhatResources()
	return {
		"ui/views/dress/sexchangetipview.prefab"
	}
end

function SexchangetipViewPresentor:buildViews()
	return {
		SexchangetipView.New()
	}
end

return SexchangetipViewPresentor
