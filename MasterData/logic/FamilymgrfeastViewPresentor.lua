-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/FamilymgrfeastViewPresentor.lua

module("logic.extensions.family.view.FamilymgrfeastViewPresentor", package.seeall)

local FamilymgrfeastViewPresentor = class("FamilymgrfeastViewPresentor", ViewPresentor)

function FamilymgrfeastViewPresentor:ctor()
	FamilymgrfeastViewPresentor.super.ctor(self)
end

function FamilymgrfeastViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FamilymgrfeastViewPresentor:dependWhatResources()
	return {
		"ui/views/family/familymgrfeastview.prefab"
	}
end

function FamilymgrfeastViewPresentor:buildViews()
	return {
		FamilymgrfeastView.New()
	}
end

function FamilymgrfeastViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return FamilymgrfeastViewPresentor
