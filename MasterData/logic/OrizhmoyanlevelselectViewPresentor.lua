-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fantian/view/copy/OrizhmoyanlevelselectViewPresentor.lua

module("logic.extensions.fantian.view.copy.OrizhmoyanlevelselectViewPresentor", package.seeall)

local OrizhmoyanlevelselectViewPresentor = class("OrizhmoyanlevelselectViewPresentor", ViewPresentor)

function OrizhmoyanlevelselectViewPresentor:ctor()
	OrizhmoyanlevelselectViewPresentor.super.ctor(self)
end

function OrizhmoyanlevelselectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OrizhmoyanlevelselectViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/fantian/copy/orizhmoyanlevelselectview.prefab"
	}
end

function OrizhmoyanlevelselectViewPresentor:buildViews()
	return {
		OrizhmoyanlevelselectView.New()
	}
end

return OrizhmoyanlevelselectViewPresentor
