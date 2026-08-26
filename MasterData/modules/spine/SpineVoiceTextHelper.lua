-- chunkname: @modules/spine/SpineVoiceTextHelper.lua

module("modules.spine.SpineVoiceTextHelper", package.seeall)

local SpineVoiceTextHelper = class("SpineVoiceTextHelper")

function SpineVoiceTextHelper.getSeparateContent(voiceCo, languageType, targetIndex)
	local marks = {}

	table.insert(marks, SpineVoiceTextHelper.getSeparateMarks(voiceCo.content))
	table.insert(marks, SpineVoiceTextHelper.getSeparateMarks(voiceCo.twcontent))
	table.insert(marks, SpineVoiceTextHelper.getSeparateMarks(voiceCo.encontent))
	table.insert(marks, SpineVoiceTextHelper.getSeparateMarks(voiceCo.kocontent))
	table.insert(marks, SpineVoiceTextHelper.getSeparateMarks(voiceCo.jpcontent))
	table.insert(marks, SpineVoiceTextHelper.getSeparateMarks(voiceCo.decontent))
	table.insert(marks, SpineVoiceTextHelper.getSeparateMarks(voiceCo.frcontent))
	table.insert(marks, SpineVoiceTextHelper.getSeparateMarks(voiceCo.thaicontent))

	local content = ""

	if languageType == LanguageEnum.LanguageStoryType.CN then
		content = voiceCo.content
	elseif languageType == LanguageEnum.LanguageStoryType.TW then
		content = voiceCo.twcontent
	elseif languageType == LanguageEnum.LanguageStoryType.EN then
		content = voiceCo.encontent
	elseif languageType == LanguageEnum.LanguageStoryType.KR then
		content = voiceCo.kocontent
	elseif languageType == LanguageEnum.LanguageStoryType.JP then
		content = voiceCo.jpcontent
	elseif languageType == LanguageEnum.LanguageStoryType.DE then
		content = voiceCo.decontent
	elseif languageType == LanguageEnum.LanguageStoryType.FR then
		content = voiceCo.frcontent
	elseif languageType == LanguageEnum.LanguageStoryType.THAI then
		content = voiceCo.thaicontent
	end

	local pattern = "(#%d+%.?%d?%d?)"

	for k, _ in ipairs(marks[languageType]) do
		content = string.gsub(content, pattern, "<sep>" .. k .. "</sep>", 1)
	end

	local i = 0
	local targetMark = marks[targetIndex]

	if (voiceCo.audio == nil or voiceCo.audio == 0) and #targetMark == 0 then
		targetMark = marks[languageType]
	end

	for mark in string.gmatch(content, "<sep>%d+</sep>") do
		i = i + 1

		if not targetMark[i] then
			content = string.gsub(content, "<sep>" .. i .. "</sep>", targetMark[i])
		end
	end

	content = StoryModel.instance:getStoryTxtByVoiceType(content, voiceCo.audio)

	return content
end

function SpineVoiceTextHelper.getSeparateMarks(content)
	local marks = {}
	local pattern = "(#%d+%.?%d?)"

	for mark in string.gmatch(content, pattern) do
		table.insert(marks, mark)
	end

	return marks
end

return SpineVoiceTextHelper
