-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscompetition/view/GoddessCompetitionRedPackPrizeViewPresentor.lua

module("logic.extensions.goddesscompetition.view.GoddessCompetitionRedPackPrizeViewPresentor", package.seeall)

local GoddessCompetitionRedPackPrizeViewPresentor = class("GoddessCompetitionRedPackPrizeViewPresentor", ViewPresentor)

function GoddessCompetitionRedPackPrizeViewPresentor:ctor()
	GoddessCompetitionRedPackPrizeViewPresentor.super.ctor(self)
end

function GoddessCompetitionRedPackPrizeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessCompetitionRedPackPrizeViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesscompetition/goddesscompetitionredpackprizeview.prefab"
	}
end

function GoddessCompetitionRedPackPrizeViewPresentor:buildViews()
	return {
		GoddessCompetitionRedPackPrizeView.New()
	}
end

return GoddessCompetitionRedPackPrizeViewPresentor
