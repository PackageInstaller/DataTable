-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godxiuerchallenge/model/GodXiuerChallengeModel.lua

module("logic.extensions.godxiuerchallenge.model.GodXiuerChallengeModel", package.seeall)

local GodXiuerChallengeModel = class("GodXiuerChallengeModel", BaseModel)

GodXiuerChallengeModel.StageRight = 1
GodXiuerChallengeModel.StageWrong = 2
GodXiuerChallengeModel.EvolveChallengeId = 60
GodXiuerChallengeModel.NormalChallengeId = 61

function GodXiuerChallengeModel:ctor()
	return
end

function GodXiuerChallengeModel:onInit()
	self:onReset()
end

function GodXiuerChallengeModel:onReset()
	self._activityId = 0
	self._dataDic = {}

	local challengeIds = {
		60,
		61
	}

	for i, challengeId in ipairs(challengeIds) do
		local data = {}

		data._score = 0
		data._changeSetId = 0
		data._limitChallengeInfos = {}
		data._limitForm = nil
		data._deltaLimitChallengeInfos = {}
		data._id = 0
		data._stage = 0
		data._pass = false
		data._wholePeopleForm = nil
		data._isLimitWin = false
		data._isWholePeopleWin = false
		self._dataDic[challengeId] = data
	end

	self._customTrueOrFalseFmtMo = nil
	self._customGoodOrEvilFmtMo = nil
	self._curChallengeId = 0
end

function GodXiuerChallengeModel:setCurChallengeId(challengeId)
	self._curChallengeId = challengeId
end

function GodXiuerChallengeModel:isPassTime(challengeId)
	local cfg = GoodOrEvilChallengeConfig.instance:getCfgById(challengeId)

	if not string.nilorempty(cfg.passSaleAwardTime) then
		local time = GameUtil.string2time(cfg.passSaleAwardTime)

		return time > ServerTime.now()
	end

	return false
end

function GodXiuerChallengeModel:isEvolveChallenge(challengeId)
	return challengeId == GodXiuerChallengeModel.EvolveChallengeId
end

function GodXiuerChallengeModel:getCustomTrueOrFalseFmtMo(challengeId, id, stage, form)
	if self._customTrueOrFalseFmtMo == nil then
		self._customTrueOrFalseFmtMo = TrueOrFalseChallengeCustomFmtMo.New()
	end

	self._customTrueOrFalseFmtMo:initParams(challengeId, id, stage, form)

	return self._customTrueOrFalseFmtMo
end

function GodXiuerChallengeModel:getCustomGoodOrEvilFmtMo(challengeId, id)
	if self._customGoodOrEvilFmtMo == nil then
		self._customGoodOrEvilFmtMo = GoodOrEvilChallengeCustomFmtMo.New()
	end

	self._customGoodOrEvilFmtMo:initParams(challengeId, id)

	return self._customGoodOrEvilFmtMo
end

function GodXiuerChallengeModel:onChallengeScoreInfoRes(msg, challengeId)
	self._dataDic[msg.challengeId]._score = msg.score
end

function GodXiuerChallengeModel:onChallengeOneKeyPassRes(msg, challengeId)
	if self._dataDic[challengeId] then
		self._dataDic[challengeId]._changeSetId = msg.changeSetId

		local cfg = GoodOrEvilChallengeConfig.instance:getCfgById(challengeId)

		if cfg then
			maxScore = cfg.score
			self._dataDic[challengeId]._score = maxScore
		end
	end
end

function GodXiuerChallengeModel:onLimitChallengeInfoRes(msg, challengeId)
	if self._dataDic[challengeId] then
		self._dataDic[challengeId]._limitChallengeInfos = GameUtil.pbToTable(msg.limitChallengeInfos) or {}
	end
end

function GodXiuerChallengeModel:onLimitChallengeFormRes(msg, challengeId)
	if self._dataDic[challengeId] then
		self._dataDic[challengeId]._limitForm = msg:HasField("form") and GameUtil.pbToTable(msg.form) or nil
	end
end

function GodXiuerChallengeModel:onWholePeopleChallengeInfoRes(msg, challengeId)
	if self._dataDic[challengeId] then
		self._dataDic[challengeId]._id = msg.id
		self._dataDic[challengeId]._stage = msg.stage
		self._dataDic[challengeId]._pass = msg.pass
		self._dataDic[challengeId]._day = msg.day
		self._dataDic[challengeId]._wholePeopleForm = msg:HasField("form") and GameUtil.pbToTable(msg.form) or nil
	end
end

function GodXiuerChallengeModel:onLimitChallengeResetRes(challengeId)
	if self._dataDic[challengeId] then
		self._dataDic[challengeId]._limitChallengeInfos = {}
	end
end

function GodXiuerChallengeModel:onLimitChallengeEndRes(msg)
	if self._curChallengeId > 0 then
		self._dataDic[self._curChallengeId]._isLimitWin = msg.isWin
		self._dataDic[self._curChallengeId]._deltaLimitChallengeInfos = GameUtil.pbToTable(msg.limitChallengeInfos) or {}
	end
end

function GodXiuerChallengeModel:onWholePeopleChallengeEndRes(msg)
	if self._curChallengeId > 0 then
		self._dataDic[self._curChallengeId]._isWholePeopleWin = msg.isWin
		self._dataDic[self._curChallengeId]._id = msg.id
		self._dataDic[self._curChallengeId]._stage = msg.stage
		self._dataDic[self._curChallengeId]._pass = msg.pass
		self._dataDic[self._curChallengeId]._score = msg.score
	end
end

function GodXiuerChallengeModel:isLimitChallengeInfoSame(challengeId)
	if self._dataDic[challengeId] then
		local oldInfos = self._dataDic[challengeId]._limitChallengeInfos
		local deltaInfos = self._dataDic[challengeId]._deltaLimitChallengeInfos
		local delta = deltaInfos[1]

		if delta then
			for i, old in ipairs(oldInfos) do
				if old.id == delta.id then
					if old.num == 0 then
						return true, old.num, delta.num, delta.id
					end

					return old.num == delta.num, old.num, delta.num, delta.id
				end
			end

			return true, 0, delta.num, delta.id
		end
	end
end

function GodXiuerChallengeModel:updateDeltaLimitChallengeInfos(challengeId)
	if self._dataDic[challengeId] then
		local deltaInfos = self._dataDic[challengeId]._deltaLimitChallengeInfos

		if deltaInfos then
			for i, delta in ipairs(deltaInfos) do
				local isExist = false
				local oldInfos = self._dataDic[challengeId]._limitChallengeInfos

				for i, old in ipairs(oldInfos) do
					if delta.id == old.id then
						old.num = delta.num
						isExist = true

						break
					end
				end

				if not isExist then
					table.insert(oldInfos, delta)
				end
			end
		end
	end
end

function GodXiuerChallengeModel:getLimitChallengeInfos(challengeId)
	if self._dataDic[challengeId] then
		return self._dataDic[challengeId]._limitChallengeInfos
	else
		return nil
	end
end

function GodXiuerChallengeModel:getScore(challengeId)
	if self._dataDic[challengeId] then
		return self._dataDic[challengeId]._score
	end

	return 0
end

function GodXiuerChallengeModel:getMaxScore(challengeId)
	local cfg = GoodOrEvilChallengeConfig.instance:getCfgById(challengeId)

	if cfg then
		return cfg.score
	else
		return 0
	end
end

function GodXiuerChallengeModel:isPass(challengeId)
	if self:getScore(challengeId) >= self:getMaxScore(challengeId) then
		return true
	end

	return false
end

function GodXiuerChallengeModel:getOneKeyChangeSetId(challengeId)
	if self._dataDic[challengeId] then
		return self._dataDic[challengeId]._changeSetId
	end
end

function GodXiuerChallengeModel:isLimitChallengedAll(challengeId)
	local limitChallengeInfos = self:getLimitChallengeInfos(challengeId)

	return limitChallengeInfos and #limitChallengeInfos == 10
end

function GodXiuerChallengeModel:getLimitChallengeSurvivalAndRound(challengeId)
	local happyNum = 0
	local sadNum = 0
	local limitChallengeInfos = self:getLimitChallengeInfos(challengeId)

	if not limitChallengeInfos or #limitChallengeInfos == 0 then
		return happyNum, sadNum
	end

	for i, v in ipairs(limitChallengeInfos) do
		if v.id >= 1 and v.id <= 5 then
			happyNum = happyNum + v.num
		end

		if v.id >= 6 and v.id <= 10 then
			sadNum = sadNum + v.num
		end
	end

	return happyNum, sadNum
end

function GodXiuerChallengeModel:isLevelPass(challengeId, id)
	local limitChallengeInfos = self:getLimitChallengeInfos(challengeId)

	if limitChallengeInfos and #limitChallengeInfos > 0 then
		for i, v in ipairs(limitChallengeInfos) do
			if v.id == id and v.num > 0 then
				return true, v.num
			end
		end

		return false, 0
	else
		return false, 0
	end
end

function GodXiuerChallengeModel:getCurWholePeopleId(challengeId)
	if self._dataDic[challengeId] then
		return self._dataDic[challengeId]._id
	else
		return nil
	end
end

function GodXiuerChallengeModel:getCurWholePeopleDay(challengeId)
	if self._dataDic[challengeId] and self._dataDic[challengeId]._day then
		local day = self._dataDic[challengeId]._day

		return (day - 1) % 7 + 1
	else
		return 1
	end
end

function GodXiuerChallengeModel:isWholePeopleLevelPass(challengeId, id)
	if self._dataDic[challengeId] then
		local curId = self._dataDic[challengeId]._id
		local stage = self._dataDic[challengeId]._stage
		local pass = self._dataDic[challengeId]._pass

		if id < curId then
			return true
		elseif curId == id and stage == GodXiuerChallengeModel.StageWrong and pass then
			return true
		end

		return false
	else
		return false
	end
end

function GodXiuerChallengeModel:isCurWholePeopleLevel(challengeId, id)
	if self._dataDic[challengeId] then
		local curId = self._dataDic[challengeId]._id

		return curId == id
	else
		return false
	end
end

function GodXiuerChallengeModel:isCurLevelCanChallenge(challengeId, id, stage)
	if self._dataDic[challengeId] then
		if stage == GodXiuerChallengeModel.StageRight then
			return not self:isWholePeopleLevelPass(challengeId, id)
		else
			local curId = self._dataDic[challengeId]._id
			local curStage = self._dataDic[challengeId]._stage
			local curPass = self._dataDic[challengeId]._pass

			if curId == id and curStage == GodXiuerChallengeModel.StageRight and curPass then
				return true
			end
		end
	end

	return false
end

function GodXiuerChallengeModel:getWholePeopleStageAndPass(challengeId)
	if self._dataDic[challengeId] then
		local stage = self._dataDic[challengeId]._stage
		local pass = self._dataDic[challengeId]._pass

		return stage, pass
	else
		return 1, false
	end
end

function GodXiuerChallengeModel:getWholePeopleWrongForm(challengeId)
	if self._dataDic[challengeId] then
		return self._dataDic[challengeId]._wholePeopleForm
	end
end

GodXiuerChallengeModel.instance = GodXiuerChallengeModel.New()

return GodXiuerChallengeModel
