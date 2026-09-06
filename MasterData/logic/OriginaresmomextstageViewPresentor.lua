-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originaresmom/view/OriginaresmomextstageViewPresentor.lua

module("logic.extensions.originaresmom.view.OriginaresmomextstageViewPresentor", package.seeall)

local OriginaresmomextstageViewPresentor = class("OriginaresmomextstageViewPresentor", ViewPresentor)

function OriginaresmomextstageViewPresentor:ctor()
	OriginaresmomextstageViewPresentor.super.ctor(self)
end

function OriginaresmomextstageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginaresmomextstageViewPresentor:dependWhatResources()
	return {
		"ui/views/originaresmom/originaresmomextstageview.prefab"
	}
end

function OriginaresmomextstageViewPresentor:buildViews()
	return {
		OriginaresmomextstageView.New()
	}
end

return OriginaresmomextstageViewPresentor
