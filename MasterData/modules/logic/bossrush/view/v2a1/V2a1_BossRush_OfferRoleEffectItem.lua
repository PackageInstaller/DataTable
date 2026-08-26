-- chunkname: @modules/logic/bossrush/view/v2a1/V2a1_BossRush_OfferRoleEffectItem.lua

module("modules.logic.bossrush.view.v2a1.V2a1_BossRush_OfferRoleEffectItem", package.seeall)

local V2a1_BossRush_OfferRoleEffectItem = class("V2a1_BossRush_OfferRoleEffectItem", BaseChildView)

function V2a1_BossRush_OfferRoleEffectItem:onInitView()
	self._goline = gohelper.findChild(self.viewGO, "image_Line")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a1_BossRush_OfferRoleEffectItem:addEvents()
	return
end

function V2a1_BossRush_OfferRoleEffectItem:removeEvents()
	return
end

function V2a1_BossRush_OfferRoleEffectItem:_editableInitView()
	self._txt = self.viewGO:GetComponent(gohelper.Type_TextMesh)
end

local placeholder = "OfferRoleEffectItem_skillNameDesc"

function V2a1_BossRush_OfferRoleEffectItem:activeLine(isActive)
	gohelper.setActive(self._goline, isActive)
end

function V2a1_BossRush_OfferRoleEffectItem:updateInfo(parentView, desc, heroId)
	self.parentView = parentView
	self._needUseSkillEffDescList = {}
	self._needUseSkillEffDescList2 = {}
	self._heroId = heroId

	local _, skillName, skillIndex = self:_parseDesc(desc)

	self._skillIndex = skillIndex
	desc = self:addLink(desc)
	desc = string.gsub(desc, "▩(%d)%%s", placeholder)
	desc = self:addNumColor(desc)

	local skillNameDesc = self:_buildSkillNameLinkTag(skillName)

	desc = string.gsub(desc, placeholder, skillNameDesc)
	self._hyperLinkClick = self.viewGO:GetComponent(typeof(ZProj.TMPHyperLinkClick))

	self._hyperLinkClick:SetClickListener(self._onHyperLinkClick, self)

	self._txt.text = desc
	self._fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(self.viewGO.gameObject, FixTmpBreakLine)

	self._fixTmpBreakLine:refreshTmpContent(self.viewGO)
end

function V2a1_BossRush_OfferRoleEffectItem:_parseDesc(desc)
	local _, _, skillIndex = string.find(desc, "▩(%d)%%s")

	if not skillIndex then
		return desc
	end

	skillIndex = tonumber(skillIndex)

	local skillId = skillIndex == 0 and SkillConfig.instance:getpassiveskillsCO(self._heroId)[1].skillPassive or SkillConfig.instance:getHeroBaseSkillIdDict(self._heroId)[skillIndex]

	if not skillId then
		return desc
	end

	local skillName = lua_skill.configDict[skillId].name

	return desc, skillName, skillIndex
end

local skillTypeColor = "#7e99d0"

function V2a1_BossRush_OfferRoleEffectItem:_buildSkillNameLinkTag(skillName)
	local color = skillTypeColor

	return skillName and string.format("<color=%s><link=\"skillIndex\">【%s】</link></color>", color, skillName) or ""
end

function V2a1_BossRush_OfferRoleEffectItem:addLink(desc)
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

function V2a1_BossRush_OfferRoleEffectItem.addLinkCb1(skillName)
	local format = "[%s]"

	return getBuffLink(format, skillName)
end

function V2a1_BossRush_OfferRoleEffectItem.addLinkCb2(skillName)
	local format = "【%s】"

	return getBuffLink(format, skillName)
end

function V2a1_BossRush_OfferRoleEffectItem:addNumColor(desc)
	desc = self:filterRichText(desc)

	local colorFormat = SkillHelper.getColorFormat("#deaa79", "%1")

	desc = string.gsub(desc, "[+-]?[%d%./%%]+", colorFormat)
	desc = self:revertRichText(desc)

	return desc
end

function V2a1_BossRush_OfferRoleEffectItem.replaceColorFunc(text)
	if string.find(text, "[<>]") then
		return text
	end
end

V2a1_BossRush_OfferRoleEffectItem.richTextList = {}
V2a1_BossRush_OfferRoleEffectItem.replaceText = "▩replace▩"
V2a1_BossRush_OfferRoleEffectItem.replaceIndex = 0

function V2a1_BossRush_OfferRoleEffectItem:filterRichText(desc)
	tabletool.clear(V2a1_BossRush_OfferRoleEffectItem.richTextList)

	desc = string.gsub(desc, "(<.->)", self._filterRichText)

	return desc
end

function V2a1_BossRush_OfferRoleEffectItem._filterRichText(richText)
	table.insert(V2a1_BossRush_OfferRoleEffectItem.richTextList, richText)

	return V2a1_BossRush_OfferRoleEffectItem.replaceText
end

function V2a1_BossRush_OfferRoleEffectItem:revertRichText(desc)
	V2a1_BossRush_OfferRoleEffectItem.replaceIndex = 0
	desc = string.gsub(desc, V2a1_BossRush_OfferRoleEffectItem.replaceText, self._revertRichText)

	tabletool.clear(V2a1_BossRush_OfferRoleEffectItem.richTextList)

	return desc
end

function V2a1_BossRush_OfferRoleEffectItem._revertRichText(text)
	V2a1_BossRush_OfferRoleEffectItem.replaceIndex = V2a1_BossRush_OfferRoleEffectItem.replaceIndex + 1

	return V2a1_BossRush_OfferRoleEffectItem.richTextList[V2a1_BossRush_OfferRoleEffectItem.replaceIndex] or ""
end

function V2a1_BossRush_OfferRoleEffectItem:_onHyperLinkClick(data, clickPosition)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if data ~= "skillIndex" then
		CommonBuffTipController.instance:openCommonTipViewWithCustomPos(tonumber(data), CommonBuffTipEnum.Anchor[ViewName.CharacterExSkillView], CommonBuffTipEnum.Pivot.Right)
	elseif self._skillIndex == 0 then
		local info = {}

		info.tag = "passiveskill"
		info.heroid = self._heroId
		info.tipPos = Vector2.New(-292, -51.1)
		info.anchorParams = {
			Vector2.New(1, 0.5),
			Vector2.New(1, 0.5)
		}
		info.buffTipsX = -776

		local heroMo = HeroMo.New()
		local config = HeroConfig.instance:getHeroCO(self._heroId)

		heroMo:init(info, config)

		heroMo.passiveSkillLevel = {}

		for i = 1, 3 do
			table.insert(heroMo.passiveSkillLevel, i)
		end

		info.heroMo = heroMo

		CharacterController.instance:openCharacterTipView(info)
	else
		local info = {}
		local skillDict = SkillConfig.instance:getHeroAllSkillIdDictByExSkillLevel(self._heroId)

		info.super = self._skillIndex == 3
		info.skillIdList = skillDict[self._skillIndex]
		info.monsterName = HeroConfig.instance:getHeroCO(self._heroId).name
		info.anchorX = -500

		ViewMgr.instance:openView(ViewName.SkillTipView, info)
	end
end

function V2a1_BossRush_OfferRoleEffectItem:onOpen()
	return
end

function V2a1_BossRush_OfferRoleEffectItem:onClose()
	return
end

function V2a1_BossRush_OfferRoleEffectItem:onDestroyView()
	return
end

return V2a1_BossRush_OfferRoleEffectItem
