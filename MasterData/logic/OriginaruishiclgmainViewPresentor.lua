-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originaruishiclg/view/OriginaruishiclgmainViewPresentor.lua

module("logic.extensions.originaruishiclg.view.OriginaruishiclgmainViewPresentor", package.seeall)

local OriginaruishiclgmainViewPresentor = class("OriginaruishiclgmainViewPresentor", ViewPresentor)

function OriginaruishiclgmainViewPresentor:ctor()
	OriginaruishiclgmainViewPresentor.super.ctor(self)
end

function OriginaruishiclgmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginaruishiclgmainViewPresentor:dependWhatResources()
	return {
		"ui/views/originaruishiclg/originaruishiclgmainview.prefab"
	}
end

function OriginaruishiclgmainViewPresentor:buildViews()
	return {
		OriginaruishiclgmainView.New()
	}
end

return OriginaruishiclgmainViewPresentor
