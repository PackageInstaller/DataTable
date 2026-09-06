-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sevendays/view/SevenSignViewPresentor.lua

module("logic.extensions.sevendays.view.SevenSignViewPresentor", package.seeall)

local SevenSignViewPresentor = class("SevenSignViewPresentor", ViewPresentor)

function SevenSignViewPresentor:ctor()
	SevenSignViewPresentor.super.ctor(self)
end

function SevenSignViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SevenSignViewPresentor:dependWhatResources()
	return {
		"ui/views/sevendays/sevensignview.prefab"
	}
end

function SevenSignViewPresentor:buildViews()
	return {
		SevenSignView.New()
	}
end

return SevenSignViewPresentor
