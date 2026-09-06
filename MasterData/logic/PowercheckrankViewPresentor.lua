-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/handbook/view/PowercheckrankViewPresentor.lua

module("logic.extensions.handbook.view.PowercheckrankViewPresentor", package.seeall)

local PowercheckrankViewPresentor = class("PowercheckrankViewPresentor", ViewPresentor)

function PowercheckrankViewPresentor:ctor()
	PowercheckrankViewPresentor.super.ctor(self)
end

function PowercheckrankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PowercheckrankViewPresentor:dependWhatResources()
	return {
		"ui/views/powercheck/powercheckrankview.prefab"
	}
end

function PowercheckrankViewPresentor:buildViews()
	return {
		PowercheckrankView.New()
	}
end

return PowercheckrankViewPresentor
