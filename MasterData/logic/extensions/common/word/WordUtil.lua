-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/word/WordUtil.lua

module("logic.extensions.common.word.WordUtil", package.seeall)

local M = {}

M.NameDefaultColor = "#FFFFFF"

local kWordPattern = "%b[]"
local kWordPrefix = "word_"
local kTagPrefix = "tag_"
local kBuffPrefix = "buff_"

function M.parseProperWord(content)
	local wordKey = string.gsub(content, kWordPrefix, "")
	local wordCO = WordConfig.instance:getWordCO(wordKey)

	if wordCO then
		local properWord = ProperWord.New(wordKey)

		properWord:setCO(wordCO)

		return properWord
	end

	return nil
end

function M.parseTagWord(content)
	local tagKey = string.gsub(content, kTagPrefix, "")
	local tagId = tonumber(tagKey)

	tagId = tagId or ActiveSkillConfig.instance:getSkillTagIdByDescKey(tagKey)

	local tagCO = ActiveSkillConfig.instance:getSkillTagCO(tagId)

	if tagCO then
		local tagWord = TagWord.New(tagId)

		tagWord:setCO(tagCO)

		return tagWord
	end

	return nil
end

function M.parseBuffWord(content)
	local buffKey = string.gsub(content, kBuffPrefix, "")
	local buffId = tonumber(buffKey)

	buffId = buffId or BuffConfig.instance:getBuffIdByKey(buffKey)

	if buffId then
		local buffCO = BuffConfig.instance:getBuffCO(buffId)

		if buffCO then
			local buffWord = BuffWord.New(buffId)

			buffWord:setCO(buffCO)

			return buffWord
		end
	end

	return nil
end

local parseWordChain = {
	M.parseProperWord,
	M.parseTagWord,
	M.parseBuffWord
}

function M.parse(desc, changeWordFun)
	if string.nilorempty(desc) then
		return nil
	end

	local result = WordData.New(desc)

	local function replaceFun(patternStr)
		local content = string.sub(patternStr, 2, -2)
		local word

		for _, parseWordFun in ipairs(parseWordChain) do
			word = parseWordFun(content)

			if word then
				result:addWord(word)

				if changeWordFun then
					return changeWordFun(word)
				else
					return M.defaultWordName(word)
				end
			end
		end

		return patternStr
	end

	local parsedDesc = string.gsub(desc, kWordPattern, replaceFun)

	result:setDesc(parsedDesc)

	return result
end

function M.defaultWordName(word)
	return word:getNameUnderline()
end

function M.wordNameBracket(word)
	return word:getNameBracket()
end

function M:wordNameBracketUnderline(word)
	return word:getNameBracketUnderline()
end

function M.sortWord(wordA, wordB)
	local aType = wordA:getType()
	local bType = wordB:getType()

	if aType == bType then
		if aType == WordEnum.WordType.Buff then
			local buffA = wordA:getKey()
			local buffB = wordB:getKey()

			return BuffCOUtil.buffSort(buffA, buffB)
		end

		return false
	end

	return aType < bType
end

function M.onTextChange(wordTextCmp, oldText)
	local wordData = M.parse(oldText)

	if wordData and wordData:length() > 0 then
		local data = {}

		data.wordData = wordData
		data.wordTextCmp = wordTextCmp
		data.bindGo = wordTextCmp:GetBindGo()

		wordTextCmp:SetText(wordData:toString())
		wordTextCmp:SetOnClickEvent(M.onClickWordText, data)
	else
		wordTextCmp:RemoveOnClickEvent()
	end
end

function M.onClickWordText(data)
	if data.wordData then
		local info = {}

		info.wordData = data.wordData
		info.bindGo = data.bindGo

		ViewMgr.instance:open(ViewName.WordView, info)
	end
end

return M
