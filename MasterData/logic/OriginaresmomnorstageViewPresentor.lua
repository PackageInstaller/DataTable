-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originaresmom/view/OriginaresmomnorstageViewPresentor.lua

module("logic.extensions.originaresmom.view.OriginaresmomnorstageViewPresentor", package.seeall)

local OriginaresmomnorstageViewPresentor = class("OriginaresmomnorstageViewPresentor", ViewPresentor)

function OriginaresmomnorstageViewPresentor:ctor()
	OriginaresmomnorstageViewPresentor.super.ctor(self)
end

function OriginaresmomnorstageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginaresmomnorstageViewPresentor:dependWhatResources()
	return {
		"ui/views/originaresmom/originaresmomnorstageview.prefab"
	}
end

function OriginaresmomnorstageViewPresentor:buildViews()
	return {
		OriginaresmomnorstageView.New()
	}
end

return OriginaresmomnorstageViewPresentor
