-- chunkname: @modules/common/others/SkillHelper.lua

module("modules.common.others.SkillHelper", package.seeall)

local SkillHelper = class("SkillHelper")

function SkillHelper.getTagDescRecursion(desc, nameColor)
	nameColor = nameColor or "#6680bd"

	local matches = HeroSkillModel.instance:getEffectTagIDsFromDescRecursion(desc)
	local wordContent = ""
	local tagNameExistDict = {}

	for k = 1, #matches do
		local co = SkillConfig.instance:getSkillEffectDescCo(matches[k])

		if co then
			local name = co.name

			if (not co.notAddLink or co.notAddLink == 0) and not tagNameExistDict[name] then
				tagNameExistDict[name] = true

				local tagDesc = SkillHelper.buildDesc(co.desc)

				wordContent = wordContent .. string.format("<color=%s>[%s]</color>:%s\n", nameColor, name, tagDesc)
			end
		end
	end

	return wordContent
end

function SkillHelper.addHyperLinkClick(textComp, clickCallback, clickCallbackObj)
	if gohelper.isNil(textComp) then
		logError("textComp is nil, please check !!!")

		return
	end

	local hyperLinkClick = gohelper.onceAddComponent(textComp, typeof(ZProj.TMPHyperLinkClick))

	hyperLinkClick:SetClickListener(clickCallback or SkillHelper.defaultClick, clickCallbackObj)
end

function SkillHelper.defaultClick(effId, clickPosition)
	CommonBuffTipController.instance:openCommonTipView(effId, clickPosition)
end

function SkillHelper.getSkillDesc(monsterName, effectCo, percentColor, bracketColor)
	local desc = FightConfig.instance:getSkillEffectDesc(monsterName, effectCo)

	return SkillHelper.buildDesc(desc, percentColor, bracketColor)
end

function SkillHelper.buildDesc(desc, percentColor, bracketColor)
	desc = SkillHelper.addLink(desc)
	desc = SkillHelper.addColor(desc, percentColor, bracketColor)

	return desc
end

function SkillHelper.getEntityDescBySkillCo(entityId, skillCo, percentColor, bracketColor)
	local entityName = FightConfig.instance:getEntityName(entityId)

	return SkillHelper.getSkillDesc(entityName, skillCo, percentColor, bracketColor)
end

function SkillHelper.getEntityDescBySkillId(entityId, skillId)
	local skillCo = lua_skill.configDict[skillId]

	if not skillCo then
		logError("技能表找不到id : " .. tostring(skillId))

		return ""
	end

	local entityName = FightConfig.instance:getEntityName(entityId)

	return SkillHelper.getSkillDesc(entityName, skillCo)
end

function SkillHelper.addColor(desc, percentColor, bracketColor)
	desc = SkillHelper.addNumColor(desc, percentColor)
	desc = SkillHelper.addBracketColor(desc, bracketColor)

	return desc
end

function SkillHelper.addBracketColor(desc, bracketColor)
	if string.nilorempty(bracketColor) then
		bracketColor = "#4e6698"
	end

	local bracketColorFormat = SkillHelper.getColorFormat(bracketColor, "%1")

	desc = string.gsub(desc, "%[.-%]", bracketColorFormat)
	desc = string.gsub(desc, "【.-】", bracketColorFormat)

	return desc
end

local richTextList = {}
local replaceRichIndex = 0
local replaceRichText = "▩rich_replace▩"

function SkillHelper.filterRichText(desc)
	tabletool.clear(richTextList)

	desc = string.gsub(desc, "(<.->)", SkillHelper._filterRichText)

	return desc
end

function SkillHelper._filterRichText(richText)
	table.insert(richTextList, richText)

	return replaceRichText
end

function SkillHelper.revertRichText(desc)
	replaceRichIndex = 0
	desc = string.gsub(desc, replaceRichText, SkillHelper._revertRichText)

	tabletool.clear(richTextList)

	return desc
end

function SkillHelper._revertRichText(text)
	replaceRichIndex = replaceRichIndex + 1

	return richTextList[replaceRichIndex] or ""
end

function SkillHelper.addNumColor(desc, percentColor)
	if string.nilorempty(percentColor) then
		percentColor = "#C66030"
	end

	desc = SkillHelper.filterRichText(desc)

	local percentColorFormat = SkillHelper.getColorFormat(percentColor, "%1")

	desc = string.gsub(desc, "[+-]?[%d%./%%]+", percentColorFormat)
	desc = SkillHelper.revertRichText(desc)

	return desc
end

function SkillHelper.getColorFormat(color, text)
	return string.format("<color=%s>%s</color>", color, text)
end

function SkillHelper.addLink(desc)
	desc = string.gsub(desc, "%[(.-)%]", SkillHelper._replaceDescTagFunc1)
	desc = string.gsub(desc, "【(.-)】", SkillHelper._replaceDescTagFunc2)

	return desc
end

function SkillHelper._replaceDescTagFunc1(skillName)
	local co = SkillConfig.instance:getSkillEffectDescCoByName(skillName)

	skillName = SkillHelper.removeRichTag(skillName)

	if not co then
		return string.format("[%s]", skillName)
	end

	if not co.notAddLink or co.notAddLink == 0 then
		return string.format("[<u><link=%s>%s</link></u>]", co.id, skillName)
	end

	return string.format("[%s]", skillName)
end

function SkillHelper._replaceDescTagFunc2(skillName)
	local co = SkillConfig.instance:getSkillEffectDescCoByName(skillName)

	skillName = SkillHelper.removeRichTag(skillName)

	if not co then
		return string.format("【%s】", skillName)
	end

	if not co.notAddLink or co.notAddLink == 0 then
		return string.format("【<u><link=%s>%s</link></u>】", co.id, skillName)
	end

	return string.format("【%s】", skillName)
end

function SkillHelper.removeRichTag(name)
	return string.gsub(name, "<.->", "")
end

function SkillHelper.canShowTag(tagCo)
	return tagCo and (not tagCo.notAddLink or tagCo.notAddLink == 0)
end

return SkillHelper
