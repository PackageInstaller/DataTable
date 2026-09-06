-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doubleeleven/view/SeckillZoneViewPresentor.lua

module("logic.extensions.doubleeleven.view.SeckillZoneViewPresentor", package.seeall)

local SeckillZoneViewPresentor = class("SeckillZoneViewPresentor", ViewWithGuidePresentor)

function SeckillZoneViewPresentor:ctor()
	SeckillZoneViewPresentor.super.ctor(self)
end

function SeckillZoneViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeckillZoneViewPresentor:dependWhatResources()
	return {
		"ui/views/doubleeleven/seckillzoneview.prefab"
	}
end

function SeckillZoneViewPresentor:buildViews()
	return {
		SeckillZoneView.New()
	}
end

return SeckillZoneViewPresentor
