-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/destroyevil/view/DestroyEvilSelectViewPresentor.lua

module("logic.extensions.destroyevil.view.DestroyEvilSelectViewPresentor", package.seeall)

local DestroyEvilSelectViewPresentor = class("DestroyEvilSelectViewPresentor", ViewPresentor)

function DestroyEvilSelectViewPresentor:ctor()
	DestroyEvilSelectViewPresentor.super.ctor(self)
end

function DestroyEvilSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DestroyEvilSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/destroyevil/destroyevilselectview.prefab"
	}
end

function DestroyEvilSelectViewPresentor:buildViews()
	return {
		DestroyEvilSelectView.New()
	}
end

return DestroyEvilSelectViewPresentor
