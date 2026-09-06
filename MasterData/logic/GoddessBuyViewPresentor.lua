-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessvote/view/GoddessBuyViewPresentor.lua

module("logic.extensions.goddessvote.view.GoddessBuyViewPresentor", package.seeall)

local GoddessBuyViewPresentor = class("GoddessBuyViewPresentor", ViewPresentor)

function GoddessBuyViewPresentor:ctor()
	GoddessBuyViewPresentor.super.ctor(self)
end

function GoddessBuyViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GoddessBuyViewPresentor:dependWhatResources()
	return {
		"ui/views/goddessvote/goddessbuyview.prefab"
	}
end

function GoddessBuyViewPresentor:buildViews()
	return {
		GoddessBuyView.New()
	}
end

return GoddessBuyViewPresentor
