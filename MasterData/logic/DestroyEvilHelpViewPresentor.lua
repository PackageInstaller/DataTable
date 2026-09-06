-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/destroyevil/view/DestroyEvilHelpViewPresentor.lua

module("logic.extensions.destroyevil.view.DestroyEvilHelpViewPresentor", package.seeall)

local DestroyEvilHelpViewPresentor = class("DestroyEvilHelpViewPresentor", ViewPresentor)

function DestroyEvilHelpViewPresentor:ctor()
	DestroyEvilHelpViewPresentor.super.ctor(self)
end

function DestroyEvilHelpViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DestroyEvilHelpViewPresentor:dependWhatResources()
	return {
		"ui/views/destroyevil/destroyevilhelpview.prefab"
	}
end

function DestroyEvilHelpViewPresentor:buildViews()
	return {
		DestroyEvilHelpView.New()
	}
end

return DestroyEvilHelpViewPresentor
