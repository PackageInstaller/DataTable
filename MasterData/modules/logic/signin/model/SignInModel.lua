-- chunkname: @modules/logic/signin/model/SignInModel.lua

module("modules.logic.signin.model.SignInModel", package.seeall)

local SignInModel = class("SignInModel", BaseModel)

function SignInModel:onInit()
	self:reInit()
end

function SignInModel:reInit()
	self._totalSignDays = 0
	self._targetdate = {
		2021,
		1,
		1
	}
	self._newShowDetail = true
	self._newSwitch = false
	self._isAutoSignGetReward = true
	self._showBirthday = false
	self._signInfo = {}
	self._historySignInfos = {}
	self._heroBirthdayInfos = {}
end

function SignInModel:setHeroBirthdayInfos(info)
	for _, v in ipairs(info) do
		if not self._heroBirthdayInfos[v.heroId] then
			local birthInfoMo = SignInHeroBirthdayInfoMo.New()

			birthInfoMo:init(v)

			self._heroBirthdayInfos[v.heroId] = birthInfoMo
		else
			self._heroBirthdayInfos[v.heroId]:reset(v)
		end
	end
end

function SignInModel:addSignInBirthdayCount(heroId)
	self._heroBirthdayInfos[heroId] = self._heroBirthdayInfos[heroId] or SignInHeroBirthdayInfoMo.New()

	self._heroBirthdayInfos[heroId]:addBirthdayCount()
end

function SignInModel:getHeroBirthdayCount(heroId)
	if self._heroBirthdayInfos[heroId] then
		return self._heroBirthdayInfos[heroId].birthdayCount
	end

	return 0
end

function SignInModel:setShowBirthday(show)
	self._showBirthday = show
end

function SignInModel:isShowBirthday()
	return self._showBirthday
end

function SignInModel:setHeroBirthdayGet(heroId)
	self._signInfo:addBirthdayHero(heroId)
end

function SignInModel:isHeroBirthdayGet(heroId)
	local specialBlockId = RoomConfig.instance:getHeroSpecialBlockId(heroId)

	if (specialBlockId or nil) and RoomModel.instance:isHasBlockById(specialBlockId) then
		return true
	end

	for _, v in pairs(self._signInfo.birthdayHeroIds) do
		if v == heroId then
			return true
		end
	end

	return false
end

function SignInModel:getCurDayBirthdayHeros()
	local curDate = self:getCurDate()
	local heros = {}
	local heroList = self:getDayAllBirthdayHeros(curDate.month, curDate.day)

	for _, v in pairs(heroList) do
		local heroCo = HeroConfig.instance:getHeroCO(v)

		if not string.nilorempty(heroCo.roleBirthday) and not heroCo.isSP then
			local birth = string.splitToNumber(heroCo.roleBirthday, "/")
			local bonusLength = #string.split(heroCo.birthdayBonus, ";")

			if birth[1] == curDate.month and birth[2] == curDate.day then
				local birthdayCount = self:getHeroBirthdayCount(v)

				if self:isHeroBirthdayGet(v) then
					if birthdayCount <= bonusLength then
						table.insert(heros, v)
					end
				elseif birthdayCount < bonusLength then
					table.insert(heros, v)
				end
			end
		end
	end

	table.sort(heros)

	return heros
end

function SignInModel:getNoSignBirthdayHeros(month, day)
	local heros = {}
	local heroList = self:getDayAllBirthdayHeros(month, day)

	for _, v in ipairs(heroList) do
		local heroCo = HeroConfig.instance:getHeroCO(v)

		if not string.nilorempty(heroCo.roleBirthday) and not heroCo.isSP then
			local birth = string.splitToNumber(heroCo.roleBirthday, "/")
			local bonusLength = #string.split(heroCo.birthdayBonus, ";")
			local birthdayCount = self:getHeroBirthdayCount(v)

			if birth[1] == month and birth[2] == day and birthdayCount < bonusLength then
				table.insert(heros, tonumber(heroCo.id))
			end
		end
	end

	table.sort(heros)

	return heros
end

function SignInModel:getDayAllBirthdayHeros(month, day)
	local heros = {}
	local heroList = lua_character.configDict

	for _, v in pairs(heroList) do
		if v.roleBirthday ~= "" and v.isOnline == "1" then
			local birth = string.splitToNumber(v.roleBirthday, "/")

			if birth[1] == month and birth[2] == day then
				table.insert(heros, tonumber(v.id))
			end
		end
	end

	table.sort(heros)

	return heros
end

function SignInModel:getSignBirthdayHeros(year, month, day)
	local heros = {}

	self._curDate = self:getCurDate()

	local heroIds = self:getDayAllBirthdayHeros(month, day)

	for _, v in pairs(heroIds) do
		local heroCo = HeroConfig.instance:getHeroCO(v)

		if not string.nilorempty(heroCo.roleBirthday) and not heroCo.isSP then
			local birth = string.splitToNumber(heroCo.roleBirthday, "/")
			local bonusLength = #string.split(heroCo.birthdayBonus, ";")

			if birth[1] == month and birth[2] == day then
				local birthdayCount = self:getHeroBirthdayCount(v)

				if self._curDate.year ~= year then
					if self._curDate.month == month then
						birthdayCount = birthdayCount - 1
					end
				else
					local birthdayGet = self:isHeroBirthdayGet(v)

					if not birthdayGet and not ((month < self._curDate.month or month == self._curDate.month and day < self._curDate.day or nil) and true) then
						birthdayCount = birthdayCount + 1
					end
				end

				if birthdayCount > 0 and birthdayCount <= bonusLength then
					table.insert(heros, v)
				end
			end
		end
	end

	table.sort(heros)

	return heros
end

function SignInModel:setSignInInfo(info)
	self._signInfo = SignInInfoMo.New()

	self._signInfo:init(info)

	self._totalSignDays = self._signInfo.addupSignInDay
end

function SignInModel:setSignDayRewardGet(info)
	self._signInfo:addSignInfo(info)

	self._totalSignDays = #self._signInfo:getSignDays()
end

function SignInModel:getSupplementMonthCardDays()
	return self._signInfo and self._signInfo:getSupplementMonthCardDays() or 0
end

function SignInModel:setSupplementMonthCard(day)
	self._signInfo:setSupplementMonthCardDays(day)
end

function SignInModel:getCanSupplementMonthCardDays()
	local day = 0

	if StoreModel.instance:hasPurchaseMonthCard() then
		local monthCardInfo = StoreModel.instance:getMonthCardInfo()
		local monthCardCo = StoreConfig.instance:getMonthCardConfig(monthCardInfo.id)

		if monthCardCo then
			local itemId = monthCardCo.signingItem
			local itemCount = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.SpecialExpiredItem, itemId)
			local noSignInDay = self:getSupplementMonthCardDays()

			if not itemCount or not noSignInDay then
				return 0
			end

			if itemCount < 1 or noSignInDay < 1 then
				return day
			end

			return math.min(itemCount, noSignInDay)
		end
	end

	return day
end

function SignInModel:getSupplementMonthCardItemId()
	return
end

function SignInModel:checkDailyAllowanceIsOpen()
	if not ActivityModel.instance:isActOnLine(ActivityEnum.Activity.DailyAllowance) then
		return false
	end

	return true
end

function SignInModel:checkIsFirstGoldDay()
	if self:checkDailyAllowanceIsOpen() then
		local actmo = ActivityModel.instance:getActMO(ActivityEnum.Activity.DailyAllowance)
		local sec = ServerTime.now() - actmo:getRealStartTimeStamp()
		local remainday = TimeUtil.secondsToDDHHMMSS(sec) + 1

		if remainday == 1 then
			return true
		end

		return false
	end
end

function SignInModel:getDailyAllowanceBonus()
	if self:checkDailyAllowanceIsOpen() then
		local remainday = math.floor(self:getGoldOpenDay())

		return SignInConfig.instance:getGoldReward(remainday)
	end
end

function SignInModel:getTargetDailyAllowanceBonus(date)
	if self:checkDailyAllowanceIsOpen() then
		local targetTime = TimeUtil.timeToTimeStamp(date[1], date[2], date[3], TimeDispatcher.DailyRefreshTime, 1, 1)
		local remainday = math.floor(self:getGoldOpenDay(targetTime))

		return SignInConfig.instance:getGoldReward(remainday)
	end
end

function SignInModel:getGoldOpenDay(targetTime)
	local actStartTime = ActivityModel.instance:getActStartTime(ActivityEnum.Activity.DailyAllowance) / 1000
	local startTimeTable = os.date("*t", ServerTime.timeInLocal(actStartTime))

	startTimeTable.hour = 5
	startTimeTable.min = 0
	startTimeTable.sec = 0

	local startTimeAmend = os.time(startTimeTable) - ServerTime.clientToServerOffset()
	local offset = ServerTime.now() - startTimeAmend

	return ((targetTime or nil) and targetTime - startTimeAmend) / 86400 + 1
end

function SignInModel:checkIsGoldDayAndPass(date, isItem, itemIndex)
	if self:checkIsGoldDay(date, isItem, itemIndex) then
		local dtTable = {
			hour = 0,
			min = 0,
			sec = 0,
			year = date[1],
			month = date[2],
			day = (isItem or nil) and itemIndex
		}
		local localTimestamp = os.time(dtTable)
		local dateTimeInServer = localTimestamp - ServerTime.clientToServerOffset() - ServerTime.getDstOffset()
		local now = ServerTime.now() - TimeDispatcher.DailyRefreshTime * 3600
		local registerTimeInLocal = ServerTime.timeInLocal(tonumber(PlayerModel.instance:getPlayinfo().registerTime) / 1000)
		local registerDateTime = os.date("*t", registerTimeInLocal - TimeDispatcher.DailyRefreshTime * 3600)
		local registerDateTimeTable = {
			hour = 0,
			min = 0,
			sec = 0,
			year = registerDateTime.year,
			month = registerDateTime.month,
			day = registerDateTime.day
		}
		local registerTimeStamp = os.time(registerDateTimeTable)
		local registerTimeStamp0Clock = registerTimeStamp - ServerTime.clientToServerOffset() - ServerTime.getDstOffset()

		return registerTimeStamp0Clock <= dateTimeInServer and dateTimeInServer <= now
	end

	return false
end

function SignInModel:checkIsGoldDay(date, isItem, itemIndex)
	if self:checkDailyAllowanceIsOpen() then
		local dtTable = {
			hour = 12,
			min = 0,
			sec = 0,
			year = date[1],
			month = date[2],
			day = (isItem or nil) and itemIndex
		}
		local localTimestamp = os.time(dtTable)
		local dateTimeInServer = localTimestamp - ServerTime.clientToServerOffset() - ServerTime.getDstOffset()
		local actmo = ActivityModel.instance:getActMO(ActivityEnum.Activity.DailyAllowance)
		local startTime = actmo:getRealStartTimeStamp() - TimeDispatcher.DailyRefreshTime * 3600
		local endTime = actmo:getRealEndTimeStamp() - TimeDispatcher.DailyRefreshTime * 3600
		local codict = lua_activity143_bonus.configDict
		local colist = codict and codict[ActivityEnum.Activity.DailyAllowance]

		if colist then
			if not #colist then
				local actDays = 0
				local onlinesec = actDays * TimeUtil.OneDaySecond
				local endTimeWithActDays = startTime + onlinesec
				local realEndTime = math.min(endTime, endTimeWithActDays)

				return startTime < dateTimeInServer and dateTimeInServer < realEndTime
			end
		end
	end

	return false
end

function SignInModel:setSignTotalRewardGet(id)
	self._signInfo:addSignTotalIds(id)
end

function SignInModel:getTotalSignDays()
	return self._totalSignDays
end

function SignInModel:getAllSignDays()
	return self._signInfo.hasSignInDays
end

function SignInModel:getAllSignTotals()
	return self._signInfo.hasGetAddupBonus
end

function SignInModel:isSignDayRewardGet(day)
	for _, v in pairs(self._signInfo.hasSignInDays) do
		if v == day then
			return true
		end
	end

	return false
end

function SignInModel:clearSignInDays()
	self._signInfo:clearSignInDays()

	self._getBirthHeros = {}
end

function SignInModel:isSignTotalRewardGet(id)
	for _, v in pairs(self._signInfo.hasGetAddupBonus) do
		if v == id then
			return true
		end
	end

	return false
end

function SignInModel:isSignSeverDataGet()
	local date = self:getCurDate()

	return self:isSignDayRewardGet(date.day)
end

function SignInModel:getValidMonthCard(year, month, day)
	local time = TimeUtil.timeToTimeStamp(year, month, day, 0, 0, 0) - ServerTime.nowInLocal() + ServerTime.now()

	for _, v in pairs(self._signInfo.monthCardHistory) do
		if TimeUtil.isSameDay(time, v.startTime - TimeDispatcher.DailyRefreshTime * 3600) or TimeUtil.isSameDay(time, v.endTime - TimeDispatcher.DailyRefreshTime * 3600 - 1) then
			return v.id
		end

		if time >= v.startTime - TimeDispatcher.DailyRefreshTime * 3600 and time <= v.endTime - TimeDispatcher.DailyRefreshTime * 3600 - 1 then
			return v.id
		end
	end

	return nil
end

function SignInModel:getCurDate()
	return os.date("!*t", ServerTime.now() + ServerTime.serverUtcOffset() - TimeDispatcher.DailyRefreshTime * 3600)
end

function SignInModel:isAutoSign()
	return self._isAutoSignGetReward
end

function SignInModel:setAutoSign(auto)
	self._isAutoSignGetReward = auto
end

function SignInModel:isNewShowDetail()
	return self._newShowDetail
end

function SignInModel:setNewShowDetail(new)
	self._newShowDetail = new
end

function SignInModel:isNewSwitch()
	return self._newSwitch
end

function SignInModel:setNewSwitch(new)
	self._newSwitch = new
end

function SignInModel:setSignInHistory(info)
	self._historySignInfos[info.month] = SignInHistoryInfoMo.New()

	self._historySignInfos[info.month]:init(info)
end

function SignInModel:getHistorySignInDays(month)
	return self._historySignInfos[month].hasSignInDays
end

function SignInModel:isHistoryDaySigned(month, day)
	if not self._historySignInfos[month] then
		return false
	end

	for _, v in pairs(self._historySignInfos[month].hasSignInDays) do
		if tonumber(v) == tonumber(day) then
			return true
		end
	end

	return false
end

function SignInModel:getSignTargetDate()
	return self._targetdate
end

function SignInModel:setTargetDate(year, month, day, wday)
	if self._targetdate then
		self._targetDate = {
			year,
			month,
			day
		}
	end

	if not wday then
		local timestamp = TimeUtil.timeToTimeStamp(year, month, day, wday, TimeDispatcher.DailyRefreshTime, 1, 1)
		local date = os.date("*t", timestamp)

		wday = date.wday
	end

	self._targetdate.year = tonumber(year)
	self._targetdate.month = tonumber(month)
	self._targetdate.day = tonumber(day)
	self._targetdate.wday = tonumber(wday)
	self._targetdate[1] = self._targetdate.year
	self._targetdate[2] = self._targetdate.month
	self._targetdate[3] = self._targetdate.day
end

function SignInModel:getSignRewardsByDate(date)
	local wday = TimeUtil.getTodayWeedDay(date)

	return SignInConfig.instance:getSignRewardBouns(wday)
end

function SignInModel:getAdvanceHero()
	local curDate = self:getCurDate()

	for i = 1, 3 do
		local date = os.date("!*t", ServerTime.now() + ServerTime.serverUtcOffset() + 86400 * i - TimeDispatcher.DailyRefreshTime * 3600)
		local heros = self:getNoSignBirthdayHeros(date.month, date.day)

		if #heros > 0 then
			local hero = heros[1]

			for _, v in pairs(heros) do
				local maxCo = HeroConfig.instance:getHeroCO(hero)
				local co = HeroConfig.instance:getHeroCO(v)

				if maxCo.rare < co.rare then
					hero = v
				end
			end

			return hero, i
		end
	end

	return 0
end

function SignInModel:getShowMonthItemCo()
	local registerDate = tonumber(PlayerModel.instance:getPlayinfo().registerTime)
	local date = os.date("!*t", registerDate / 1000 + ServerTime.serverUtcOffset() - TimeDispatcher.DailyRefreshTime * 3600)
	local curDate = self:getCurDate()
	local monthCo = {}

	if date.year == curDate.year then
		for i = date.month, curDate.month do
			local o = {}

			o.year = date.year
			o.month = i

			table.insert(monthCo, o)
		end
	else
		if curDate.year - date.year > 1 then
			for i = curDate.month, 12 do
				local o = {}

				o.year = curDate.year - 1
				o.month = i

				table.insert(monthCo, o)
			end
		elseif date.month < curDate.month then
			if not curDate.month then
				local month = date.month

				for i = month, 12 do
					local o = {}

					o.year = curDate.year - 1
					o.month = i

					table.insert(monthCo, o)
				end
			end
		end

		for i = 1, curDate.month do
			local o = {}

			o.year = curDate.year
			o.month = i

			table.insert(monthCo, o)
		end
	end

	return monthCo
end

function SignInModel.checkFestivalDecorationUnlock()
	local actId = CommonConfig.instance:getConstNum(ConstEnum.SignInCalendarDecorationActId)
	local unlock = ActivityModel.instance:isActOnLine(actId)

	if unlock == nil or unlock == false then
		return false
	end

	local startTime = ActivityModel.instance:getActStartTime(actId)
	local endTime = ActivityModel.instance:getActEndTime(actId)
	local nowTime = ServerTime.now() * 1000

	return startTime ~= nil and endTime ~= nil and startTime <= nowTime and nowTime < endTime
end

function SignInModel:onReceiveSignInTotalRewardReply(msg)
	self:setRewardMark(msg.mark)
end

function SignInModel:isClaimedAccumulateReward(id)
	return self._signInfo:isClaimedAccumulateReward(id)
end

function SignInModel:isClaimableAccumulateReward(idOrNil)
	return self._signInfo:isClaimableAccumulateReward(idOrNil)
end

function SignInModel:onReceiveSignInTotalRewardAllReply(msg)
	self:setRewardMark(msg.mark)
end

function SignInModel:setRewardMark(rewardMark)
	self._signInfo:setRewardMark(rewardMark or 0)
end

function SignInModel:getSpecialdate()
	if not self._specialdate then
		local dateString = CommonConfig.instance:getConstStr(ConstEnum.SignInSpecialDate)
		local year, month, day = 0, 0, 0

		if not string.nilorempty(dateString) then
			year, month, day = dateString:match("(%d+)-(%d+)-(%d+)")
		end

		logNormal(string.format("SignInModel:getSpecialdate() ==> %s %s %s %s", dateString, year, month, day))

		self._specialdate = {
			year = tonumber(year),
			month = tonumber(month),
			day = tonumber(day)
		}
	end

	return self._specialdate
end

SignInModel.instance = SignInModel.New()

return SignInModel
