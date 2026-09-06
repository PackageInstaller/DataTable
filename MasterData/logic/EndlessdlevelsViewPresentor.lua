-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitefuture/view/EndlessdlevelsViewPresentor.lua

module("logic.extensions.infinitefuture.view.EndlessdlevelsViewPresentor", package.seeall)

local EndlessdlevelsViewPresentor = class("EndlessdlevelsViewPresentor", ViewPresentor)

function EndlessdlevelsViewPresentor:ctor()
	EndlessdlevelsViewPresentor.super.ctor(self)
end

function EndlessdlevelsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function EndlessdlevelsViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/infinitefuture/endlessdlevelsview.prefab"
	}
end

function EndlessdlevelsViewPresentor:buildViews()
	return {
		EndlessdlevelsView.New()
	}
end

return EndlessdlevelsViewPresentor
