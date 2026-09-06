-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/traincampqiecuo/view/PkcreateroomViewPresentor.lua

module("logic.extensions.pk.view.PkcreateroomViewPresentor", package.seeall)

local PkcreateroomViewPresentor = class("PkcreateroomViewPresentor", ViewPresentor)

function PkcreateroomViewPresentor:ctor()
	PkcreateroomViewPresentor.super.ctor(self)
end

function PkcreateroomViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PkcreateroomViewPresentor:dependWhatResources()
	return {
		"ui/views/traincampqiecuo/pkcreateroomview.prefab"
	}
end

function PkcreateroomViewPresentor:buildViews()
	return {
		PkcreateroomView.New()
	}
end

return PkcreateroomViewPresentor
