-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originaresmom/view/OriginaresmomextresultViewPresentor.lua

module("logic.extensions.originaresmom.view.OriginaresmomextresultViewPresentor", package.seeall)

local OriginaresmomextresultViewPresentor = class("OriginaresmomextresultViewPresentor", ViewPresentor)

function OriginaresmomextresultViewPresentor:ctor()
	OriginaresmomextresultViewPresentor.super.ctor(self)
end

function OriginaresmomextresultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginaresmomextresultViewPresentor:dependWhatResources()
	return {
		"ui/views/originaresmom/originaresmomextresultview.prefab"
	}
end

function OriginaresmomextresultViewPresentor:buildViews()
	return {
		OriginaresmomextresultView.New()
	}
end

return OriginaresmomextresultViewPresentor
