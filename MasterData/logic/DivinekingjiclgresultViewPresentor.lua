-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingjiclg/view/DivinekingjiclgresultViewPresentor.lua

module("logic.extensions.divinekingjiclg.view.DivinekingjiclgresultViewPresentor", package.seeall)

local DivinekingjiclgresultViewPresentor = class("DivinekingjiclgresultViewPresentor", ViewPresentor)

function DivinekingjiclgresultViewPresentor:ctor()
	DivinekingjiclgresultViewPresentor.super.ctor(self)
end

function DivinekingjiclgresultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinekingjiclgresultViewPresentor:dependWhatResources()
	return {
		"ui/views/divinekingjiclg/divinekingjiclgresultview.prefab"
	}
end

function DivinekingjiclgresultViewPresentor:buildViews()
	return {
		DivinekingjiclgresultView.New()
	}
end

return DivinekingjiclgresultViewPresentor
