-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/birthdaywishes/view/CollectblessinggiveViewPresentor.lua

module("logic.extensions.birthdaywishes.view.CollectblessinggiveViewPresentor", package.seeall)

local CollectblessinggiveViewPresentor = class("CollectblessinggiveViewPresentor", ViewPresentor)

function CollectblessinggiveViewPresentor:ctor()
	CollectblessinggiveViewPresentor.super.ctor(self)
end

function CollectblessinggiveViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CollectblessinggiveViewPresentor:dependWhatResources()
	return {
		"ui/views/collectblessing/collectblessinggiveview.prefab"
	}
end

function CollectblessinggiveViewPresentor:buildViews()
	return {
		CollectBlessingGiveView.New()
	}
end

return CollectblessinggiveViewPresentor
