-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summontower/view/SummontowermainViewPresentor.lua

module("logic.extensions.summontower.view.SummontowermainViewPresentor", package.seeall)

local SummontowermainViewPresentor = class("SummontowermainViewPresentor", ViewPresentor)

function SummontowermainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SummontowermainViewPresentor:dependWhatResources()
	return {
		"ui/views/summontower/summontowermainview.prefab"
	}
end

function SummontowermainViewPresentor:buildViews()
	return {
		SummontowerMainView.New()
	}
end

function SummontowermainViewPresentor:getTempResources()
	return {
		SummontowerModel.instance:getPlayerSpineRes()
	}
end

return SummontowermainViewPresentor
