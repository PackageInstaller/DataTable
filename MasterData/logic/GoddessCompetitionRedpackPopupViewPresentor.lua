-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscompetition/view/GoddessCompetitionRedpackPopupViewPresentor.lua

module("logic.extensions.goddesscompetition.view.GoddessCompetitionRedpackPopupViewPresentor", package.seeall)

local GoddessCompetitionRedpackPopupViewPresentor = class("GoddessCompetitionRedpackPopupViewPresentor", ViewPresentor)

function GoddessCompetitionRedpackPopupViewPresentor:ctor()
	GoddessCompetitionRedpackPopupViewPresentor.super.ctor(self)
end

function GoddessCompetitionRedpackPopupViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessCompetitionRedpackPopupViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesscompetition/goddesscompetitionredpackpopupview.prefab"
	}
end

function GoddessCompetitionRedpackPopupViewPresentor:buildViews()
	return {
		GoddessCompetitionRedpackPopupView.New()
	}
end

return GoddessCompetitionRedpackPopupViewPresentor
