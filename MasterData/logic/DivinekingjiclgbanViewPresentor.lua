-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingjiclg/view/DivinekingjiclgbanViewPresentor.lua

module("logic.extensions.divinekingjiclg.view.DivinekingjiclgbanViewPresentor", package.seeall)

local DivinekingjiclgbanViewPresentor = class("DivinekingjiclgbanViewPresentor", ViewPresentor)

function DivinekingjiclgbanViewPresentor:ctor()
	DivinekingjiclgbanViewPresentor.super.ctor(self)
end

function DivinekingjiclgbanViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinekingjiclgbanViewPresentor:dependWhatResources()
	return {
		"ui/views/divinekingjiclg/divinekingjiclgbanview.prefab"
	}
end

function DivinekingjiclgbanViewPresentor:buildViews()
	return {
		DivinekingjiclgbanView.New()
	}
end

return DivinekingjiclgbanViewPresentor
