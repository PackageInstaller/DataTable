-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/controlaction/config/ControlActionConfig.lua

module("logic.extensions.controlaction.config.ControlActionConfig", package.seeall)

local M = class("ControlActionConfig", BaseConfig)

function M:getNames()
	return {
		ConfigName.MonitorInfo,
		ConfigName.MonitorZone,
		ConfigName.MonitorDungeonLevel,
		ConfigName.PostTheme,
		ConfigName.PostReply,
		ConfigName.PostPlayer,
		ConfigName.PostPlayerGroup,
		ConfigName.Manual,
		ConfigName.ManualTask,
		ConfigName.ControlActionConst
	}
end

function M:getMonitorZoneCfg(code)
	local cfgs = self._dict[ConfigName.MonitorZone].dataList

	for _, cfg in ipairs(cfgs) do
		if cfg.code == tonumber(code) then
			return cfg
		end
	end
end

function M:getMonitorDungeonGroupCfg(code)
	local cfgs = self._dict[ConfigName.MonitorInfo].dataList

	for _, cfg in ipairs(cfgs) do
		if cfg.code == tonumber(code) then
			return cfg
		end
	end
end

function M:getMonitorDungeonLimitCfg(code)
	local cfgs = self._dict[ConfigName.MonitorDungeonLevel].dataList

	for _, cfg in ipairs(cfgs) do
		if cfg.code == tonumber(code) then
			return cfg
		end
	end
end

function M:getThemePostCfg(code)
	local cfgs = self._dict[ConfigName.PostTheme].dataList

	for _, cfg in ipairs(cfgs) do
		if cfg.code == tonumber(code) then
			return cfg
		end
	end
end

function M:getReplyPostCfg(code)
	local cfgs = self._dict[ConfigName.PostReply].dataList

	for _, cfg in ipairs(cfgs) do
		if cfg.code == tonumber(code) then
			return cfg
		end
	end
end

function M:getPlayerCfg(code)
	local cfgs = self._dict[ConfigName.PostPlayer].dataList

	for _, cfg in ipairs(cfgs) do
		if cfg.code == tonumber(code) then
			return cfg
		end
	end
end

function M:getPlayerGroupCfg(code)
	local playerList = {}
	local cfgs = self._dict[ConfigName.PostPlayerGroup].dataList

	for _, cfg in ipairs(cfgs) do
		if cfg.code == tonumber(code) then
			table.insert(playerList, cfg)
		end
	end

	return playerList
end

function M:getManualCfgList()
	local cfgs = self._dict[ConfigName.Manual].dataList

	return cfgs
end

function M:getManualTaskCfg(id)
	local cfgs = self._dict[ConfigName.ManualTask].dataList

	for _, cfg in ipairs(cfgs) do
		if cfg.id == tonumber(id) then
			return cfg
		end
	end
end

function M:getGuideThemePostCfgList()
	local dataList = {}
	local cfgs = self._dict[ConfigName.PostTheme].dataList

	for _, cfg in ipairs(cfgs) do
		if cfg.type == 99 then
			table.insert(dataList, cfg)
		end
	end

	return dataList
end

function M:getGuideReplayPostCfgList(themePostCode)
	local dataList = {}
	local cfgs = self._dict[ConfigName.PostReply].dataList

	for _, cfg in ipairs(cfgs) do
		local findeCode = false

		if cfg.themePosts then
			for i, v in ipairs(cfg.themePosts) do
				if v == themePostCode then
					findeCode = true
				end
			end
		end

		if findeCode and cfg.descTime ~= "" and #dataList <= 5 then
			table.insert(dataList, cfg)
		end
	end

	return dataList
end

function M:getConstValue(constKey)
	local co = self._dict[ConfigName.ControlActionConst][constKey]

	return co and co.numValue or 0
end

function M:isTeachDungeon(protomerId, dungeonId)
	local protomerCo = self:getMonitorDungeonGroupCfg(protomerId)

	if protomerCo and protomerCo.dungeonCodes[#protomerCo.dungeonCodes] == dungeonId then
		return true
	end

	return false
end

function M:getProtomerId(dungeonId)
	local cfgs = self._dict[ConfigName.MonitorInfo].dataList

	for _, cfg in ipairs(cfgs) do
		if table.indexof(cfg.dungeonCodes, dungeonId) then
			return cfg.code
		end
	end

	return nil
end

function M:isTeachDungeonById(dungeonId)
	local promotomerId = self:getProtomerId(dungeonId)

	return self:isTeachDungeon(promotomerId, dungeonId)
end

M.instance = M.New()

return M
