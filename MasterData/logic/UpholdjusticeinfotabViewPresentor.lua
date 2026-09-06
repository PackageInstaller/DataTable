-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/upholdjustice/view/UpholdjusticeinfotabViewPresentor.lua

module("logic.extensions.upholdjustice.view.UpholdjusticeinfotabViewPresentor", package.seeall)

local UpholdjusticeinfotabViewPresentor = class("UpholdjusticeinfotabViewPresentor", ViewPresentor)

function UpholdjusticeinfotabViewPresentor:ctor()
	UpholdjusticeinfotabViewPresentor.super.ctor(self)
end

function UpholdjusticeinfotabViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function UpholdjusticeinfotabViewPresentor:dependWhatResources()
	return {
		"ui/views/upholdjustice/upholdjusticeinfotabview.prefab"
	}
end

function UpholdjusticeinfotabViewPresentor:buildViews()
	return {
		UpholdjusticeinfotabView.New()
	}
end

return UpholdjusticeinfotabViewPresentor
