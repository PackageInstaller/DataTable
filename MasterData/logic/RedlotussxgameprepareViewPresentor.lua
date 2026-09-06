-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/redlotusdinnerparty/view/RedlotussxgameprepareViewPresentor.lua

module("logic.extensions.redlotusdinnerparty.view.RedlotussxgameprepareViewPresentor", package.seeall)

local RedlotussxgameprepareViewPresentor = class("RedlotussxgameprepareViewPresentor", ViewPresentor)

function RedlotussxgameprepareViewPresentor:ctor()
	RedlotussxgameprepareViewPresentor.super.ctor(self)
end

function RedlotussxgameprepareViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RedlotussxgameprepareViewPresentor:dependWhatResources()
	return {
		"ui/views/redlotusdinnerparty/redlotussxgameprepareview.prefab"
	}
end

function RedlotussxgameprepareViewPresentor:buildViews()
	return {
		RedlotussxgameprepareView.New()
	}
end

return RedlotussxgameprepareViewPresentor
