-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/upholdjustice/view/UpholdjusticepopupViewPresentor.lua

module("logic.extensions.upholdjustice.view.UpholdjusticepopupViewPresentor", package.seeall)

local UpholdjusticepopupViewPresentor = class("UpholdjusticepopupViewPresentor", ViewPresentor)

function UpholdjusticepopupViewPresentor:ctor()
	UpholdjusticepopupViewPresentor.super.ctor(self)
end

function UpholdjusticepopupViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function UpholdjusticepopupViewPresentor:dependWhatResources()
	return {
		"ui/views/upholdjustice/upholdjusticepopupview.prefab"
	}
end

function UpholdjusticepopupViewPresentor:buildViews()
	return {
		UpholdjusticepopupView.New()
	}
end

return UpholdjusticepopupViewPresentor
