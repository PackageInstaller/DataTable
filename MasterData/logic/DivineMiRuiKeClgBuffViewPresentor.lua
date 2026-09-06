-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemiruikeclg/view/DivineMiRuiKeClgBuffViewPresentor.lua

module("logic.extensions.divinemiruikeclg.view.DivineMiRuiKeClgBuffViewPresentor", package.seeall)

local DivineMiRuiKeClgBuffViewPresentor = class("DivineMiRuiKeClgBuffViewPresentor", ViewPresentor)

function DivineMiRuiKeClgBuffViewPresentor:ctor()
	DivineMiRuiKeClgBuffViewPresentor.super.ctor(self)
end

function DivineMiRuiKeClgBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineMiRuiKeClgBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/divinemiruikeclg/divinemiruikeclgbuffview.prefab"
	}
end

function DivineMiRuiKeClgBuffViewPresentor:buildViews()
	return {
		DivineMiRuiKeClgBuffView.New()
	}
end

return DivineMiRuiKeClgBuffViewPresentor
