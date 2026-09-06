-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nuoyasisterclg/view/NuoYaSisterClgExtremeViewPresentor.lua

module("logic.extensions.nuoyasisterclg.view.NuoYaSisterClgExtremeViewPresentor", package.seeall)

local NuoYaSisterClgExtremeViewPresentor = class("NuoYaSisterClgExtremeViewPresentor", ViewPresentor)

function NuoYaSisterClgExtremeViewPresentor:ctor()
	NuoYaSisterClgExtremeViewPresentor.super.ctor(self)
end

function NuoYaSisterClgExtremeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NuoYaSisterClgExtremeViewPresentor:dependWhatResources()
	return {
		"ui/views/nuoyasisterclg/nuoyasisterclgextremeview.prefab"
	}
end

function NuoYaSisterClgExtremeViewPresentor:buildViews()
	return {
		NuoYaSisterClgExtremeView.New()
	}
end

return NuoYaSisterClgExtremeViewPresentor
