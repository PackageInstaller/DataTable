-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191CharacterTipView.lua

module("modules.logic.versionactivity2_7.act191.view.Act191CharacterTipView", package.seeall)

local Act191CharacterTipView = class("Act191CharacterTipView", BaseView)

function Act191CharacterTipView:onInitView()
	self._gopassiveskilltip = gohelper.findChild(self.viewGO, "#go_passiveskilltip")
	self._simageshadow = gohelper.findChildSingleImage(self.viewGO, "#go_passiveskilltip/mask/root/scrollview/#simage_shadow")
	self._goeffectdesc = gohelper.findChild(self.viewGO, "#go_passiveskilltip/mask/root/scrollview/viewport/content/#go_effectdesc")
	self._goeffectdescitem = gohelper.findChild(self.viewGO, "#go_passiveskilltip/mask/root/scrollview/viewport/content/#go_effectdesc/#go_effectdescitem")
	self._scrollview = gohelper.findChildScrollRect(self.viewGO, "#go_passiveskilltip/mask/root/scrollview")
	self._gomask1 = gohelper.findChild(self.viewGO, "#go_passiveskilltip/mask/root/scrollview/#go_mask1")
	self._txtpassivename = gohelper.findChildText(self.viewGO, "#go_passiveskilltip/name/bg/#txt_passivename")
	self._btnclosepassivetip = gohelper.findChildButtonWithAudio(self.viewGO, "#go_passiveskilltip/#btn_closepassivetip")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act191CharacterTipView:addEvents()
	self._btnclosepassivetip:AddClickListener(self._btnclosepassivetipOnClick, self)
end

function Act191CharacterTipView:removeEvents()
	self._btnclosepassivetip:RemoveClickListener()
end

function Act191CharacterTipView:_btnclosepassivetipOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

function Act191CharacterTipView:_editableInitView()
	self._passiveskilltipcontent = gohelper.findChild(self._gopassiveskilltip, "mask/root/scrollview/viewport/content")
	self._passiveskilltipmask = gohelper.findChild(self._gopassiveskilltip, "mask"):GetComponent(typeof(UnityEngine.UI.RectMask2D))

	self._simageshadow:LoadImage(ResUrl.getCharacterIcon("bg_shade"))

	self._passiveskillitems = {}

	for i = 0, 3 do
		local o = self:getUserDataTb_()

		o.go = gohelper.findChild(self._gopassiveskilltip, "mask/root/scrollview/viewport/content/talentstar" .. tostring(i))
		o.desc = gohelper.findChildTextMesh(o.go, "desctxt")
		o.hyperLinkClick = SkillHelper.addHyperLinkClick(o.desc, self._onHyperLinkClick, self)
		o.fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(o.desc.gameObject, FixTmpBreakLine)
		o.on = gohelper.findChild(o.go, "#go_passiveskills/passiveskill/on")
		o.unlocktxt = gohelper.findChildText(o.go, "#go_passiveskills/passiveskill/unlocktxt")
		o.canvasgroup = gohelper.onceAddComponent(o.go, typeof(UnityEngine.CanvasGroup))
		o.connectline = gohelper.findChild(o.go, "line")
		self._passiveskillitems[i] = o
	end

	self._txtpassivename = gohelper.findChildText(self.viewGO, "#go_passiveskilltip/name/bg/#txt_passivename")
	self._skillEffectDescItems = self:getUserDataTb_()
end

function Act191CharacterTipView:onUpdateParam()
	return
end

function Act191CharacterTipView:onOpen()
	local info = self.viewParam

	self.config = Activity191Config.instance:getRoleCo(info.id)

	self:_setPassiveSkill(info.anchorParams, info.tipPos)
end

function Act191CharacterTipView:onClose()
	return
end

function Act191CharacterTipView:onDestroyView()
	return
end

function Act191CharacterTipView:_setPassiveSkill(anchorParams, tipPos)
	self._matchSkillNames = {}

	local skillIds = Activity191Config.instance:getHeroPassiveSkillIdList(self.config.id)

	if self.viewParam.stoneId then
		skillIds = Activity191Helper.replaceSkill(self.viewParam.stoneId, skillIds)
	end

	local firstSkill = skillIds[1]

	self._txtpassivename.text = lua_skill.configDict[firstSkill].name

	local txtTab = {}

	for i, skillId in pairs(skillIds) do
		local skillCo = lua_skill.configDict[skillId]

		txtTab[i] = FightConfig.instance:getSkillEffectDesc(self.config.name, skillCo)
	end

	local matchTxtTab = HeroSkillModel.instance:getSkillEffectTagIdsFormDescTabRecursion(txtTab)
	local tagNameExistDict = {}
	local skillEffectDescTab = {}

	for i = 0, 3 do
		local passiveItem = self._passiveskillitems[i]
		local skillId = skillIds[i]

		if skillId then
			local unlock = true
			local skillCo = lua_skill.configDict[skillId]
			local txt = FightConfig.instance:getSkillEffectDesc(self.config.name, skillCo)

			for _, v in pairs(matchTxtTab[i]) do
				local effectCo = SkillConfig.instance:getSkillEffectDescCo(v)
				local name = effectCo.name
				local canShowSkillTag = HeroSkillModel.instance:canShowSkillTag(name, true)

				if canShowSkillTag and not tagNameExistDict[name] then
					tagNameExistDict[name] = true

					if effectCo.isSpecialCharacter == 1 then
						local desc = effectCo.desc

						txt = string.format("%s", txt)

						local skillEffectDesc = SkillHelper.buildDesc(desc)

						table.insert(skillEffectDescTab, {
							desc = skillEffectDesc,
							title = effectCo.name
						})
					end
				end
			end

			passiveItem.desc.text = SkillHelper.buildDesc(txt)

			local unlockTxt

			if i == 0 then
				unlockTxt = luaLang("character_skill_passive_0")
			else
				local ranknum = self:_getTargetRankByEffect(self.config.roleId, i)

				unlockTxt = string.format(luaLang("character_passive_unlock"), GameUtil.getRomanNums(ranknum))
			end

			passiveItem.unlocktxt.text = unlockTxt

			SLFramework.UGUI.GuiHelper.SetColor(passiveItem.unlocktxt, "#313B33")

			passiveItem.canvasgroup.alpha = unlock and 1 or 0.83

			gohelper.setActive(passiveItem.on, unlock)
			passiveItem.fixTmpBreakLine:refreshTmpContent(passiveItem.desc)
			SLFramework.UGUI.GuiHelper.SetColor(passiveItem.desc, unlock and "#272525" or "#3A3A3A")
			gohelper.setActive(passiveItem.go, true)
			gohelper.setActive(passiveItem.connectline, i ~= #skillIds)
		end

		gohelper.setActive(passiveItem.go, skillId ~= nil)
	end

	self:_showSkillEffectDesc(skillEffectDescTab)
	self:_refreshPassiveSkillScroll()
	self:_setTipPos(self._gopassiveskilltip.transform, tipPos, anchorParams)
end

function Act191CharacterTipView:_getTargetRankByEffect(heroid, skilllv)
	local rankCo = SkillConfig.instance:getheroranksCO(heroid)

	for k, _ in pairs(rankCo) do
		local effect = CharacterModel.instance:getrankEffects(heroid, k)

		if effect[2] == skilllv then
			return k - 1
		end
	end

	return 0
end

function Act191CharacterTipView:_showSkillEffectDesc(skillEffectDescTab)
	gohelper.setActive(self._goeffectdesc, skillEffectDescTab and #skillEffectDescTab > 0)

	for i = 1, #skillEffectDescTab do
		local skillDesc = skillEffectDescTab[i]
		local descItem = self:_getSkillEffectDescItem(i)

		descItem.desc.text = skillDesc.desc
		descItem.title.text = SkillHelper.removeRichTag(skillDesc.title)

		descItem.fixTmpBreakLine:refreshTmpContent(descItem.desc)
		gohelper.setActive(descItem.go, true)
	end

	for i = #skillEffectDescTab + 1, #self._skillEffectDescItems do
		gohelper.setActive(self._passiveskillitems[i].go, false)
	end
end

function Act191CharacterTipView:_getSkillEffectDescItem(index)
	local descItem = self._skillEffectDescItems[index]

	if not descItem then
		descItem = self:getUserDataTb_()
		descItem.go = gohelper.cloneInPlace(self._goeffectdescitem, "descitem" .. index)
		descItem.desc = gohelper.findChildText(descItem.go, "effectdesc")
		descItem.title = gohelper.findChildText(descItem.go, "titlebg/bg/name")
		descItem.fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(descItem.desc.gameObject, FixTmpBreakLine)
		descItem.hyperLinkClick = SkillHelper.addHyperLinkClick(descItem.desc, self._onHyperLinkClick, self)

		table.insert(self._skillEffectDescItems, index, descItem)
	end

	return descItem
end

function Act191CharacterTipView:_refreshPassiveSkillScroll()
	local root = gohelper.findChild(self._gopassiveskilltip, "mask/root")

	ZProj.UGUIHelper.RebuildLayout(root.transform)

	local scrollContentHeight = recthelper.getHeight(self._passiveskilltipcontent.transform)
	local scrollViewHeight = recthelper.getHeight(self._scrollview.transform)

	self._couldScroll = scrollViewHeight < scrollContentHeight

	gohelper.setActive(self._gomask1, self._couldScroll and gohelper.getRemindFourNumberFloat(self._scrollview.verticalNormalizedPosition) > 0)

	self._passiveskilltipmask.enabled = false

	local passviewskilltipviewport = gohelper.findChild(self._gopassiveskilltip, "mask/root/scrollview/viewport")
	local psviewportVerticalGroup = gohelper.onceAddComponent(passviewskilltipviewport, gohelper.Type_VerticalLayoutGroup)
	local psviewportLayoutElement = gohelper.onceAddComponent(passviewskilltipviewport, typeof(UnityEngine.UI.LayoutElement))

	psviewportVerticalGroup.enabled = false
	psviewportLayoutElement.enabled = true
	psviewportLayoutElement.preferredHeight = recthelper.getHeight(passviewskilltipviewport.transform)
end

function Act191CharacterTipView:_setTipPos(tipTran, tipPos, anchorParams)
	if not tipTran then
		return
	end

	if anchorParams then
		if not anchorParams[1] then
			local targetAnchorMin = Vector2.New(0.5, 0.5)

			if anchorParams then
				if not anchorParams[2] then
					local targetAnchorMax = Vector2.New(0.5, 0.5)
					local targetTipPos = tipPos and tipPos or Vector2.New(0, 0)

					self._gopassiveskilltip.transform.anchorMin = targetAnchorMin
					self._gopassiveskilltip.transform.anchorMax = targetAnchorMax

					recthelper.setAnchor(tipTran, targetTipPos.x, targetTipPos.y)
				end
			end
		end
	end
end

Act191CharacterTipView.LeftWidth = 470
Act191CharacterTipView.RightWidth = 190
Act191CharacterTipView.TopHeight = 292
Act191CharacterTipView.Interval = 10

function Act191CharacterTipView:_onHyperLinkClick(effectId, clickPosition)
	CommonBuffTipController.instance:openCommonTipViewWithCustomPosCallback(tonumber(effectId), self.setTipPosCallback, self)
end

function Act191CharacterTipView:setTipPosCallback(rectTrTipViewGo, rectTrScrollTip)
	self.rectTrPassive = self.rectTrPassive or self._gopassiveskilltip:GetComponent(gohelper.Type_RectTransform)

	local w = GameUtil.getViewSize()
	local halfW = w / 2
	local screenPosX, screenPosY = recthelper.uiPosToScreenPos2(self.rectTrPassive)
	local localPosX, localPosY = SLFramework.UGUI.RectTrHelper.ScreenPosXYToAnchorPosXY(screenPosX, screenPosY, rectTrTipViewGo, CameraMgr.instance:getUICamera(), nil, nil)
	local leftRemainWidth = halfW + localPosX - Act191CharacterTipView.LeftWidth - Act191CharacterTipView.Interval
	local scrollTipWidth = recthelper.getWidth(rectTrScrollTip)
	local showLeft = scrollTipWidth <= leftRemainWidth

	rectTrScrollTip.pivot = CommonBuffTipEnum.Pivot.Right

	local anchorX = localPosX
	local anchorY = localPosY

	anchorX = showLeft and anchorX - Act191CharacterTipView.LeftWidth - Act191CharacterTipView.Interval or anchorX + Act191CharacterTipView.RightWidth + Act191CharacterTipView.Interval + scrollTipWidth
	anchorY = anchorY + Act191CharacterTipView.TopHeight

	recthelper.setAnchor(rectTrScrollTip, anchorX, anchorY)
end

return Act191CharacterTipView
