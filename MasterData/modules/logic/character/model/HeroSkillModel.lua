-- chunkname: @modules/logic/character/model/HeroSkillModel.lua

module("modules.logic.character.model.HeroSkillModel", package.seeall)

local HeroSkillModel = class("HeroSkillModel", BaseModel)

function HeroSkillModel:onInit()
	self._skillTagInfos = {}
end

function HeroSkillModel:_initSkillTagInfos()
	local effDescCo = SkillConfig.instance:getSkillEffectDescsCo()

	for _, v in pairs(effDescCo) do
		self._skillTagInfos[v.name] = v
	end
end

function HeroSkillModel:isTagSkillInfo(tag)
	return self._skillTagInfos[tag]
end

function HeroSkillModel:getSkillTagInfoColorType(tag)
	return self._skillTagInfos[tag].color
end

function HeroSkillModel:getSkillTagInfoDesc(tag)
	return self._skillTagInfos[tag].desc
end

function HeroSkillModel:getEffectTagIDsFromDescNotRecursion(desc)
	if not self._skillTagInfos or not next(self._skillTagInfos) then
		self:_initSkillTagInfos()
	end

	local matchesTagIds = {}

	desc = desc or "" or desc
	desc = string.gsub(desc, "【", "[")
	desc = string.gsub(desc, "】", "]")

	for tag in string.gmatch(desc, "%[(.-)%]") do
		if string.nilorempty(tag) or self._skillTagInfos[tag] == nil then
			logError(string.format(" '%s' 技能描述中， '%s' tag 不存在", desc, tag))
		else
			table.insert(matchesTagIds, self._skillTagInfos[tag].id)
		end
	end

	return matchesTagIds
end

function HeroSkillModel:getEffectTagIDsFromDescRecursion(desc)
	local levelQueue = self:getEffectTagIDsFromDescNotRecursion(desc)

	return self:treeLevelTraversal(levelQueue, {}, {})
end

function HeroSkillModel:getEffectTagDescFromDescRecursion(desc, tagColor)
	local matches = HeroSkillModel.instance:getEffectTagIDsFromDescRecursion(desc)
	local wordContent = ""
	local tagNameExistDict = {}

	for k = 1, #matches do
		local co = SkillConfig.instance:getSkillEffectDescCo(matches[k])

		if co then
			local name = co.name
			local canShowSkillTag = HeroSkillModel.instance:canShowSkillTag(name)

			if canShowSkillTag and not tagNameExistDict[name] then
				tagNameExistDict[name] = true
				wordContent = wordContent .. string.format("<color=%s>[%s]</color>:%s\n", tagColor, name, co.desc)
			end
		end
	end

	return wordContent
end

function HeroSkillModel:getEffectTagDescIdList(desc)
	local matches = HeroSkillModel.instance:getEffectTagIDsFromDescRecursion(desc)
	local tagList = {}
	local tagNameExistDict = {}

	for k = 1, #matches do
		local co = SkillConfig.instance:getSkillEffectDescCo(matches[k])

		if co then
			local name = co.name
			local canShowSkillTag = HeroSkillModel.instance:canShowSkillTag(name)

			if canShowSkillTag and not tagNameExistDict[name] then
				tagNameExistDict[name] = true

				table.insert(tagList, co.id)
			end
		end
	end

	return tagList
end

function HeroSkillModel:canShowSkillTag(tagName, isCharacter)
	local tagCo = SkillConfig.instance:getSkillEffectDescCoByName(tagName)

	return SkillHelper.canShowTag(tagCo)
end

function HeroSkillModel:getSkillEffectTagIdsFormDescTabRecursion(descTab)
	local existTags = {}
	local resultTab = {}

	for i, tab in pairs(descTab) do
		resultTab[i] = self:treeLevelTraversal(self:getEffectTagIDsFromDescNotRecursion(tab), {}, existTags)
	end

	return resultTab
end

function HeroSkillModel:treeLevelTraversal(queue, needShowTags, existTags)
	if #queue == 0 then
		return needShowTags
	end

	for i = 1, #queue do
		local tag_id = table.remove(queue, 1)

		if not existTags[tag_id] then
			existTags[tag_id] = true

			table.insert(needShowTags, tag_id)

			local matchTagIds = self:getEffectTagIDsFromDescNotRecursion(SkillConfig.instance:getSkillEffectDescCo(tag_id).desc)

			for _, temp_tag_id in ipairs(matchTagIds) do
				if not existTags[temp_tag_id] then
					table.insert(queue, temp_tag_id)
				end
			end
		end
	end

	return self:treeLevelTraversal(queue, needShowTags, existTags)
end

function HeroSkillModel:skillDesToSpot(str, percentColorParam, bracketColorParam, noUseLine)
	if string.nilorempty(percentColorParam) then
		percentColorParam = "#C66030"
	end

	if string.nilorempty(bracketColorParam) then
		bracketColorParam = "#4e6698"
	end

	local result = string.gsub(str, "(%-%d+%%)", "{%1}")

	result = string.gsub(result, "(%+%d+%%)", "{%1}")
	result = string.gsub(result, "(%-%d+%.*%d*%%)", "{%1}")
	result = string.gsub(result, "(%d+%.*%d*%%)", "{%1}")
	result = string.gsub(result, "%[", string.format("<color=%s>[", bracketColorParam))
	result = string.gsub(result, "%【", string.format("<color=%s>[", bracketColorParam))
	result = string.gsub(result, "%]", "]</color>")
	result = string.gsub(result, "%】", "]</color>")
	result = string.gsub(result, "%{", string.format("<color=%s>", percentColorParam))
	result = string.gsub(result, "%}", "</color>")
	result = self:spotSkillAttribute(result, noUseLine)
	result = SkillConfig.instance:processSkillDesKeyWords(result)

	return result
end

function HeroSkillModel:spotSkillAttribute(str, noUseLine)
	local result = str
	local attCo = HeroConfig.instance:getHeroAttributesCO()

	for _, v in pairs(attCo) do
		if v.showcolor == 1 and not noUseLine then
			result = string.gsub(result, v.name, string.format("<u>%s</u>", v.name))
		end
	end

	return result
end

function HeroSkillModel:formatDescWithColor(desc, numColor, skillNameColor, notChangeNum)
	numColor = numColor or "#d7a270"
	skillNameColor = skillNameColor or "#5f7197"

	local result = desc

	if notChangeNum ~= true then
		local replaceSkillNameList = {}
		local len = 0

		result = string.gsub(result, "(%[.-%])", function(str)
			len = len + 1
			replaceSkillNameList[len] = str

			return "▩replace▩"
		end)
		result = string.gsub(result, "(【.-】)", function(str)
			len = len + 1
			replaceSkillNameList[len] = str

			return "▩replace▩"
		end)
		result = string.gsub(result, "([%d%-%+%%%./]+)", string.format("<color=%s>%%1</color>", numColor))

		local index = 0

		result = string.gsub(result, "▩replace▩", function()
			index = index + 1

			return replaceSkillNameList[index]
		end)
	end

	result = string.gsub(result, "(%[.-%])", string.format("<color=%s>%%1</color>", skillNameColor))
	result = string.gsub(result, "(【.-】)", string.format("<color=%s>%%1</color>", skillNameColor))

	return result
end

HeroSkillModel.instance = HeroSkillModel.New()

return HeroSkillModel
