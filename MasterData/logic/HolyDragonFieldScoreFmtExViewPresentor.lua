-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holydragonfield/view/HolyDragonFieldScoreFmtExViewPresentor.lua

module("logic.extensions.holydragonfield.view.HolyDragonFieldScoreFmtExViewPresentor", package.seeall)

local HolyDragonFieldScoreFmtExViewPresentor = class("HolyDragonFieldScoreFmtExViewPresentor", ViewPresentor)

function HolyDragonFieldScoreFmtExViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HolyDragonFieldScoreFmtExViewPresentor:dependWhatResources()
	return {
		"ui/views/holydragonfield/holydragonfieldscorefmtexview.prefab"
	}
end

function HolyDragonFieldScoreFmtExViewPresentor:buildViews()
	return {
		HolyDragonFieldScoreFmtExView.New()
	}
end

return HolyDragonFieldScoreFmtExViewPresentor
