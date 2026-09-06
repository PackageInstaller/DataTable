-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tongbattle/model/TongBattleModel.lua

module("logic.extensions.tongbattle.model.TongBattleModel", package.seeall)

local TongBattleModel = class("TongBattleModel", BaseModel)

function TongBattleModel:ctor()
	self.challengeId = 21
	self.petRaceId = 10334
	self.tongBaseInfo = nil
	self.tongBattleInfo = nil
	self._cacheEndInfo = nil
	self._commRankList = nil
	self._hellRankList = nil
end

function TongBattleModel:onInit()
	TongBattleModel.super.onInit(self)
	self:onReset()
end

function TongBattleModel:onReset()
	self.tongBaseInfo = nil
	self.tongBattleInfo = nil
	self._cacheEndInfo = nil
	self._commRankList = nil
	self._hellRankList = nil
end

function TongBattleModel:getTongBaseInfo()
	if self.tongBaseInfo == nil then
		self:_setTongBaseInfo()
	end

	return self.tongBaseInfo
end

function TongBattleModel:getTongBattleInfo()
	if self.tongBattleInfo == nil then
		self:_setTongBattleInfo()
	end

	return self.tongBattleInfo
end

function TongBattleModel:getBuyCountConsume(planId, num)
	num = checknumber(num)

	local allCfgs = TongBattleConfig.instance:getAllBuyTimesCfgs(planId)
	local allNum = #allCfgs
	local cfg = allCfgs[1]

	if num > 0 then
		cfg = allCfgs[num] or allCfgs[allNum]
	end

	if cfg and not string.nilorempty(cfg.consume) then
		return string.split(cfg.consume, ":"), allNum
	end

	return nil, 0
end

function TongBattleModel:getPlayerRankInfo(isComm)
	local nowTime = ServerTime.now()

	if isComm then
		self._commRankList = self._commRankList or {}

		if nowTime >= checknumber(self._commRankList.sendTime) + 60 then
			self._commRankList.sendTime = nowTime

			TongBattleController.instance:csGetTongRankInfoReq(true)
		end

		return self._commRankList
	else
		self._hellRankList = self._hellRankList or {}

		if nowTime >= checknumber(self._hellRankList.sendTime) + 60 then
			self._hellRankList.sendTime = nowTime

			TongBattleController.instance:csGetTongRankInfoReq(false)
		end

		return self._hellRankList
	end
end

function TongBattleModel:getTongRankTabList()
	return {
		"普通模式",
		"地狱模式"
	}
end

function TongBattleModel:_setTongBaseInfo()
	self.tongBaseInfo = {}
	self.tongBaseInfo.useCount = 0
	self.tongBaseInfo.buyCount = 0
	self.tongBaseInfo.tongCount = 0
	self.tongBaseInfo.isGetTong = false
	self.tongBaseInfo.prizeCount = 0
end

function TongBattleModel:_setTongBattleInfo()
	self.tongBattleInfo = {}
	self.tongBattleInfo.roundList = {
		0,
		0,
		0,
		0
	}
	self.tongBattleInfo.fireNum = 0
	self.tongBattleInfo.fireCount = 0
	self.tongBattleInfo.roundCount = 0
	self.tongBattleInfo.isLockBuxi = false
	self.tongBattleInfo.demonRounds = {
		0,
		0,
		0,
		0
	}
	self.tongBattleInfo.isFireEff = false
end

function TongBattleModel:isOpenDemonShowRound()
	if self._cacheEndInfo and (self._cacheEndInfo.chalType == 3 or self._cacheEndInfo.chalType == 4) then
		if checknumber(self._cacheEndInfo.newTurns) > 0 then
			local str

			if checknumber(self._cacheEndInfo.oldTurns) <= 0 then
				str = langPara("text_tong_desc_1", self._cacheEndInfo.newTurns)
			else
				local cfg = TongBattleConfig.instance:getBattleBaseCfg(self.challengeId)
				local differ = cfg and checknumber(cfg.demonRoundsDiffer) or 0

				str = differ >= math.abs(checknumber(self._cacheEndInfo.newTurns) - checknumber(self._cacheEndInfo.oldTurns)) and langPara("text_tong_desc_2", self._cacheEndInfo.oldTurns, self._cacheEndInfo.newTurns) or langPara("text_tong_desc_3", self._cacheEndInfo.oldTurns, self._cacheEndInfo.newTurns)
			end

			if string.nilorempty(str) then
				return false
			end

			TipsFacade.instance:openTipWindow(lang("text_battle_end"), str, nil, lang("text_tong_know"), UnityEngine.TextAnchor.MiddleCenter)

			return true
		end

		self._cacheEndInfo.oldTurns = nil
		self._cacheEndInfo.newTurns = nil
	end

	return false
end

function TongBattleModel:isOpenDemonChooseRound()
	if self._cacheEndInfo and (self._cacheEndInfo.chalType == 3 or self._cacheEndInfo.chalType == 4) then
		local count = checknumber(self._cacheEndInfo.passCount)

		if count == 0 then
			return
		end

		local str
		local cfg = MaterialMgr.getMatCfg(MatType.PET_SKIN, self.petRaceId)

		if self._cacheEndInfo.isGetTong then
			str = count < 0 and langPara("text_tong_desc_4", cfg.skinName) or langPara("text_tong_desc_24", count, cfg.skinName)
		elseif count < -1 then
			if self._cacheEndInfo.chalType == 3 then
				str = langPara("text_tong_desc_23", lang("text_tong_desc_25"), cfg.skinName)
			elseif self._cacheEndInfo.chalType == 4 then
				str = langPara("text_tong_desc_23", lang("text_tong_desc_26"), cfg.skinName)
			end
		elseif count == -1 then
			str = langPara("text_tong_desc_5", count, cfg.skinName)
		elseif count > 0 then
			str = langPara("text_tong_desc_6", count, cfg.skinName)
		end

		if string.nilorempty(str) then
			return false
		end

		TipsFacade.instance:openTipWindow(lang("text_battle_success"), str, nil, lang("text_tong_know"), UnityEngine.TextAnchor.MiddleCenter)

		self._cacheEndInfo = nil

		return true
	end

	return false
end

function TongBattleModel:isOpenTinderChooseRound()
	if self._cacheEndInfo and self._cacheEndInfo.chalType == 1 then
		local temp = self._cacheEndInfo.newTurns - self._cacheEndInfo.oldTurns
		local isFirst = false

		if self.tongBattleInfo and self.tongBattleInfo.roundList then
			local count = checknumber(self.tongBattleInfo.roundList[self._cacheEndInfo.chalId])

			temp = temp + count

			if count <= 0 then
				isFirst = true
			end
		else
			isFirst = true
		end

		if not isFirst and self._cacheEndInfo.oldTurns == 0 then
			isFirst = true
		end

		local params = {}

		params.desc = langPara("text_tong_desc_7", temp)
		params.oldTurns = self._cacheEndInfo.oldTurns
		params.newTurns = self._cacheEndInfo.newTurns
		params.allTurns = checknumber(self.tongBattleInfo.roundCount)
		params.isFirst = isFirst

		UIStateManager.instance:push(ViewName.TongResult, params)

		self._cacheEndInfo = nil

		return true
	end

	return false
end

function TongBattleModel:getTongBattleRedpoint()
	local value = GameUtil.getUserDayData("TongBattleRedpoint")

	if checknumber(value) == 1 then
		return false
	end

	if self.tongBaseInfo == nil then
		self:_setTongBaseInfo()
	end

	if not TLChallengeController.instance:isInOpenTime(self.challengeId) then
		return false
	end

	local challCfg = TongBattleConfig.instance:getBattleBaseCfg(self.challengeId)

	return challCfg.freeChallengeTimes + self.tongBaseInfo.buyCount > self.tongBaseInfo.useCount
end

function TongBattleModel:scSendTongBaseInfo(data)
	self:_setChallCountInfo(data.todayChallengeTimes, data.todayChallengeBuyTimes)

	self.tongBaseInfo.prizeCount = checknumber(data.todayGainDiamonds)
	self.tongBaseInfo.tongCount = checknumber(data.spaceGained)
	self.tongBaseInfo.isGetTong = data.isGetPupil

	GlobalDispatcher:dispatch(GlobalNotify.UpdateTongBaseInfo)
end

function TongBattleModel:scSendTongBattleInfo(data)
	self:_setChallCountInfo(data.todayChallengeTimes, data.todayChallengeBuyTimes)

	self.tongBaseInfo.prizeCount = checknumber(data.todayGainDiamonds)

	if self.tongBattleInfo == nil then
		self:_setTongBattleInfo()
	end

	if data.seedTurns and #data.seedTurns == 4 then
		self.tongBattleInfo.roundList = data.seedTurns
	end

	self.tongBattleInfo.isFireEff = false

	if checknumber(self.tongBattleInfo.fireNum) + 1 == checknumber(data.fireNum) then
		self.tongBattleInfo.isFireEff = true
	end

	self.tongBattleInfo.fireNum = checknumber(data.fireNum)
	self.tongBattleInfo.roundCount = checknumber(data.turns)
	self.tongBattleInfo.isLockBuxi = true
	self.tongBattleInfo.fireCount = 0

	for _, count in pairs(self.tongBattleInfo.roundList) do
		if type(count) == "number" then
			self.tongBattleInfo.fireCount = self.tongBattleInfo.fireCount + checknumber(count)

			if checknumber(count) <= 0 then
				self.tongBattleInfo.isLockBuxi = false
			end
		end
	end

	if self.tongBattleInfo.isLockBuxi and self.tongBattleInfo.fireCount ~= self.tongBattleInfo.roundCount then
		self.tongBattleInfo.isLockBuxi = false
	end

	GlobalDispatcher:dispatch(GlobalNotify.UpdateTongBattleInfo)
end

function TongBattleModel:_setChallCountInfo(num1, num2)
	if self.tongBaseInfo == nil then
		self:_setTongBaseInfo()
	end

	self.tongBaseInfo.useCount = checknumber(num1)
	self.tongBaseInfo.buyCount = checknumber(num2)
end

function TongBattleModel:scSendTongBuyTimes(data)
	self:_setChallCountInfo(self.tongBaseInfo.useCount, data.todayChallengeBuyTimes)
	GlobalDispatcher:dispatch(GlobalNotify.UpdateTongBuyCount)
end

function TongBattleModel:scSendTongBossInfo(msg, isComm)
	if self.tongBaseInfo == nil then
		self:_setTongBaseInfo()
	end

	if isComm then
		self.tongBattleInfo.demonRounds[1] = checknumber(msg.fireTurn)
		self.tongBattleInfo.demonRounds[2] = checknumber(msg.darkTurn)
	else
		self.tongBattleInfo.demonRounds[3] = checknumber(msg.fireTurn)
		self.tongBattleInfo.demonRounds[4] = checknumber(msg.darkTurn)
	end

	GlobalDispatcher:dispatch(GlobalNotify.UpdateTongBossInfo)
end

function TongBattleModel:scSendTongRankInfoSuc(msg, isComm)
	if isComm then
		self._commRankList = self._commRankList or {}
		self._commRankList.infoList = msg.infoList
		self._commRankList.myRank = msg.myRank
		self._commRankList.rankSize = msg.rankSize
	else
		self._hellRankList = self._hellRankList or {}
		self._hellRankList.infoList = msg.infoList
		self._hellRankList.myRank = msg.myRank
		self._hellRankList.rankSize = msg.rankSize
	end

	GlobalDispatcher:dispatch(GlobalNotify.UpdateTongRankInfo, isComm, true)
end

function TongBattleModel:scSendTongNotifyBattleEnd(msg)
	self._cacheEndInfo = nil

	if msg == nil or msg.challengeId ~= self.challengeId or not msg.isWin then
		return
	end

	self._cacheEndInfo = {
		oldTurns = checknumber(msg.oldTurns),
		newTurns = checknumber(msg.newTurns),
		passCount = checknumber(msg.passCount),
		chalId = checknumber(msg.stage),
		chalType = checknumber(msg.type),
		fireNum = checknumber(msg.fireNum)
	}

	if self.tongBaseInfo then
		self._cacheEndInfo.isGetTong = self.tongBaseInfo.isGetTong or false
	end

	if msg.type == 3 then
		if self.tongBattleInfo == nil then
			self:_setTongBattleInfo()
		end

		if checknumber(msg.stage) == 1 then
			self._cacheEndInfo.oldTurns = self.tongBattleInfo.demonRounds[2]
		elseif checknumber(msg.stage) == 2 then
			self._cacheEndInfo.oldTurns = self.tongBattleInfo.demonRounds[1]
		end

		self._cacheEndInfo.newTurns = checknumber(msg.passTurns)
	elseif msg.type == 4 then
		if self.tongBattleInfo == nil then
			self:_setTongBattleInfo()
		end

		if checknumber(msg.stage) == 1 then
			self._cacheEndInfo.oldTurns = self.tongBattleInfo.demonRounds[4]
		elseif checknumber(msg.stage) == 2 then
			self._cacheEndInfo.oldTurns = self.tongBattleInfo.demonRounds[3]
		end

		self._cacheEndInfo.newTurns = checknumber(msg.passTurns)
	end
end

TongBattleModel.instance = TongBattleModel.New()

return TongBattleModel
