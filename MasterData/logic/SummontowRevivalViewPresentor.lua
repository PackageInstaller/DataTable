-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summontower/view/SummontowRevivalViewPresentor.lua

module("logic.extensions.summontower.view.SummontowRevivalViewPresentor", package.seeall)

local SummontowRevivalViewPresentor = class("SummontowRevivalViewPresentor", ViewPresentor)

function SummontowRevivalViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SummontowRevivalViewPresentor:dependWhatResources()
	return {
		"ui/views/summontower/sumtowrevivalview.prefab"
	}
end

function SummontowRevivalViewPresentor:buildViews()
	return {
		SummontowRevivalView.New()
	}
end

return SummontowRevivalViewPresentor
