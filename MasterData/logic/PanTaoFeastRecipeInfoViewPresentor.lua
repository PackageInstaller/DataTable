-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pantaofeast/view/PanTaoFeastRecipeInfoViewPresentor.lua

module("logic.extensions.pantaofeast.view.PanTaoFeastRecipeInfoViewPresentor", package.seeall)

local PanTaoFeastRecipeInfoViewPresentor = class("PanTaoFeastRecipeInfoViewPresentor", ViewPresentor)

function PanTaoFeastRecipeInfoViewPresentor:ctor()
	PanTaoFeastRecipeInfoViewPresentor.super.ctor(self)
end

function PanTaoFeastRecipeInfoViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PanTaoFeastRecipeInfoViewPresentor:dependWhatResources()
	return {
		"ui/views/pantaofeast/pantaofeastrecipeinfoview.prefab"
	}
end

function PanTaoFeastRecipeInfoViewPresentor:buildViews()
	return {
		PanTaoFeastRecipeInfoView.New()
	}
end

return PanTaoFeastRecipeInfoViewPresentor
