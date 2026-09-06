-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originaruishiclg/view/OriginaruishiclgstageViewPresentor.lua

module("logic.extensions.originaruishiclg.view.OriginaruishiclgstageViewPresentor", package.seeall)

local OriginaruishiclgstageViewPresentor = class("OriginaruishiclgstageViewPresentor", ViewPresentor)

function OriginaruishiclgstageViewPresentor:ctor()
	OriginaruishiclgstageViewPresentor.super.ctor(self)
end

function OriginaruishiclgstageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginaruishiclgstageViewPresentor:dependWhatResources()
	return {
		"ui/views/originaruishiclg/originaruishiclgstageview.prefab"
	}
end

function OriginaruishiclgstageViewPresentor:buildViews()
	return {
		OriginaruishiclgstageView.New()
	}
end

return OriginaruishiclgstageViewPresentor
