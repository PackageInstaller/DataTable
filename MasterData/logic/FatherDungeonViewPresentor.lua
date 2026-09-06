-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scenariocopy/view/father/FatherDungeonViewPresentor.lua

module("logic.extensions.scenariocopy.view.father.FatherDungeonViewPresentor", package.seeall)

local FatherDungeonViewPresentor = class("FatherDungeonViewPresentor", ViewPresentor)

function FatherDungeonViewPresentor:ctor()
	FatherDungeonViewPresentor.super.ctor(self)
end

function FatherDungeonViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FatherDungeonViewPresentor:dependWhatResources()
	return {
		"ui/views/scenariocopy/brithday/brithdaycopyview.prefab"
	}
end

function FatherDungeonViewPresentor:getTempResources()
	return {}
end

function FatherDungeonViewPresentor:buildViews()
	return {
		FatherDungeonView.New()
	}
end

return FatherDungeonViewPresentor
