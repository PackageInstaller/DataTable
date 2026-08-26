-- chunkname: @modules/logic/character/view/destiny/SkillDescComp.lua

module("modules.logic.character.view.destiny.SkillDescComp", package.seeall)

local SkillDescComp = class("SkillDescComp", LuaCompBase)
local placeholder = "SkillDescComp"
local skillTypeColor
local richTextList = {}
local replaceRichText = "▩rich_replace▩"
local replaceRichIndex = 0
local bracketTextList = {}
local BRACKETTextList = {}
local replaceBracketText = "▩bracket_replace▩"
local replaceBRACKETText = "▩BRACKET_replace▩"
local replaceBracketIndex = 0
local replaceBRACKETIndex = 0

function SkillDescComp:init(go)
	self.viewGO = go
end

function SkillDescComp:updateInfo(txtComp, desc, heroId)
	self.heroMo = HeroModel.instance:getByHeroId(heroId)

	if not self.heroMo then
		self.heroMo = HeroMo.New()

		local config = HeroConfig.instance:getHeroCO(self._heroId)

		self.heroMo:init({}, config)

		self.heroMo.passiveSkillLevel = {}

		for i = 1, 3 do
			table.insert(self.heroMo.passiveSkillLevel, i)
		end
	end

	self._txtComp = txtComp
	self._heroId = heroId

	if self._skillNameList ~= nil then
		tabletool.clear(self._skillNameList)
	end

	desc = self:_replaceSkillTag(desc, "▩(%d+)%%s")
	desc = self:addLink(desc)
	desc = self:filterBracketText(desc)
	desc = self:addNumColor(desc)
	desc = self:revertBracketText(desc)
	desc = self:_revertSkillName(desc, 1)
	self._hyperLinkClick = gohelper.onceAddComponent(self.viewGO, typeof(ZProj.TMPHyperLinkClick))

	self._hyperLinkClick:SetClickListener(self._onHyperLinkClick, self)

	self._txtComp.text = desc
	self._fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(self.viewGO.gameObject, FixTmpBreakLine)

	self._fixTmpBreakLine:refreshTmpContent(self.viewGO)
end

function SkillDescComp:setTipParam(skillTipAnchorX, buffTipAnchor)
	self._skillTipAnchorX = skillTipAnchorX
	self._buffTipAnchor = buffTipAnchor
end

function SkillDescComp:setBuffTipPivot(pivot)
	self._buffTipPivot = pivot
end

function SkillDescComp:_replaceSkillTag(desc, pattern)
	local startIndex, _, skillIndex = string.find(desc, pattern)

	if not startIndex then
		return desc
	end

	skillIndex = tonumber(skillIndex)

	local skillId, extraSkillIndex, specialSkillId

	if skillIndex == 0 then
		skillId = SkillConfig.instance:getpassiveskillsCO(self._heroId)[1].skillPassive
	else
		self._deviceMo = SkillConfig.instance:getHeroDeviceMO(self._heroId, self.heroMo)

		if self._deviceMo then
			local index = 1

			if skillIndex > 10 then
				local _tempIndex = skillIndex

				skillIndex = _tempIndex % 10
				index = math.floor(_tempIndex / 10)
			end

			skillId = self._deviceMo:getSkillId(skillIndex, index)
			specialSkillId = skillId
		else
			local _, _, _skillIndex = string.find(desc, "▩%d%%s<(%d)>")
			local skillIds = SkillConfig.instance:getHeroAllSkillIdDictByExSkillLevel(self._heroId, nil, self.heroMo, nil, true)
			local skillChoice = SkillConfig.instance:getFightCardChoice(skillIds[skillIndex])

			if _skillIndex and skillChoice then
				extraSkillIndex = tonumber(_skillIndex)
				skillId = skillChoice[extraSkillIndex][skillIndex]
			else
				skillId = skillIds[skillIndex][1]
			end
		end
	end

	if not skillId then
		logError("没找到当前角色的技能：heroId:" .. self._heroId .. "  skillindex:" .. skillIndex)

		return desc
	end

	local skillName = lua_skill.configDict[skillId].name
	local foramt = "<color=%s><link=\"skillIndex=%s|extraSkillIndex=%s|specialSkillId={%s}\">【%s】</link></color>"
	local _skillName = skillName and string.format(foramt, self:getLinkColor(), skillIndex, extraSkillIndex or -1, specialSkillId or -1, skillName) or ""

	self._skillNameList = self._skillNameList or {}

	table.insert(self._skillNameList, _skillName)

	desc = string.gsub(desc, pattern, placeholder, 1)

	if extraSkillIndex then
		desc = string.gsub(desc, "<%d>", "", 1)
	end

	return self:_replaceSkillTag(desc, pattern)
end

function SkillDescComp:_revertSkillName(desc, index)
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

function SkillDescComp:addLink(desc)
	skillTypeColor = self:getLinkColor()
	desc = string.gsub(desc, "%[(.-)%]", self.addLinkCb1)
	desc = string.gsub(desc, "【(.-)】", self.addLinkCb2)
	skillTypeColor = nil

	return desc
end

local function getBuffLink(format, skillName)
	local co = SkillConfig.instance:getSkillEffectDescCoByName(skillName)

	skillName = SkillHelper.removeRichTag(skillName)

	if not co then
		return skillName
	end

	local color = skillTypeColor

	if not co.notAddLink or co.notAddLink == 0 then
		skillName = string.format("<u><link=%s>%s</link></u>", co.id, skillName)
	end

	skillName = string.format(format, skillName)

	return string.format("<color=%s>%s</color>", color, skillName)
end

function SkillDescComp.addLinkCb1(skillName)
	local format = "[%s]"

	return getBuffLink(format, skillName)
end

function SkillDescComp.addLinkCb2(skillName)
	local format = "【%s】"

	return getBuffLink(format, skillName)
end

function SkillDescComp:addNumColor(desc)
	desc = self:filterRichText(desc)

	local colorFormat = SkillHelper.getColorFormat(self:getNumberColor(), "%1")

	desc = string.gsub(desc, "[+-]?[%d%./%%]+", colorFormat)
	desc = self:revertRichText(desc)

	return desc
end

function SkillDescComp:getNumberColor()
	return self._numColor or "#deaa79"
end

function SkillDescComp:setNumberColor(color)
	self._numColor = color
end

function SkillDescComp:getLinkColor()
	return self._linkColor or "#7e99d0"
end

function SkillDescComp:setLinkColor(color)
	self._linkColor = color
end

function SkillDescComp:filterRichText(desc)
	tabletool.clear(richTextList)

	desc = string.gsub(desc, "(<.->)", self._filterRichText)

	return desc
end

function SkillDescComp._filterRichText(richText)
	table.insert(richTextList, richText)

	return replaceRichText
end

function SkillDescComp:revertRichText(desc)
	replaceRichIndex = 0
	desc = string.gsub(desc, replaceRichText, self._revertRichText)

	tabletool.clear(richTextList)

	return desc
end

function SkillDescComp._revertRichText(text)
	replaceRichIndex = replaceRichIndex + 1

	return richTextList[replaceRichIndex] or ""
end

function SkillDescComp:filterBracketText(desc)
	tabletool.clear(bracketTextList)
	tabletool.clear(BRACKETTextList)

	desc = string.gsub(desc, "【.-】", self._filterBRACKETText)
	desc = string.gsub(desc, "%[.-%]", self._filterBracketText)

	return desc
end

function SkillDescComp._filterBracketText(richText)
	table.insert(bracketTextList, richText)

	return replaceBracketText
end

function SkillDescComp._filterBRACKETText(richText)
	table.insert(BRACKETTextList, richText)

	return replaceBRACKETText
end

function SkillDescComp:revertBracketText(desc)
	replaceBracketIndex = 0
	replaceBRACKETIndex = 0
	desc = string.gsub(desc, replaceBRACKETText, self._reverBRACKETText)
	desc = string.gsub(desc, replaceBracketText, self._reverBracketText)

	tabletool.clear(bracketTextList)
	tabletool.clear(BRACKETTextList)

	return desc
end

function SkillDescComp._reverBracketText(text)
	replaceBracketIndex = replaceBracketIndex + 1

	return bracketTextList[replaceBracketIndex] or ""
end

function SkillDescComp._reverBRACKETText(text)
	replaceBRACKETIndex = replaceBRACKETIndex + 1

	return BRACKETTextList[replaceBRACKETIndex] or ""
end

function SkillDescComp:_onHyperLinkClick(data, clickPosition)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	local skillIndex, extraSkillIndex, specialSkillId = string.match(data, "skillIndex=(.-)|extraSkillIndex=(.-)|specialSkillId={(.-)}")

	skillIndex = skillIndex and tonumber(skillIndex)

	if not skillIndex then
		CommonBuffTipController.instance:openCommonTipViewWithCustomPos(tonumber(data), self._buffTipAnchor or CommonBuffTipEnum.Anchor[ViewName.CharacterExSkillView], self._buffTipPivot or CommonBuffTipEnum.Pivot.Right, nil, 1)
	elseif skillIndex == 0 then
		local info = {}

		info.tag = "passiveskill"
		info.heroid = self._heroId
		info.tipPos = Vector2.New(-292, -51.1)
		info.anchorParams = {
			Vector2.New(1, 0.5),
			Vector2.New(1, 0.5)
		}
		info.buffTipsX = -776
		info.heroMo = self.heroMo
		info.defaultVNP = 1

		CharacterController.instance:openCharacterTipView(info)
	else
		local info = {}
		local skillDict = SkillConfig.instance:getHeroAllSkillIdDictByExSkillLevel(self._heroId, nil, self.heroMo, nil, true)
		local skillIds = skillDict[skillIndex]

		if extraSkillIndex then
			extraSkillIndex = tonumber(extraSkillIndex)

			if extraSkillIndex ~= -1 then
				local skillChoice = SkillConfig.instance:getFightCardChoice(skillDict[skillIndex])

				if skillChoice then
					skillIds = skillChoice[extraSkillIndex]
				end
			end
		end

		if specialSkillId then
			specialSkillId = tonumber(specialSkillId)

			if specialSkillId ~= -1 then
				skillIds = {
					specialSkillId
				}
			end
		end

		info.super = skillIndex == 3
		info.skillIdList = skillIds
		info.monsterName = HeroConfig.instance:getHeroCO(self._heroId).name
		info.anchorX = self._skillTipAnchorX
		info.heroMo = self.heroMo

		ViewMgr.instance:openView(ViewName.SkillTipView, info)
	end
end

return SkillDescComp
