-- chunkname: @modules/logic/tower/view/assistboss/TowerSkillTipView.lua

module("modules.logic.tower.view.assistboss.TowerSkillTipView", package.seeall)

local TowerSkillTipView = class("TowerSkillTipView", BaseView)

function TowerSkillTipView:onInitView()
	self._gonewskilltip = gohelper.findChild(self.viewGO, "#go_newskilltip")
	self._gospecialitem = gohelper.findChild(self.viewGO, "#go_newskilltip/skilltipScrollview/Viewport/Content/name/special/#go_specialitem")
	self._goline = gohelper.findChild(self.viewGO, "#go_newskilltip/skilltipScrollview/Viewport/Content/#go_line")
	self._goskillspecialitem = gohelper.findChild(self.viewGO, "#go_newskilltip/skilltipScrollview/Viewport/Content/skillspecial/#go_skillspecialitem")
	self._goskilltipScrollviewContent = gohelper.findChild(self.viewGO, "#go_newskilltip/skilltipScrollview/Viewport/Content")
	self._scrollskilltipScrollview = gohelper.findChildScrollRect(self.viewGO, "#go_newskilltip/skilltipScrollview")
	self._goarrow = gohelper.findChild(self.viewGO, "#go_newskilltip/bottombg/#go_arrow")
	self._gostoryDesc = gohelper.findChild(self.viewGO, "#go_newskilltip/skilltipScrollview/Viewport/Content/#go_storyDesc")
	self._txtstory = gohelper.findChildText(self.viewGO, "#go_newskilltip/skilltipScrollview/Viewport/Content/#go_storyDesc/#txt_story")
	self._goSuperContent = gohelper.findChild(self.viewGO, "#go_newskilltip/#scroll_super/Viewport/#go_superContent")
	self._goSuperItem = gohelper.findChild(self.viewGO, "#go_newskilltip/#scroll_super/Viewport/#go_superContent/super")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerSkillTipView:addEvents()
	return
end

function TowerSkillTipView:removeEvents()
	return
end

function TowerSkillTipView:_editableInitView()
	gohelper.setActive(self._goBuffContainer, false)
	self._scrollskilltipScrollview:AddOnValueChanged(self._refreshArrow, self)

	self.superSkillItemList = self:getUserDataTb_()

	gohelper.setActive(self._goSuperItem, false)

	self._newskilltips = self:getUserDataTb_()
	self._newskilltips[1] = gohelper.findChild(self._gonewskilltip, "normal")
	self._newskilltips[2] = gohelper.findChild(self._goSuperContent, "super")
	self._newskillname = gohelper.findChildText(self._goskilltipScrollviewContent, "name")
	self._newskilldesc = gohelper.findChildText(self._goskilltipScrollviewContent, "desc")
	self._fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(self._newskilldesc.gameObject, FixTmpBreakLine)

	SkillHelper.addHyperLinkClick(self._newskilldesc, self._onHyperLinkClick, self)

	self._skillTagGOs = self:getUserDataTb_()
	self._skillEffectGOs = self:getUserDataTb_()

	gohelper.setActive(self._gospecialitem, false)
	gohelper.setActive(self._goskillspecialitem, false)

	self._viewInitialized = true
end

function TowerSkillTipView:_refreshArrow()
	local goTipHeight = recthelper.getHeight(self._goskilltipScrollviewContent.transform)
	local scrollTipHeight = recthelper.getHeight(self._scrollskilltipScrollview.transform)

	if scrollTipHeight < goTipHeight and self._scrollskilltipScrollview.verticalNormalizedPosition > 0.01 then
		gohelper.setActive(self._goarrow, true)
	else
		gohelper.setActive(self._goarrow, false)
	end
end

function TowerSkillTipView:_setNewSkills(skillIdList, super, isCharacter)
	self._curSkillLevel = self._curSkillLevel or nil
	self._skillIdList = skillIdList
	self._super = super

	gohelper.setActive(self._newskilltips[1], not super)

	if not super then
		-- block empty
	else
		local curUserSkillId = self.viewParam.userSkillId

		if curUserSkillId then
			self.curSuperSkillItemId = curUserSkillId
		end

		self:createAndRefreshSuperSkillItem()
	end

	if self.viewName == ViewName.FightFocusView then
		if ViewMgr.instance:isOpen(ViewName.FightFocusView) then
			transformhelper.setLocalPosXY(self._gonewskilltip.transform, 270, -24.3)
		else
			transformhelper.setLocalPosXY(self._gonewskilltip.transform, 185.12, 49.85)
		end
	else
		transformhelper.setLocalPosXY(self._gonewskilltip.transform, 0.69, -0.54)
	end
end

function TowerSkillTipView:_refreshSkill(level)
	if not self._skillIdList[level] then
		level = 1
	end

	self._curSkillLevel = level

	for i = 1, 3 do
		gohelper.setActive(self._newskillitems[i].selectframe, i == level)
		gohelper.setActive(self._newskillitems[i].selectarrow, i == level)
	end

	local skillConfig = lua_skill.configDict[tonumber(self._skillIdList[level])]

	if skillConfig then
		self._newskillname.text = skillConfig.name
		self._newskilldesc.text = SkillHelper.getSkillDesc(self.monsterName, skillConfig)

		self._fixTmpBreakLine:refreshTmpContent(self._newskilldesc)
		gohelper.setActive(self._gostoryDesc, not string.nilorempty(skillConfig.desc_art))

		self._txtstory.text = skillConfig.desc_art
		self._scrollskilltipScrollview.verticalNormalizedPosition = 1

		self:_refreshSkillSpecial(skillConfig)
	else
		logError("找不到技能: " .. tostring(self._skillIdList[level]))
	end
end

function TowerSkillTipView:_refreshSkillSpecial(skillConfig)
	local skillTags = {}

	if skillConfig.battleTag and skillConfig.battleTag ~= "" then
		skillTags = string.split(skillConfig.battleTag, "#")

		for i = 1, #skillTags do
			local skillTagGO = self._skillTagGOs[i]

			if not skillTagGO then
				skillTagGO = gohelper.cloneInPlace(self._gospecialitem, "item" .. i)

				table.insert(self._skillTagGOs, skillTagGO)
			end

			local name = gohelper.findChildText(skillTagGO, "name")
			local tagConfig = HeroConfig.instance:getBattleTagConfigCO(skillTags[i])

			if tagConfig then
				name.text = tagConfig.tagName
			else
				logError("找不到技能BattleTag: " .. tostring(skillTags[i]))
			end

			gohelper.setActive(skillTagGO, true)
		end
	end

	for i = #skillTags + 1, #self._skillTagGOs do
		gohelper.setActive(self._skillTagGOs[i], false)
	end

	gohelper.setActive(self._goline, false)

	local desc = FightConfig.instance:getSkillEffectDesc(self.monsterName, skillConfig)
	local skillEffects = HeroSkillModel.instance:getEffectTagIDsFromDescRecursion(desc)

	for i = #skillEffects, 1, -1 do
		local skillEffectId = tonumber(skillEffects[i])
		local skillEffectConfig = SkillConfig.instance:getSkillEffectDescCo(skillEffectId)

		if skillEffectConfig then
			if not SkillHelper.canShowTag(skillEffectConfig) then
				table.remove(skillEffects, i)
			end
		else
			logError("找不到技能eff_desc: " .. tostring(skillEffectId))
		end
	end

	local index = 1

	for i = 1, #skillEffects do
		local skillEffectId = tonumber(skillEffects[i])
		local skillEffectConfig = SkillConfig.instance:getSkillEffectDescCo(skillEffectId)

		if skillEffectConfig.isSpecialCharacter == 1 then
			gohelper.setActive(self._goline, true)

			local skillEffectGO = self._skillEffectGOs[index]

			if not skillEffectGO then
				skillEffectGO = gohelper.cloneInPlace(self._goskillspecialitem, "item" .. index)

				table.insert(self._skillEffectGOs, skillEffectGO)
			end

			local nameBg = gohelper.findChildImage(skillEffectGO, "titlebg/bg")
			local name = gohelper.findChildText(skillEffectGO, "titlebg/bg/name")
			local desc = gohelper.findChildText(skillEffectGO, "desc")

			SkillHelper.addHyperLinkClick(desc, self._onHyperLinkClick, self)

			local descFixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(desc.gameObject, FixTmpBreakLine)

			if skillEffectConfig then
				SLFramework.UGUI.GuiHelper.SetColor(nameBg:GetComponent("Image"), TowerSkillTipView.skillTypeColor[skillEffectConfig.color])

				name.text = SkillHelper.removeRichTag(skillEffectConfig.name)
				desc.text = SkillHelper.getSkillDesc(self.monsterName, skillEffectConfig)

				descFixTmpBreakLine:refreshTmpContent(desc)
			else
				logError("找不到技能eff_desc: " .. tostring(skillEffectId))
			end

			gohelper.setActive(skillEffectGO, true)

			index = index + 1
		end
	end

	for i = index, #self._skillEffectGOs do
		gohelper.setActive(self._skillEffectGOs[i], false)
	end

	self:_refreshArrow()
end

function TowerSkillTipView:_onHyperLinkClick(effId, clickPosition)
	CommonBuffTipController.instance:openCommonTipViewWithCustomPos(tonumber(effId), CommonBuffTipEnum.Anchor[self.viewName], CommonBuffTipEnum.Pivot.Right)
end

function TowerSkillTipView:onUpdateParam()
	self:initView()
end

function TowerSkillTipView:onOpen()
	self:initView()
end

function TowerSkillTipView:initView()
	local info = self.viewParam

	self.srcSkillIdList = info.skillIdList
	self.isSuper = info.super
	self.isCharacter = true

	self:updateMonsterName()
	self:_setNewSkills(self.srcSkillIdList, self.isSuper, self.isCharacter)

	local anchorX = info and info.anchorX

	if anchorX then
		recthelper.setAnchorX(self.viewGO.transform, anchorX)
	end
end

function TowerSkillTipView:updateMonsterName()
	self.monsterName = self.viewParam.monsterName

	if not self.monsterName then
		logError("TowerSkillTipView 缺少 monsterName 参数")

		self.monsterName = ""
	end
end

function TowerSkillTipView:showInfo(info, isCharacter, entityId)
	if not self._viewInitialized then
		return
	end

	self.entityMo = FightDataHelper.entityMgr:getById(entityId)
	self.monsterName = FightConfig.instance:getEntityName(entityId)
	self.entitySkillIndex = info.skillIndex

	if string.nilorempty(self.monsterName) then
		logError("TowerSkillTipView monsterName 为 nil, entityId : " .. tostring(entityId))

		self.monsterName = ""
	end

	self.srcSkillIdList = info.skillIdList
	self.isSuper = info.super
	self.isCharacter = isCharacter

	gohelper.setActive(self._gonewskilltip, true)
	self:_setNewSkills(self.srcSkillIdList, self.isSuper, self.isCharacter)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Tipsopen)
end

function TowerSkillTipView:hideInfo()
	if not self._viewInitialized then
		return
	end

	gohelper.setActive(self._gonewskilltip, false)
end

function TowerSkillTipView:createAndRefreshSuperSkillItem()
	for index, skillId in ipairs(self._skillIdList) do
		local superItem = self.superSkillItemList[index]

		if not superItem then
			superItem = {
				id = skillId,
				index = index,
				go = gohelper.clone(self._goSuperItem, self._goSuperContent, skillId)
			}
			superItem.icon = gohelper.findChildSingleImage(superItem.go, "imgIcon")
			superItem.tag = gohelper.findChildSingleImage(superItem.go, "tag/tagIcon")
			superItem.aggrandizement = gohelper.findChild(superItem.go, "aggrandizement")
			superItem.backbg = gohelper.findChild(superItem.go, "backbg")
			superItem.goSelect = gohelper.findChild(superItem.go, "go_select")
			superItem.btnClick = gohelper.findChildButtonWithAudio(superItem.go, "btn_click")

			superItem.btnClick:AddClickListener(self.onSuperItemClick, self, superItem)

			self.superSkillItemList[index] = superItem

			gohelper.setActive(superItem.tag, false)
			gohelper.setActive(superItem.backbg, false)
			gohelper.setActive(superItem.go, true)

			self.curSuperSkillItemId = self.curSuperSkillItemId or superItem.id
		end

		local skillConfig = lua_skill.configDict[skillId]

		superItem.icon:LoadImage(ResUrl.getSkillIcon(skillConfig.icon))
		superItem.tag:LoadImage(ResUrl.getAttributeIcon("attribute_" .. skillConfig.showTag))
		gohelper.setActive(superItem.aggrandizement, false)
		gohelper.setActive(superItem.goSelect, self.curSuperSkillItemId == superItem.id)
	end

	for i = #self._skillIdList + 1, #self.superSkillItemList do
		gohelper.setActive(self.superSkillItemList[i].go, false)
	end

	self:refreshDesc()
end

function TowerSkillTipView:onSuperItemClick(skillItem)
	if skillItem and skillItem.id == self.curSuperSkillItemId then
		return
	end

	self.curSuperSkillItemId = skillItem.id

	for index, superItem in pairs(self.superSkillItemList) do
		gohelper.setActive(superItem.goSelect, superItem.id == self.curSuperSkillItemId)
	end

	self:refreshDesc()
end

function TowerSkillTipView:refreshDesc()
	local skillConfig = lua_skill.configDict[self.curSuperSkillItemId]

	if skillConfig then
		gohelper.setActive(self._gostoryDesc, not string.nilorempty(skillConfig.desc_art))

		self._newskillname.text = skillConfig.name
		self._newskilldesc.text = SkillHelper.getSkillDesc(self.monsterName, skillConfig)

		self._fixTmpBreakLine:refreshTmpContent(self._newskilldesc)

		self._scrollskilltipScrollview.verticalNormalizedPosition = 1

		self:_refreshSkillSpecial(skillConfig)
	else
		logError("找不到技能: " .. tostring(self.curSuperSkillItemId))
	end
end

function TowerSkillTipView:onDestroyView()
	self._scrollskilltipScrollview:RemoveOnValueChanged()

	for index, superItem in pairs(self.superSkillItemList) do
		superItem.icon:UnLoadImage()
		superItem.tag:UnLoadImage()
		superItem.btnClick:RemoveClickListener()
	end
end

return TowerSkillTipView
