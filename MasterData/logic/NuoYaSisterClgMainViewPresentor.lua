-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nuoyasisterclg/view/NuoYaSisterClgMainViewPresentor.lua

module("logic.extensions.nuoyasisterclg.view.NuoYaSisterClgMainViewPresentor", package.seeall)

local NuoYaSisterClgMainViewPresentor = class("NuoYaSisterClgMainViewPresentor", ViewPresentor)

function NuoYaSisterClgMainViewPresentor:ctor()
	NuoYaSisterClgMainViewPresentor.super.ctor(self)
end

function NuoYaSisterClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NuoYaSisterClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/nuoyasisterclg/nuoyasisterclgmainview.prefab"
	}
end

function NuoYaSisterClgMainViewPresentor:buildViews()
	return {
		NuoYaSisterClgMainView.New()
	}
end

return NuoYaSisterClgMainViewPresentor
