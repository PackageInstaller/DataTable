-- chunkname: @modules/logic/character/view/CharacterSkillDescripte.lua

module("modules.logic.character.view.CharacterSkillDescripte", package.seeall)

local CharacterSkillDescripte = class("CharacterSkillDescripte", BaseChildView)

function CharacterSkillDescripte:onInitView()
	self._txtlv = gohelper.findChildText(self.viewGO, "#txt_skillevel")
	self._goCurlevel = gohelper.findChild(self.viewGO, "#go_curlevel")
	self._txtskillDesc = gohelper.findChildText(self.viewGO, "#txt_descripte")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterSkillDescripte:addEvents()
	return
end

function CharacterSkillDescripte:removeEvents()
	return
end

function CharacterSkillDescripte:_editableInitView()
	self.canvasGroup = gohelper.onceAddComponent(self._txtskillDesc.gameObject, gohelper.Type_CanvasGroup)
	self.txtlvcanvasGroup = gohelper.onceAddComponent(self._txtlv.gameObject, gohelper.Type_CanvasGroup)
	self.govx = gohelper.findChild(self.viewGO, "vx")

	gohelper.setActive(self.govx, false)

	self.vxAni = self.govx:GetComponent(typeof(UnityEngine.Animation))
	self.aniLength = self.vxAni.clip.length
end

function CharacterSkillDescripte:onUpdateParam()
	return
end

CharacterSkillDescripte.skillNameDesc = "CharacterSkillDescripte_skillNameDesc"

function CharacterSkillDescripte:updateInfo(parentView, heroId, exSkillLevel, nowLevel, fromHeroDetailView)
	self.parentView = parentView

	local exCo = SkillConfig.instance:getherolevelexskillCO(heroId, exSkillLevel)

	self._txtlv.text = exSkillLevel
	self._needUseSkillEffDescList = {}
	self._needUseSkillEffDescList2 = {}

	local desc, skillName, skillIndex, choiceSkillMatchInfos = SkillConfig.instance:getExSkillDesc(exCo)

	self._skillIndex = skillIndex
	self._choiceSkillMatchInfos = choiceSkillMatchInfos
	self._heroId = heroId
	desc = self:_isChoiceSkill() and string.gsub(desc, "▩%d%%s<%d>", CharacterSkillDescripte.skillNameDesc) or string.gsub(desc, "▩(%d)%%s", CharacterSkillDescripte.skillNameDesc)
	desc = SkillHelper.addLink(desc)
	desc = self:addNumColor(desc)
	desc = SkillHelper.addBracketColor(desc, "#7e99d0")

	if self:_isChoiceSkill() then
		for i = 1, #choiceSkillMatchInfos do
			local info = choiceSkillMatchInfos[i]
			local skillNameDesc = self:_buildChioceSkillNameLinkTag(info.skillName, info.choiceSkillIndex)

			desc = string.gsub(desc, CharacterSkillDescripte.skillNameDesc, skillNameDesc, 1)
		end
	else
		local skillNameDesc = self:_buildSkillNameLinkTag(skillName)

		desc = string.gsub(desc, CharacterSkillDescripte.skillNameDesc, skillNameDesc)
	end

	gohelper.setActive(self._goCurlevel, not fromHeroDetailView and nowLevel + 1 == exSkillLevel)

	self.canvasGroup.alpha = nowLevel < exSkillLevel and 0.5 or 1
	self.txtlvcanvasGroup.alpha = nowLevel < exSkillLevel and 0.5 or 1
	self._hyperLinkClick = self._txtskillDesc:GetComponent(typeof(ZProj.TMPHyperLinkClick))

	self._hyperLinkClick:SetClickListener(self._onHyperLinkClick, self)

	local height = GameUtil.getTextHeightByLine(self._txtskillDesc, desc, 28, -3)

	height = height + 54

	recthelper.setHeight(self.viewGO.transform, height)

	self._txtskillDesc.text = desc
	self._fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(self._txtskillDesc.gameObject, FixTmpBreakLine)

	self._fixTmpBreakLine:refreshTmpContent(self._txtskillDesc)

	return height
end

function CharacterSkillDescripte:_isChoiceSkill()
	return self._choiceSkillMatchInfos and #self._choiceSkillMatchInfos > 0
end

function CharacterSkillDescripte:addNumColor(desc)
	desc = self:filterRichText(desc)

	local colorFormat = SkillHelper.getColorFormat("#deaa79", "%1")

	desc = string.gsub(desc, "[+-]?[%d%./%%]+", colorFormat)
	desc = self:revertRichText(desc)

	return desc
end

function CharacterSkillDescripte.replaceColorFunc(text)
	if string.find(text, "[<>]") then
		return text
	end
end

CharacterSkillDescripte.richTextList = {}
CharacterSkillDescripte.replaceText = "▩replace▩"
CharacterSkillDescripte.replaceIndex = 0

function CharacterSkillDescripte:filterRichText(desc)
	tabletool.clear(CharacterSkillDescripte.richTextList)

	desc = string.gsub(desc, "(<.->)", self._filterRichText)

	return desc
end

function CharacterSkillDescripte._filterRichText(richText)
	table.insert(CharacterSkillDescripte.richTextList, richText)

	return CharacterSkillDescripte.replaceText
end

function CharacterSkillDescripte:revertRichText(desc)
	CharacterSkillDescripte.replaceIndex = 0
	desc = string.gsub(desc, CharacterSkillDescripte.replaceText, self._revertRichText)

	tabletool.clear(CharacterSkillDescripte.richTextList)

	return desc
end

function CharacterSkillDescripte._revertRichText(text)
	CharacterSkillDescripte.replaceIndex = CharacterSkillDescripte.replaceIndex + 1

	return CharacterSkillDescripte.richTextList[CharacterSkillDescripte.replaceIndex] or ""
end

function CharacterSkillDescripte:_onHyperLinkClick(data, clickPosition)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	local _, _, choiceIndex = string.find(data, "skillIndex_(%d)")

	if data ~= "skillIndex" and not choiceIndex then
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
		info.showAttributeOption = self.parentView:getShowAttributeOption()
		info.heroMo = self.parentView.viewParam.heroMo

		CharacterController.instance:openCharacterTipView(info)
	else
		local info = {}
		local skillDict = SkillConfig.instance:getHeroAllSkillIdDictByExSkillLevel(self._heroId, self.parentView:getShowAttributeOption(), self.parentView.viewParam.heroMo, nil, true)

		info.super = self._skillIndex == 3

		local skillIdList = skillDict[self._skillIndex]

		if self:_isChoiceSkill() then
			if choiceIndex then
				choiceIndex = tonumber(choiceIndex)

				local _skillIdList = {}

				for _, skillId in ipairs(skillIdList) do
					local _skillId = SkillConfig.instance:getFightCardChoiceSkillIdByIndex(skillId, choiceIndex)

					if _skillId then
						table.insert(_skillIdList, _skillId)
					end
				end

				info.skillIdList = _skillIdList
			else
				info.skillIdList = skillIdList
			end
		else
			info.skillIdList = skillIdList
		end

		info.monsterName = HeroConfig.instance:getHeroCO(self._heroId).name
		info.heroMo = self.parentView.viewParam.heroMo

		ViewMgr.instance:openView(ViewName.SkillTipView, info)
	end
end

function CharacterSkillDescripte:_buildSkillNameLinkTag(skillName)
	return (string.format("<link=\"skillIndex\"><color=#7e99d0>【%s】</color></link>", skillName))
end

function CharacterSkillDescripte:_buildChioceSkillNameLinkTag(skillName, choiceIndex)
	return (string.format("<link=\"skillIndex_%s\"><color=#7e99d0>【%s】</color></link>", choiceIndex, skillName))
end

function CharacterSkillDescripte:playHeroExSkillUPAnimation()
	gohelper.setActive(self.govx, true)
	TaskDispatcher.runDelay(self.onAnimationDone, self, self.aniLength)
end

function CharacterSkillDescripte:onAnimationDone()
	gohelper.setActive(self.govx, false)
end

function CharacterSkillDescripte:jumpAnimation()
	local normalizedTime = 0.782608695652174

	TaskDispatcher.cancelTask(self.onAnimationDone, self)
	TaskDispatcher.runDelay(self.onAnimationDone, self, self.aniLength * (1 - normalizedTime))
	ZProj.GameHelper.SetAnimationStateNormalizedTime(self.vxAni, "item_vx_in", normalizedTime)
end

function CharacterSkillDescripte:onOpen()
	return
end

function CharacterSkillDescripte:onClose()
	TaskDispatcher.cancelTask(self.onAnimationDone, self)
	self.vxAni:Stop()
end

function CharacterSkillDescripte:onDestroyView()
	return
end

return CharacterSkillDescripte
