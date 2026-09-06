-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/destroyevil/view/DestroyevilselectdifficltViewPresentor.lua

module("logic.extensions.destroyevil.view.DestroyevilselectdifficltViewPresentor", package.seeall)

local DestroyevilselectdifficltViewPresentor = class("DestroyevilselectdifficltViewPresentor", ViewPresentor)

function DestroyevilselectdifficltViewPresentor:ctor()
	DestroyevilselectdifficltViewPresentor.super.ctor(self)
end

function DestroyevilselectdifficltViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DestroyevilselectdifficltViewPresentor:dependWhatResources()
	return {
		"ui/views/destroyevil/destroyevilselectdifficltview.prefab"
	}
end

function DestroyevilselectdifficltViewPresentor:buildViews()
	return {
		DestroyevilselectdifficltView.New()
	}
end

return DestroyevilselectdifficltViewPresentor
