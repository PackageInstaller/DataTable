-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/challenge/model/ChallengeModel.lua

module("logic.extensions.challenge.model.ChallengeModel", package.seeall)

local ChallengeModel = class("ChallengeModel", BaseListModel)
local json = require("cjson")

function ChallengeModel:ctor()
	ChallengeModel.super.ctor(self)
	self:onReset()
end

function ChallengeModel:onReset()
	ChallengeModel.super.onReset(self)

	self._curInfo = nil
	self._curBranch = nil
	self._changeSetIds = {}
	self._simpleInfos = {}
end

function ChallengeModel:setBattleResultInfo()
	local phase = self:getCurPhase()
	local branch = self:getCurBranch()

	printInfo("此处执行了！！！！！！！", phase, branch)

	if not branch then
		branch = 0

		printInfo("此处进行了修正！！")
	end

	local params = {}

	params.curNum = self:getWinCount(phase, branch) + 1

	local cfg = ChallengeConfig.instance:getChallengeMissionCfg(ChallengeModel.instance:getCurId(), phase, branch)

	params.totalNum = #cfg.subMission

	local curIndex = ChallengeModel.instance:getWinCount(phase, branch) + 1

	if BattleRecordRankController.instance:isChallengeWithBattleRecord(ChallengeModel.instance:getCurId()) then
		params.videoKey = BattleRecordRankController.instance:getChallengeRankKey(ChallengeModel.instance:getCurId(), phase, branch, curIndex)
	end
end

function ChallengeModel:setCurChallenge(msg)
	self:_updateSimpleInfo(msg.challengeId, msg.curPhase, msg.isGetPrize)

	self._curInfo = msg
	self._curExtParams = json.decode(self._curInfo.extJsonParams)
	self._phaseInfo = {}
	self._branchInfo = {}
	self._branchInfoExtParams = {}

	local phaseInfos = self._curInfo.phaseNotPassedInfo

	for i, v in ipairs(phaseInfos) do
		self._phaseInfo[v.phaseId] = v
		self._branchInfo[v.phaseId] = {}

		for i1, v1 in ipairs(v.branchInfo) do
			self._branchInfo[v.phaseId][v1.branchId] = v1

			if v1.extJsonParams and tostring(v1.extJsonParams) ~= "" then
				self._branchInfoExtParams[v.phaseId] = self._branchInfoExtParams[v.phaseId] or {}
				self._branchInfoExtParams[v.phaseId][v1.branchId] = json.decode(v1.extJsonParams)
			end
		end
	end
end

function ChallengeModel:getCurId()
	if self._curInfo then
		return self._curInfo.challengeId
	end

	return nil
end

function ChallengeModel:changeLongTimeValues(extJson)
	local values = json.decode(extJson).long_time_values

	if values then
		for i = 1, #self._curInfo.longTimeValue do
			self._curInfo.longTimeValue[i] = values[i]
		end
	end
end

function ChallengeModel:getCurPhase()
	if self._curInfo then
		return self._curInfo.curPhase
	end

	return nil
end

function ChallengeModel:setCurBranch(curBranchId)
	self._curBranch = curBranchId
end

function ChallengeModel:setCurBranchForLinear()
	local isSet = false

	for k, v in pairs(self._branchInfo) do
		for k1, v1 in pairs(v) do
			local isPass = v1.state == GameEnum.ChallengeBranchState.PASSED

			if isPass then
				-- block empty
			elseif not isSet then
				isSet = true
				self._curBranch = v1.branchId

				return
			end
		end
	end
end

function ChallengeModel:getCurBranch()
	return self._curBranch
end

function ChallengeModel:getBranchExtParams(branch)
	return self._branchInfoExtParams[self._curInfo.curPhase][branch]
end

function ChallengeModel:setBranchExtParams(branch, para)
	self._branchInfoExtParams[self._curInfo.curPhase][branch] = para
end

function ChallengeModel:getBranchExtPara(branch)
	return self._branchInfo[self._curInfo.curPhase][branch].extJsonParams
end

function ChallengeModel:setBranchExtPara(branch, para)
	self._branchInfo[self._curInfo.curPhase][branch].extJsonParams = para
end

function ChallengeModel:getBranchState(phase, branch)
	if not self._phaseInfo[phase] or not self._branchInfo[phase][branch] then
		return GameEnum.ChallengeBranchState.PASSED
	end

	return self._branchInfo[phase][branch].state
end

function ChallengeModel:setWinCount(phase, branch, count)
	if not self._branchInfo[phase] or not self._branchInfo[phase][branch] then
		return
	end

	self._branchInfo[phase][branch].linearInfo.winCount = count
end

function ChallengeModel:getWinCount(phase, branch)
	if not self._branchInfo[phase] or not self._branchInfo[phase][branch] then
		return nil
	end

	return self._branchInfo[phase][branch].linearInfo.winCount
end

function ChallengeModel:getBranchForNextMission(phase, branch)
	return
end

function ChallengeModel:getTeamInfo(phase, branch)
	local index = self._branchInfo[phase][branch].linearInfo.winCount + 1

	return self._branchInfo[phase][branch].team[index]
end

function ChallengeModel:setPrizeGot()
	self._curInfo.isGetPrize = true
end

function ChallengeModel:canGetPrize()
	return self._curInfo.isOpen and not self._curInfo.isGetPrize
end

function ChallengeModel:isPrizeGot()
	return self._curInfo.isGetPrize
end

function ChallengeModel:isBranchPassed(phase, branch)
	return self:getBranchState(phase, branch) == GameEnum.ChallengeBranchState.PASSED
end

function ChallengeModel:getLongTimeValues(challengeId)
	return self._curInfo.longTimeValue
end

function ChallengeModel:getDailyValues()
	return self._curInfo.dailyValue
end

function ChallengeModel:getExtJsonParams()
	return self._curInfo.extJsonParams
end

function ChallengeModel:modifyExtJsonParams(extJsonParams)
	self._curInfo.extJsonParams = extJsonParams
end

function ChallengeModel:getCurExtParams()
	return self._curExtParams
end

function ChallengeModel:setCurExtParams(extJsonParams)
	self._curExtParams = extJsonParams
end

function ChallengeModel:modifyDailyValues(index, val)
	self._curInfo.dailyValue[index] = val
end

function ChallengeModel:setChangeSetIds(ids)
	self:clearChangeSetIds()
	table.insert(self._changeSetIds, ids)
end

function ChallengeModel:getChangeSetIds()
	return self._changeSetIds
end

function ChallengeModel:clearChangeSetIds()
	self._changeSetIds = {}
end

function ChallengeModel:isXiongMaoGamePass()
	return self:_isChallengePass(18) and self:_isGetedPrize(18)
end

function ChallengeModel:isQianNiaoWanGamePass()
	return self:_isChallengePass(17) and self:_isGetedPrize(17)
end

function ChallengeModel:isChallengeAndPrizePass(challengeId)
	return self:_isChallengePass(challengeId) and self:_isGetedPrize(challengeId)
end

function ChallengeModel:_isChallengePass(challengeId)
	return self._simpleInfos[challengeId] and self._simpleInfos[challengeId].curPhase == -1
end

function ChallengeModel:_isGetedPrize(challengeId)
	return self._simpleInfos[challengeId] and self._simpleInfos[challengeId].isGetPrize
end

function ChallengeModel:setChallengeSimpleInfos(msg)
	local simpleinfo = msg.simpleInfo

	for i, v in ipairs(simpleinfo) do
		self:_updateSimpleInfo(v.challengeId, v.curPhase, v.isGetPrize)
	end
end

function ChallengeModel:setSimpleInfosByUnlockMsg(challengeInfos)
	if challengeInfos then
		for i, v in ipairs(challengeInfos) do
			self:_updateSimpleInfo(v.challengeId, v.curPhase, v.isGetPrize)
		end
	end
end

function ChallengeModel:_updateSimpleInfo(challengeId, curPhase, isGetPrize)
	if self._simpleInfos[challengeId] then
		self._simpleInfos[challengeId].curPhase = curPhase
		self._simpleInfos[challengeId].isGetPrize = isGetPrize
	else
		self._simpleInfos[challengeId] = {}
		self._simpleInfos[challengeId].curPhase = curPhase
		self._simpleInfos[challengeId].isGetPrize = isGetPrize
	end
end

ChallengeModel.instance = ChallengeModel.New()

return ChallengeModel
