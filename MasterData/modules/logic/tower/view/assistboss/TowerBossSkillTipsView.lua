-- chunkname: @modules/logic/tower/view/assistboss/TowerBossSkillTipsView.lua

module("modules.logic.tower.view.assistboss.TowerBossSkillTipsView", package.seeall)

local TowerBossSkillTipsView = class("TowerBossSkillTipsView", BaseView)

function TowerBossSkillTipsView:onInitView()
	self._txtpassivename = gohelper.findChildText(self.viewGO, "#go_passiveskilltip/root/content/skills/name/bg/#txt_passivename")
	self._gopassiveskilltip = gohelper.findChild(self.viewGO, "#go_passiveskilltip")
	self._goeffectdesc = gohelper.findChild(self.viewGO, "#go_passiveskilltip/root/content/skills/#go_effectContent/#go_effectdesc")
	self._goeffectdescitem = gohelper.findChild(self.viewGO, "#go_passiveskilltip/root/content/skills/#go_effectContent/#go_effectdesc/#go_effectdescitem")
	self._btnclosepassivetip = gohelper.findChildButtonWithAudio(self.viewGO, "#go_passiveskilltip/#btn_closepassivetip")
	self._rectbg = gohelper.findChild(self.viewGO, "#go_passiveskilltip/root/bg"):GetComponent(gohelper.Type_RectTransform)
	self._canvasGroupTeachSkills = gohelper.findChild(self.viewGO, "#go_passiveskilltip/root/content/teachSkills"):GetComponent(typeof(UnityEngine.CanvasGroup))
	self._goTeachSkills = gohelper.findChild(self.viewGO, "#go_passiveskilltip/root/content/teachSkills/#go_teachSkills")
	self._txtTeachSkillTitle = gohelper.findChildText(self.viewGO, "#go_passiveskilltip/root/content/teachSkills/#txt_teachSkillTitle")
	self._txtTeachDesc = gohelper.findChildText(self.viewGO, "#go_passiveskilltip/root/content/teachSkills/#go_teachSkills/#txt_teachDesc")
	self._passiveskillitems = {}

	for i = 1, 3 do
		local o = self:getUserDataTb_()

		o.go = gohelper.findChild(self._gopassiveskilltip, "root/content/skills/#go_effectContent/talentstar" .. tostring(i))
		o.desc = gohelper.findChildTextMesh(o.go, "desctxt")
		o.hyperLinkClick = SkillHelper.addHyperLinkClick(o.desc, self._onHyperLinkClick, self)
		o.fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(o.desc.gameObject, FixTmpBreakLine)
		o.on = gohelper.findChild(o.go, "#go_passiveskills/passiveskill/on")
		o.unlocktxt = gohelper.findChildText(o.go, "#go_passiveskills/passiveskill/unlocktxt")
		o.canvasgroup = gohelper.onceAddComponent(o.go, typeof(UnityEngine.CanvasGroup))
		o.connectline = gohelper.findChild(o.go, "line")
		self._passiveskillitems[i] = o
	end

	self._skillEffectDescItems = self:getUserDataTb_()

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerBossSkillTipsView:addEvents()
	self.addClickCb(self, self._btnclosepassivetip, self._btnclosepassivetipOnClick, self)
end

function TowerBossSkillTipsView:removeEvents()
	self:removeClickCb(self._btnclosepassivetip)
end

function TowerBossSkillTipsView:_editableInitView()
	self.teachSkillTab = self:getUserDataTb_()
end

function TowerBossSkillTipsView:_onHyperLinkClick(effectId, clickPosition)
	CommonBuffTipController.instance:openCommonTipViewWithCustomPosCallback(tonumber(effectId), self.setTipPosCallback, self)
end

TowerBossSkillTipsView.LeftWidth = 910
TowerBossSkillTipsView.RightWidth = 390
TowerBossSkillTipsView.TopHeightOffset = 25
TowerBossSkillTipsView.Interval = 10

function TowerBossSkillTipsView:setTipPosCallback(rectTrTipViewGo, rectTrScrollTip)
	self.rectTrPassive = self.rectTrPassive or self._gopassiveskilltip:GetComponent(gohelper.Type_RectTransform)

	local w = GameUtil.getViewSize()
	local halfW = w / 2
	local screenPosX, screenPosY = recthelper.uiPosToScreenPos2(self.rectTrPassive)
	local localPosX, localPosY = SLFramework.UGUI.RectTrHelper.ScreenPosXYToAnchorPosXY(screenPosX, screenPosY, rectTrTipViewGo, CameraMgr.instance:getUICamera(), nil, nil)
	local leftRemainWidth = halfW + localPosX - TowerBossSkillTipsView.LeftWidth - TowerBossSkillTipsView.Interval
	local scrollTipWidth = recthelper.getWidth(rectTrScrollTip)
	local showLeft = scrollTipWidth <= leftRemainWidth

	rectTrScrollTip.pivot = CommonBuffTipEnum.Pivot.Right

	local anchorX = localPosX
	local anchorY = localPosY

	anchorX = showLeft and anchorX - TowerBossSkillTipsView.LeftWidth - TowerBossSkillTipsView.Interval or anchorX + TowerBossSkillTipsView.RightWidth + TowerBossSkillTipsView.Interval + scrollTipWidth

	local bgHeight = recthelper.getHeight(self._rectbg)

	anchorY = anchorY + bgHeight / 2 - TowerBossSkillTipsView.TopHeightOffset

	recthelper.setAnchor(rectTrScrollTip, anchorX, anchorY)
end

function TowerBossSkillTipsView:_btnclosepassivetipOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

function TowerBossSkillTipsView:onUpdateParam()
	self:refreshParam()
	self:refreshView()
end

function TowerBossSkillTipsView:onOpen()
	self:refreshParam()
	self:refreshView()
end

function TowerBossSkillTipsView:refreshParam()
	self.bossId = self.viewParam.bossId
	self.bossMo = TowerAssistBossModel.instance:getById(self.bossId)
	self.config = TowerConfig.instance:getAssistBossConfig(self.bossId)
end

function TowerBossSkillTipsView:refreshView()
	self:refreshPassiveSkill()
	self:refreshTeachSkill()
end

function TowerBossSkillTipsView:refreshPassiveSkill()
	local skillsList = TowerConfig.instance:getPassiveSKills(self.bossId)

	self._txtpassivename.text = self.config.passiveSkillName

	local txtTab = {}

	for i = 1, #skillsList do
		local skills = skillsList[i]
		local skillId = skills[1]
		local skillCo = lua_skill.configDict[skillId]

		txtTab[i] = FightConfig.instance:getSkillEffectDesc(self.config.name, skillCo)
	end

	local matchTxtTab = HeroSkillModel.instance:getSkillEffectTagIdsFormDescTabRecursion(txtTab)
	local skillEffectDescTab = {}
	local tagNameExistDict = {}

	if self.bossMo and self.bossMo.trialLevel > 0 then
		local var_12_0 = self.bossMo.trialLevel

		if not self.bossMo.trialLevel then
			if self.bossMo then
				var_12_0 = self.bossMo.level

				if not self.bossMo.level then
					local bossLev = 0

					for i, item in ipairs(self._passiveskillitems) do
						if skillsList[i] then
							local skillId = skillsList[i][1]

							if skillId then
								gohelper.setActive(item.go, true)

								local unlock = TowerConfig.instance:isSkillActive(self.bossId, skillId, bossLev)

								for _, v in ipairs(matchTxtTab[i]) do
									local effectCo = SkillConfig.instance:getSkillEffectDescCo(v)
									local name = effectCo.name
									local canShowSkillTag = HeroSkillModel.instance:canShowSkillTag(name)

									if canShowSkillTag and not tagNameExistDict[name] then
										tagNameExistDict[name] = true

										if effectCo.isSpecialCharacter == 1 then
											local desc = effectCo.desc
											local skillEffectDesc = SkillHelper.buildDesc(desc)

											table.insert(skillEffectDescTab, {
												desc = skillEffectDesc,
												title = effectCo.name
											})
										end
									end
								end

								local desc = SkillHelper.buildDesc(txtTab[i])

								if not unlock then
									local lev = TowerConfig.instance:getPassiveSkillActiveLev(self.bossId, skillId)

									item.unlocktxt.text = formatLuaLang("towerboss_skill_get", lev)
								else
									item.unlocktxt.text = formatLuaLang("towerboss_skill_order", GameUtil.getRomanNums(i))
								end

								item.canvasgroup.alpha = unlock and 1 or 0.5

								gohelper.setActive(item.on, unlock)

								item.desc.text = desc

								item.fixTmpBreakLine:refreshTmpContent(item.desc)
								gohelper.setActive(item.go, true)
								gohelper.setActive(item.connectline, i ~= #skillsList)
							else
								gohelper.setActive(item.go, false)
							end
						end
					end

					self:_showSkillEffectDesc(skillEffectDescTab)
				end
			end
		end
	end
end

function TowerBossSkillTipsView:_showSkillEffectDesc(skillEffectDescTab)
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

function TowerBossSkillTipsView:_getSkillEffectDescItem(index)
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

function TowerBossSkillTipsView:refreshTeachSkill()
	local isAllEpisodeFinish = TowerBossTeachModel.instance:isAllEpisodeFinish(self.bossId)

	self._canvasGroupTeachSkills.alpha = isAllEpisodeFinish and 1 or 0.5
	self._txtTeachSkillTitle.text = isAllEpisodeFinish and formatLuaLang("towerboss_skill_order", GameUtil.getRomanNums(4)) or luaLang("towerboss_teachskill_unlock")

	local teachSkillList = string.splitToNumber(self.config.teachSkills, "#")

	gohelper.CreateObjList(self, self.showTeachSkill, teachSkillList, self._goTeachSkills, self._txtTeachDesc.gameObject)
end

function TowerBossSkillTipsView:showTeachSkill(obj, data, index)
	local skillCo = lua_skill.configDict[data]
	local desc = FightConfig.instance:getSkillEffectDesc(self.config.name, skillCo)
	local txtdesc = obj:GetComponent(gohelper.Type_TextMesh)

	txtdesc.text = SkillHelper.buildDesc(desc)

	if not self.teachSkillTab[index] then
		self.teachSkillTab[index] = {}
		self.teachSkillTab[index].teachHyperLinkClick = SkillHelper.addHyperLinkClick(txtdesc, self._onHyperLinkClick, self)
		self.teachSkillTab[index].teachfixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(obj, FixTmpBreakLine)
	end

	self.teachSkillTab[index].teachfixTmpBreakLine:refreshTmpContent(txtdesc)
end

function TowerBossSkillTipsView:onClose()
	return
end

function TowerBossSkillTipsView:onDestroyView()
	return
end

return TowerBossSkillTipsView
