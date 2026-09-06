-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wisdomaltar/view/WisdomAltarViewPresentor.lua

module("logic.extensions.wisdomaltar.view.WisdomAltarViewPresentor", package.seeall)

local WisdomAltarViewPresentor = class("WisdomAltarViewPresentor", ViewWithGuidePresentor)

function WisdomAltarViewPresentor:dependWhatResources()
	return {
		"ui/views/wisdomaltar/wisdomaltarview.prefab",
		ItemPet.ResPath
	}
end

function WisdomAltarViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WisdomAltarViewPresentor:buildViews()
	return {
		WisdomAltarView.New()
	}
end

return WisdomAltarViewPresentor
