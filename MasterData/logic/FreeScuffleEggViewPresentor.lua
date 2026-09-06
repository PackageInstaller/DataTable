-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/freescuffle/view/FreeScuffleEggViewPresentor.lua

module("logic.extensions.divinemizongclg.view.FreeScuffleEggViewPresentor", package.seeall)

local FreeScuffleEggViewPresentor = class("FreeScuffleEggViewPresentor", ViewPresentor)

function FreeScuffleEggViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FreeScuffleEggViewPresentor:dependWhatResources()
	return {
		"ui/views/freescuffle/freescuffleeggview.prefab"
	}
end

function FreeScuffleEggViewPresentor:buildViews()
	return {
		FreeScuffleEggView.New()
	}
end

return FreeScuffleEggViewPresentor
