-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/audio/CharacterAudioConfig.lua

module("logic.common.audio.CharacterAudioConfig", package.seeall)

local M = class("CharacterAudioConfig", BaseConfig)

M._characterAudioCOs = nil
M._characterSoundSortCOs = {}

function M:getNames()
	return {
		"character_audio",
		"character_sound_sort"
	}
end

function M:handleConfig(name, content)
	if name == "character_audio" then
		self._characterAudioCOs = content
	elseif name == "character_sound_sort" then
		self._characterSoundSortCOs = content
	end
end

function M:getSoundSort(id)
	local co = self._characterSoundSortCOs[id]

	return co and co.sort_id or 1000 + id
end

function M:getCharacterAudiosById(id, noprint)
	local coList = self._characterAudioCOs[id]

	if not coList then
		if enableErrorLog and not noprint then
			printError("{excel:S声音表.xlsx, sheetName:export_角色配音与气泡}找不到对应角色配置:" .. tostring(id))
		end

		return false
	end

	return coList
end

function M:getCharacterAudioCOByHeroIdAndAudioId(heroId, audioId)
	local coList = self:getCharacterAudiosById(heroId)

	if coList then
		return coList[audioId]
	end

	return false
end

function M:getCharacterAudioByIdAndType(id, type)
	local coList = self._characterAudioCOs[id]

	if not coList then
		if enableErrorLog then
			printError("{excel:S声音表.xlsx, sheetName:export_角色配音与气泡}找不到对应角色配置:" .. tostring(id))
		end

		return false
	end

	local co = false

	for _, v in pairs(coList) do
		if v.type == type then
			co = v

			break
		end
	end

	if not co then
		if enableErrorLog then
			printError("{excel:S声音表.xlsx, sheetName:export_角色配音与气泡}找不到对应类型配置:" .. tostring(type))
		end

		return false
	end

	return co
end

function M:getCharacterAudioByAffinityLv(id, level)
	local coList = self._characterAudioCOs[id]

	if not coList then
		if enableErrorLog then
			printError("{excel:S声音表.xlsx, sheetName:export_角色配音与气泡}找不到对应角色配置:" .. tostring(id))
		end

		return false
	end

	local co = false
	local ffinity = lang("tip_authority_title") .. level

	for _, v in pairs(coList) do
		if v.audioName == ffinity then
			co = v

			break
		end
	end

	if not co then
		if enableErrorLog then
			printError("{excel:S声音表.xlsx, sheetName:export_角色配音与气泡}找不到对应亲和度配置:" .. id .. "  " .. tostring(level))
		end

		return false
	end

	return co
end

M.instance = M.New()

return M
