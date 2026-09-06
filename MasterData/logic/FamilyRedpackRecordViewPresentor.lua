-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/FamilyRedpackRecordViewPresentor.lua

module("logic.extensions.family.view.FamilyRedpackRecordViewPresentor", package.seeall)

local FamilyRedpackRecordViewPresentor = class("FamilyRedpackRecordViewPresentor", ViewWithGuidePresentor)

function FamilyRedpackRecordViewPresentor:ctor()
	FamilyRedpackRecordViewPresentor.super.ctor(self)
end

function FamilyRedpackRecordViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FamilyRedpackRecordViewPresentor:dependWhatResources()
	return {
		"ui/views/family/familyredpackrecordview.prefab"
	}
end

function FamilyRedpackRecordViewPresentor:buildViews()
	return {
		FamilyRedpackRecordView.New()
	}
end

return FamilyRedpackRecordViewPresentor
