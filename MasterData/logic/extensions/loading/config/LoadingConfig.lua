-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/loading/config/LoadingConfig.lua

module("logic.extensions.loading.config.LoadingConfig", package.seeall)

local M = class("LoadingConfig", BaseConfig)

function M:onInit()
	self._loadingConfigIndex = {}
end

function M:getNames()
	return {
		ConfigName.Loading
	}
end

function M:handleConfig(name, content)
	M.super.handleConfig(self, name, content)

	local index = 1

	for k, v in pairs(content.dataList or {}) do
		self._loadingConfigIndex[index] = v
		index = index + 1
	end
end

function M:getAllLoadingConfig()
	return self._loadingConfigIndex
end

function M:getLoadingConfigById(id)
	local info = false

	for k, v in pairs(self._dict) do
		info = v[id]

		if info then
			break
		end
	end

	return info
end

function M:getRandomLoadingConfig()
	local _lenConfig = self._loadingConfigIndex and #self._loadingConfigIndex or 0

	if _lenConfig > 0 then
		math.randomseed(os.time())

		local _randomIndex = math.random(_lenConfig)
		local info = self._loadingConfigIndex[_randomIndex]

		return info
	else
		printError("配置为空")

		return nil
	end
end

M.instance = M.New()

return M
