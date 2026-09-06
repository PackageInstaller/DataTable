-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originaresmom/view/OriginaresmomnorresultViewPresentor.lua

module("logic.extensions.originaresmom.view.OriginaresmomnorresultViewPresentor", package.seeall)

local OriginaresmomnorresultViewPresentor = class("OriginaresmomnorresultViewPresentor", ViewPresentor)

function OriginaresmomnorresultViewPresentor:ctor()
	OriginaresmomnorresultViewPresentor.super.ctor(self)
end

function OriginaresmomnorresultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginaresmomnorresultViewPresentor:dependWhatResources()
	return {
		"ui/views/originaresmom/originaresmomnorresultview.prefab"
	}
end

function OriginaresmomnorresultViewPresentor:buildViews()
	return {
		OriginaresmomnorresultView.New()
	}
end

return OriginaresmomnorresultViewPresentor
