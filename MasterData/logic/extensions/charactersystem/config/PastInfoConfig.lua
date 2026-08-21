-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/config/PastInfoConfig.lua

module("logic.extensions.charactersystem.config.PastInfoConfig", package.seeall)

local M = class("PastInfoConfig", BaseConfig)

function M:onInit()
	self._heroInfoSpFiles = {}
end

function M:getNames()
	return {
		ConfigName.PastInfo,
		ConfigName.CharacterInfo,
		ConfigName.OrgInfo,
		ConfigName.UniversallyUnlock
	}
end

function M:handleConfig(name, content)
	M.super.handleConfig(self, name, content)

	if name == ConfigName.CharacterInfo then
		for k, v in pairs(content.dataList or {}) do
			if not self._heroInfoSpFiles[v.id] then
				self._heroInfoSpFiles[v.id] = {}
			end

			self._heroInfoSpFiles[v.id][CharacterInfoEnum.UnlockTyp.SpFile1] = v.spfile1
			self._heroInfoSpFiles[v.id][CharacterInfoEnum.UnlockTyp.SpFile2] = v.spfile2
			self._heroInfoSpFiles[v.id][CharacterInfoEnum.UnlockTyp.SpFile3] = v.spfile3
		end
	end
end

function M:getInfo(id)
	local tableInfo = self._dict[ConfigName.PastInfo]
	local findInfo = tableInfo and tableInfo[id] or false

	return findInfo
end

function M:getPastInfoList()
	return self._dict[ConfigName.PastInfo].dataList
end

function M:getPastInfoCount()
	return #self._dict[ConfigName.PastInfo].dataList
end

function M:getOrgInfo(id)
	local tableInfo = self._dict[ConfigName.OrgInfo]
	local findInfo = tableInfo and tableInfo[id] or false

	return findInfo
end

function M:getCharacterInfoList()
	return self._dict[ConfigName.CharacterInfo].dataList
end

function M:getCharacterInfo(heroId)
	local tableInfo = self._dict[ConfigName.CharacterInfo]
	local findInfo = tableInfo and tableInfo[heroId] or false

	if not findInfo and enableErrorLog then
		printError("角色资料表中无法找到角色ID", heroId)
	end

	return findInfo
end

function M:getUniversallyUnlockConfig(id)
	local tableInfo = self._dict[ConfigName.UniversallyUnlock]
	local findInfo = tableInfo and tableInfo[id] or false

	return findInfo
end

function M:getCharacterInfoSpfile(heroId, spFileTyp)
	if self._heroInfoSpFiles[heroId] then
		return self._heroInfoSpFiles[heroId][spFileTyp]
	end

	return nil
end

M.instance = M.New()

return M
