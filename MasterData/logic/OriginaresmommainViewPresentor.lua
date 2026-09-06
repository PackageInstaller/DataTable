-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originaresmom/view/OriginaresmommainViewPresentor.lua

module("logic.extensions.originaresmom.view.OriginaresmommainViewPresentor", package.seeall)

local OriginaresmommainViewPresentor = class("OriginaresmommainViewPresentor", ViewPresentor)

function OriginaresmommainViewPresentor:ctor()
	OriginaresmommainViewPresentor.super.ctor(self)
end

function OriginaresmommainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginaresmommainViewPresentor:dependWhatResources()
	return {
		"ui/views/originaresmom/originaresmommainview.prefab"
	}
end

function OriginaresmommainViewPresentor:buildViews()
	return {
		OriginaresmommainView.New()
	}
end

return OriginaresmommainViewPresentor
