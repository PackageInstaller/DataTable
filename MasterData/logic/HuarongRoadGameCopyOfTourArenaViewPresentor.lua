-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tourarena/view/copy/huarong/HuarongRoadGameCopyOfTourArenaViewPresentor.lua

module("logic.extensions.tourarena.view.copy.huarong.HuarongRoadGameCopyOfTourArenaViewPresentor", package.seeall)

local HuarongRoadGameCopyOfTourArenaViewPresentor = class("HuarongRoadGameCopyOfTourArenaViewPresentor", HuarongRoadGameViewPresentor)

function HuarongRoadGameCopyOfTourArenaViewPresentor:buildViews()
	return {
		HuarongRoadGameCopyOfTourArenaView.New()
	}
end

return HuarongRoadGameCopyOfTourArenaViewPresentor
