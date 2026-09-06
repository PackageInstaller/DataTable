-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineasheslessdragon/view/DivineasheslessdragonmainViewPresentor.lua

module("logic.extensions.divineasheslessdragon.view.DivineasheslessdragonmainViewPresentor", package.seeall)

local DivineasheslessdragonmainViewPresentor = class("DivineasheslessdragonmainViewPresentor", ViewPresentor)

function DivineasheslessdragonmainViewPresentor:ctor()
	DivineasheslessdragonmainViewPresentor.super.ctor(self)
end

function DivineasheslessdragonmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineasheslessdragonmainViewPresentor:dependWhatResources()
	return {
		"ui/views/divineasheslessdragon/divineasheslessdragonmainview.prefab"
	}
end

function DivineasheslessdragonmainViewPresentor:buildViews()
	return {
		DivineasheslessdragonmainView.New()
	}
end

return DivineasheslessdragonmainViewPresentor
