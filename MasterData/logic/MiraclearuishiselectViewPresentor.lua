-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiunuobrotherhood/view/copy/MiraclearuishiselectViewPresentor.lua

module("logic.extensions.xiunuobrotherhood.view.copy.MiraclearuishiselectViewPresentor", package.seeall)

local MiraclearuishiselectViewPresentor = class("MiraclearuishiselectViewPresentor", ViewPresentor)

function MiraclearuishiselectViewPresentor:ctor()
	MiraclearuishiselectViewPresentor.super.ctor(self)
end

function MiraclearuishiselectViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function MiraclearuishiselectViewPresentor:dependWhatResources()
	return {
		"ui/views/xiunuobrotherhood/copy/miraclearuishiselectview.prefab"
	}
end

function MiraclearuishiselectViewPresentor:buildViews()
	return {
		MiraclearuishiselectView.New()
	}
end

return MiraclearuishiselectViewPresentor
