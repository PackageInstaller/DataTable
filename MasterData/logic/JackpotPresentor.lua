-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jackpot/view/JackpotPresentor.lua

module("logic.extensions.jackpot.view.JackpotPresentor", package.seeall)

local JackpotPresentor = class("JackpotPresentor", ViewPresentor)

function JackpotPresentor:ctor()
	JackpotPresentor.super.ctor(self)
end

function JackpotPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function JackpotPresentor:dependWhatResources()
	return {
		"ui/views/jackpot/jackpotview.prefab"
	}
end

function JackpotPresentor:buildViews()
	return {
		JackpotView.New()
	}
end

return JackpotPresentor
