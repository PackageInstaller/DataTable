-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/challenge/view/specialviews/QianNiaoPickAPet.lua

module("logic.extensions.challenge.view.specialviews.QianNiaoPickAPet", package.seeall)

local QianNiaoPickAPet = class("QianNiaoPickAPet", PickAPetInfoBase)

function QianNiaoPickAPet:ctor()
	QianNiaoPickAPet.super.ctor(self)

	self._gameType = PickAPetModel.GameType.QianNiaoZhenShen
	self._initCollectNums = nil
end

function QianNiaoPickAPet:setParams(params)
	self._initCollectNums = params or {
		0,
		0
	}
end

function QianNiaoPickAPet:getParams()
	return self._initCollectNums
end

function QianNiaoPickAPet:onGameOverCallback(callback)
	local challengeId = ChallengeModel.instance:getCurId()
	local count = PickAPetModel.instance:getCollect()
	local reqExtParams = "{\"count\":" .. count .. ",\"starGame\":\"false\"}"

	printInfo(reqExtParams)
	ChallengeController.instance:extTeamOpt(17, 3, "17_Accumulate", reqExtParams, function()
		ChallengeFacade.instance:startChallange(challengeId, function(prePhase)
			GameUtil.callBack(callback)

			if prePhase == ChallengeModel.instance:getCurPhase() then
				UIStateManager.instance:push(ViewName.qianniaozhenshenview)
			end
		end)
	end)
end

function PickAPetInfoBase:getViewDesc()
	return "千鸟丸真身"
end

function PickAPetInfoBase:getIconName()
	return "icon_10155_qianniaowan", "icon_10020_yuandulingbao"
end

return QianNiaoPickAPet
