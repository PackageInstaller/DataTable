-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recommendfmt/view/PetNoticeViewPresentor.lua

module("logic.extensions.recommendfmt.view.PetNoticeViewPresentor", package.seeall)

local PetNoticeViewPresentor = class("PetNoticeViewPresentor", ViewPresentor)

function PetNoticeViewPresentor:ctor()
	PetNoticeViewPresentor.super.ctor(self)
end

function PetNoticeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetNoticeViewPresentor:dependWhatResources()
	return {
		"ui/views/recommendfmt/petnoticeview.prefab"
	}
end

function PetNoticeViewPresentor:buildViews()
	return {
		PetNoticeView.New()
	}
end

return PetNoticeViewPresentor
