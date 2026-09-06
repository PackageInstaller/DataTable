-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonfmteditViewPresentor.lua

module("logic.extensions.season.view.SeasonfmteditViewPresentor", package.seeall)

local SeasonfmteditViewPresentor = class("SeasonfmteditViewPresentor", ViewWithGuidePresentor)

function SeasonfmteditViewPresentor:ctor()
	SeasonfmteditViewPresentor.super.ctor(self)
end

function SeasonfmteditViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasonfmteditViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasonfmteditview.prefab"
	}
end

function SeasonfmteditViewPresentor:buildViews()
	return {
		SeasonfmteditView.New()
	}
end

function SeasonfmteditViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return SeasonfmteditViewPresentor
