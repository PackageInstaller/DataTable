-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/upholdjustice/view/UpholdjusticeranktabViewPresentor.lua

module("logic.extensions.upholdjustice.view.UpholdjusticeranktabViewPresentor", package.seeall)

local UpholdjusticeranktabViewPresentor = class("UpholdjusticeranktabViewPresentor", ViewPresentor)

function UpholdjusticeranktabViewPresentor:ctor()
	UpholdjusticeranktabViewPresentor.super.ctor(self)
end

function UpholdjusticeranktabViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function UpholdjusticeranktabViewPresentor:dependWhatResources()
	return {
		"ui/views/upholdjustice/upholdjusticeranktabview.prefab"
	}
end

function UpholdjusticeranktabViewPresentor:buildViews()
	return {
		UpholdjusticeranktabView.New()
	}
end

return UpholdjusticeranktabViewPresentor
