-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scenariocopy/view/nainfei/NianfeicopyViewPresentor.lua

module("logic.extensions.scenariocopy.view.dreamteammutualhelp.NianfeicopyViewPresentor", package.seeall)

local NianfeicopyViewPresentor = class("NianfeicopyViewPresentor", ViewPresentor)

NianfeicopyViewPresentor.bgPicturePaths = {}

function NianfeicopyViewPresentor:ctor()
	NianfeicopyViewPresentor.super.ctor(self)
end

function NianfeicopyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NianfeicopyViewPresentor:dependWhatResources()
	return {
		"ui/views/scenariocopy/nianfei/nianfeicopyview.prefab"
	}
end

function NianfeicopyViewPresentor:getTempResources()
	return {
		NianfeicopyViewPresentor.bgPicturePaths[1]
	}
end

function NianfeicopyViewPresentor:buildViews()
	return {
		NianfeicopyView.New()
	}
end

return NianfeicopyViewPresentor
