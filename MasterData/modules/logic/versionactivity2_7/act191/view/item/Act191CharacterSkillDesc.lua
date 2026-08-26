-- chunkname: @modules/logic/versionactivity2_7/act191/view/item/Act191CharacterSkillDesc.lua

module("modules.logic.versionactivity2_7.act191.view.item.Act191CharacterSkillDesc", package.seeall)

local Act191CharacterSkillDesc = class("Act191CharacterSkillDesc", BaseChildView)

function Act191CharacterSkillDesc:onInitView()
	self._txtlv = gohelper.findChildText(self.viewGO, "#txt_skillevel")
	self._goCurlevel = gohelper.findChild(self.viewGO, "#go_curlevel")
	self._txtskillDesc = gohelper.findChildText(self.viewGO, "#txt_descripte")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act191CharacterSkillDesc:addEvents()
	return
end

function Act191CharacterSkillDesc:removeEvents()
	return
end

function Act191CharacterSkillDesc:_editableInitView()
	self.canvasGroup = gohelper.onceAddComponent(self._txtskillDesc.gameObject, gohelper.Type_CanvasGroup)
	self.txtlvcanvasGroup = gohelper.onceAddComponent(self._txtlv.gameObject, gohelper.Type_CanvasGroup)
	self.govx = gohelper.findChild(self.viewGO, "vx")

	gohelper.setActive(self.govx, false)

	self.vxAni = self.govx:GetComponent(typeof(UnityEngine.Animation))
	self.aniLength = self.vxAni.clip.length
end

function Act191CharacterSkillDesc:onUpdateParam()
	return
end

function Act191CharacterSkillDesc:updateInfo(parentView, config, exSkillLevel)
	self.config = config

	local nowLevel = self.config.exLevel

	self.parentView = parentView

	local exCo = Activity191Config.instance:getHeroLevelExSkillCo(self.config.id, exSkillLevel)

	self._txtlv.text = exSkillLevel
	self._needUseSkillEffDescList = {}
	self._needUseSkillEffDescList2 = {}

	local desc, skillName, skillIndex = Activity191Config.instance:getExSkillDesc(exCo, self.config.id)

	self._skillIndex = skillIndex
	desc = string.gsub(desc, "▩(%d)%%s", "CharacterSkillDescripte_skillNameDesc")
	desc = SkillHelper.addLink(desc)
	desc = self:addNumColor(desc)
	desc = SkillHelper.addBracketColor(desc, "#7e99d0")

	local skillNameDesc = self:_buildSkillNameLinkTag(skillName)

	desc = string.gsub(desc, "CharacterSkillDescripte_skillNameDesc", skillNameDesc)

	gohelper.setActive(self._goCurlevel, false)

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

function Act191CharacterSkillDesc:addNumColor(desc)
	desc = self:filterRichText(desc)

	local colorFormat = SkillHelper.getColorFormat("#deaa79", "%1")

	desc = string.gsub(desc, "[+-]?[%d%./%%]+", colorFormat)
	desc = self:revertRichText(desc)

	return desc
end

function Act191CharacterSkillDesc.replaceColorFunc(text)
	if string.find(text, "[<>]") then
		return text
	end
end

Act191CharacterSkillDesc.richTextList = {}
Act191CharacterSkillDesc.replaceText = "▩replace▩"
Act191CharacterSkillDesc.replaceIndex = 0

function Act191CharacterSkillDesc:filterRichText(desc)
	tabletool.clear(Act191CharacterSkillDesc.richTextList)

	desc = string.gsub(desc, "(<.->)", self._filterRichText)

	return desc
end

function Act191CharacterSkillDesc._filterRichText(richText)
	table.insert(Act191CharacterSkillDesc.richTextList, richText)

	return Act191CharacterSkillDesc.replaceText
end

function Act191CharacterSkillDesc:revertRichText(desc)
	Act191CharacterSkillDesc.replaceIndex = 0
	desc = string.gsub(desc, Act191CharacterSkillDesc.replaceText, self._revertRichText)

	tabletool.clear(Act191CharacterSkillDesc.richTextList)

	return desc
end

function Act191CharacterSkillDesc._revertRichText(text)
	Act191CharacterSkillDesc.replaceIndex = Act191CharacterSkillDesc.replaceIndex + 1

	return Act191CharacterSkillDesc.richTextList[Act191CharacterSkillDesc.replaceIndex] or ""
end

function Act191CharacterSkillDesc:_onHyperLinkClick(data, clickPosition)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if data ~= "skillIndex" then
		CommonBuffTipController.instance:openCommonTipViewWithCustomPos(tonumber(data), CommonBuffTipEnum.Anchor[ViewName.CharacterExSkillView], CommonBuffTipEnum.Pivot.Right)
	elseif self._skillIndex == 0 then
		if self.config.type == Activity191Enum.CharacterType.Hero then
			local info = {}

			info.id = self.config.id
			info.tipPos = Vector2.New(-292, -51.1)
			info.anchorParams = {
				Vector2.New(1, 0.5),
				Vector2.New(1, 0.5)
			}
			info.buffTipsX = -776

			ViewMgr.instance:openView(ViewName.Act191CharacterTipView, info)
		end
	else
		local info = {}
		local skillDict = Activity191Config.instance:getHeroSkillIdDic(self.config.id)

		info.super = self._skillIndex == 3
		info.skillIdList = skillDict[self._skillIndex]
		info.monsterName = self.config.name
		info.heroId = self.config.roleId
		info.skillIndex = self._skillIndex

		ViewMgr.instance:openView(ViewName.SkillTipView, info)
	end
end

function Act191CharacterSkillDesc:_buildSkillNameLinkTag(skillName)
	return (string.format("<link=\"skillIndex\"><color=#7e99d0>【%s】</color></link>", skillName))
end

function Act191CharacterSkillDesc:playHeroExSkillUPAnimation()
	gohelper.setActive(self.govx, true)
	TaskDispatcher.runDelay(self.onAnimationDone, self, self.aniLength)
end

function Act191CharacterSkillDesc:onAnimationDone()
	gohelper.setActive(self.govx, false)
end

function Act191CharacterSkillDesc:jumpAnimation()
	local normalizedTime = 0.782608695652174

	TaskDispatcher.cancelTask(self.onAnimationDone, self)
	TaskDispatcher.runDelay(self.onAnimationDone, self, self.aniLength * (1 - normalizedTime))
	ZProj.GameHelper.SetAnimationStateNormalizedTime(self.vxAni, "item_vx_in", normalizedTime)
end

function Act191CharacterSkillDesc:onOpen()
	return
end

function Act191CharacterSkillDesc:onClose()
	TaskDispatcher.cancelTask(self.onAnimationDone, self)
	self.vxAni:Stop()
end

function Act191CharacterSkillDesc:onDestroyView()
	return
end

return Act191CharacterSkillDesc
