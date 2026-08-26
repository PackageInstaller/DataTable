-- chunkname: @modules/logic/login/config/LoginConfig.lua

module("modules.logic.login.config.LoginConfig", package.seeall)

local LoginConfig = class("LoginConfig", BaseConfig)

function LoginConfig:reqConfigNames()
	return {
		"login_view_page"
	}
end

function LoginConfig:onInit()
	self._config = nil
end

function LoginConfig:onConfigLoaded(configName, configTable)
	if configName == "" then
		self._config = configTable
	elseif configName == "login_view_page" then
		self._loginPageConfig = configTable
	end
end

function LoginConfig:getConfigTable()
	return self._config
end

function LoginConfig:getPageCfgById(id)
	return self._loginPageConfig and self._loginPageConfig.configDict[id]
end

function LoginConfig:getPageCfgList()
	return self._loginPageConfig and self._loginPageConfig.configList
end

function LoginConfig:getEpisodeIdList(isRest)
	if not self._pisodeIdList or isRest == true then
		self._pisodeIdList = {}

		local dict = {}

		self:_addEpisodeCo(self:getPageCfgList(), self._pisodeIdList, dict)
		self:_addEpisodeCo(booterLoadingConfig(), self._pisodeIdList, dict)
	end

	return self._pisodeIdList
end

function LoginConfig:_addEpisodeCo(coList, idList, dict)
	if coList then
		for _, co in ipairs(coList) do
			local episodeId = co.episodeId

			if episodeId and episodeId ~= 0 and not dict[episodeId] then
				dict[episodeId] = true

				table.insert(idList, episodeId)
			end
		end
	end
end

LoginConfig.instance = LoginConfig.New()

return LoginConfig
