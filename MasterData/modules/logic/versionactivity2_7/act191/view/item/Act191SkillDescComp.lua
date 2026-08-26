-- chunkname: @modules/logic/versionactivity2_7/act191/view/item/Act191SkillDescComp.lua

module("modules.logic.versionactivity2_7.act191.view.item.Act191SkillDescComp", package.seeall)

local Act191SkillDescComp = class("Act191SkillDescComp", LuaCompBase)
local placeholder = "SkillDescComp"
local skillTypeColor = "#7e99d0"

function Act191SkillDescComp:init(go)
	self.viewGO = go
end

function Act191SkillDescComp:updateInfo(txtComp, desc, config)
	self._txtComp = txtComp
	self._config = config

	if self._skillNameList ~= nil then
		tabletool.clear(self._skillNameList)
	end

	desc = self:_replaceSkillTag(desc, "▩(%d)%%s")
	desc = self:addLink(desc)
	desc = self:addNumColor(desc)
	desc = self:_revertSkillName(desc, 1)
	self._hyperLinkClick = gohelper.onceAddComponent(self.viewGO, typeof(ZProj.TMPHyperLinkClick))

	self._hyperLinkClick:SetClickListener(self._onHyperLinkClick, self)

	self._txtComp.text = desc
	self._fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(self.viewGO.gameObject, FixTmpBreakLine)

	self._fixTmpBreakLine:refreshTmpContent(self.viewGO)
end

function Act191SkillDescComp:setTipParam(skillTipAnchorX, buffTipAnchor)
	self._skillTipAnchorX = skillTipAnchorX
	self._buffTipAnchor = buffTipAnchor
end

function Act191SkillDescComp:_replaceSkillTag(desc, pattern)
	local startIndex, _, skillIndex = string.find(desc, pattern)

	if not startIndex then
		return desc
	end

	skillIndex = tonumber(skillIndex)

	local skillId = skillIndex == 0 and Activity191Config.instance:getHeroPassiveSkillIdList(self._config.id)[1] or Activity191Config.instance:getHeroSkillIdDic(self._config.id, true)[skillIndex]

	if not skillId then
		logError("没找到当前角色的技能：heroId:" .. self._config.id .. "  skillindex:" .. skillIndex)

		return desc
	end

	local skillName = lua_skill.configDict[skillId].name
	local foramt = "<color=%s><link=\"skillIndex=%s\">【%s】</link></color>"
	local _skillName = skillName and string.format(foramt, skillTypeColor, skillIndex, skillName) or ""

	self._skillNameList = self._skillNameList or {}

	table.insert(self._skillNameList, _skillName)

	desc = string.gsub(desc, pattern, placeholder, 1)

	return self:_replaceSkillTag(desc, pattern)
end

function Act191SkillDescComp:_revertSkillName(desc, index)
	local startIndex = string.find(desc, placeholder)

	if not startIndex then
		return desc
	end

	local skillName = self._skillNameList[index]

	if not skillName then
		return desc
	end

	desc = string.gsub(desc, placeholder, skillName, 1)

	return self:_revertSkillName(desc, index + 1)
end

function Act191SkillDescComp:addLink(desc)
	desc = string.gsub(desc, "%[(.-)%]", self.addLinkCb1)
	desc = string.gsub(desc, "【(.-)】", self.addLinkCb2)

	return desc
end

local function getBuffLink(format, skillName)
	local co = SkillConfig.instance:getSkillEffectDescCoByName(skillName)

	skillName = SkillHelper.removeRichTag(skillName)

	if not co then
		return skillName
	end

	local color = skillTypeColor

	skillName = string.format(format, skillName)

	if not co.notAddLink or co.notAddLink == 0 then
		return string.format("<color=%s><u><link=%s>%s</link></u></color>", color, co.id, skillName)
	end

	return string.format("<color=%s>%s</color>", color, skillName)
end

function Act191SkillDescComp.addLinkCb1(skillName)
	local format = "[%s]"

	return getBuffLink(format, skillName)
end

function Act191SkillDescComp.addLinkCb2(skillName)
	local format = "【%s】"

	return getBuffLink(format, skillName)
end

function Act191SkillDescComp:addNumColor(desc)
	desc = self:filterRichText(desc)

	local colorFormat = SkillHelper.getColorFormat("#deaa79", "%1")

	desc = string.gsub(desc, "[+-]?[%d%./%%]+", colorFormat)
	desc = self:revertRichText(desc)

	return desc
end

function Act191SkillDescComp.replaceColorFunc(text)
	if string.find(text, "[<>]") then
		return text
	end
end

Act191SkillDescComp.richTextList = {}
Act191SkillDescComp.replaceText = "▩replace▩"
Act191SkillDescComp.replaceIndex = 0

function Act191SkillDescComp:filterRichText(desc)
	tabletool.clear(Act191SkillDescComp.richTextList)

	desc = string.gsub(desc, "(<.->)", self._filterRichText)

	return desc
end

function Act191SkillDescComp._filterRichText(richText)
	table.insert(Act191SkillDescComp.richTextList, richText)

	return Act191SkillDescComp.replaceText
end

function Act191SkillDescComp:revertRichText(desc)
	Act191SkillDescComp.replaceIndex = 0
	desc = string.gsub(desc, Act191SkillDescComp.replaceText, self._revertRichText)

	tabletool.clear(Act191SkillDescComp.richTextList)

	return desc
end

function Act191SkillDescComp._revertRichText(text)
	Act191SkillDescComp.replaceIndex = Act191SkillDescComp.replaceIndex + 1

	return Act191SkillDescComp.richTextList[Act191SkillDescComp.replaceIndex] or ""
end

function Act191SkillDescComp:_onHyperLinkClick(data, clickPosition)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	local skillIndex = string.match(data, "skillIndex=(%d)")

	skillIndex = skillIndex and tonumber(skillIndex)

	if not skillIndex then
		CommonBuffTipController.instance:openCommonTipViewWithCustomPos(tonumber(data), (not self._buffTipAnchor or nil) and CommonBuffTipEnum.Anchor[ViewName.CharacterExSkillView], CommonBuffTipEnum.Pivot.Right)
	elseif skillIndex == 0 then
		local info = {}

		info.tag = "passiveskill"
		info.id = self._config.id
		info.tipPos = Vector2.New(-292, -51.1)
		info.anchorParams = {
			Vector2.New(1, 0.5),
			Vector2.New(1, 0.5)
		}
		info.buffTipsX = -776

		ViewMgr.instance:openView(ViewName.Act191CharacterTipView, info)
	else
		local info = {}
		local skillDict = Activity191Config.instance:getHeroSkillIdDic(self._config.id)

		info.super = skillIndex == 3
		info.skillIdList = skillDict[skillIndex]
		info.monsterName = self._config.name
		info.heroId = self._config.roleId
		info.anchorX = self._skillTipAnchorX

		ViewMgr.instance:openView(ViewName.SkillTipView, info)
	end
end

return Act191SkillDescComp
