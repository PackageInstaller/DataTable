-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/codeword/config/CodeWordConfig.lua

module("logic.extensions.codeword.config.CodeWordConfig", package.seeall)

local CodeWordConfig = class("CodeWordConfig", BaseConfig)

function CodeWordConfig:onInit()
	CodeWordConfig.super.onInit(self)

	self.code_word_group = nil
	self.code_word = nil
end

function CodeWordConfig:getNames()
	return {
		"code_word_group",
		"code_word"
	}
end

function CodeWordConfig:handleConfig(name, content)
	if name == "code_word_group" then
		self.code_word_group = content
	elseif name == "code_word" then
		self.code_word = content
	end
end

function CodeWordConfig:getWordGroupList()
	return self.code_word_group.dataList
end

function CodeWordConfig:getWordGroupCfg(groupId)
	return self.code_word_group[groupId]
end

function CodeWordConfig:getTextCfg(groupId, id)
	if self.code_word[groupId] then
		return self.code_word[groupId][id]
	end
end

function CodeWordConfig:getCfgByText(text, chatChannel)
	local list = self.code_word.dataList
	local count = #list

	for i = count, 1, -1 do
		if list[i].text == text and self:_isAvailableById(list[i].groupId, chatChannel) then
			return list[i]
		end
	end
end

function CodeWordConfig:_isAvailableById(groupId, chatChannel)
	local cfg = CodeWordConfig.instance:getWordGroupCfg(groupId)

	if not cfg then
		return false
	end

	local channelList = string.split(cfg.channelIds, "#")
	local isAvailableChannel = false

	for i, v in ipairs(channelList) do
		if checknumber(v) == chatChannel then
			isAvailableChannel = true

			break
		end
	end

	return isAvailableChannel
end

CodeWordConfig.instance = CodeWordConfig.New()

return CodeWordConfig
