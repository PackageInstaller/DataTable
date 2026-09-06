-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summontower/view/SummontowerchooseViewPresentor.lua

module("logic.extensions.summontower.view.SummontowerchooseViewPresentor", package.seeall)

local SummontowerchooseViewPresentor = class("SummontowerchooseViewPresentor", ViewPresentor)

function SummontowerchooseViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SummontowerchooseViewPresentor:dependWhatResources()
	return {
		"ui/views/summontower/summontowerchooseview.prefab"
	}
end

function SummontowerchooseViewPresentor:buildViews()
	return {
		SummontowerChooseView.New()
	}
end

return SummontowerchooseViewPresentor
