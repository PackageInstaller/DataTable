-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/birthdaywishes/view/CollectblessingrecordViewPresentor.lua

module("logic.extensions.birthdaywishes.view.CollectblessingrecordViewPresentor", package.seeall)

local CollectblessingrecordViewPresentor = class("CollectblessingrecordViewPresentor", ViewPresentor)

function CollectblessingrecordViewPresentor:ctor()
	CollectblessingrecordViewPresentor.super.ctor(self)
end

function CollectblessingrecordViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CollectblessingrecordViewPresentor:dependWhatResources()
	return {
		"ui/views/collectblessing/collectblessingrecordview.prefab"
	}
end

function CollectblessingrecordViewPresentor:buildViews()
	return {
		CollectBlessingRecordView.New()
	}
end

return CollectblessingrecordViewPresentor
