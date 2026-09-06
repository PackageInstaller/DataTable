-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinean/view/DivineAnLevelsViewPresentor.lua

module("logic.extensions.divinean.view.DivineAnLevelsViewPresentor", package.seeall)

local DivineAnLevelsViewPresentor = class("DivineAnLevelsViewPresentor", ViewPresentor)

function DivineAnLevelsViewPresentor:ctor()
	DivineAnLevelsViewPresentor.super.ctor(self)
end

function DivineAnLevelsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineAnLevelsViewPresentor:dependWhatResources()
	return {
		"ui/views/divinean/divineanlevelsview.prefab"
	}
end

function DivineAnLevelsViewPresentor:buildViews()
	return {
		DivineAnLevelsView.New()
	}
end

return DivineAnLevelsViewPresentor
