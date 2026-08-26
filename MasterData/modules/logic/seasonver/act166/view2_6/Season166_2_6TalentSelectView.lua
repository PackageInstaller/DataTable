-- chunkname: @modules/logic/seasonver/act166/view2_6/Season166_2_6TalentSelectView.lua

module("modules.logic.seasonver.act166.view2_6.Season166_2_6TalentSelectView", package.seeall)

local Season166_2_6TalentSelectView = class("Season166_2_6TalentSelectView", BaseView)

function Season166_2_6TalentSelectView:onInitView()
	self._txttitleen = gohelper.findChildText(self.viewGO, "root/left/#txt_titleen")
	self._txttitle = gohelper.findChildText(self.viewGO, "root/left/#txt_title")
	self._txtbasicSkill = gohelper.findChildText(self.viewGO, "root/left/#txt_basicSkill")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season166_2_6TalentSelectView:addEvents()
	self.addEventCb(self, Season166Controller.instance, Season166Event.SetTalentSkill, self.OnSetTalentSkill, self)
end

function Season166_2_6TalentSelectView:removeEvents()
	return
end

local SkillItemStatus = {
	Lock = 4,
	Full = 2,
	Select = 3,
	Normal = 1
}

function Season166_2_6TalentSelectView:_editableInitView()
	SkillHelper.addHyperLinkClick(self._txtbasicSkill, self.clcikHyperLink, self)

	self.unlockStateTab = self:getUserDataTb_()
	self.localUnlockStateTab = self:getUserDataTb_()
end

function Season166_2_6TalentSelectView:onOpen()
	if self.viewParam and self.viewParam.talentId then
		self.actId = Season166Model.instance:getCurSeasonId()
		self.talentId = self.viewParam.talentId
		self.talentConfig = lua_activity166_talent.configDict[self.actId][self.talentId]
		self._txttitle.text = self.talentConfig.name
		self._txttitleen.text = self.talentConfig.nameEn

		local baseSkillIdsStr = self.talentConfig.baseSkillIds

		if string.nilorempty(baseSkillIdsStr) then
			baseSkillIdsStr = self.talentConfig.baseSkillIds2
		end

		local basicSkillIds = string.splitToNumber(baseSkillIdsStr, "#")
		local effectConfig = lua_skill_effect.configDict[basicSkillIds[1]]
		local txt = FightConfig.instance:getSkillEffectDesc("", effectConfig)

		self._txtbasicSkill.text = SkillHelper.buildDesc(txt)
		self.styleCfgDic = lua_activity166_talent_style.configDict[self.talentId]
		self.talentInfo = Season166Model.instance:getTalentInfo(self.actId, self.talentId)
		self.baseConfig = Season166Config.instance:getBaseSpotByTalentId(self.actId, self.talentId)

		self:refreshTalentParam(self.talentInfo)
		self:_initSkillItem()
		self:_initLeftArea()
		self:_initMiddleArea()
		self:playUnlockEffect()
	else
		logError("please open view with talentId")
	end
end

function Season166_2_6TalentSelectView:onClose()
	self:saveUnlockState()
end

function Season166_2_6TalentSelectView:refreshTalentParam(talentInfo)
	self.talentLvl = talentInfo.level
	self.maxSlot = talentInfo.config.slot
end

function Season166_2_6TalentSelectView:_initLeftArea()
	self.selectSkillList = {}

	for i = 1, 3 do
		local selectItem = self:getUserDataTb_()

		selectItem.go = gohelper.findChild(self.viewGO, "root/left/basicSkill/" .. i)
		selectItem.goUnequip = gohelper.findChild(selectItem.go, "unequip")
		selectItem.goWhiteBg = gohelper.findChild(selectItem.go, "unequip/bg2")
		selectItem.goEquiped = gohelper.findChild(selectItem.go, "equiped")
		selectItem.animEquip = selectItem.goEquiped:GetComponent(gohelper.Type_Animation)
		selectItem.txtDesc = gohelper.findChildText(selectItem.go, "equiped/txt_desc")

		SkillHelper.addHyperLinkClick(selectItem.txtDesc, self.clcikHyperLink, self)

		local imageSlot = gohelper.findChildImage(selectItem.go, "equiped/txt_desc/slot")

		UISpriteSetMgr.instance:setSeason166Sprite(imageSlot, "season166_talentree_pointl" .. tostring(self.talentConfig.sortIndex))

		local goParticle = gohelper.findChild(selectItem.go, "equiped/txt_desc/slot/" .. self.talentConfig.sortIndex)

		gohelper.setActive(goParticle, true)

		selectItem.goLock = gohelper.findChild(selectItem.go, "locked")

		local txtLock = gohelper.findChildText(selectItem.go, "locked/txt_desc")
		local needStar = self.styleCfgDic[i].needStar

		txtLock.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("season166_talent_selectlock"), needStar, self.baseConfig.name)
		selectItem.anim = selectItem.go:GetComponent(gohelper.Type_Animator)
		self.selectSkillList[i] = selectItem
	end

	self:_refreshSelectSkill()
end

function Season166_2_6TalentSelectView:_initMiddleArea()
	local sortIndex = self.talentConfig.sortIndex
	local middleGo = gohelper.findChild(self.viewGO, "root/middle/talent" .. sortIndex)

	self.equipSlotList = self:getUserDataTb_()
	self.equipSlotLightList = self:getUserDataTb_()

	for i = 1, 3 do
		local path = "equipslot/" .. i

		self.equipSlotList[i] = gohelper.findChild(middleGo, path)

		gohelper.setActive(self.equipSlotList[i], i <= self.maxSlot)

		local lightPath = "equipslot/" .. i .. "/light"

		self.equipSlotLightList[i] = gohelper.findChild(middleGo, lightPath)
	end

	gohelper.setActive(middleGo, true)
	self:_refreshMiddlSlot()
end

function Season166_2_6TalentSelectView:_initSkillItem()
	self.skillUnlockLvlDic = {}
	self.skillIds = {}

	for _, styleCfg in ipairs(self.styleCfgDic) do
		local skillIds = string.splitToNumber(styleCfg.skillId, "#")
		local skillIds2 = string.splitToNumber(styleCfg.skillId2, "#")

		tabletool.addValues(self.skillIds, skillIds)
		tabletool.addValues(self.skillIds, skillIds2)

		local skillIdList = {}

		tabletool.addValues(skillIdList, skillIds)
		tabletool.addValues(skillIdList, skillIds2)

		self.skillUnlockLvlDic[styleCfg.level] = skillIdList
	end

	self.skillItemDic = {}

	for i = 1, 6 do
		local go = gohelper.findChild(self.viewGO, "root/right/#scroll_skill/Viewport/Content/skillItem" .. i)
		local skillId = self.skillIds[i]

		if skillId then
			local skillItem = self:getUserDataTb_()

			skillItem.effctConfig = lua_skill_effect.configDict[skillId]

			local content = gohelper.findChild(go, "content")

			skillItem.canvasGroup = content:GetComponent(gohelper.Type_CanvasGroup)
			skillItem.goslot = gohelper.findChild(go, "content/slot/go_slotLight")
			skillItem.txtdesc = gohelper.findChildText(go, "content/txt_desc")
			skillItem.txtdesc.text = FightConfig.instance:getSkillEffectDesc("", skillItem.effctConfig)

			local imageSlot = gohelper.findChildImage(go, "content/slot/go_slotLight")

			UISpriteSetMgr.instance:setSeason166Sprite(imageSlot, "season166_talentree_pointl" .. tostring(self.talentConfig.sortIndex))

			skillItem.select = gohelper.findChild(go, "select")
			skillItem.normal = gohelper.findChild(go, "normal")
			skillItem.full = gohelper.findChild(go, "full")
			skillItem.lock = gohelper.findChild(go, "lock")

			local txtlocktips = gohelper.findChildText(go, "lock/txt_locktips")
			local unlockLvl = self:getSkillUnlockLvl(skillId)
			local needStar = self.styleCfgDic[unlockLvl].needStar

			txtlocktips.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("season166_talent_selectlock"), needStar, self.baseConfig.name)
			skillItem.anim = go:GetComponent(gohelper.Type_Animator)

			local btnClick = gohelper.findChildButtonWithAudio(go, "click")

			self.addClickCb(self, btnClick, self._clickItem, self, skillId)

			self.skillItemDic[skillId] = skillItem
		else
			gohelper.setActive(go, false)
		end
	end

	self:_refreshSkillItemStatus()
end

function Season166_2_6TalentSelectView:_refreshSelectSkill(isAdd)
	local skillIds = self.talentInfo.skillIds
	local selectIndex = #skillIds + 1

	for i, selectItem in ipairs(self.selectSkillList) do
		if i == selectIndex and selectIndex <= self.maxSlot then
			gohelper.setActive(selectItem.goWhiteBg, true)
		else
			gohelper.setActive(selectItem.goWhiteBg, false)
		end

		if i > self.maxSlot then
			gohelper.setActive(selectItem.goUnequip, false)
			gohelper.setActive(selectItem.goEquiped, false)
			gohelper.setActive(selectItem.goLock, true)
		elseif i > #skillIds then
			gohelper.setActive(selectItem.goUnequip, true)
			gohelper.setActive(selectItem.goEquiped, false)
			gohelper.setActive(selectItem.goLock, false)
		else
			local effectConfig = lua_skill_effect.configDict[skillIds[i]]
			local txt = FightConfig.instance:getSkillEffectDesc("", effectConfig)

			selectItem.txtDesc.text = SkillHelper.buildDesc(txt)

			gohelper.setActive(selectItem.goUnequip, false)
			gohelper.setActive(selectItem.goEquiped, true)
			gohelper.setActive(selectItem.goLock, false)

			if isAdd and i == #skillIds then
				selectItem.animEquip:Play("equiped_open")
				AudioMgr.instance:trigger(AudioEnum.Season166.play_ui_checkpoint_light)
			end
		end
	end
end

function Season166_2_6TalentSelectView:_refreshMiddlSlot()
	local skillCnt = #self.talentInfo.skillIds

	for i = 1, self.maxSlot do
		gohelper.setActive(self.equipSlotLightList[i], i <= skillCnt)
	end
end

function Season166_2_6TalentSelectView:_refreshSkillItemStatus()
	for id, skillItem in pairs(self.skillItemDic) do
		local unlockLvl = self:getSkillUnlockLvl(id)
		local status = self:InferSkillStatus(id, unlockLvl)
		local styleCfg = self.styleCfgDic[unlockLvl]

		skillItem.canvasGroup.alpha = (status == SkillItemStatus.Full or status == SkillItemStatus.Lock) and 0.5 or 1

		gohelper.setActive(skillItem.select, status == SkillItemStatus.Select)
		gohelper.setActive(skillItem.goslot, status == SkillItemStatus.Select)
		gohelper.setActive(skillItem.normal, status == SkillItemStatus.Normal)
		gohelper.setActive(skillItem.full, status == SkillItemStatus.Full)
		gohelper.setActive(skillItem.lock, status == SkillItemStatus.Lock)

		local isUnlock = status ~= SkillItemStatus.Lock and styleCfg.needStar > 0

		if isUnlock then
			self.unlockStateTab[id] = Season166Enum.UnlockState or Season166Enum.LockState
		end

		skillItem.isUnlock = isUnlock
	end
end

function Season166_2_6TalentSelectView:_clickItem(skillId)
	local unlockLvl = self:getSkillUnlockLvl(skillId)
	local status = self:InferSkillStatus(skillId, unlockLvl)

	if status == SkillItemStatus.Normal then
		local skillIds = tabletool.copy(self.talentInfo.skillIds)

		skillIds[#skillIds + 1] = skillId

		Activity166Rpc.instance:SendAct166SetTalentSkillRequest(self.actId, self.talentId, skillIds)
	elseif status == SkillItemStatus.Select then
		local skillIds = tabletool.copy(self.talentInfo.skillIds)

		tabletool.removeValue(skillIds, skillId)
		Activity166Rpc.instance:SendAct166SetTalentSkillRequest(self.actId, self.talentId, skillIds)
	end
end

function Season166_2_6TalentSelectView:OnSetTalentSkill(talentId, isAdd)
	if self.talentId == talentId then
		self:_refreshSkillItemStatus()
		self:_refreshSelectSkill(isAdd)
		self:_refreshMiddlSlot()
		self:saveUnlockState()
	end
end

function Season166_2_6TalentSelectView:InferSkillStatus(skillId, unlockLvl)
	if unlockLvl > self.talentLvl then
		return SkillItemStatus.Lock
	end

	if tabletool.indexOf(self.talentInfo.skillIds, skillId) then
		return SkillItemStatus.Select
	end

	if #self.talentInfo.skillIds >= self.maxSlot then
		return SkillItemStatus.Full
	end

	return SkillItemStatus.Normal
end

function Season166_2_6TalentSelectView:getSkillUnlockLvl(skillId)
	for lvl, skillIds in pairs(self.skillUnlockLvlDic) do
		if tabletool.indexOf(skillIds, skillId) then
			return lvl
		end
	end

	return 0
end

function Season166_2_6TalentSelectView:playUnlockEffect()
	local talentLocalLvl = Season166Controller.instance:getPlayerPrefs(Season166Enum.TalentLvlLocalSaveKey .. self.talentId, 0)
	local talentLvl = self.talentInfo.level

	if talentLocalLvl < talentLvl then
		for i = 1, talentLvl do
			local selectItem = self.selectSkillList[i]

			if i == talentLvl then
				selectItem.anim:Play("unlock")
				AudioMgr.instance:trigger(AudioEnum.Season166.play_ui_checkpoint_unlock)
			end

			for j = 1, 2 do
				local skillId = self.skillIds[(i - 1) * 2 + j]
				local skillItem = self.skillItemDic[skillId]

				if i == talentLvl then
					skillItem.anim:Play("unlock")
				end
			end
		end

		Season166Controller.instance:savePlayerPrefs(Season166Enum.TalentLvlLocalSaveKey .. self.talentId, talentLvl)
	end
end

function Season166_2_6TalentSelectView:isTalentSelect(skillId)
	local curSelectSkills = self.talentInfo.skillIds

	return tabletool.indexOf(curSelectSkills, skillId)
end

function Season166_2_6TalentSelectView:saveUnlockState()
	local saveStrTab = {}
	local saveKey = Season166Model.instance:getTalentLocalSaveKey(self.talentId)

	for skillId, unlockState in pairs(self.unlockStateTab) do
		local saveStr = string.format("%s|%s", skillId, unlockState)

		table.insert(saveStrTab, saveStr)
	end

	local saveDataStr = cjson.encode(saveStrTab)

	Season166Controller.instance:savePlayerPrefs(saveKey, saveDataStr)
end

function Season166_2_6TalentSelectView:clcikHyperLink(effectId, clickPosition)
	CommonBuffTipController.instance:openCommonTipViewWithCustomPos(effectId, Vector2(-305, 30))
end

return Season166_2_6TalentSelectView
