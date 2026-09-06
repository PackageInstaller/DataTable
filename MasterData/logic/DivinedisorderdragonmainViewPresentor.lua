-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedisorderdragon/view/DivinedisorderdragonmainViewPresentor.lua

module("logic.extensions.divinedisorderdragon.view.DivinedisorderdragonmainViewPresentor", package.seeall)

local DivinedisorderdragonmainViewPresentor = class("DivinedisorderdragonmainViewPresentor", ViewPresentor)

function DivinedisorderdragonmainViewPresentor:ctor()
	DivinedisorderdragonmainViewPresentor.super.ctor(self)
end

function DivinedisorderdragonmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinedisorderdragonmainViewPresentor:dependWhatResources()
	return {
		"ui/views/divinedisorderdragon/divinedisorderdragonmainview.prefab"
	}
end

function DivinedisorderdragonmainViewPresentor:buildViews()
	return {
		DivinedisorderdragonmainView.New()
	}
end

return DivinedisorderdragonmainViewPresentor
