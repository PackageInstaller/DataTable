-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitefuture/view/SaifumainViewPresentor.lua

module("logic.extensions.infinitefuture.view.SaifumainViewPresentor", package.seeall)

local SaifumainViewPresentor = class("SaifumainViewPresentor", ViewPresentor)

function SaifumainViewPresentor:ctor()
	SaifumainViewPresentor.super.ctor(self)
end

function SaifumainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SaifumainViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/infinitefuture/saifumainview.prefab"
	}
end

function SaifumainViewPresentor:buildViews()
	return {
		SaifumainView.New()
	}
end

return SaifumainViewPresentor
