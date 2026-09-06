-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holydragonfield/view/HolyDragonFieldBuffViewPresentor.lua

module("logic.extensions.holydragonfield.view.HolyDragonFieldBuffViewPresentor", package.seeall)

local HolyDragonFieldBuffViewPresentor = class("HolyDragonFieldBuffViewPresentor", ViewPresentor)

function HolyDragonFieldBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HolyDragonFieldBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/holydragonfield/holydragonfieldbuffview.prefab"
	}
end

function HolyDragonFieldBuffViewPresentor:buildViews()
	return {
		HolyDragonFieldBuffView.New()
	}
end

return HolyDragonFieldBuffViewPresentor
