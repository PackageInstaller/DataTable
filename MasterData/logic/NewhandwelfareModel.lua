-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newhandwelfare/model/NewhandwelfareModel.lua

module("logic.extensions.newhandwelfare.view.NewhandwelfareModel", package.seeall)

local NewhandwelfareModel = class("NewhandwelfareModel", BaseModel)

NewhandwelfareModel.priviligeWholeLifeDot = "NewhandwelfareModel.priviligeWholeLifeDot"

function NewhandwelfareModel:ctor()
	return
end

function NewhandwelfareModel:onInit()
	self:onReset()
end

function NewhandwelfareModel:onReset()
	self._endTime = -1
	self._dailyOnlineSec = 0
	self._loginDay = 0
	self._recordOnlineAddTimeStamp = -1
	self._signInPrizeGainState = {}
	self._onlinePrizeGainState = {}
	self._zdlNormalPrizeGainState = {}
	self._zdlSuperPrizeGainState = {}
	self._activeZdlSuperPrize = false
	self._periodId = -1
	self._newHandActiveDays = 0
	self._teamZdls = {}
	self._gainPrizeIdsInTeam = {}
	self._formationCustomFmtMo = nil
end

function NewhandwelfareModel:handleNewHandWelfareGetBoundInfoRes(msg)
	table.clear(self._teamZdls)

	for _, v in ipairs(msg.teamInfos) do
		self._teamZdls[v.teamId] = v.maxZdl
	end

	for _, prizeId in ipairs(msg.gainPrizeIds) do
		self._gainPrizeIdsInTeam[prizeId] = true
	end
end

function NewhandwelfareModel:handleNewHandWelfareSubmitFormZdlRes(msg)
	self._teamZdls[msg.teamId] = self._teamZdls[msg.teamId] or Mathf.Max(self._teamZdls[msg.teamId], msg.zdl)
end

function NewhandwelfareModel:handleNewHandWelfareGainBoundPrizeRes(msg)
	self._gainPrizeIdsInTeam[msg.prizeId] = true
end

function NewhandwelfareModel:isNewHandPlayer()
	local lvOk = MofangModel.instance:getCurLv() >= NewhandwelfareConfig.instance:getCommonValue("UNDER_LEVEL", true)

	if lvOk then
		local time1_Ok = NewhandwelfareConfig.instance:getNewHandActiveTime() < RoleModel.instance:getActiveTimeSec()

		if time1_Ok then
			return ServerTime.now() < self:getNewHandPlayerEndTime() and self._periodId > 0
		end
	end

	return false
end

function NewhandwelfareModel:isInNewPrivilegeTime()
	if self._periodId > 0 then
		local lvOk = MofangModel.instance:getCurLv() >= NewhandwelfareConfig.instance:getCommonValue("UNDER_LEVEL", true)
		local startTime, endTime = self:getPrivilegeTimeActStartEndTime()

		if lvOk then
			local startTime, endTime = self:getPrivilegeTimeActStartEndTime()

			return GameUtil.getTimePeriodTypeBySec(startTime, endTime) == GameUtil.inTimePeriod
		end
	end

	return false
end

function NewhandwelfareModel:isNewHandActivePlayer()
	return NewhandwelfareConfig.instance:getNewHandActiveTime() < RoleModel.instance:getActiveTimeSec()
end

function NewhandwelfareModel:getNewHandPlayerStartEndTime()
	local startTime = RoleModel.instance:getActiveTimeSec()
	local endTime = self:getNewHandPlayerEndTime()

	return startTime, endTime
end

function NewhandwelfareModel:getPrivilegeTimeActStartEndTime()
	local startTime = RoleModel.instance:getActiveTimeSec()
	local endTime = self:getPrivilegeTimeActEndTime()

	return startTime, endTime
end

function NewhandwelfareModel:getNewHandPlayerEndTime()
	return math.floor(self._endTime / 1000)
end

function NewhandwelfareModel:getOnlineTime()
	return self._dailyOnlineSec + ((self._recordOnlineAddTimeStamp > 0 or nil) and ServerTime.now() - self._recordOnlineAddTimeStamp)
end

function NewhandwelfareModel:setInfo(msg)
	self._dailyOnlineSec = msg.dailyOnlineSec
	self._loginDay = msg.loginDay
	self._signInPrizeGainState = GameUtil.pbToTable(msg.signInPrizeGainState)
	self._onlinePrizeGainState = GameUtil.pbToTable(msg.onlinePrizeGainState)
	self._zdlNormalPrizeGainState = GameUtil.pbToTable(msg.zdlNormalPrizeGainState)
	self._zdlSuperPrizeGainState = GameUtil.pbToTable(msg.zdlSuperPrizeGainState)
	self._recordOnlineAddTimeStamp = ServerTime.now()
	self._endTime = msg.endTime
	self._activeZdlSuperPrize = msg.activeZdlSuperPrize
	self._newHandActiveDays = msg.newHandActiveDays
	self._periodId = msg.periodId or -1
end

function NewhandwelfareModel:getPeriodId()
	return self._periodId
end

function NewhandwelfareModel:getNewHandActiveDays()
	return self._newHandActiveDays
end

function NewhandwelfareModel:oneKeyGainOnlinePrizeRes(prizeIds)
	for i, prizeId in ipairs(prizeIds) do
		self._onlinePrizeGainState[prizeId] = true
	end
end

function NewhandwelfareModel:gainOnlinePrizeRes(prizeId)
	self._onlinePrizeGainState[prizeId] = true
end

function NewhandwelfareModel:gainSignInPrizeRes(day)
	self._signInPrizeGainState[day] = true
end

function NewhandwelfareModel:gainZdlPrizeRes(prizeId, isNormal)
	if isNormal then
		self._zdlNormalPrizeGainState[prizeId] = true
	else
		self._zdlSuperPrizeGainState[prizeId] = true
	end
end

function NewhandwelfareModel:isGainOnlinePrize(prizeId)
	return self._onlinePrizeGainState[prizeId]
end

function NewhandwelfareModel:isGainZdlPrize(prizeId, isNormal)
	if isNormal then
		return self._zdlNormalPrizeGainState[prizeId]
	else
		return self._zdlSuperPrizeGainState[prizeId]
	end
end

function NewhandwelfareModel:isGainSignInPrize(day)
	return self._signInPrizeGainState[day]
end

function NewhandwelfareModel:checkCanGainOnlinePrize(periodId, day, prizeId)
	if not self._onlinePrizeGainState[prizeId] then
		local data = NewhandwelfareConfig.instance:getOnlineRewardData(periodId, day, prizeId)

		if data then
			local onlineTime = self:getOnlineTime()

			return onlineTime >= data.onlineTime * 60
		else
			return false
		end
	end

	return false
end

function NewhandwelfareModel:checkCanGainSingInPrize(periodId, day)
	if not self._signInPrizeGainState[day] then
		local cfg = NewhandwelfareConfig.instance:getSignInRewardCfg(periodId, day)

		return self._loginDay >= cfg.day
	end

	return false
end

function NewhandwelfareModel:checkCanGainZdlPrize(periodId, prizeId, isNormal)
	if not (isNormal and self._zdlNormalPrizeGainState[prizeId] or self._zdlSuperPrizeGainState[prizeId]) and (isNormal or self:isBuyZDLSuperPrize()) then
		local cfg = NewhandwelfareConfig.instance:getZdlRewardCfg(periodId, prizeId)

		if cfg then
			return RoleModel.instance:getMaxPower() >= cfg.needZdl
		else
			return false
		end
	end

	return false
end

function NewhandwelfareModel:isOnTrialGoldenDiamond()
	if not self:isOnTrialGoldenDiamondTime() then
		return false
	else
		return GoldenDiamondCardModel.instance.isUser
	end
end

function NewhandwelfareModel:isOnTrialGoldenDiamondTime()
	if self._periodId <= 0 then
		return false
	end

	local time1_Ok = self:isNewHandActivePlayer()

	if time1_Ok then
		local pcfg = NewhandwelfareConfig.instance:getPeriodCfg(self._periodId)

		if pcfg then
			if not pcfg.newHandGoldenDiamond then
				local onTrialDay = 0

				if onTrialDay >= self._newHandActiveDays then
					return true
				end
			end
		end
	end

	return false
end

function NewhandwelfareModel:checkZdlPrizeDot()
	if self._periodId <= 0 then
		return false
	end

	local cfgs = NewhandwelfareConfig.instance:getZdlRewardCfgs(self._periodId) or {}

	for i, v in ipairs(cfgs) do
		if self:checkCanGainZdlPrize(self._periodId, v.prizeId, true) or self:checkCanGainZdlPrize(self._periodId, v.prizeId, false) then
			return true
		end
	end
end

function NewhandwelfareModel:checkOnlinePrizeDot()
	if self._periodId <= 0 then
		return false
	end

	if ServerTime.now() >= self:getOnlineTimeActEndTime() then
		return false
	end

	local cfg = NewhandwelfareConfig.instance:getOnlineRewardCfg(self._periodId, self._newHandActiveDays)

	if cfg then
		for i, v in ipairs(cfg) do
			if self:checkCanGainOnlinePrize(self._periodId, v.prizeId) then
				return true
			end
		end
	end

	return false
end

function NewhandwelfareModel:checkSignInPrizeDot()
	if self._periodId <= 0 then
		return false
	end

	local cfgs = NewhandwelfareConfig.instance:getSignInRewardCfgs(self._periodId) or {}

	for i, v in ipairs(cfgs) do
		if self:checkCanGainSingInPrize(self._periodId, v.day) then
			return true
		end
	end
end

function NewhandwelfareModel:checkPriviligePrizeDot()
	return RedPointModel.instance:isActive(RedPointModel.ID_GOLDENDIAMONDCARD) or self:checkPriviligeWholeLifeDot()
end

function NewhandwelfareModel:checkRedDot()
	return self:checkZdlPrizeDot() or self:checkSignInPrizeDot() or self:checkOnlinePrizeDot() or self:checkPriviligePrizeDot() or self:checkPriviligeWholeLifeDot()
end

function NewhandwelfareModel:checkPriviligeWholeLifeDot()
	if not self:isOnTrialGoldenDiamond() then
		return string.nilorempty(GameUtil.getUserData(NewhandwelfareModel.priviligeWholeLifeDot))
	end
end

function NewhandwelfareModel:recordPriviligeWholeLifeDot()
	GameUtil.saveUserData(NewhandwelfareModel.priviligeWholeLifeDot, "isOk")
end

function NewhandwelfareModel:isBuyZDLSuperPrize()
	return self._activeZdlSuperPrize
end

function NewhandwelfareModel:oneKeyGainZdlPrizeRes(msg)
	for i, id in ipairs(msg.normalPrizeIds) do
		self:gainZdlPrizeRes(id, true)
	end

	for i, id in ipairs(msg.superPrizeIds) do
		self:gainZdlPrizeRes(id, false)
	end
end

function NewhandwelfareModel:welfarePaySucRes()
	self._activeZdlSuperPrize = true
end

function NewhandwelfareModel:getOnlineTimeActEndTime()
	return self:_getHandTimeActEndTime("newHandOnlinePrizeDays")
end

function NewhandwelfareModel:getHandTimeActEndTime()
	return self:_getHandTimeActEndTime("newHandDays")
end

function NewhandwelfareModel:getPrivilegeTimeActEndTime()
	return self:_getHandTimeActEndTime("newHandPrivilegeDays")
end

function NewhandwelfareModel:_getHandTimeActEndTime(field)
	local pcfg = NewhandwelfareConfig.instance:getPeriodCfg(self._periodId)

	if pcfg then
		if not pcfg[field] then
			local days = 0
			local statrTime = self:_getHandTimeActStartTime()

			return statrTime + 86400 * days
		end
	end
end

function NewhandwelfareModel:_getHandTimeActStartTime()
	local pcfg = NewhandwelfareConfig.instance:getPeriodCfg(self._periodId)

	if pcfg then
		if not pcfg.newHandDays then
			local day = 0
			local endTime = self:getNewHandPlayerEndTime()

			return Mathf.Max(endTime - 86400 * day, 0)
		end
	end
end

function NewhandwelfareModel:getCollectNumInTeam(bondTeamId)
	local num = 0
	local data = NewhandwelfareConfig.instance:getBondTeamData(bondTeamId)

	if data.bondRaceIds then
		for _, raceId in ipairs(data.bondRaceIds) do
			if self:isHaveCollectInTeam(raceId) then
				num = num + 1
			end
		end
	end

	return num
end

function NewhandwelfareModel:isHaveCollectInTeam(raceId)
	return HandbookModel.instance:isHasPet(raceId)
end

function NewhandwelfareModel:getTeamMaxZdl(teamId)
	return self._teamZdls[teamId] or 0
end

function NewhandwelfareModel:isHasGainPrizeInTeam(prizeId)
	return self._gainPrizeIdsInTeam[prizeId] == true
end

function NewhandwelfareModel:isEnoughPrizeInTeam(prizeId)
	local isEnough = false
	local data = NewhandwelfareConfig.instance:getBondPrizeData(self._periodId, prizeId)

	if data then
		if data.type == NewhandwelfareEnum.BondPrizeType_Collect then
			local num = self:getCollectNumInTeam(data.bondTeamId)

			isEnough = num >= data.paramVal
		elseif data.type == NewhandwelfareEnum.BondPrizeType_Verify then
			local zdl = self:getTeamMaxZdl(data.bondTeamId)

			isEnough = zdl >= data.paramVal
		end
	end

	return isEnough
end

function NewhandwelfareModel:getNewhandwelfareFmtCustomFmtMo()
	if self._formationCustomFmtMo == nil then
		self._formationCustomFmtMo = NewHandVerifyFormationCustomFmtMo.New()
	end

	return self._formationCustomFmtMo
end

NewhandwelfareModel.instance = NewhandwelfareModel.New()

return NewhandwelfareModel
