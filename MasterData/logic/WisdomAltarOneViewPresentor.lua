-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wisdomaltar/view/WisdomAltarOneViewPresentor.lua

module("logic.extensions.wisdomaltar.view.WisdomAltarOneViewPresentor", package.seeall)

local WisdomAltarOneViewPresentor = class("WisdomAltarOneViewPresentor", MissionViewPresentor)

function WisdomAltarOneViewPresentor:dependWhatResources()
	return {
		"ui/views/wisdomaltar/wisdomaltartipview.prefab"
	}
end

function WisdomAltarOneViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function WisdomAltarOneViewPresentor:buildViews()
	return {
		WisdomAltarOneView.New()
	}
end

return WisdomAltarOneViewPresentor
