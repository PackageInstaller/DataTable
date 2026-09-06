-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/birthdaywishes/view/CollectblessingmainViewPresentor.lua

module("logic.extensions.birthdaywishes.view.CollectblessingmainViewPresentor", package.seeall)

local CollectblessingmainViewPresentor = class("CollectblessingmainViewPresentor", ViewPresentor)

function CollectblessingmainViewPresentor:ctor()
	CollectblessingmainViewPresentor.super.ctor(self)
end

function CollectblessingmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CollectblessingmainViewPresentor:dependWhatResources()
	return {
		"ui/views/collectblessing/collectblessingmainview.prefab"
	}
end

function CollectblessingmainViewPresentor:buildViews()
	return {
		CollectBlessingMainView.New()
	}
end

return CollectblessingmainViewPresentor
