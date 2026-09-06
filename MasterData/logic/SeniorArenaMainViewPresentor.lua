-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/seniorarena/view/SeniorArenaMainViewPresentor.lua

module("logic.extensions.seniorarena.view.SeniorArenaMainViewPresentor", package.seeall)

local SeniorArenaMainViewPresentor = class("SeniorArenaMainViewPresentor", ViewPresentor)

function SeniorArenaMainViewPresentor:ctor()
	SeniorArenaMainViewPresentor.super.ctor(self)
end

function SeniorArenaMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeniorArenaMainViewPresentor:dependWhatResources()
	return {
		"ui/views/seniorarena/seniorarenamainview.prefab"
	}
end

function SeniorArenaMainViewPresentor:buildViews()
	return {
		SeniorArenaMainView.New()
	}
end

return SeniorArenaMainViewPresentor
