-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/challenge/facade/ChallengeFacade.lua

module("logic.extensions.challenge.facade.ChallengeFacade", package.seeall)

local ChallengeFacade = class("ChallengeFacade", BaseFacade)

function ChallengeFacade:loadSmallGameInfo()
	return
end

function ChallengeFacade:startChallange(challengeId, func, isNotOpenChallengeView)
	local isEnough, moFangLevel, challengeName = ChallengeController.instance:isMoFangLvEnough(challengeId)

	if isEnough then
		ChallengeAgent.instance:sendPM_ChallengeGetInfoReq(challengeId, func, isNotOpenChallengeView)
	else
		TipsFacade.instance:openLockTips(moFangLevel, GameEnum.MagicLockType.Challenge, challengeName)
	end
end

function ChallengeFacade:getChallengeOpenMofangLv(petId)
	local cfgs = ChallengeConfig.instance:getAllChallengeCfg()
	local challengeCfg

	for _, cfg in pairs(cfgs) do
		if cfg.getRaceIds and petId == cfg.getRaceIds[1] then
			challengeCfg = cfg

			print("find challenge cfg id = " .. cfg.id)

			break
		end
	end

	if not challengeCfg then
		print("not mofang unlock,raceId:" .. petId)

		return 21
	end

	return checknumber(challengeCfg.mofangLv)
end

function ChallengeFacade:getChallengeIsOpened(petId)
	local cfgs = ChallengeConfig.instance:getAllChallengeCfg()
	local challengeCfg

	for _, cfg in pairs(cfgs) do
		if cfg.getRaceIds and petId == cfg.getRaceIds[1] then
			challengeCfg = cfg

			break
		end
	end

	return challengeCfg and MofangModel.instance:getCurLv() >= checknumber(challengeCfg.mofangLv)
end

function ChallengeFacade:checkNuoya(challengeId, func)
	NewHandAgent.instance:sendGetKirinInfoReq(function(msg)
		local kiringaintime = msg.kirinGainTime
		local _time = checknumber(kiringaintime)

		if _time > 0 then
			_time = math.floor(_time / 1000)
		end

		if _time == -1 then
			TipsFacade.instance:openTipWindow(lang("tip"), lang("诺亚挑战在新手第二天开启，\n请明天来挑战吧！"))
		elseif _time == -2 then
			ChallengeAgent.instance:sendPM_ChallengeGetInfoReq(challengeId, func)
		else
			local now = ServerTime.now()

			if _time < now then
				ChallengeAgent.instance:sendPM_ChallengeGetInfoReq(challengeId, func)
			else
				TipsFacade.instance:openTipWindow(lang("tip"), lang("诺亚挑战在新手第二天开启，\n请明天来挑战吧！"))
			end
		end
	end)
end

function ChallengeFacade:isBranchPassed(challengeId, phase, branch, levelIdx)
	local model = ChallengeModel.instance
	local currId = model:getCurId()

	if not currId or currId ~= challengeId then
		return
	end

	local pass = model:isBranchPassed(phase, branch)

	if pass then
		return true
	end

	if levelIdx and levelIdx > 0 then
		local winCnt = model:getWinCount(phase, branch)

		if not winCnt then
			return
		end

		return levelIdx <= winCnt
	else
		return pass
	end
end

function ChallengeFacade:isChallengingBranchLevel(challengeId, phase, branch, levelIdx)
	local model = ChallengeModel.instance
	local currId = model:getCurId()

	if not currId or currId ~= challengeId then
		return
	end

	local currParse = model:getCurPhase()

	if currParse ~= phase then
		return
	end

	local currBranch = model:getCurBranch()

	if currBranch ~= branch then
		return
	end

	local winCnt = model:getWinCount(phase, branch) or 0

	return winCnt == levelIdx - 1
end

function ChallengeFacade:startFight(challengeId, branchId)
	if FormationFacade.instance:checkFormationEmptyAndPosNumLimit(function()
		ChallengeController.instance:startFight(challengeId, branchId)
	end) then
		return
	end

	ChallengeController.instance:startFight(challengeId, branchId)
end

function ChallengeFacade:challengeBatchGetSimpleInfosReq(challengeId)
	ChallengeAgent.instance:sendPM_ChallengeBatchGetSimpleInfosReq(challengeId)
end

ChallengeFacade.instance = ChallengeFacade.New()

return ChallengeFacade
