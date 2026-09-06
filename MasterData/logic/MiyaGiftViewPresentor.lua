-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/miya/MiyaGiftViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.miya.MiyaGiftViewPresentor", package.seeall)

local MiyaGiftViewPresentor = class("MiyaGiftViewPresentor", ViewPresentor)

function MiyaGiftViewPresentor:ctor()
	MiyaGiftViewPresentor.super.ctor(self)
end

function MiyaGiftViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function MiyaGiftViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/miyagiftview.prefab"
	}
end

function MiyaGiftViewPresentor:buildViews()
	return {
		MiyaGiftView.New()
	}
end

return MiyaGiftViewPresentor
