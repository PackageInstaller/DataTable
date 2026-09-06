-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/view/OriMatGameBuffSelectViewPresentor.lua

module("logic.extensions.orimatgame.view.OriMatGameBuffSelectViewPresentor", package.seeall)

local OriMatGameBuffSelectViewPresentor = class("OriMatGameBuffSelectViewPresentor", ViewPresentor)

function OriMatGameBuffSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function OriMatGameBuffSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/orimatgame/orimatgamebuffselectview.prefab"
	}
end

function OriMatGameBuffSelectViewPresentor:buildViews()
	return {
		OriMatGameBuffSelectView.New()
	}
end

return OriMatGameBuffSelectViewPresentor
