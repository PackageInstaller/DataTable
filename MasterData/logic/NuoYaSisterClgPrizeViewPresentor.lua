-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nuoyasisterclg/view/NuoYaSisterClgPrizeViewPresentor.lua

module("logic.extensions.nuoyasisterclg.view.NuoYaSisterClgPrizeViewPresentor", package.seeall)

local NuoYaSisterClgPrizeViewPresentor = class("NuoYaSisterClgPrizeViewPresentor", ViewPresentor)

function NuoYaSisterClgPrizeViewPresentor:ctor()
	NuoYaSisterClgPrizeViewPresentor.super.ctor(self)
end

function NuoYaSisterClgPrizeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function NuoYaSisterClgPrizeViewPresentor:dependWhatResources()
	return {
		"ui/views/nuoyasisterclg/nuoyasisterclgprizeview.prefab"
	}
end

function NuoYaSisterClgPrizeViewPresentor:buildViews()
	return {
		NuoYaSisterClgPrizeView.New()
	}
end

return NuoYaSisterClgPrizeViewPresentor
