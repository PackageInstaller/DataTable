-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/model/FamilyModel.lua

module("logic.extensions.family.model.FamilyModel", package.seeall)

local FamilyModel = class("FamilyModel", BaseModel)

FamilyModel.GetUnlockedBossInfosRes = "FamilyModel.GetUnlockedBossInfosRes"
FamilyModel.OpenBossChallengeRes = "FamilyModel.OpenBossChallengeRes"
FamilyModel.ChallengeBossRes = "FamilyModel.ChallengeBossRes"
FamilyModel.SweepBossRes = "FamilyModel.SweepBossRes"
FamilyModel.BossClgEndRes = "FamilyModel.BossClgEndRes"

function FamilyModel:ctor()
	self._redpackData = nil
end

function FamilyModel:onInit()
	self:onReset()

	self._cachePower = checknumber(FamilyConfig.instance:getCommonValue("MAX_ZDL_DEFAULT"))
	self._maxPower = checknumber(FamilyConfig.instance:getCommonValue("MAX_ZDL_MAX"))
	self._minPower = checknumber(FamilyConfig.instance:getCommonValue("MAX_ZDL_MIN"))
	self._cacheLevel = checknumber(FamilyConfig.instance:getCommonValue("PLAYER_LEVEL_DEFAULT"))
	self._maxLevel = checknumber(FamilyConfig.instance:getCommonValue("PLAYER_LEVEL_MAX"))
	self._minLevel = checknumber(FamilyConfig.instance:getCommonValue("PLAYER_LEVEL_MIN"))
end

function FamilyModel:onReset()
	self._familyViews = {}
	self._familyViewList = {}
	self._appliedIds = {}
	self._myFamilyInfo = nil
	self._members = nil
	self._logs = nil
	self._donateInfo = nil
	self._applyList = nil
	self._unlockedBossInfos = {}
	self._totemList = {}
	self._redpackData = nil
	self._managePanelInfo = nil
	self._searchInfo = nil
	self._familyActivityPanelInfoResMsg = nil
end

function FamilyModel:clearFamilyViews()
	self._familyViews = {}
	self._familyViewList = {}
	self._appliedIds = {}
end

function FamilyModel:insertFamilyViews(views, needSort)
	if needSort then
		table.sort(views, function(a, b)
			if a.hasApplied ~= b.hasApplied then
				return a.hasApplied
			end
		end)
	end

	for _, v in ipairs(views) do
		if not self._familyViews[v.familyId] then
			table.insert(self._familyViewList, v)

			self._familyViews[v.familyId] = v

			if v.hasApplied then
				self._appliedIds[v.familyId] = true
			end
		end
	end
end

function FamilyModel:setFamilyViewApplied(familyId, isApplied)
	self._appliedIds[familyId] = isApplied
end

function FamilyModel:getFamilyViewApplied(familyId)
	return self._appliedIds[familyId] == true
end

function FamilyModel:getFamilyList()
	return self._familyViewList
end

function FamilyModel:getFamilyView()
	return
end

function FamilyModel:getFamilyId()
	return (self._myFamilyInfo or nil) and (self._myFamilyInfo.familyId or 0)
end

function FamilyModel:getMyFamilyInfo()
	return self._myFamilyInfo
end

function FamilyModel:setMyFamilyInfo(info)
	self._myFamilyInfo = info
end

function FamilyModel:getMyFamilySettingInfo()
	if self._myFamilyInfo then
		return self._myFamilyInfo.settings
	end

	return nil
end

function FamilyModel:setSettingInfo(info)
	local settings = self:getMyFamilySettingInfo()

	if settings then
		settings.iconId = info.iconId
		settings.settingsCdEndMillis = info.settingsCdEndMillis
		settings.familyName = info.familyName
		settings.purpose = info.purpose
		settings.needApproval = info.needApproval
		settings.maxZdlLimit = info.maxZdlLimit
		settings.playerLevelLimit = info.playerLevelLimit
	end
end

function FamilyModel:getFamilyName()
	local settings = self:getMyFamilySettingInfo()

	return (settings or nil) and (settings.familyName or "无")
end

function FamilyModel:getCachePower()
	self._cachePower = checknumber(self._cachePower)
	self._cachePower = math.max(self._minPower, self._cachePower)
	self._cachePower = math.min(self._maxPower, self._cachePower)

	return self._cachePower
end

function FamilyModel:setCachePower(value)
	self._cachePower = value
end

function FamilyModel:getCacheLevel()
	self._cacheLevel = checknumber(self._cacheLevel)
	self._cacheLevel = math.max(self._minLevel, self._cacheLevel)
	self._cacheLevel = math.min(self._maxLevel, self._cacheLevel)

	return self._cacheLevel
end

function FamilyModel:setCacheLevel(value)
	self._cacheLevel = value
end

function FamilyModel:setDeclaration(value)
	if self._myFamilyInfo then
		self._myFamilyInfo.declaration = value
	end
end

function FamilyModel:getDeclaration()
	if self._myFamilyInfo then
		return self._myFamilyInfo.declaration
	end

	return ""
end

function FamilyModel:getDailyKickCount()
	if self._myFamilyInfo then
		return self._myFamilyInfo.dailyKickCount
	end

	return 0
end

function FamilyModel:setDailyKickCount(value)
	if self._myFamilyInfo then
		self._myFamilyInfo.dailyKickCount = checknumber(value)
	end
end

function FamilyModel:getDailyJoinCount()
	if self._myFamilyInfo then
		return self._myFamilyInfo.dailyJoinCount
	end

	return 0
end

function FamilyModel:setDailyJoinCount(value)
	if self._myFamilyInfo then
		self._myFamilyInfo.dailyJoinCount = checknumber(value)
	end
end

function FamilyModel:setFamilyLogs(logs)
	self._logs = logs or {}
end

function FamilyModel:getFamilyLogs()
	if not self._logs then
		table.sort(self._logs, function(a, b)
			return checknumber(a.eventTime) > checknumber(b.eventTime)
		end)

		return self._logs
	end
end

function FamilyModel:getLastLog()
	local t = self:getFamilyLogs()

	if #t > 0 then
		return t[1]
	elseif self._myFamilyInfo then
		return self._myFamilyInfo.latestLog
	end

	return nil
end

function FamilyModel:setMembers(value)
	self._members = value
end

function FamilyModel:getMembers()
	return self._members or {}
end

function FamilyModel:removeMember(userIds)
	if userIds == nil or #userIds == 0 then
		return
	end

	local tempList = GameUtil.pbToTable(self._members) or {}

	self._members = {}

	for _, v in ipairs(tempList) do
		if v and v.simpleInfo and not table.indexof(userIds, v.simpleInfo.userId) then
			table.insert(self._members, v)
		end
	end
end

function FamilyModel:setMemberRole(memberId, newRole)
	for k, v in ipairs(self._members) do
		if v.simpleInfo.userId == memberId then
			v.role = newRole
			v.lastChangeRoleTime = ServerTime.now() * 1000
		end
	end

	if checknumber(memberId) == checknumber(LoginModel.instance.userId) and self._myFamilyInfo then
		self._myFamilyInfo.myRole = newRole
	end
end

function FamilyModel:setDonateInfo(infos)
	self._donateInfo = self._donateInfo or {}
	self._donateInfo.infos = infos or {}
end

function FamilyModel:addDonateRecord(addRecords)
	if addRecords == nil or #addRecords == 0 then
		return
	end

	self._donateInfo = self._donateInfo or {}
	self._donateInfo.records = self._donateInfo.records or {}

	for _, info in pairs(addRecords) do
		if info and checknumber(info.userId) > 0 then
			table.insert(self._donateInfo.records, info)
		end
	end

	if #self._donateInfo.records > 1 then
		table.sort(self._donateInfo.records, function(a, b)
			return a.donateTimeMillis > b.donateTimeMillis
		end)
	end

	local value = FamilyConfig.instance:getCommonValue("DONATE_RECORD_LIMIT", true)

	if value < #self._donateInfo.records then
		table.remove(self._donateInfo.records, value + 1)
	end
end

function FamilyModel:getDonateInfo()
	return self._donateInfo
end

function FamilyModel:setFamilyScore(value)
	if self._myFamilyInfo then
		self._myFamilyInfo.score = value
	end
end

function FamilyModel:isInFamily()
	return FamilyController.instance:getFamilyLv() > 0
end

function FamilyModel:getFamilyLv()
	local score = self:getFamilyScore()

	return FamilyConfig.instance:getFamliyLvByScore(score)
end

function FamilyModel:getFamilyScore()
	if self._myFamilyInfo then
		return self._myFamilyInfo.score
	else
		return 0
	end
end

function FamilyModel:getMyRole()
	if self._myFamilyInfo then
		return self._myFamilyInfo.myRole
	else
		return -1
	end
end

function FamilyModel:isFamilyChief()
	local index = self:getMyRole()

	return index == GameEnum.FamilyMemberType.ChiefMain or index == GameEnum.FamilyMemberType.ChiefVice
end

function FamilyModel:getRoleCount(role)
	local count = 0

	if not self._members then
		for _, v in ipairs(self._members) do
			if v.role == role then
				count = count + 1
			end
		end

		return count
	end
end

function FamilyModel:setApplyList(value)
	self._applyList = value
end

function FamilyModel:getApplyList()
	return self._applyList or {}
end

function FamilyModel:removeApply(userId)
	for k, v in ipairs(self._applyList) do
		if v.simpleInfo.userId == userId then
			table.remove(self._applyList, k)

			break
		end
	end
end

function FamilyModel:getApplyCdEndTime()
	return checknumber(self._applyCdEndMillis) / 1000
end

function FamilyModel:setApplyCdEndTime(value)
	self._applyCdEndMillis = value
end

function FamilyModel:getDonateTimes()
	if self._donateInfo then
		return self._donateInfo.infos.donateTimes
	elseif self._myFamilyInfo then
		return self._myFamilyInfo.donateTimes
	else
		return 0
	end
end

function FamilyModel:getPoolLv()
	if self._donateInfo then
		return self._donateInfo.infos.poolFamilyLevel
	elseif self._myFamilyInfo then
		return self._myFamilyInfo.poolFamilyLevel
	else
		return 0
	end
end

function FamilyModel:openBossChallengeSuccessed(msg)
	local data = self:getUnlockedBossInfo(msg.bossId)

	if data then
		data.endTimeMillis = msg.endTimeMillis
		data.clgTimes = 0
	end
end

function FamilyModel:sweepBossSuccessed(msg)
	local data = self:getUnlockedBossInfo(msg.bossId)

	if data then
		data.clgTimes = msg.clgTimes
	end
end

function FamilyModel:bossClgEnd(msg)
	self.bossClgEndData = msg
end

function FamilyModel:getBossLivenessPro(bossId)
	local data = self:getUnlockedBossInfo(bossId)
	local cfg = FamilyConfig.instance:getFamilyBossCfg(bossId)

	if data then
		if not data.scoreCount then
			local curr = 0
			local needLiveness = cfg.openConsume
			local color = curr < needLiveness and "red" or "#4eae1a"

			return (cfg.openConsume or nil) and ("<color=" .. color .. ">" .. curr .. "</color>/" .. needLiveness or "")
		end
	end
end

function FamilyModel:getBossLivenessRatio(bossId)
	local data = self:getUnlockedBossInfo(bossId)
	local cfg = FamilyConfig.instance:getFamilyBossCfg(bossId)

	if data then
		if not data.scoreCount then
			local curr = 0
			local needLiveness = cfg.openConsume

			return needLiveness <= 0 and 0.001 or curr / needLiveness
		end
	end
end

function FamilyModel:isChallengeOpen(bossId)
	local data = self:getUnlockedBossInfo(bossId)

	return (data or nil) and checknumber(data.endTimeMillis) ~= -1
end

function FamilyModel:hasChallenge(bossId)
	local data = self:getUnlockedBossInfo(bossId)

	return (data or nil) and checknumber(data.lastDamage) > 0
end

function FamilyModel:canOpenChallenge(bossId)
	local canOpen = false
	local isManager = self:isOpenBossChallengeManager()
	local data = self:getUnlockedBossInfo(bossId)

	if data and isManager then
		local needLiveness = FamilyConfig.instance:getFamilyBossNeedLiveness(bossId)

		canOpen = not self:isBossLock(bossId) and needLiveness <= checknumber(data.scoreCount)
	end

	return canOpen
end

function FamilyModel:getBossChallegenLeftTime(bossId)
	local maxTime = VipModel.instance:getFreeChallengeTimesOfFamilyBoss()
	local data = self:getUnlockedBossInfo(bossId)

	return math.max(0, (data or nil) and maxTime - data.clgTimes)
end

function FamilyModel:getBossChallegenLeftTimeStr(bossId)
	local maxTime = VipModel.instance:getFreeChallengeTimesOfFamilyBoss()
	local leftTime = self:getBossChallegenLeftTime(bossId)
	local color = leftTime <= 0 and "red" or "#60ee85"

	return "剩余次数:<color=" .. color .. ">" .. leftTime .. "</color>/" .. maxTime
end

function FamilyModel:isOpenBossChallengeManager()
	local index = self:getMyRole()

	return index == 1 or index == 0
end

function FamilyModel:getBossOpenDesc(bossId)
	local cfg = FamilyConfig.instance:getFamilyBossCfg(bossId)

	return (langPara("tip_family_BOSS_begin", checknumber(cfg.openConsume), checknumber(cfg.contTime), cfg.challengeCount))
end

function FamilyModel:isBossLock(bossId)
	local cfg = FamilyConfig.instance:getFamilyBossCfg(bossId)
	local lv = self:getFamilyLv()

	return lv < cfg.familyLevel, cfg.familyLevel
end

function FamilyModel:getOriginalCurFormation()
	return FormationNewModel.instance:GetCurTeam():GetCurFormation()
end

function FamilyModel:_getCurFormation()
	return PetHireModel.instance:getFormationMoByFormId(PetHireModel.ID_TYPE_NORMAL)
end

function FamilyModel:getAllShowPetList()
	local pets = BagPetsController.instance:getFightBagPet() or {}

	pets = PetHireModel.instance:appendListByHirePets(pets)

	return pets
end

function FamilyModel:getAllFamilyBossCfgs()
	local allCfgs = FamilyConfig.instance:getAllFamilyBossCfg()
	local tempList = {}

	for _, cfg in pairs(allCfgs or {}) do
		if self:isFamilyBossOpenShow(cfg) then
			table.insert(tempList, cfg)
		end
	end

	if #tempList ~= 2 then
		printError("家族Boss同时显示的个数不对，清查看配置表！！")
	end

	if #tempList > 1 then
		table.sort(tempList, function(a, b)
			return a.id < b.id
		end)
	end

	return tempList
end

function FamilyModel:isFamilyBossOpenShow(cfg, isTips)
	if cfg == nil or checknumber(cfg.id) <= 0 then
		return false
	end

	if string.nilorempty(cfg.onlineTime) and string.nilorempty(cfg.offlineTime) then
		return true
	end

	local value = GameUtil.getTimePeriodType(cfg.onlineTime, cfg.offlineTime)

	if value == GameUtil.inTimePeriod then
		return true
	end

	if value == GameUtil.beforeTimePeriod then
		if isTips then
			FloatWordMgr.instance:show("Boss还未开启")
		end

		return false
	end

	if value == GameUtil.afterTimePeriod then
		if isTips then
			FloatWordMgr.instance:show("Boss已结束")
		end

		return false
	end

	return false
end

function FamilyModel:setUnlockedBossInfos(infos)
	self._unlockedBossInfos = {}

	for _, v in ipairs(infos) do
		if v and checknumber(v.bossId) > 0 then
			self._unlockedBossInfos[v.bossId] = v
		end
	end
end

function FamilyModel:getUnlockedBossInfos()
	return self._unlockedBossInfos
end

function FamilyModel:getUnlockedBossInfo(bossId)
	return self._unlockedBossInfos[bossId]
end

function FamilyModel:isBossCanBattle(bossId)
	local dot = false
	local open = self:isChallengeOpen(bossId)

	if open then
		local leftTime = self:getBossChallegenLeftTime(bossId)

		dot = leftTime > 0
	elseif self:isOpenBossChallengeManager() and self:canOpenChallenge(bossId) then
		dot = true
	end

	return dot
end

function FamilyModel:getFaimlyRedpackData()
	if self._redpackData == nil then
		self._redpackData = {
			redList = {},
			taskList = {},
			redTimes = {}
		}
	end

	return self._redpackData
end

function FamilyModel:getInfoByRedpackId(rpId)
	if self._redpackData == nil or self._redpackData.redList == nil then
		return nil
	end

	rpId = checknumber(rpId)

	for _, info in pairs(self._redpackData.redList) do
		if info and checknumber(info.packetId) == rpId then
			return info
		end
	end

	return nil
end

function FamilyModel:getCurrentRedpackCount()
	local allCfgs = FamilyConfig.instance:getAllRedpackTypeCfgs()
	local str = ""

	if not self._redpackData.redTimes then
		for i = 1, #allCfgs do
			if string.nilorempty(str) then
				str = "今日领取："
			end

			str = str .. allCfgs[i].name .. " " .. checknumber(self._redpackData.redTimes[allCfgs[i].packetType]) .. "/" .. allCfgs[i].dailyLimit

			if i < #allCfgs then
				str = str .. "，"
			end
		end

		return str
	end
end

function FamilyModel:getRedpackAndTaskname(taskId)
	if checknumber(taskId) <= 0 then
		return "家族红包", "红包"
	end

	local taskCfg = FamilyConfig.instance:getRedpackTaskCfgsById(taskId)

	if taskCfg == nil then
		return "家族红包", "红包"
	end

	local typeCfg = FamilyConfig.instance:getRedpackTypeCfg(taskCfg.packetType)

	if typeCfg == nil then
		return taskCfg.taskTitle, "红包"
	end

	return taskCfg.taskTitle, typeCfg.name
end

function FamilyModel:getOpenRedpackTaskCfgs()
	local allCfgs = FamilyConfig.instance:getRedpackTaskCfgs()
	local tempList = {}
	local count = 0
	local nowTime = ServerTime.now()
	local info, expiredTime

	for _, cfg in pairs(allCfgs or {}) do
		if cfg and checknumber(cfg.taskId) > 0 and GameUtil.checkIsInTimePeriod(cfg.startTime, cfg.endTime) then
			info = self._redpackData.taskList[cfg.taskId] or {}
			expiredTime = checknumber(info.expiredTime) / 1000

			if expiredTime == 0 or nowTime < expiredTime then
				local stage = 2

				if checknumber(info.curProgress) >= cfg.maxProgress then
					if info.gainedPrize then
						stage = 3
					else
						count = count + 1
						stage = 1
					end
				end

				table.insert(tempList, {
					cfg = cfg,
					info = info,
					stage = stage
				})
			end
		end
	end

	if #tempList > 1 then
		table.sort(tempList, function(a, b)
			if a.stage == b.stage then
				return a.cfg.taskId < b.cfg.taskId
			end

			return a.stage < b.stage
		end)
	end

	return tempList, count
end

function FamilyModel:csSendFamilyRedPacketGetTaskInfo(taskInfos)
	self._redpackData = self._redpackData or {}
	self._redpackData.taskList = {}

	for _, info in pairs(taskInfos or {}) do
		if info and checknumber(info.taskId) > 0 then
			self._redpackData.taskList[info.taskId] = info
		end
	end
end

function FamilyModel:csSendFamilyRedPacketSendRedPacket(taskId)
	taskId = checknumber(taskId)

	if taskId <= 0 or self._redpackData == nil then
		return
	end

	if self._redpackData.taskList == nil or self._redpackData.taskList[taskId] == nil then
		return
	end

	self._redpackData.taskList[taskId].gainedPrize = true
end

function FamilyModel:csSendFamilyRedPacketGetList(msg)
	self._redpackData = self._redpackData or {}
	self._redpackData.redList = GameUtil.pbToTable(msg.redPacketList) or {}
	self._redpackData.redTimes = {}

	for _, info in pairs(msg.times) do
		if info and checknumber(info.packeType) > 0 then
			self._redpackData.redTimes[info.packeType] = checknumber(info.time)
		end
	end
end

function FamilyModel:csSendFamilyRedPacketGain(rpInfo)
	if self._redpackData.redList == nil or #self._redpackData.redList == 0 or rpInfo == nil then
		return
	end

	if self._redpackData.redTimes then
		self._redpackData.redTimes[rpInfo.packetType] = checknumber(self._redpackData.redTimes[rpInfo.packetType]) + 1
	end

	for i = 1, #self._redpackData.redList do
		if self._redpackData.redList[i] and self._redpackData.redList[i].packetId == rpInfo.packetId then
			self._redpackData.redList[i] = GameUtil.pbToTable(rpInfo)

			return
		end
	end
end

function FamilyModel:setManagePanelInfo(msg)
	self._managePanelInfo = msg
end

function FamilyModel:getManagePanelInfo()
	return self._managePanelInfo
end

function FamilyModel:getMoney()
	if self._myFamilyInfo then
		return checknumber(self._myFamilyInfo.money)
	end

	return 0
end

function FamilyModel:onSendAllMainRes(msg)
	if self._managePanelInfo then
		self._managePanelInfo.allMemberMailCdMillis = msg.allMemberMailCdMillis
		self._managePanelInfo.allMemberMailTimes = msg.allMemberMailTimes
	end

	local costMoney = FamilyConfig.instance:getCommonValue("SEND_ALL_MEMBER_MAIL_COST", true)

	self:costMoney(costMoney)
end

function FamilyModel:onSendEnlistMsgRes(msg)
	if self._managePanelInfo then
		local cd = FamilyConfig.instance:getCommonValue("SEND_ENLIST_CD_SEC", true) * 1000

		self._managePanelInfo.sendEnlistCdEndMillis = ServerTime.nowMs() + cd
	end

	local costMoney = FamilyConfig.instance:getCommonValue("SEND_ENLIST_MSG_COST", true)

	self:costMoney(costMoney)
end

function FamilyModel:getPartySchedule()
	return self._managePanelInfo.weeklyOpenPartySchedule
end

function FamilyModel:setSearchFamilyInfo(msg)
	self._searchInfo = msg
end

function FamilyModel:getSearchFamilyInfo()
	return self._searchInfo
end

function FamilyModel:handleGetFamilyActivityPanelInfoRes(msg)
	self._familyActivityPanelInfoResMsg = msg
end

function FamilyModel:getFamilyActivityPanelInfoResMsg()
	return self._familyActivityPanelInfoResMsg
end

function FamilyModel:onScheduleOpenPartyRes(schedule)
	if self._managePanelInfo and self._managePanelInfo.weeklyOpenPartySchedule then
		local pb = require("pb")

		for i = #self._managePanelInfo.weeklyOpenPartySchedule.dayOfWeeks, 1, -1 do
			self._managePanelInfo.weeklyOpenPartySchedule.dayOfWeeks:remove(i)
		end

		for i, v in ipairs(schedule.dayOfWeeks) do
			self._managePanelInfo.weeklyOpenPartySchedule.dayOfWeeks:append(v)
		end

		if #schedule.dayOfWeeks <= 0 then
			self._managePanelInfo.weeklyOpenPartySchedule.hour = 0
			self._managePanelInfo.weeklyOpenPartySchedule.minute = 0
		else
			self._managePanelInfo.weeklyOpenPartySchedule.hour = schedule.hour
			self._managePanelInfo.weeklyOpenPartySchedule.minute = schedule.minute
		end
	end
end

function FamilyModel:getAllTotemList()
	return self._totemList
end

function FamilyModel:onGetFamilyTotemInfoReq(msg)
	self._totemList = GameUtil.pbToTable(msg.totemList)
end

function FamilyModel:onUpdateFamilyTotemInfoReq(msg, costMoney)
	self._totemList = GameUtil.pbToTable(msg.totemList)

	self:costMoney(costMoney)
end

function FamilyModel:costMoney(costMoney)
	if self._myFamilyInfo then
		self._myFamilyInfo.money = checknumber(self._myFamilyInfo.money) - costMoney

		GlobalDispatcher:dispatch(GlobalNotify.OnMaterialCountChange)
	end
end

FamilyModel.instance = FamilyModel.New()

return FamilyModel
