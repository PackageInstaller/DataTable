-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlerecord/view/ChllengeRankViewPresentor.lua

module("logic.extensions.battlerecord.view.ChllengeRankViewPresentor", package.seeall)

local ChllengeRankViewPresentor = class("ChllengeRankViewPresentor", ViewPresentor)

function ChllengeRankViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ChllengeRankViewPresentor:dependWhatResources()
	return {
		"ui/views/battlerecord/challengeranksview.prefab"
	}
end

function ChllengeRankViewPresentor:buildViews()
	return {
		ChllengeRankView.New()
	}
end

return ChllengeRankViewPresentor
