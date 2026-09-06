-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doloresclg/view/DoloresclglevelViewPresentor.lua

module("logic.extensions.doloresclg.view.DoloresclglevelViewPresentor", package.seeall)

local DoloresclglevelViewPresentor = class("DoloresclglevelViewPresentor", ViewPresentor)

function DoloresclglevelViewPresentor:ctor()
	DoloresclglevelViewPresentor.super.ctor(self)
end

function DoloresclglevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DoloresclglevelViewPresentor:dependWhatResources()
	return {
		"ui/views/doloresclg/doloresclglevelview.prefab"
	}
end

function DoloresclglevelViewPresentor:buildViews()
	return {
		DoloresclglevelView.New()
	}
end

return DoloresclglevelViewPresentor
