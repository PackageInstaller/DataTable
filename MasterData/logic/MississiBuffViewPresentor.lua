-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/mississi/MississiBuffViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.mississi.MississiBuffViewPresentor", package.seeall)

local MississiBuffViewPresentor = class("MississiBuffViewPresentor", ViewPresentor)

function MississiBuffViewPresentor:ctor()
	MississiBuffViewPresentor.super.ctor(self)
end

function MississiBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MississiBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/mississi/mississibuffview.prefab"
	}
end

function MississiBuffViewPresentor:buildViews()
	return {
		MississiBuffView.New()
	}
end

return MississiBuffViewPresentor
