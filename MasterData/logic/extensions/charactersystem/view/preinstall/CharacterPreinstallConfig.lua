-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/preinstall/CharacterPreinstallConfig.lua

module("logic.extensions.charactersystem.view.preinstall.CharacterPreinstallConfig", package.seeall)

local M = class("CharacterPreinstallConfig", BaseConfig)

function M:onInit()
	self._cfgPreinstall = false
	self._cfgPreNumLimit = {}
end

function M:getNames()
	return {
		ConfigName.CharacterRecommendedPreinstall,
		ConfigName.CharacterPreinstallConst
	}
end

function M:handleConfig(name, content)
	if name == ConfigName.CharacterRecommendedPreinstall then
		self._cfgPreinstall = content
	elseif name == ConfigName.CharacterPreinstallConst then
		self._cfgPreNumLimit = content
	end
end

function M:GetPreinstallNumLimit()
	return self._cfgPreNumLimit.CharPreNumLimit[2]
end

function M:getConstCfg()
	return self._cfgPreNumLimit
end

function M:GetCharacterPreInstallList(heroId, noprint)
	local coList = self._cfgPreinstall[heroId]

	if not coList then
		if enableErrorLog and not noprint then
			printError("{excel:J角色预设、编队表.xlsx, sheetName:export_推荐预设}找不到对应角色配置:" .. tostring(heroId))
		end

		return nil
	end

	return coList
end

M.instance = M.New()

return M
