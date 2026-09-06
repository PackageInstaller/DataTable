-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/CutepetmypublicViewPresentor.lua

module("logic.extensions.cutepet.view.CutepetmypublicViewPresentor", package.seeall)

local CutepetmypublicViewPresentor = class("CutepetmypublicViewPresentor", ViewPresentor)

function CutepetmypublicViewPresentor:ctor()
	CutepetmypublicViewPresentor.super.ctor(self)
end

function CutepetmypublicViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CutepetmypublicViewPresentor:dependWhatResources()
	return {
		"ui/views/cutepet/cutepetmypublicview.prefab"
	}
end

function CutepetmypublicViewPresentor:buildViews()
	return {
		CutepetmypublicView.New()
	}
end

return CutepetmypublicViewPresentor
