-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/view/OriMatGameSpecialGridViewPresentor.lua

module("logic.extensions.orimatgame.view.OriMatGameSpecialGridViewPresentor", package.seeall)

local OriMatGameSpecialGridViewPresentor = class("OriMatGameSpecialGridViewPresentor", ViewPresentor)

function OriMatGameSpecialGridViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function OriMatGameSpecialGridViewPresentor:dependWhatResources()
	return {
		"ui/views/orimatgame/orimatgamespecialgridview.prefab"
	}
end

function OriMatGameSpecialGridViewPresentor:buildViews()
	return {
		OriMatGameSpecialGridView.New()
	}
end

return OriMatGameSpecialGridViewPresentor
