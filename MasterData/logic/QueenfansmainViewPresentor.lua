-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/darkdragonknife/view/QueenfansmainViewPresentor.lua

module("logic.extensions.darkdragonknife.view.QueenfansmainViewPresentor", package.seeall)

local QueenfansmainViewPresentor = class("QueenfansmainViewPresentor", ViewPresentor)

function QueenfansmainViewPresentor:ctor()
	QueenfansmainViewPresentor.super.ctor(self)
end

function QueenfansmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function QueenfansmainViewPresentor:dependWhatResources()
	return {
		"ui/views/darkdragonknife/queenfansmainview.prefab"
	}
end

function QueenfansmainViewPresentor:buildViews()
	return {
		QueenfansmainView.New()
	}
end

return QueenfansmainViewPresentor
