-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/heartmoneycat/view/HeartmoneycatViewPresentor.lua

module("logic.extensions.heartmoneycat.view.HeartmoneycatViewPresentor", package.seeall)

local HeartmoneycatViewPresentor = class("HeartmoneycatViewPresentor", ViewPresentor)

function HeartmoneycatViewPresentor:ctor()
	HeartmoneycatViewPresentor.super.ctor(self)
end

function HeartmoneycatViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HeartmoneycatViewPresentor:dependWhatResources()
	return {
		"ui/views/heartmoneycat/heartmoneycatview.prefab"
	}
end

function HeartmoneycatViewPresentor:buildViews()
	return {
		HeartMoneyCatView.New()
	}
end

return HeartmoneycatViewPresentor
