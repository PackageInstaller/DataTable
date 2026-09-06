-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/challenge/view/ChallengeViewPresentor.lua

module("logic.extensions.challenge.view.ChallengeViewPresentor", package.seeall)

local ChallengeViewPresentor = class("ChallengeViewPresentor", ViewPresentor)

ChallengeViewPresentor.Url_DialogView = "ui/views/challenge/challengeview.prefab"

function ChallengeViewPresentor:ctor()
	ChallengeViewPresentor.super.ctor(self)
end

function ChallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ChallengeViewPresentor:dependWhatResources()
	return {
		ChallengeViewPresentor.Url_DialogView
	}
end

function ChallengeViewPresentor:buildViews()
	local views = {}
	local challengeView = ChallengeMgrView.New()

	table.insert(views, challengeView)

	return views
end

function ChallengeViewPresentor:getTempResources()
	local challengeId = ChallengeModel.instance:getCurId()
	local cfg = ChallengeConfig.instance:getChallengeCfg(challengeId)

	if cfg and cfg.choosePrefab ~= "" then
		local url = "ui/views/challenge/choose/" .. cfg.choosePrefab .. ".prefab"

		return {
			url
		}
	end
end

return ChallengeViewPresentor
