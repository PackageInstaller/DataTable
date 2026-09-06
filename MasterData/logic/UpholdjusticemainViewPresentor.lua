-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/upholdjustice/view/UpholdjusticemainViewPresentor.lua

module("logic.extensions.upholdjustice.view.UpholdjusticemainViewPresentor", package.seeall)

local UpholdjusticemainViewPresentor = class("UpholdjusticemainViewPresentor", ViewPresentor)

function UpholdjusticemainViewPresentor:ctor()
	UpholdjusticemainViewPresentor.super.ctor(self)
end

function UpholdjusticemainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function UpholdjusticemainViewPresentor:dependWhatResources()
	return {
		"ui/views/upholdjustice/upholdjusticemainview.prefab"
	}
end

function UpholdjusticemainViewPresentor:buildViews()
	return {
		UpholdjusticemainView.New()
	}
end

return UpholdjusticemainViewPresentor
