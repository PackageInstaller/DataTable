-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/freescuffle/view/FreeScuffleSkillBagViewPresentor.lua

module("logic.extensions.freescuffle.view.FreeScuffleSkillBagViewPresentor", package.seeall)

local FreeScuffleSkillBagViewPresentor = class("FreeScuffleSkillBagViewPresentor", ViewPresentor)

function FreeScuffleSkillBagViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FreeScuffleSkillBagViewPresentor:dependWhatResources()
	return {
		"ui/views/freescuffle/freescuffleskillbagview.prefab"
	}
end

function FreeScuffleSkillBagViewPresentor:buildViews()
	return {
		FreeScuffleSkillBagView.New()
	}
end

return FreeScuffleSkillBagViewPresentor
