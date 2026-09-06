-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nineplace/view/FormationunlockViewPresentor.lua

module("logic.extensions.nineplace.view.FormationunlockViewPresentor", package.seeall)

local FormationunlockViewPresentor = class("FormationunlockViewPresentor", ViewPresentor)

function FormationunlockViewPresentor:ctor()
	FormationunlockViewPresentor.super.ctor(self)
end

function FormationunlockViewPresentor:attachToWhichRoot()
	return ViewRootType.Top
end

function FormationunlockViewPresentor:dependWhatResources()
	return {
		"ui/views/nineplace/formationunlockview.prefab"
	}
end

function FormationunlockViewPresentor:buildViews()
	return {
		FormationunlockView.New()
	}
end

return FormationunlockViewPresentor
