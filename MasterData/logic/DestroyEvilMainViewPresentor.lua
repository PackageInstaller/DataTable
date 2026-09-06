-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/destroyevil/view/DestroyEvilMainViewPresentor.lua

module("logic.extensions.destroyevil.view.DestroyEvilMainViewPresentor", package.seeall)

local DestroyEvilMainViewPresentor = class("DestroyEvilMainViewPresentor", ViewPresentor)

function DestroyEvilMainViewPresentor:ctor()
	DestroyEvilMainViewPresentor.super.ctor(self)
end

function DestroyEvilMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DestroyEvilMainViewPresentor:dependWhatResources()
	return {
		"ui/views/destroyevil/destroyevilmainview.prefab"
	}
end

function DestroyEvilMainViewPresentor:buildViews()
	return {
		DestroyEvilMainView.New()
	}
end

return DestroyEvilMainViewPresentor
