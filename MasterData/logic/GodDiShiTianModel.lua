-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddishitian/model/GodDiShiTianModel.lua

module("logic.extensions.goddishitian.model.GodDiShiTianModel", package.seeall)

local GodDiShiTianModel = class("GodDiShiTianModel", BaseModel)

GodDiShiTianModel.StageState = {
	ChallengeSuccess = 2,
	Unchallenge = 0,
	ChallengeFail = 1
}

function GodDiShiTianModel:ctor()
	return
end

function GodDiShiTianModel:onInit()
	self:onReset()
end

function GodDiShiTianModel:onReset()
	self._customFmtMo = nil
	self._isRecieveGetInfoRes = false
	self._challengeId = 41
	self._finalLevelPass = false
	self._stageInfo = {}
	self._simpleForm = nil
	self._oneKeyChangeSetId = nil
	self._conditions = {}
	self._battleStageTypeId = 0
	self._battleStageId = 0
	self._oldBattleScore = 0
	self._newBattleScore = 0
	self._isBattleWin = false
end

function GodDiShiTianModel:getChallengeId()
	return self._challengeId
end

function GodDiShiTianModel:getCustomFmtMo()
	if self._customFmtMo == nil then
		self._customFmtMo = GodDiShiTianCustomFmtMo.New()
	end

	return self._customFmtMo
end

function GodDiShiTianModel:onGodDiShiTianGetInfoRes(msg)
	self._isRecieveGetInfoRes = true
	self._finalLevelPass = msg.pass
	self._stageInfo = GameUtil.pbToTable(msg.stageInfo) or {}
	self._simpleForm = GameUtil.pbToTable(msg.simpleForm)

	table.sort(self._stageInfo, function(a, b)
		return a.stageType < b.stageType
	end)
end

function GodDiShiTianModel:onGodDiShiTianChallengeRes(msg)
	return
end

function GodDiShiTianModel:onGodDiShiTianSetScoreRes(msg)
	for i, v in ipairs(self._stageInfo) do
		for j, n in ipairs(v.stageInfo) do
			if n.stageId == msg.stageId then
				n.score = msg.score
				n.state = GodDiShiTianModel.StageState.ChallengeSuccess

				break
			end
		end
	end
end

function GodDiShiTianModel:onGodDiShiTianQuickPassRes(msg)
	self._finalLevelPass = msg.pass

	if msg:HasField("changeSetId") then
		self._oneKeyChangeSetId = msg.changeSetId
	end
end

function GodDiShiTianModel:onGodDiShiTianStageOverRes(msg)
	self._battleStageTypeId = 0
	self._battleStageId = 0

	if msg:HasField("pass") then
		self._finalLevelPass = msg.pass
	end

	for i, v in ipairs(self._stageInfo) do
		for j, n in ipairs(v.stageInfo) do
			if n.stageId == msg.stageId then
				self._battleStageTypeId = v.stageType
				self._battleStageId = msg.stageId
				self._oldBattleScore = n.score
				self._newBattleScore = msg.score
				n.score = msg.score
				v.totalScore = msg.totalScore

				break
			end
		end
	end

	self._isBattleWin = msg.win
	self._conditions = GameUtil.pbToTable(msg.condition) or {}
end

function GodDiShiTianModel:isRecieveGetInfoRes()
	return self._isRecieveGetInfoRes
end

function GodDiShiTianModel:getOneKeyChangeSetId()
	self._oneKeyChangeSetId = nil

	return self._oneKeyChangeSetId
end

function GodDiShiTianModel:getConditionStrs()
	local cfg = GodDiShiTianConfig.instance:getStageTypeInfoCfg(self._battleStageTypeId, self._battleStageId)

	if not cfg then
		return {}
	end

	local strList = {}
	local scorePlanId = cfg.scorePlanId

	for i, v in ipairs(self._conditions) do
		local cfgScore = GodDiShiTianConfig.instance:getChallengeScoreCfg(scorePlanId, v.conditionId)

		if cfgScore then
			local str = string.format(cfgScore.desc, unpack(v.param or {}))

			str = str .. " " .. string.format("获得%d分", v.score)

			table.insert(strList, str)
		end
	end

	return strList
end

function GodDiShiTianModel:isShowCoverScoreView()
	return self._battleStageTypeId > 0 and self._battleStageTypeId < 4 and self._oldBattleScore ~= self._newBattleScore
end

function GodDiShiTianModel:getBattleStageId()
	return self._battleStageId
end

function GodDiShiTianModel:getBattleStageTypeId()
	return self._battleStageTypeId
end

function GodDiShiTianModel:getBattleScore()
	return self._oldBattleScore, self._newBattleScore
end

function GodDiShiTianModel:getSimpleForm()
	if self._simpleForm then
		for i, v in ipairs(self._simpleForm.pos) do
			if v ~= 0 and not BagModel.instance:getBagPetById(v) then
				self._simpleForm.pos[i] = 0
			end
		end
	end

	return self._simpleForm
end

function GodDiShiTianModel:isPassFinalLevel()
	return self._finalLevelPass
end

function GodDiShiTianModel:isFinalLevelOpen()
	local score

	for i, v in ipairs(self._stageInfo) do
		if v.stageType >= 1 and v.stageType <= 3 then
			local cfg = GodDiShiTianConfig.instance:getStageTypeCfg(v.stageType)

			if cfg then
				if not cfg.passLine then
					local targetScore = 0

					if targetScore > v.totalScore then
						return false
					end

					if score then
						if Mathf.Abs(score - v.totalScore) > 0.0001 then
							return false
						end
					else
						score = v.totalScore
					end

					for m, n in ipairs(v.stageInfo) do
						if n.state < GodDiShiTianModel.StageState.ChallengeSuccess then
							return false
						end
					end
				end
			end
		end
	end

	return true
end

function GodDiShiTianModel:getChapterScore(index)
	local score = 0

	for i, v in ipairs(self._stageInfo) do
		if v.stageType == index then
			score = v.totalScore

			break
		end
	end

	return score
end

function GodDiShiTianModel:isChapterPass(index)
	local isPass = false

	for i, v in ipairs(self._stageInfo) do
		if v.stageType == index then
			isPass = true

			for m, n in ipairs(v.stageInfo) do
				if n.state < GodDiShiTianModel.StageState.ChallengeSuccess then
					isPass = false

					break
				end
			end

			break
		end
	end

	return isPass
end

function GodDiShiTianModel:isAnyStagePass(index)
	local isAnyStagePass = false

	for i, v in ipairs(self._stageInfo) do
		if v.stageType == index then
			for m, n in ipairs(v.stageInfo) do
				if n.state == GodDiShiTianModel.StageState.ChallengeSuccess then
					isAnyStagePass = true
				end
			end

			break
		end
	end

	return isAnyStagePass
end

function GodDiShiTianModel:isBattleStageWinedBefore(stageId)
	for i, v in ipairs(self._stageInfo) do
		for m, n in ipairs(v.stageInfo) do
			if n.stageId == stageId then
				return n.state == GodDiShiTianModel.StageState.ChallengeSuccess
			end
		end
	end

	return false
end

function GodDiShiTianModel:getChapterInfo(index)
	for i, v in ipairs(self._stageInfo) do
		if v.stageType == index then
			table.sort(v.stageInfo, function(a, b)
				return a.stageId < b.stageId
			end)

			return v.stageInfo
		end
	end
end

function GodDiShiTianModel:isChallengeWin()
	return self._isBattleWin
end

GodDiShiTianModel.instance = GodDiShiTianModel.New()

return GodDiShiTianModel
