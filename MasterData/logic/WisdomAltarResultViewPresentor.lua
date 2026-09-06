-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wisdomaltar/view/WisdomAltarResultViewPresentor.lua

module("logic.extensions.wisdomaltar.view.WisdomAltarResultViewPresentor", package.seeall)

local WisdomAltarResultViewPresentor = class("WisdomAltarResultViewPresentor", MissionViewPresentor)

function WisdomAltarResultViewPresentor:dependWhatResources()
	return {
		"ui/views/wisdomaltar/wisdomaltaroneresult.prefab"
	}
end

function WisdomAltarResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function WisdomAltarResultViewPresentor:buildViews()
	return {
		WisdomAltarResultView.New()
	}
end

return WisdomAltarResultViewPresentor
