-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/watertianyan/view/divinemiuke/DivineMiuKeBuffViewPresentor.lua

module("logic.extensions.watertianyan.view.divinemiuke.DivineMiuKeBuffViewPresentor", package.seeall)

local DivineMiuKeBuffViewPresentor = class("DivineMiuKeBuffViewPresentor", ViewPresentor)

function DivineMiuKeBuffViewPresentor:ctor()
	DivineMiuKeBuffViewPresentor.super.ctor(self)
end

function DivineMiuKeBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineMiuKeBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/watertianyan/divinemiuke/divinemiukebuffview.prefab"
	}
end

function DivineMiuKeBuffViewPresentor:buildViews()
	return {
		DivineMiuKeBuffView.New()
	}
end

return DivineMiuKeBuffViewPresentor
