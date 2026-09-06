-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscompetition/view/GoddessCompetitionSpecialItemViewPresentor.lua

module("logic.extensions.goddesscompetition.view.GoddessCompetitionSpecialItemViewPresentor", package.seeall)

local GoddessCompetitionSpecialItemViewPresentor = class("GoddessCompetitionSpecialItemViewPresentor", ViewPresentor)

function GoddessCompetitionSpecialItemViewPresentor:ctor()
	GoddessCompetitionSpecialItemViewPresentor.super.ctor(self)
end

function GoddessCompetitionSpecialItemViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessCompetitionSpecialItemViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesscompetition/goddesscompetitionspecialitemview.prefab"
	}
end

function GoddessCompetitionSpecialItemViewPresentor:buildViews()
	return {
		GoddessCompetitionSpecialItemView.New()
	}
end

function GoddessCompetitionSpecialItemViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GoddessCompetitionSpecialItemViewPresentor
