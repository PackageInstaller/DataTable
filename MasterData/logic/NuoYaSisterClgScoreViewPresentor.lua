-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nuoyasisterclg/view/NuoYaSisterClgScoreViewPresentor.lua

module("logic.extensions.nuoyasisterclg.view.NuoYaSisterClgScoreViewPresentor", package.seeall)

local NuoYaSisterClgScoreViewPresentor = class("NuoYaSisterClgScoreViewPresentor", ViewPresentor)

function NuoYaSisterClgScoreViewPresentor:ctor()
	NuoYaSisterClgScoreViewPresentor.super.ctor(self)
end

function NuoYaSisterClgScoreViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function NuoYaSisterClgScoreViewPresentor:dependWhatResources()
	return {
		"ui/views/nuoyasisterclg/nuoyasisterclgscoreview.prefab"
	}
end

function NuoYaSisterClgScoreViewPresentor:buildViews()
	return {
		NuoYaSisterClgScoreView.New()
	}
end

return NuoYaSisterClgScoreViewPresentor
