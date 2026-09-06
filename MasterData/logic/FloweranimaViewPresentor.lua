-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sendflower/view/FloweranimaViewPresentor.lua

module("logic.extensions.sendflower.view.FloweranimaViewPresentor", package.seeall)

local FloweranimaViewPresentor = class("FloweranimaViewPresentor", ViewPresentor)

function FloweranimaViewPresentor:ctor()
	FloweranimaViewPresentor.super.ctor(self)
end

function FloweranimaViewPresentor:attachToWhichRoot()
	return ViewRootType.Top
end

function FloweranimaViewPresentor:dependWhatResources()
	return {
		"ui/views/sendflower/floweranimaview.prefab"
	}
end

function FloweranimaViewPresentor:buildViews()
	return {
		FlowerAnimaView.New()
	}
end

return FloweranimaViewPresentor
