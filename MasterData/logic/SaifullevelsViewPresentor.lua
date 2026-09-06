-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitefuture/view/SaifullevelsViewPresentor.lua

module("logic.extensions.infinitefuture.view.SaifullevelsViewPresentor", package.seeall)

local SaifullevelsViewPresentor = class("SaifullevelsViewPresentor", ViewPresentor)

function SaifullevelsViewPresentor:ctor()
	SaifullevelsViewPresentor.super.ctor(self)
end

function SaifullevelsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SaifullevelsViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/infinitefuture/saifullevelsview.prefab"
	}
end

function SaifullevelsViewPresentor:buildViews()
	return {
		SaifullevelsView.New()
	}
end

return SaifullevelsViewPresentor
