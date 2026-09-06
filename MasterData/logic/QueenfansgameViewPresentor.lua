-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/darkdragonknife/view/QueenfansgameViewPresentor.lua

module("logic.extensions.darkdragonknife.view.QueenfansgameViewPresentor", package.seeall)

local QueenfansgameViewPresentor = class("QueenfansgameViewPresentor", ViewPresentor)

function QueenfansgameViewPresentor:ctor()
	QueenfansgameViewPresentor.super.ctor(self)
end

function QueenfansgameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function QueenfansgameViewPresentor:dependWhatResources()
	return {
		"ui/views/darkdragonknife/queenfansgameview.prefab"
	}
end

function QueenfansgameViewPresentor:buildViews()
	return {
		QueenfansgameView.New()
	}
end

return QueenfansgameViewPresentor
