-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/home/controller/AudioTimerSystem.lua

require("dm.base.TimeUtil")

AudioTimerSystem = AudioTimerSystem or {}

local shareInjector = DmGame:getInstance()._injector

function AudioTimerSystem:getLoginAndEnterHomeSound(heroId)
	local customDataSystem = shareInjector:getInstance(CustomDataSystem)
	local lastLoginTime = customDataSystem:getValue(PrefixType.kGlobal, "lastLogin", -1)

	lastLoginTime = tonumber(lastLoginTime)

	local curTime = shareInjector:getInstance("GameServerAgent"):remoteTimestamp()

	curTime = math.ceil(curTime)

	local soundId

	if lastLoginTime == -1 then
		soundId = "Voice_" .. heroId .. "_35"
	elseif curTime - lastLoginTime > 172800 then
		soundId = "Voice_" .. heroId .. "_38"

		if self:checkIsSoundExist("Voice_" .. heroId .. "_38") == false then
			soundId = "Voice_" .. heroId .. "_35"
		end
	else
		local today4TimeStamp = TimeUtil:getTimeByDateForTargetTimeInToday({
			sec = 0,
			min = 0,
			hour = 4
		})

		if today4TimeStamp <= curTime and lastLoginTime < today4TimeStamp then
			soundId = "Voice_" .. heroId .. "_35"
		else
			local key = math.random(1, 2)

			if key == 1 then
				soundId = self:getWeatherSoundId(heroId)
			else
				local _tabCurTime = TimeUtil:getHMSByTimestamp(curTime)
				local hour = _tabCurTime.hour

				soundId = hour >= 4 and hour < 11 and "Voice_" .. heroId .. "_53" or hour >= 11 and hour < 14 and "Voice_" .. heroId .. "_54" or hour >= 14 and hour < 18 and "Voice_" .. heroId .. "_55" or hour >= 18 and hour < 22 and "Voice_" .. heroId .. "_56" or "Voice_" .. heroId .. "_57"
			end
		end
	end

	customDataSystem:setValue(PrefixType.kGlobal, "lastLogin", curTime)

	return soundId
end

function AudioTimerSystem:checkIsSoundExist(soundId)
	return (ConfigReader:getRecordById("Sound", soundId) ~= nil or nil) and true
end

function AudioTimerSystem:getWeatherSoundId(heroId)
	local settingModel = shareInjector:getInstance(SettingSystem):getSettingModel()
	local weathData = settingModel:getWeatherData()
	local climateDay = GameStyle:getClimateById(weathData.conditionIdDay)

	return (climateDay or nil) and "Voice_" .. heroId .. ClimateSoundId[climateDay]
end

function AudioTimerSystem:getResumeHomeSound(heroId, weather)
	local activitySystem = shareInjector:getInstance(ActivitySystem)
	local isActivity = activitySystem:hasRedPointForActivity(DailyGift)

	if isActivity then
		return "Voice_" .. heroId .. "_58"
	end

	local mailSystem = shareInjector:getInstance(MailSystem)

	if mailSystem:queryRedPointState() then
		return "Voice_" .. heroId .. "_59"
	end

	if self:checkIsPlayerBirthday(false) then
		return "Voice_" .. heroId .. "_19"
	end

	if self:checkIsHeroBirthday(heroId, false) then
		return "Voice_" .. heroId .. "_39"
	end

	local soundId = ""
	local allSound = {}
	local hasLove, loveSound = self:getHeroLoveSoundId(heroId)

	if hasLove then
		allSound[#allSound + 1] = loveSound
	end

	if self:checkIsPlayerBirthday(true) then
		allSound[#allSound + 1] = "Voice_" .. heroId .. "_19"
	end

	if self:checkIsHeroBirthday(heroId, true) then
		allSound[#allSound + 1] = "Voice_" .. heroId .. "_39"
	end

	local randomNum = math.random(1, 2)

	allSound[#allSound + 1] = randomNum > 1 and "Voice_" .. heroId .. "_37" or "Voice_" .. heroId .. "_60"

	local random_Index = math.random(1, #allSound)

	soundId = allSound[random_Index]

	if allSound[random_Index] == "" or self:checkIsSoundExist(soundId) == false then
		soundId = "Voice_" .. heroId .. "_60"
	end

	self._passSoundId = soundId

	return self._passSoundId
end

function AudioTimerSystem:checkIsPlayerBirthday(ignoreLocalData)
	local result = false
	local developSystem = shareInjector:getInstance(DevelopSystem)
	local playerBirthday = developSystem:getPlayer():getBirthday()

	if playerBirthday == nil or playerBirthday == "" then
		result = false
	else
		local customDataSystem = shareInjector:getInstance(CustomDataSystem)
		local birthdayTab = self:parseTimeStr(playerBirthday)
		local curTime = shareInjector:getInstance("GameServerAgent"):remoteTimestamp()
		local tabCurTime = TimeUtil:getYMDByTimestamp(curTime)
		local lastBirthdayLoginYear = customDataSystem:getValue(PrefixType.kGlobal, "lastBirthdayLoginYear", -1)

		if lastBirthdayLoginYear == tabCurTime.year and ignoreLocalData == false then
			result = false
		elseif birthdayTab.month == tabCurTime.month and birthdayTab.day == tabCurTime.day then
			customDataSystem:setValue(PrefixType.kGlobal, "lastBirthdayLoginYear", tabCurTime.year)

			result = true
		end
	end

	return result
end

function AudioTimerSystem:checkIsHeroBirthday(heroId, ignoreLocalData)
	local result = false
	local heroBirthday = ConfigReader:getDataByNameIdAndKey("HeroLove", heroId, "Birthday")

	if heroBirthday then
		if #heroBirthday == 2 then
			local heroMonth = heroBirthday[1]
			local heroDay = heroBirthday[2]
			local dataSystem_Key = "lastHeroBirthdayLoginYear" .. heroId
			local customDataSystem = shareInjector:getInstance(CustomDataSystem)
			local lastBirthdayLoginYear = customDataSystem:getValue(PrefixType.kGlobal, dataSystem_Key, -1)
			local curTime = shareInjector:getInstance("GameServerAgent"):remoteTimestamp()
			local tabCurTime = TimeUtil:getYMDByTimestamp(curTime)

			if lastBirthdayLoginYear == tabCurTime.year and ignoreLocalData == false then
				result = false
			elseif heroMonth == tabCurTime.month and heroDay == tabCurTime.day then
				customDataSystem:setValue(PrefixType.kGlobal, dataSystem_Key, tabCurTime.year)

				result = true
			end
		elseif #heroBirthday == 1 then
			result = self:checkIsPlayerBirthday(ignoreLocalData)
		end
	end

	return result
end

function AudioTimerSystem:parseTimeStr(timeStr)
	local _tab = {}
	local _str
	local strTab = string.split(timeStr, "-")

	_tab.year = tonumber(strTab[1])
	_tab.month = tonumber(strTab[2])
	_tab.day = tonumber(strTab[3])

	return _tab
end

function AudioTimerSystem:getHeroLoveSoundId(heroId, part)
	local soundId = ""
	local developSystem = shareInjector:getInstance(DevelopSystem)
	local heroSystem = developSystem:getHeroSystem()
	local hero = heroSystem:getHeroById(heroId)
	local loveLevel = 0

	if heroSystem:hasHero(heroId) then
		loveLevel = hero:getLoveLevel()
	end

	if part == nil then
		if loveLevel > 1 then
			local allSound = {}

			allSound[#allSound + 1] = "Voice_" .. heroId .. "_14"

			if loveLevel > 2 then
				allSound[#allSound + 1] = "Voice_" .. heroId .. "_15"
			end

			if loveLevel > 4 then
				allSound[#allSound + 1] = "Voice_" .. heroId .. "_16"
			end

			if loveLevel > 5 then
				allSound[#allSound + 1] = "Voice_" .. heroId .. "_17"
			end

			if loveLevel > 7 then
				allSound[#allSound + 1] = "Voice_" .. heroId .. "_18"
			end

			local random = math.random(1, #allSound)

			soundId = allSound[random]
		end
	elseif loveLevel > 0 then
		local allSound = {}

		if part == "head" then
			allSound[#allSound + 1] = "Voice_" .. heroId .. "_41"
		elseif part == "body" then
			allSound[#allSound + 1] = "Voice_" .. heroId .. "_44"
		end

		if loveLevel > 4 then
			if part == "head" then
				allSound[#allSound + 1] = "Voice_" .. heroId .. "_42"
			elseif part == "body" then
				allSound[#allSound + 1] = "Voice_" .. heroId .. "_45"
			end
		end

		if loveLevel > 9 then
			if part == "head" then
				allSound[#allSound + 1] = "Voice_" .. heroId .. "_43"
			elseif part == "body" then
				allSound[#allSound + 1] = "Voice_" .. heroId .. "_46"
			end
		end

		if #allSound > 0 then
			local random = math.random(1, #allSound)

			soundId = allSound[random]
		end
	end

	return (soundId ~= "" or nil) and true, soundId
end

function AudioTimerSystem:getSixtySecendSoundId(heroId)
	local result
	local hasLove, loveSound = self:getHeroLoveSoundId(heroId)

	if hasLove then
		local random = math.random(1, 2)

		result = random == 1 and loveSound or "Voice_" .. heroId .. "_05"
	else
		result = "Voice_" .. heroId .. "_05"
	end

	return result
end

function AudioTimerSystem:getHeroTouchSoundByPart(heroId, part, touchCount)
	local allSound = {}
	local result = ""

	if self:checkIsPlayerBirthday(true) then
		allSound[#allSound + 1] = "Voice_" .. heroId .. "_19"
	end

	if self:checkIsHeroBirthday(heroId, true) then
		allSound[#allSound + 1] = "Voice_" .. heroId .. "_39"
	end

	local hasLove, loveSound = self:getHeroLoveSoundId(heroId, part)

	if hasLove then
		allSound[#allSound + 1] = loveSound
	end

	if part == "all" then
		local random = math.random(1, 2)

		allSound[#allSound + 1] = random > 1 and "Voice_" .. heroId .. "_47" or "Voice_" .. heroId .. "_48"
	end

	if touchCount >= 5 then
		allSound[#allSound + 1] = "Voice_" .. heroId .. "_60"
	end

	local random_Index = math.random(1, #allSound)

	result = allSound[random_Index]

	if allSound[random_Index] == "" or self:checkIsSoundExist(result) == false then
		result = "Voice_" .. heroId .. "_37"

		if self:checkIsSoundExist("Voice_" .. heroId .. "_37") == false then
			result = "Voice_" .. heroId .. "_01"
		end
	end

	dump("result============", result)

	return result
end

function AudioTimerSystem:playStartBattleVoice(arg)
	local team

	if _G.type(arg) == "string" then
		local developSystem = shareInjector:getInstance(DevelopSystem)

		team = developSystem:getTeamByType(arg)
	else
		team = arg
	end

	if team then
		local teamHeros = team.getHeroes and team:getHeroes() or team.heroes

		if teamHeros and #teamHeros > 0 then
			local idx = math.random(1, #teamHeros)

			if not teamHeros[idx] then
				local heroId = ""

				if _G.type(heroId) == "string" and string.len(heroId) > 0 then
					local audioId = "Voice_" .. heroId .. "_25"

					AudioEngine:getInstance():playEffect(audioId, false)
				end
			end
		end
	end
end
