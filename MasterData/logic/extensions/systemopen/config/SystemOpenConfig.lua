-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/systemopen/config/SystemOpenConfig.lua

module("logic.extensions.systemopen.config.SystemOpenConfig", package.seeall)

local M = class("SystemOpenConfig", BaseConfig)

function M:ctor()
	self._systemOpenConfig = nil
	self._systemOpenCOMap = {}
	self._enemyHintConfig = {}
end

function M:reset()
	self._systemOpenCOMap = {}
end

function M:getNames()
	return {
		ConfigName.SystemOpen,
		ConfigName.SystemOpenHint,
		ConfigName.EnemyHint
	}
end

function M:handleConfig(name, content)
	if name == ConfigName.SystemOpen then
		self._systemOpenConfig = content
	elseif name == ConfigName.SystemOpenHint then
		self._systemOpenHit = {}

		for k, v in pairs(content.dataList or {}) do
			self._systemOpenHit[v.code] = v
		end
	elseif name == ConfigName.EnemyHint then
		for i, v in pairs(content.dataList or {}) do
			self._enemyHintConfig[v.code] = v
		end
	end
end

function M:getSystemOpenCOById(id)
	local co = self._systemOpenCOMap[id]

	if not co and self._systemOpenConfig[id] then
		co = SystemOpenCO.New(self._systemOpenConfig[id])
		self._systemOpenCOMap[id] = co
	end

	return co
end

function M:getAllUnlockTaskStepCode()
	local codeList = {}

	for k, v in pairs(self._systemOpenConfig.dataList) do
		table.insert(codeList, v.unlockTaskStepCode)
	end

	return codeList
end

function M:getSystemOpenHintLst()
	return self._systemOpenHit
end

function M:getSystemOpenHint(code)
	return self._systemOpenHit[code]
end

function M:getAllGuideOpenSystemInfo(guideId)
	local codeList = {}

	for k, v in pairs(self._systemOpenConfig.dataList) do
		if v.unlockGuideCode == guideId and v.online ~= 0 then
			if not codeList[guideId] then
				codeList[guideId] = {}
			end

			table.insert(codeList[guideId], v.code)
		end
	end

	return codeList
end

function M:getMonsterHintByCode(code)
	return self._enemyHintConfig[code]
end

M.instance = M.New()

return M
