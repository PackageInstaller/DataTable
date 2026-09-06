-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonfmttabextViewPresentor.lua

module("logic.extensions.season.view.SeasonfmttabextViewPresentor", package.seeall)

local SeasonfmttabextViewPresentor = class("SeasonfmttabextViewPresentor", ViewPresentor)

function SeasonfmttabextViewPresentor:ctor()
	SeasonfmttabextViewPresentor.super.ctor(self)
end

function SeasonfmttabextViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasonfmttabextViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasonfmttabextview.prefab"
	}
end

function SeasonfmttabextViewPresentor:buildViews()
	return {
		SeasonfmttabextView.New()
	}
end

function SeasonfmttabextViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return SeasonfmttabextViewPresentor
