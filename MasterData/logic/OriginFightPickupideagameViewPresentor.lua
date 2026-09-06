-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originfight/view/OriginFightPickupideagameViewPresentor.lua

module("logic.extensions.originfight.view.OriginFightPickupideagameViewPresentor", package.seeall)

local OriginFightPickupideagameViewPresentor = class("OriginFightPickupideagameViewPresentor", ViewPresentor)

function OriginFightPickupideagameViewPresentor:ctor()
	OriginFightPickupideagameViewPresentor.super.ctor(self)
end

function OriginFightPickupideagameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginFightPickupideagameViewPresentor:dependWhatResources()
	return {
		"ui/views/originfight/originfightpickupideagameview.prefab"
	}
end

function OriginFightPickupideagameViewPresentor:buildViews()
	return {
		OriginFightPickupideagameView.New()
	}
end

return OriginFightPickupideagameViewPresentor
