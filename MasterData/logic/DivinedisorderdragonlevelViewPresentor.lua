-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedisorderdragon/view/DivinedisorderdragonlevelViewPresentor.lua

module("logic.extensions.divinedisorderdragon.view.DivinedisorderdragonlevelViewPresentor", package.seeall)

local DivinedisorderdragonlevelViewPresentor = class("DivinedisorderdragonlevelViewPresentor", ViewPresentor)

function DivinedisorderdragonlevelViewPresentor:ctor()
	DivinedisorderdragonlevelViewPresentor.super.ctor(self)
end

function DivinedisorderdragonlevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinedisorderdragonlevelViewPresentor:dependWhatResources()
	return {
		"ui/views/divinedisorderdragon/divinedisorderdragonlevelview.prefab"
	}
end

function DivinedisorderdragonlevelViewPresentor:buildViews()
	return {
		DivinedisorderdragonlevelView.New()
	}
end

return DivinedisorderdragonlevelViewPresentor
