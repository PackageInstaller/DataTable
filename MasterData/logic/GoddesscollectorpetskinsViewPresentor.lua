-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscollector/view/GoddesscollectorpetskinsViewPresentor.lua

module("logic.extensions.goddesscollector.view.GoddesscollectorpetskinsViewPresentor", package.seeall)

local GoddesscollectorpetskinsViewPresentor = class("GoddesscollectorpetskinsViewPresentor", GoddesscollectorpetsViewPresentor)

function GoddesscollectorpetskinsViewPresentor:buildViews()
	return {
		GoddesscollectorpetskinsView.New()
	}
end

return GoddesscollectorpetskinsViewPresentor
