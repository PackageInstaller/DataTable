-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pk/view/PkjoinViewPresentor.lua

module("logic.extensions.pk.view.PkjoinViewPresentor", package.seeall)

local PkjoinViewPresentor = class("PkjoinViewPresentor", ViewPresentor)

function PkjoinViewPresentor:ctor()
	PkjoinViewPresentor.super.ctor(self)
end

function PkjoinViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PkjoinViewPresentor:dependWhatResources()
	return {
		"ui/views/pk/pkjoinview.prefab"
	}
end

function PkjoinViewPresentor:buildViews()
	return {
		PkjoinView.New()
	}
end

return PkjoinViewPresentor
