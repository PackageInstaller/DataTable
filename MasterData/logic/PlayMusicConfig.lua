-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playmusic/config/PlayMusicConfig.lua

module("logic.extensions.playmusic.config.PlayMusicConfig", package.seeall)

local PlayMusicConfig = class("PlayMusicConfig", BaseConfig)

function PlayMusicConfig:onInit()
	PlayMusicConfig.super.onInit(self)
end

function PlayMusicConfig:getNames()
	return {
		"play_music_plan",
		"play_music_setting",
		"play_music_combo",
		"play_music_rhythm",
		"play_music_line",
		"play_music_symbol",
		"play_music_hit"
	}
end

function PlayMusicConfig:handleConfig(name, content)
	if name == "play_music_plan" then
		self._pmPlanCfg = content
	elseif name == "play_music_setting" then
		self._pmSettingCfg = content
	elseif name == "play_music_combo" then
		self._pmComboCfgs = content

		self:_handlePmComboContent(content)
	elseif name == "play_music_rhythm" then
		self._pmRhythmCfgs = content

		self:_handlePmRhythmContent(content)
	elseif name == "play_music_line" then
		self._pmLineCfgs = content
	elseif name == "play_music_symbol" then
		self._pmSymbolCfg = content
	elseif name == "play_music_hit" then
		self._pmHitCfg = content

		self:_handlePmHitDataList(content)
	end
end

function PlayMusicConfig:getPmPlanData(gamePlanId)
	return self._pmPlanCfg[gamePlanId]
end

function PlayMusicConfig:getPmComboCfg(comboPlanId)
	return self._pmComboCfgs[comboPlanId]
end

function PlayMusicConfig:getPmComboCfgById(gamePlanId)
	local comboPlanId = self:getPmPlanData(gamePlanId).comboPlanId

	return self._pmComboCfgs[comboPlanId]
end

function PlayMusicConfig:getPmComboDataById(gamePlanId, comboId)
	local comboPlanId = self:getPmPlanData(gamePlanId).comboPlanId

	return self._pmComboCfgs[comboPlanId][comboId]
end

function PlayMusicConfig:getPmComboDataByIdAndCount(gamePlanId, comboCount)
	local comboPlanId = self:getPmPlanData(gamePlanId).comboPlanId
	local key = comboCount

	if key >= #self._pmComboCfgsByCount[comboPlanId] then
		key = #self._pmComboCfgsByCount[comboPlanId]
	end

	return self._pmComboCfgsByCount[comboPlanId][key]
end

function PlayMusicConfig:_handlePmComboContent(content)
	self._pmComboCfgsByCount = {}

	local startIdx, endIdx = 0, 0

	for comboPlanId, comboCfg in ipairs(content) do
		if self._pmComboCfgsByCount[comboPlanId] == nil then
			self._pmComboCfgsByCount[comboPlanId] = {}
		end

		for i = #comboCfg, 1, -1 do
			local thisData = comboCfg[i]
			local preData = comboCfg[Mathf.Max(i - 1, 1)]

			for j = thisData.comboCount, 0, -1 do
				if j >= preData.comboCount then
					self._pmComboCfgsByCount[comboPlanId][j] = thisData
				else
					break
				end
			end
		end
	end
end

function PlayMusicConfig:getPmRhythmCfg(rhythmPlanId)
	return self._pmRhythmCfgs[rhythmPlanId]
end

function PlayMusicConfig:getPmRhythmData(rhythmPlanId, rhythmId)
	return self._pmRhythmCfgs[rhythmPlanId][rhythmId]
end

function PlayMusicConfig:getPmRhythmCfgById(gamePlanId)
	local rhythmPlanId = self:getPmPlanData(gamePlanId).rhythmPlanId

	return self._pmRhythmCfgs[rhythmPlanId]
end

function PlayMusicConfig:getPmRhythmDataById(gamePlanId, rhythmId)
	local rhythmPlanId = self:getPmPlanData(gamePlanId).rhythmPlanId

	return self._pmRhythmCfgs[rhythmPlanId][rhythmId]
end

function PlayMusicConfig:getPmRhythmDataByIdAndCount(gamePlanId, score)
	local rhythmPlanId = self:getPmPlanData(gamePlanId).rhythmPlanId
	local key = score

	if key >= #self._pmRhythmCfgsByScore[rhythmPlanId] then
		key = #self._pmRhythmCfgsByScore[rhythmPlanId]
	end

	return self._pmRhythmCfgsByScore[rhythmPlanId][key]
end

function PlayMusicConfig:_handlePmRhythmContent(content)
	self._pmRhythmCfgsByScore = {}

	local startIdx, endIdx = 0, 0

	for rhythmPlanId, rhythmCfg in ipairs(content) do
		if self._pmRhythmCfgsByScore[rhythmPlanId] == nil then
			self._pmRhythmCfgsByScore[rhythmPlanId] = {}
		end

		for i = #rhythmCfg, 1, -1 do
			local thisData = rhythmCfg[i]
			local preData = rhythmCfg[Mathf.Max(i - 1, 1)]

			for j = thisData.score, 0, -1 do
				if j >= preData.score then
					self._pmRhythmCfgsByScore[rhythmPlanId][j] = thisData
				else
					break
				end
			end
		end
	end
end

function PlayMusicConfig:getPmLineCfg(linePlanId)
	return self._pmLineCfgs[linePlanId]
end

function PlayMusicConfig:getPmLineData(linePlanId, lineId)
	return self._pmLineCfgs[linePlanId][lineId]
end

function PlayMusicConfig:getPmLineCfgById(gamePlanId)
	local linePlanId = self:getPmPlanData(gamePlanId).linePlanId

	return self._pmLineCfgs[linePlanId]
end

function PlayMusicConfig:getPmLineDataById(gamePlanId, lineId)
	local linePlanId = self:getPmPlanData(gamePlanId).linePlanId

	return self._pmLineCfgs[linePlanId][lineId]
end

function PlayMusicConfig:getPmSymbolData(symbolId)
	return self._pmSymbolCfg[symbolId]
end

function PlayMusicConfig:getPmHitData(hitPlanId, hitId)
	return self._pmHitCfg[hitPlanId][hitId]
end

function PlayMusicConfig:getPmHitDataByRatio(hitPlanId, hitTimeRatio)
	return self._pmHitCfgByRatio[hitPlanId][hitTimeRatio]
end

function PlayMusicConfig:getPmHitDataByIdAndRatio(symbolId, hitTimeRatio)
	return self._pmHitCfgByRatio[self:getPmSymbolData(symbolId).hitPlanId][hitTimeRatio]
end

function PlayMusicConfig:_handlePmHitDataList(content)
	self._pmHitCfgByRatio = {}

	local startIdx, endIdx = 0, 0

	for hitPlanId, hitCfg in ipairs(content) do
		if self._pmHitCfgByRatio[hitPlanId] == nil then
			self._pmHitCfgByRatio[hitPlanId] = {}
		end

		for hitId, hitData in ipairs(hitCfg) do
			if hitData.hitTimeRatioRange == nil then
				printError("缺失配置,hitTimeRatioRange必填( x-小游戏演奏音乐.xlsx | export_符号打击方案 | hitPlanId=%s, hitId=%s )", hitPlanId, hitId)
			else
				endIdx = hitData.hitTimeRatioRange[2]
				startIdx = hitData.hitTimeRatioRange[1]

				if not hitData.hitTimeRatioRange[1] or not endIdx then
					printError("缺失配置,hitTimeRatioRange必须是概率范围( x-小游戏演奏音乐.xlsx | export_符号打击方案 | hitPlanId=%s, hitId=%s )", hitPlanId, hitId)
				end

				for idx = startIdx, endIdx, startIdx < endIdx and 1 or -1 do
					if self._pmHitCfgByRatio[hitPlanId][idx] then
						printError("hitTimeRatioRange配置的概率范围,与其它概率范围造成重叠,请务必修改( x-小游戏演奏音乐.xlsx | export_符号打击方案 | hitPlanId=%s, hitId=%s )", hitPlanId, hitId)
					end

					self._pmHitCfgByRatio[hitPlanId][idx] = hitData
				end
			end
		end
	end
end

function PlayMusicConfig:getPmSettingValue(key)
	return self._pmSettingCfg[key] and self._pmSettingCfg[key].value
end

function PlayMusicConfig:getCurGamePlanId()
	return checknumber(self:getPmSettingValue("CUR_GAMEPLANID")) or 0
end

PlayMusicConfig.instance = PlayMusicConfig.New()

return PlayMusicConfig
