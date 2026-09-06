-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/destroyevil/view/DestroyEvilMyViewPresentor.lua

module("logic.extensions.destroyevil.view.DestroyEvilMyViewPresentor", package.seeall)

local DestroyEvilMyViewPresentor = class("DestroyEvilMyViewPresentor", ViewPresentor)

function DestroyEvilMyViewPresentor:ctor()
	DestroyEvilMyViewPresentor.super.ctor(self)
end

function DestroyEvilMyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DestroyEvilMyViewPresentor:dependWhatResources()
	return {
		"ui/views/destroyevil/destroyevilmyview.prefab"
	}
end

function DestroyEvilMyViewPresentor:buildViews()
	return {
		DestroyEvilMyView.New()
	}
end

return DestroyEvilMyViewPresentor
