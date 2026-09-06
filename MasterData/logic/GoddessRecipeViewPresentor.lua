-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessdelicacy/view/GoddessRecipeViewPresentor.lua

module("logic.extensions.goddessdelicacy.view.GoddessRecipeViewPresentor", package.seeall)

local GoddessRecipeViewPresentor = class("GoddessRecipeViewPresentor", ViewPresentor)

function GoddessRecipeViewPresentor:ctor()
	GoddessRecipeViewPresentor.super.ctor(self)
end

function GoddessRecipeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessRecipeViewPresentor:dependWhatResources()
	return {
		"ui/views/goddessdelicacy/goddessrecipeview.prefab"
	}
end

function GoddessRecipeViewPresentor:buildViews()
	return {
		GoddessRecipeView.New()
	}
end

return GoddessRecipeViewPresentor
