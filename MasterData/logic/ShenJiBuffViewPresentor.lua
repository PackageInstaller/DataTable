-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shenjichallenge/view/ShenJiBuffViewPresentor.lua

module("logic.extensions.shenjichallenge.view.ShenJiBuffViewPresentor", package.seeall)

local ShenJiBuffViewPresentor = class("ShenJiBuffViewPresentor", ViewPresentor)

function ShenJiBuffViewPresentor:ctor()
	ShenJiBuffViewPresentor.super.ctor(self)
end

function ShenJiBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShenJiBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/shenjichallenge/shenjibuffview.prefab"
	}
end

function ShenJiBuffViewPresentor:buildViews()
	return {
		ShenJiBuffView.New()
	}
end

return ShenJiBuffViewPresentor
