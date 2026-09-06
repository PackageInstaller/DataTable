-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/FamilysingleapplyViewPresentor.lua

module("logic.extensions.family.view.FamilysingleapplyViewPresentor", package.seeall)

local FamilysingleapplyViewPresentor = class("FamilysingleapplyViewPresentor", ViewPresentor)

function FamilysingleapplyViewPresentor:ctor()
	FamilysingleapplyViewPresentor.super.ctor(self)
end

function FamilysingleapplyViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FamilysingleapplyViewPresentor:dependWhatResources()
	return {
		"ui/views/family/familysingleapplyview.prefab"
	}
end

function FamilysingleapplyViewPresentor:buildViews()
	return {
		FamilysingleapplyView.New()
	}
end

return FamilysingleapplyViewPresentor
