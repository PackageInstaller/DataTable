-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nuoyasisterclg/view/NuoYaSisterClgCommonViewPresentor.lua

module("logic.extensions.nuoyasisterclg.view.NuoYaSisterClgCommonViewPresentor", package.seeall)

local NuoYaSisterClgCommonViewPresentor = class("NuoYaSisterClgCommonViewPresentor", ViewPresentor)

function NuoYaSisterClgCommonViewPresentor:ctor()
	NuoYaSisterClgCommonViewPresentor.super.ctor(self)
end

function NuoYaSisterClgCommonViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NuoYaSisterClgCommonViewPresentor:dependWhatResources()
	return {
		"ui/views/nuoyasisterclg/nuoyasisterclgcommonview.prefab"
	}
end

function NuoYaSisterClgCommonViewPresentor:buildViews()
	return {
		NuoYaSisterClgCommonView.New()
	}
end

return NuoYaSisterClgCommonViewPresentor
