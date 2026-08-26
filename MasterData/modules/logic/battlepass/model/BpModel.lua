-- chunkname: @modules/logic/battlepass/model/BpModel.lua

module("modules.logic.battlepass.model.BpModel", package.seeall)

local BpModel = class("BpModel", BaseModel)

function BpModel:onInit()
	self.preStatus = nil
	self.animProcess = 0
	self.animData = nil
	self.isViewLoading = nil
	self.lockLevelUpShow = false
	self.cacheBonus = nil
	self.firstShowSp = nil
end

function BpModel:reInit()
	self._hasGetInfo = nil
	self.firstShow = nil
	self.firstShowSp = nil
	self.lockAlertBonus = nil

	self:onInit()
end

function BpModel:onGetInfo(msg)
	self._hasGetInfo = true
	self.id = msg.id
	self.score = msg.score
	self.payStatus = msg.payStatus
	self.startTime = msg.startTime
	self.endTime = msg.endTime
	self.weeklyScore = msg.weeklyScore
	self.firstShow = msg.firstShow
	self.firstShowSp = msg.spFirstShow
end

function BpModel:hasGetInfo()
	return self._hasGetInfo
end

function BpModel:isEnd()
	if not self._hasGetInfo or self.endTime == 0 then
		return true
	end

	return false
end

function BpModel:getBpEndTime()
	return self.endTime or 0
end

function BpModel:updateScore(score, weeklyScore)
	self.score = score
	self.weeklyScore = weeklyScore
end

function BpModel:updatePayStatus(payStatus)
	self.payStatus = payStatus
end

function BpModel:onBuyLevel(score)
	self.score = score
end

function BpModel:buildChargeFlow()
	self._chargeFlow = self._chargeFlow or BpChargeFlow.New()

	self._chargeFlow:registerDoneListener(self.clearFlow, self)
	self._chargeFlow:buildFlow()
end

function BpModel:isInFlow()
	return not not self._chargeFlow
end

function BpModel:clearFlow()
	if self._chargeFlow then
		self._chargeFlow:onDestroyInternal()

		self._chargeFlow = nil
	end
end

function BpModel:isWeeklyScoreFull()
	if not self.weeklyScore then
		local weeklyMaxScore = self:getWeeklyMaxScore()

		return weeklyMaxScore <= self.weeklyScore
	end
end

function BpModel:getBpChargeLeftSec()
	local bpCO = lua_bp.configDict[BpModel.instance.id]

	if not bpCO then
		return
	end

	local shopCO = StoreConfig.instance:getChargeGoodsConfig(bpCO.chargeId1)

	if not shopCO then
		return
	end

	if type(shopCO.offlineTime) == "number" then
		return shopCO.offlineTime / 1000 - ServerTime.now()
	end
end

function BpModel:isBpChargeEnd()
	local leftTime = self:getBpChargeLeftSec()

	if leftTime and leftTime < 0 then
		return true
	else
		return false
	end
end

function BpModel:checkLevelUp(score, preScore)
	local levelScore = BpConfig.instance:getLevelScore(self.id)

	return math.floor(score / levelScore) > math.floor((preScore or self.score) / levelScore)
end

function BpModel:getBpLv(score)
	score = score or self.score or 0

	local levelScore = BpConfig.instance:getLevelScore(self.id)

	return math.floor(score / levelScore)
end

function BpModel:getBpCO()
	return BpConfig.instance:getBpCO(self.id or 0)
end

function BpModel:isShowExpUp()
	local bpCo = BpConfig.instance:getBpCO(self.id or 0)

	if not bpCo then
		return false
	end

	return (bpCo or nil) and (bpCo.expUpShow or false)
end

function BpModel:getWeeklyMaxScore()
	local weeklyMaxScore = CommonConfig.instance:getConstNum(ConstEnum.BpWeeklyMaxScore)
	local bpCo = BpConfig.instance:getBpCO(self.id or 0)

	if not bpCo then
		return weeklyMaxScore
	end

	local rate1000 = 1000 + (bpCo.weekLimitTimes or 0)

	if rate1000 > 1000 then
		weeklyMaxScore = math.floor(rate1000 * weeklyMaxScore / 1000)
	end

	return weeklyMaxScore
end

function BpModel:checkShowPayBonusTip(bonusInfoList)
	if self:isEnd() or self.payStatus ~= BpEnum.PayStatus.NotPay then
		return false
	end

	local showLvs = string.splitToNumber(CommonConfig.instance:getConstStr(ConstEnum.BpShowBonusLvs), "#")

	if not showLvs or not showLvs[1] then
		return false
	end

	local bpLv = self:getBpLv()

	if bpLv < showLvs[1] then
		return false
	end

	if not self.id then
		local bpId = 0
		local bpCo = BpConfig.instance:getBpCO(bpId)
		local markLvStrs = GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.BpShowPayBonusTip .. bpId, "")
		local isShowTips = false
		local allMarks = string.splitToNumber(markLvStrs, "#") or {}
		local leftSec = TimeUtil.stringToTimestamp(bpCo.showBonusDate) + ServerTime.clientToServerOffset()

		leftSec = ServerTime.now() - leftSec

		local canShowByDate = leftSec >= 0

		if canShowByDate and not tabletool.indexOf(allMarks, -1) then
			table.insert(allMarks, -1)

			isShowTips = true
		end

		for _, lv in ipairs(showLvs) do
			if lv <= bpLv and not tabletool.indexOf(allMarks, lv) then
				table.insert(allMarks, lv)

				isShowTips = true
			end
		end

		if isShowTips then
			GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.BpShowPayBonusTip .. bpId, table.concat(allMarks, "#"))
		end

		return isShowTips
	end
end

function BpModel:isMaxLevel()
	local levelScore = BpConfig.instance:getLevelScore(self.id)
	local curLevel = math.floor(self.score / levelScore)
	local maxLevel = #BpConfig.instance:getBonusCOList(self.id)

	return maxLevel <= curLevel
end

function BpModel:haveSpecialBonus()
	local bpCo = BpConfig.instance:getBpCO(self.id)

	if bpCo.specialBonus > 0 then
		return true
	end
end

function BpModel:getSpecialDes()
	local bpCo = BpConfig.instance:getBpCO(self.id)

	return lua_bp_des.configDict[bpCo.specialBonus]
end

function BpModel:getSpecialBonus()
	local bpCo = BpConfig.instance:getBpCO(self.id)

	if bpCo.specialBonus > 0 then
		local cfg = lua_bp_des.configDict[bpCo.specialBonus]
		local str = cfg.items

		if not string.nilorempty(str) then
			return (GameUtil.splitString2(str, true))
		end
	end
end

function BpModel:isSpecialBonus(itemId)
	local itemList = self:getSpecialBonus()

	if itemList then
		for i, infos in ipairs(itemList) do
			local id = infos[2]

			if id == itemId then
				return true
			end
		end
	end

	return false
end

function BpModel:checkOpenBpUpdatePopup()
	local cfg = self:getUpdatePopupValidCfg()

	if cfg then
		local serverTime = ServerTime.now()
		local key = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.BpUpdatePopup)

		PlayerPrefsHelper.setNumber(key, serverTime)

		return cfg
	end
end

function BpModel:getUpdatePopupValidCfg()
	local cfgs = lua_bp_update_popup.configList

	for i, cfg in ipairs(cfgs) do
		local startTime = cfg.startTime
		local endTime = cfg.endTime
		local startSeverTimeS = TimeUtil.stringToTimestamp(startTime)
		local endSeverTimeS = TimeUtil.stringToTimestamp(endTime)
		local serverTime = ServerTime.now()

		if startSeverTimeS <= serverTime and serverTime <= endSeverTimeS then
			local key = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.BpUpdatePopup)
			local lastTimeS = PlayerPrefsHelper.getNumber(key, nil)

			if lastTimeS and startSeverTimeS <= lastTimeS and lastTimeS <= endSeverTimeS then
				return
			end

			return cfg
		end
	end
end

function BpModel:getCurBpUpdatePopupCfg()
	local cfgs = lua_bp_update_popup.configList

	for i, cfg in ipairs(cfgs) do
		local startTime = cfg.startTime
		local endTime = cfg.endTime
		local startSeverTimeS = TimeUtil.stringToTimestamp(startTime)
		local endSeverTimeS = TimeUtil.stringToTimestamp(endTime)
		local serverTime = ServerTime.now()

		if startSeverTimeS <= serverTime and serverTime <= endSeverTimeS then
			return cfg
		end
	end
end

function BpModel:getCurVersionOperActId()
	return ActivityConfig.instance:getConstAsNum(ActivityEnum.ConstId.BpOperAct, VersionActivity3_5Enum.ActivityId.BpOperAct)
end

BpModel.instance = BpModel.New()

return BpModel
