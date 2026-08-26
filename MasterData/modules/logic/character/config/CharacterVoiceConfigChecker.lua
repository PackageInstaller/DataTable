-- chunkname: @modules/logic/character/config/CharacterVoiceConfigChecker.lua

module("modules.logic.character.config.CharacterVoiceConfigChecker", package.seeall)

local CharacterVoiceConfigChecker = class("CharacterVoiceConfigChecker")
local triggerMinIndex = 1
local triggerMaxIndex = 5

function CharacterVoiceConfigChecker:checkConfig()
	if not SLFramework.FrameworkSettings.IsEditor then
		return
	end

	local typeHandler = {
		[CharacterEnum.VoiceType.HeroGroup] = self._handlerSkip,
		[CharacterEnum.VoiceType.EnterFight] = self._handlerSkip,
		[CharacterEnum.VoiceType.FightCardStar12] = self._handlerSkip,
		[CharacterEnum.VoiceType.FightCardStar3] = self._handlerSkip,
		[CharacterEnum.VoiceType.FightCardUnique] = self._handlerSkip,
		[CharacterEnum.VoiceType.FightBehit] = self._handlerSkip,
		[CharacterEnum.VoiceType.FightResult] = self._handlerSkip,
		[CharacterEnum.VoiceType.FightDie] = self._handlerSkip,
		[CharacterEnum.VoiceType.GetSkin] = self._handlerGetSkin,
		[CharacterEnum.VoiceType.BreakThrough] = self._handlerSkip,
		[CharacterEnum.VoiceType.Summon] = self._handlerSkip,
		[CharacterEnum.VoiceType.MainViewSpecialTouch] = self._handlerMainViewSpecialTouch,
		[CharacterEnum.VoiceType.MainViewNormalTouch] = self._handlerSkip,
		[CharacterEnum.VoiceType.WeatherChange] = self._handlerWeatherChange,
		[CharacterEnum.VoiceType.MainViewWelcome] = self._handlerMainViewWelcome,
		[CharacterEnum.VoiceType.MainViewNoInteraction] = self._handlerMainViewNoInteraction,
		[CharacterEnum.VoiceType.Greeting] = self._handlerSkip,
		[CharacterEnum.VoiceType.Skill] = self._handlerSkip,
		[CharacterEnum.VoiceType.GreetingInThumbnail] = self._handlerGreetingInThumbnail,
		[CharacterEnum.VoiceType.SpecialIdle1] = self._handlerSkip,
		[CharacterEnum.VoiceType.SpecialIdle2] = self._handlerSkip,
		[CharacterEnum.VoiceType.LimitedEntrance] = self._handlerSkip,
		[CharacterEnum.VoiceType.MainViewSpecialInteraction] = self._handlerMainViewSpecialInteraction,
		[CharacterEnum.VoiceType.MainViewSpecialRespond] = self._handlerMainViewSpecialRespond,
		[CharacterEnum.VoiceType.MainViewDragSpecialRespond] = self._handlerMainViewDragSpecialRespond,
		[CharacterEnum.VoiceType.MultiVoice] = self._handlerMultiVoice,
		[CharacterEnum.VoiceType.FightCardSkill3] = self._handlerFightCardSkill3Voice
	}

	for i, config in ipairs(lua_character_voice.configList) do
		local result = callWithCatch(self._commonCheck, self, config)

		if not result then
			logError(string.format("CharacterVoiceConfigChecker audio:%s type:%s is invalid", config.audio, config.type))
		end

		local handler = typeHandler[config.type]

		if handler then
			local result = callWithCatch(handler, self, config)

			if not result then
				logError(string.format("CharacterVoiceConfigChecker audio:%s type:%s is invalid", config.audio, config.type))
			end
		else
			logError(string.format("CharacterVoiceConfigChecker audio:%s type:%s no handler", config.audio, config.type))
		end
	end
end

function CharacterVoiceConfigChecker:_commonCheck(config)
	local list = string.splitToNumber(config.skins, "#")

	for i, skinId in ipairs(list) do
		if not lua_skin.configDict[skinId] then
			logError(string.format("CharacterVoiceConfigChecker audio:%s type:%s skinId:%s is invalid", config.audio, config.type, skinId))
		end
	end

	self:_addAudioCheck(config)
end

function CharacterVoiceConfigChecker:_addAudioCheck(config)
	if string.nilorempty(config.addaudio) then
		return
	end

	local addAudiosParams = string.split(config.addaudio, "|")

	for _, audioParam in pairs(addAudiosParams) do
		local addlist = string.split(audioParam, "#")

		for i, v in ipairs(addlist) do
			if not tonumber(v) then
				logError(string.format("CharacterVoiceConfigChecker _addAudioCheck audio:%s type:%s audioParam:%s index:%s is invalid", config.audio, config.type, audioParam, i))
			end
		end
	end
end

function CharacterVoiceConfigChecker:_handlerSkip(config)
	return
end

function CharacterVoiceConfigChecker:_handlerGetSkin(config)
	if not lua_skin.configDict[tonumber(config.param)] then
		logError(string.format("CharacterVoiceConfigChecker audio:%s type:%s param:%s is invalid", config.audio, config.type, config.param))

		return
	end
end

function CharacterVoiceConfigChecker:_handlerMainViewSpecialTouch(config)
	local index = tonumber(config.param)

	if index < triggerMinIndex or index > triggerMaxIndex then
		logError(string.format("CharacterVoiceConfigChecker audio:%s type:%s param:%s is invalid", config.audio, config.type, config.param))
	end
end

function CharacterVoiceConfigChecker:_handlerWeatherChange(config)
	local list = string.splitToNumber(config.param, "#")

	if #list == 0 then
		logError(string.format("CharacterVoiceConfigChecker audio:%s type:%s param:%s is invalid", config.audio, config.type, config.param))

		return
	end

	for k, v in pairs(list) do
		if not lua_weather_report.configDict[v] then
			logError(string.format("CharacterVoiceConfigChecker audio:%s type:%s param:%s is invalid", config.audio, config.type, config.param))

			break
		end
	end
end

function CharacterVoiceConfigChecker:_handlerMainViewWelcome(config)
	local param = string.split(config.time, "#")
	local timeList = string.split(param[1], ":")
	local h = tonumber(timeList[1])
end

function CharacterVoiceConfigChecker:_handlerMainViewNoInteraction(config)
	local list = string.splitToNumber(config.param, "#")

	if #list == 0 or not list[1] or not list[2] then
		logError(string.format("CharacterVoiceConfigChecker audio:%s type:%s param:%s is invalid", config.audio, config.type, config.param))

		return
	end
end

function CharacterVoiceConfigChecker:_handlerGreetingInThumbnail(config)
	local param = string.split(config.time, "#")
	local timeList = string.split(param[1], ":")
	local h = tonumber(timeList[1])
end

function CharacterVoiceConfigChecker:_handlerMainViewSpecialInteraction(config)
	local list = string.splitToNumber(config.param, "#")

	if #list == 0 or not list[1] or not list[2] then
		logError(string.format("CharacterVoiceConfigChecker audio:%s type:%s param:%s is invalid", config.audio, config.type, config.param))
	end

	local id = tonumber(config.param2)

	if not id or not lua_character_special_interaction_voice.configDict[id] then
		logError(string.format("CharacterVoiceConfigChecker audio:%s type:%s param2:%s is invalid", config.audio, config.type, config.param2))
	end
end

function CharacterVoiceConfigChecker:_handlerMainViewSpecialRespond(config)
	local index = tonumber(config.param) or 0

	if index == 0 then
		return
	end

	if index < triggerMinIndex or index > triggerMaxIndex then
		logError(string.format("CharacterVoiceConfigChecker audio:%s type:%s param:%s is invalid", config.audio, config.type, config.param))
	end
end

function CharacterVoiceConfigChecker:_handlerMainViewDragSpecialRespond(config)
	if not string.nilorempty(config.param2) and config.param2 ~= "skipcheck" then
		local list = string.split(config.param2, "#")

		if #list == 0 or not list[1] or not tonumber(list[2]) or not tonumber(list[3]) then
			logError(string.format("CharacterVoiceConfigChecker audio:%s type:%s param2:%s is invalid", config.audio, config.type, config.param2))
		end
	end

	local index = tonumber(config.param) or 0

	if index == 0 then
		return
	end

	if index < triggerMinIndex or index > triggerMaxIndex then
		logError(string.format("CharacterVoiceConfigChecker audio:%s type:%s param:%s is invalid", config.audio, config.type, config.param))
	end
end

function CharacterVoiceConfigChecker:_handlerMultiVoice(config)
	local targetConfig = lua_character_voice.configDict[config.heroId][tonumber(config.param)]

	if not targetConfig or targetConfig == config then
		logError(string.format("CharacterVoiceConfigChecker audio:%s type:%s param:%s is invalid", config.audio, config.type, config.param))
	end
end

function CharacterVoiceConfigChecker:_handlerFightCardSkill3Voice(config)
	local timelineStr = config.param
	local timelineList = string.split(timelineStr, "#")

	for _, timeline in ipairs(timelineList) do
		if not string.nilorempty(timeline) then
			timeline = FightHelper.getRolesTimelinePath(timeline)

			local filePath = SLFramework.FrameworkSettings.AssetRootDir .. "/" .. timeline

			if not SLFramework.FileHelper.IsFileExists(filePath) then
				logError(string.format("[CharacterVoiceConfigChecker] 角色语音表配置的timeline不存在, audio:%s, type:%s, param:%s, is invalid", config.audio, config.type, config.param))
			end
		end
	end
end

CharacterVoiceConfigChecker.instance = CharacterVoiceConfigChecker.New()

return CharacterVoiceConfigChecker
