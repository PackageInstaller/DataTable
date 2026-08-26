-- chunkname: @modules/logic/ressplit/work/VersionResSpiltAudioWhiteWork.lua

module("modules.logic.ressplit.work.VersionResSpiltAudioWhiteWork", package.seeall)

local VersionResSpiltAudioWhiteWork = class("VersionResSpiltAudioWhiteWork", BaseWork)
local _AuidoFuncType = {
	toNumber = 2,
	splitToNumber = 1
}
local _GameCfgAudioWhiteList = {
	{
		resKey = "roleVoice",
		separation = "|",
		luaName = "lua_room_character",
		funcType = _AuidoFuncType.splitToNumber
	}
}

function VersionResSpiltAudioWhiteWork:onStart(context)
	logNormal(string.format("VersionResSpiltAudioWhiteWork:onStart(context) =====>"))

	local allAudioDic = AudioConfig.instance:getAudioCO()
	local audioIdWhiteDic = self:_getAuidoIdWhiteListDict() or {}

	if context then
		if not context.bankEvent2wenDic then
			local bankEvent2wenDic = {}

			self.bankNameWhiteDic = {}
			self.wenNameWhiteDic = {}

			for audioId, v in pairs(audioIdWhiteDic) do
				local audioCfg = allAudioDic[audioId]

				if audioCfg then
					self.bankNameWhiteDic[audioCfg.bankName] = true

					local eventNap = bankEvent2wenDic[audioCfg.eventName]
					local wenNames = eventNap and eventNap[audioCfg.bankName]

					if wenNames and type(wenNames) == "table" then
						for _, wenName in ipairs(wenNames) do
							self.wenNameWhiteDic[wenName] = true
						end
					end
				end
			end

			self:onDone(true)
		end
	end
end

function VersionResSpiltAudioWhiteWork:_getAuidoIdWhiteListDict()
	local audioIdWhiteDic = {}

	self._ToNumberFuncMap = self._ToNumberFuncMap or {
		[_AuidoFuncType.splitToNumber] = VersionResSpiltAudioWhiteWork._gameCfgWhiteSplitToNumber,
		[_AuidoFuncType.toNumber] = VersionResSpiltAudioWhiteWork._gameCfgWhiteToNumber
	}

	local whiteCfgList = _GameCfgAudioWhiteList
	local numberFuncMap = self._ToNumberFuncMap

	for i = 1, #whiteCfgList do
		local whiteCfg = whiteCfgList[i]
		local tempLua = _G[whiteCfg.luaName]

		if tempLua and tempLua.configList then
			local cfgList = tempLua.configList

			for _, cfg in ipairs(cfgList) do
				local func = numberFuncMap[whiteCfg.funcType]

				if func then
					func(audioIdWhiteDic, cfg[whiteCfg.resKey], whiteCfg.separation)
				end
			end
		end
	end

	self:_addHeroStoryPlot(audioIdWhiteDic)

	return audioIdWhiteDic
end

function VersionResSpiltAudioWhiteWork:_addHeroStoryPlot(whiteDic)
	local cfgList = lua_hero_story_plot.configList
	local audioCtl = {
		[NecrologistStoryEnum.StoryControlType.Bgm] = true,
		[NecrologistStoryEnum.StoryControlType.Audio] = true,
		[NecrologistStoryEnum.StoryControlType.StopAudio] = true
	}

	if whiteDic and cfgList and #cfgList > 0 then
		for i = 1, #cfgList do
			local cfg = cfgList[i]

			if cfg and not string.nilorempty(cfg.addControl) and not string.nilorempty(cfg.controlParam) then
				local ctlIds = string.splitToNumber(cfg.addControl, "|")
				local params = string.split(cfg.controlParam, "|")

				if ctlIds and params then
					for idx, ctlId in ipairs(ctlIds) do
						if audioCtl[ctlId] and params[idx] and not string.nilorempty(params[idx]) then
							local audioParams = string.splitToNumber(params[idx], "#")

							if audioParams and audioParams[1] then
								whiteDic[audioParams[1]] = true
							end
						end
					end
				end
			end
		end
	end
end

function VersionResSpiltAudioWhiteWork._gameCfgWhiteSplitToNumber(whiteDic, res, separation)
	if whiteDic and not string.nilorempty(res) and not string.nilorempty(separation) then
		local nums = string.splitToNumber(res, separation)

		if nums then
			for k, v in ipairs(nums) do
				whiteDic[v] = true
			end
		end
	end
end

function VersionResSpiltAudioWhiteWork._gameCfgWhiteToNumber(whiteDic, value)
	if whiteDic and value then
		whiteDic[tonumber(value)] = true
	end
end

return VersionResSpiltAudioWhiteWork
