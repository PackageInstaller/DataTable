-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nuoyasisterclg/view/NuoYaSisterClgBuffViewPresentor.lua

module("logic.extensions.nuoyasisterclg.view.NuoYaSisterClgBuffViewPresentor", package.seeall)

local NuoYaSisterClgBuffViewPresentor = class("NuoYaSisterClgBuffViewPresentor", ViewPresentor)

function NuoYaSisterClgBuffViewPresentor:ctor()
	NuoYaSisterClgBuffViewPresentor.super.ctor(self)
end

function NuoYaSisterClgBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function NuoYaSisterClgBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/nuoyasisterclg/nuoyasisterclgbuffview.prefab"
	}
end

function NuoYaSisterClgBuffViewPresentor:buildViews()
	return {
		NuoYaSisterClgBuffView.New()
	}
end

return NuoYaSisterClgBuffViewPresentor
