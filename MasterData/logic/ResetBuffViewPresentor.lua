-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/tlctip/ResetBuffViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.ResetBuffViewPresentor", package.seeall)

local ResetBuffViewPresentor = class("ResetBuffViewPresentor", ViewPresentor)

function ResetBuffViewPresentor:ctor()
	ResetBuffViewPresentor.super.ctor(self)
end

function ResetBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ResetBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/resetpopupbuffview.prefab"
	}
end

function ResetBuffViewPresentor:buildViews()
	return {
		ResetBuffView.New()
	}
end

return ResetBuffViewPresentor
