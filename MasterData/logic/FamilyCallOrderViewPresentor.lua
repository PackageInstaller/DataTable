-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/view/FamilyCallOrderViewPresentor.lua

module("logic.extensions.newfamily.view.FamilyCallOrderViewPresentor", package.seeall)

local FamilyCallOrderViewPresentor = class("FamilyCallOrderViewPresentor", ViewPresentor)

function FamilyCallOrderViewPresentor:ctor()
	FamilyCallOrderViewPresentor.super.ctor(self)
end

function FamilyCallOrderViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FamilyCallOrderViewPresentor:dependWhatResources()
	return {
		"ui/views/newfamily/callorder/familycallorderview.prefab"
	}
end

function FamilyCallOrderViewPresentor:buildViews()
	return {
		FamilyCallOrderView.New()
	}
end

return FamilyCallOrderViewPresentor
