-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/challenge/view/ChallengeMini.lua

module("logic.extensions.challenge.view.ChallengeMini", package.seeall)

local ChallengeMini = class("ChallengeMini")

function ChallengeMini:onEnter(go, cfg, openByJumper)
	UIStateManager.instance:pop()
	UIStateManager.instance:push(ViewName.missionview, 0, 0, openByJumper)
	ChallengeController.instance:localNotify("ClassLoaded")
	ChallengeModel.instance:setCurBranch(0)

	self._winCount = ChallengeModel.instance:getWinCount(0, 0)
end

function ChallengeMini:onExit()
	return
end

function ChallengeMini:teamFightEnd(params)
	local curId = ChallengeModel.instance:getCurId()
	local phase = ChallengeModel.instance:getCurPhase()

	if phase == 0 then
		UIJumper.instance:pushOneStack(ViewName.challengemgrview, true, true)
	end
end

function ChallengeMini:_registerResultView(curId, achieveNum)
	local subId = self._winCount
	local cfg = ChallengeConfig.instance:getChallengeKV(curId, subId)
	local isWin = BattleFacade.instance:isSelfRealWin()

	BattleFacade.instance:registerResultHandler(function()
		if isWin then
			ViewMgr.instance:open(ViewName.BattleSettlementSuccess)
		else
			ViewMgr.instance:open(ViewName.BattleSettlementFailSimple)
		end

		return true
	end, nil)
end

return ChallengeMini
