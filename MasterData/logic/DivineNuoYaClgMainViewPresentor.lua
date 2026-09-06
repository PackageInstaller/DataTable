-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinenuoyachallenge/view/DivineNuoYaClgMainViewPresentor.lua

module("logic.extensions.divinenuoyachallenge.view.DivineNuoYaClgMainViewPresentor", package.seeall)

local DivineNuoYaClgMainViewPresentor = class("DivineNuoYaClgMainViewPresentor", ViewPresentor)

function DivineNuoYaClgMainViewPresentor:ctor()
	DivineNuoYaClgMainViewPresentor.super.ctor(self)
end

function DivineNuoYaClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineNuoYaClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/divinenuoyachallenge/divinenuoyaclgmainview.prefab"
	}
end

function DivineNuoYaClgMainViewPresentor:buildViews()
	return {
		DivineNuoYaClgMainView.New()
	}
end

return DivineNuoYaClgMainViewPresentor
