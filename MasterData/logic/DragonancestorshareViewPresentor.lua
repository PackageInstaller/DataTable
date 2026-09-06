-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/DragonancestorshareViewPresentor.lua

module("logic.extensions.operationsummary.view.DragonancestorshareViewPresentor", package.seeall)

local DragonancestorshareViewPresentor = class("DragonancestorshareViewPresentor", ViewPresentor)

function DragonancestorshareViewPresentor:ctor()
	DragonancestorshareViewPresentor.super.ctor(self)
end

function DragonancestorshareViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DragonancestorshareViewPresentor:dependWhatResources()
	return {
		"ui/views/operationsummary/dragonancestorshareview.prefab"
	}
end

function DragonancestorshareViewPresentor:buildViews()
	return {
		DragonancestorshareView.New()
	}
end

return DragonancestorshareViewPresentor
