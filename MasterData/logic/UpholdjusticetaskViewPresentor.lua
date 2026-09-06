-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/upholdjustice/view/UpholdjusticetaskViewPresentor.lua

module("logic.extensions.upholdjustice.view.UpholdjusticetaskViewPresentor", package.seeall)

local UpholdjusticetaskViewPresentor = class("UpholdjusticetaskViewPresentor", ViewPresentor)

function UpholdjusticetaskViewPresentor:ctor()
	UpholdjusticetaskViewPresentor.super.ctor(self)
end

function UpholdjusticetaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function UpholdjusticetaskViewPresentor:dependWhatResources()
	return {
		"ui/views/upholdjustice/upholdjusticetaskview.prefab"
	}
end

function UpholdjusticetaskViewPresentor:buildViews()
	return {
		UpholdjusticetaskView.New()
	}
end

return UpholdjusticetaskViewPresentor
