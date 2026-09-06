-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/heartofaojiurep/view/HeartofaojiureprankExtViewPresentor.lua

module("logic.extensions.heartofaojiurep.view.HeartofaojiureprankExtViewPresentor", package.seeall)

local HeartofaojiureprankExtViewPresentor = class("HeartofaojiureprankExtViewPresentor", ViewPresentor)

function HeartofaojiureprankExtViewPresentor:ctor()
	HeartofaojiureprankExtViewPresentor.super.ctor(self)
end

function HeartofaojiureprankExtViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HeartofaojiureprankExtViewPresentor:dependWhatResources()
	return {
		"ui/views/heartofaojiurep/heartofaojiurepextrankview.prefab"
	}
end

function HeartofaojiureprankExtViewPresentor:buildViews()
	return {
		HeartofaojiureprankExtView.New()
	}
end

return HeartofaojiureprankExtViewPresentor
