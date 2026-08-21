-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/config/preview/CharacterPreviewConfig.lua

module("logic.extensions.charactersystem.config.preview.CharacterPreviewConfig", package.seeall)

local M = class("CharacterPreviewConfig", BaseConfig)
local kDefaultHeroCfgId = 1

function M:onInit()
	return
end

function M:getNames()
	return {
		ConfigName.CharacterPreviewInfo,
		ConfigName.CharacterPreviewCamInfo,
		ConfigName.CharacterPreviewPosInfo
	}
end

function M:handleConfig(name, content)
	self.super.handleConfig(self, name, content)
end

function M:getHeroCfg()
	return self._dict[ConfigName.CharacterPreviewInfo]
end

function M:getCamCfg()
	return self._dict[ConfigName.CharacterPreviewCamInfo]
end

function M:getPosCfg()
	return self._dict[ConfigName.CharacterPreviewPosInfo]
end

function M:_getHeroCO(heroId)
	local heroCO = self:getHeroCfg()[heroId]

	if heroCO == nil then
		heroCO = self:getHeroCfg()[kDefaultHeroCfgId]
	end

	return heroCO
end

function M:getPreviewTransfInfo(heroId)
	local heroCO = self:_getHeroCO(heroId)

	return self:getPosCfg()[heroCO.posId]
end

function M:getCameraCo(heroId)
	local heroCO = self:_getHeroCO(heroId)

	return self:getCamCfg()[heroCO.camId]
end

function M:getConfig(configName)
	return self._dict[configName]
end

function M:getConfigList(configName)
	local cfg = self._dict[configName]

	return cfg and cfg.dataList or {}
end

M.instance = M.New()

return M
