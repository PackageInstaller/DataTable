-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexingjiangclg/view/DivinexjClgBuffViewPresentor.lua

module("logic.extensions.divinexingjiangclg.view.DivinexjClgBuffViewPresentor", package.seeall)

local DivinexjClgBuffViewPresentor = class("DivinexjClgBuffViewPresentor", ViewPresentor)

function DivinexjClgBuffViewPresentor:ctor()
	DivinexjClgBuffViewPresentor.super.ctor(self)
end

function DivinexjClgBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinexjClgBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/divinexingjiangclg/divinexjclgbuffview.prefab"
	}
end

function DivinexjClgBuffViewPresentor:buildViews()
	return {
		DivinexjClgBuffView.New()
	}
end

return DivinexjClgBuffViewPresentor
