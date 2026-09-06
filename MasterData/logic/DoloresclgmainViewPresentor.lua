-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doloresclg/view/DoloresclgmainViewPresentor.lua

module("logic.extensions.doloresclg.view.DoloresclgmainViewPresentor", package.seeall)

local DoloresclgmainViewPresentor = class("DoloresclgmainViewPresentor", ViewPresentor)

function DoloresclgmainViewPresentor:ctor()
	DoloresclgmainViewPresentor.super.ctor(self)
end

function DoloresclgmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DoloresclgmainViewPresentor:dependWhatResources()
	return {
		"ui/views/doloresclg/doloresclgmainview.prefab"
	}
end

function DoloresclgmainViewPresentor:buildViews()
	return {
		DoloresclgmainView.New()
	}
end

return DoloresclgmainViewPresentor
