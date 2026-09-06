-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sendflower/view/FlowerrecordsViewPresentor.lua

module("logic.extensions.sendflower.view.FlowerrecordsViewPresentor", package.seeall)

local FlowerrecordsViewPresentor = class("FlowerrecordsViewPresentor", ViewPresentor)

function FlowerrecordsViewPresentor:ctor()
	FlowerrecordsViewPresentor.super.ctor(self)
end

function FlowerrecordsViewPresentor:attachToWhichRoot()
	return ViewRootType.Notify
end

function FlowerrecordsViewPresentor:dependWhatResources()
	return {
		"ui/views/sendflower/flowerrecordsview.prefab"
	}
end

function FlowerrecordsViewPresentor:buildViews()
	return {
		FlowerrecordsView.New()
	}
end

return FlowerrecordsViewPresentor
