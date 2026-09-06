-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originjiu/view/OriginJiuMainViewPresentor.lua

module("logic.extensions.originjiu.view.OriginJiuMainViewPresentor", package.seeall)

local OriginJiuMainViewPresentor = class("OriginJiuMainViewPresentor", ViewPresentor)

function OriginJiuMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginJiuMainViewPresentor:dependWhatResources()
	return {
		"ui/views/originjiu/originjiumainview.prefab"
	}
end

function OriginJiuMainViewPresentor:buildViews()
	return {
		OriginJiuMainView.New()
	}
end

return OriginJiuMainViewPresentor
