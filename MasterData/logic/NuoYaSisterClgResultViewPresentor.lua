-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nuoyasisterclg/view/NuoYaSisterClgResultViewPresentor.lua

module("logic.extensions.nuoyasisterclg.view.NuoYaSisterClgResultViewPresentor", package.seeall)

local NuoYaSisterClgResultViewPresentor = class("NuoYaSisterClgResultViewPresentor", ViewPresentor)

function NuoYaSisterClgResultViewPresentor:ctor()
	NuoYaSisterClgResultViewPresentor.super.ctor(self)
end

function NuoYaSisterClgResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function NuoYaSisterClgResultViewPresentor:dependWhatResources()
	return {
		"ui/views/nuoyasisterclg/nuoyasisterclgresultview.prefab"
	}
end

function NuoYaSisterClgResultViewPresentor:buildViews()
	return {
		NuoYaSisterClgResultView.New()
	}
end

return NuoYaSisterClgResultViewPresentor
