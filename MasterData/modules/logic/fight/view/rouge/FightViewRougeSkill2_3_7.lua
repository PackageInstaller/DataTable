-- chunkname: @modules/logic/fight/view/rouge/FightViewRougeSkill2_3_7.lua

module("modules.logic.fight.view.rouge.FightViewRougeSkill2_3_7", package.seeall)

local FightViewRougeSkill2_3_7 = class("FightViewRougeSkill2_3_7", BaseViewExtended)
local MAX_POINT = 7
local ScrollWidthOffset = 90

function FightViewRougeSkill2_3_7:onInitView()
	FightViewRougeSkill2_3_7.instance = self
	self.goFightRoot = gohelper.findChild(self.viewContainer.viewGO, "root")
	self.goSkillItem = gohelper.findChild(self.viewGO, "root/#go_layout/#go_commonskilliconitem")

	gohelper.setActive(self.goSkillItem, false)

	self.goTips = gohelper.findChild(self.viewGO, "root/#go_Tips")

	gohelper.setActive(self.goTips, false)

	self.btnTipClick = gohelper.findChildClickWithDefaultAudio(self.viewGO, "root/#go_Tips/#btn_click")
	self.rectScrollDesc = gohelper.findChildComponent(self.viewGO, "root/#go_Tips/tips/#scroll_dec", gohelper.Type_RectTransform)
	self.rectContent = gohelper.findChildComponent(self.viewGO, "root/#go_Tips/tips/#scroll_dec/viewport/content", gohelper.Type_RectTransform)
	self.rectBg = gohelper.findChildComponent(self.viewGO, "root/#go_Tips/tips/bg", gohelper.Type_RectTransform)
	self.goTipItem = gohelper.findChild(self.viewGO, "root/#go_Tips/tips/#scroll_dec/viewport/content/#go_commonskillitem")

	gohelper.setActive(self.goTipItem, false)

	self.skillItemList = {}
	self.tipItemList = {}
	self.skillIdPlayedLightAnimDict = {}
	self.skillIdPlayedFullAnimDict = {}
end

function FightViewRougeSkill2_3_7:addEvents()
	self.btnTipClick:AddClickListener(self.btnTipOnClick, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnBuffUpdate, self.onBuffUpdate, self)
end

function FightViewRougeSkill2_3_7:removeEvents()
	self.btnTipClick:RemoveClickListener()
end

function FightViewRougeSkill2_3_7:onBuffUpdate(entityId, effectTye, buffId)
	if entityId ~= FightEnum.SideUid.MySide then
		return
	end

	for _, skillItem in ipairs(self.skillItemList) do
		if skillItem.buffId == buffId then
			local curLayer = self:getBuffLayer(buffId)

			if curLayer < skillItem.curLayer then
				self:playSkillItemTriggerAnim(skillItem)

				break
			end

			self:refreshSkillItem(skillItem)
			self:refreshTipList()

			break
		end
	end
end

function FightViewRougeSkill2_3_7:refreshSkillItem(skillItem)
	local curLayer = self:getBuffLayer(skillItem.buffId)

	skillItem.curLayer = curLayer

	local skillId = skillItem.skillId

	for i = 1, MAX_POINT do
		gohelper.setActive(skillItem.goPointList[i], i <= skillItem.maxPoint)

		if i <= skillItem.maxPoint then
			local active = i <= curLayer

			if active then
				local playedList = self.skillIdPlayedLightAnimDict[skillId]

				if not playedList then
					playedList = {}
					self.skillIdPlayedLightAnimDict[skillId] = playedList
				end

				if not playedList[i] then
					skillItem.animatorPointList[i]:Play("light", 0, 0)

					playedList[i] = true

					AudioMgr.instance:trigger(370801)
				end
			else
				skillItem.animatorPointList[i]:Play("idle")
			end
		end
	end

	if curLayer >= skillItem.maxPoint then
		if not self.skillIdPlayedFullAnimDict[skillId] then
			skillItem.animatorPlayer:Play("full")

			self.skillIdPlayedFullAnimDict[skillId] = true
		end
	else
		skillItem.animatorPlayer:Play("idle")
	end
end

function FightViewRougeSkill2_3_7:playSkillItemTriggerAnim(skillItem)
	local list = self.skillIdPlayedLightAnimDict[skillItem.skillId]

	if list then
		tabletool.clear(list)
	end

	self.skillIdPlayedFullAnimDict[skillItem.skillId] = nil

	skillItem.animatorPlayer:Play("trigger")
	AudioMgr.instance:trigger(370802)
	skillItem.animatorPlayer:Play("trigger", self.onPlayFullAnimDone, self, skillItem)
end

function FightViewRougeSkill2_3_7:onPlayFullAnimDone(skillItem)
	self:refreshSkillItem(skillItem)
	self:refreshTipList()
end

function FightViewRougeSkill2_3_7:btnTipOnClick()
	gohelper.setActive(self.goTips, false)
end

function FightViewRougeSkill2_3_7:onOpen()
	local customData = FightDataHelper.fieldMgr.customData

	customData = customData and customData[FightCustomData.CustomDataType.Rouge2]

	local skillList = FightStrUtil.instance:getSplitToNumberCache(customData.activeSkillId, "#")

	self.skillIdList = skillList or {}

	self:refreshUI()
	self:tryShowGuide()
end

function FightViewRougeSkill2_3_7:refreshUI()
	self:refreshSkillList()
	self:refreshTipList()
end

function FightViewRougeSkill2_3_7:refreshSkillList()
	local index = 0

	for _, skillId in ipairs(self.skillIdList) do
		local skillCo = lua_rouge2_active_skill.configDict[skillId]

		if skillCo then
			index = index + 1

			local skillItem = self.skillItemList[index]

			if not skillItem then
				skillItem = self:createSkillItem()

				table.insert(self.skillItemList, skillItem)
			end

			gohelper.setActive(skillItem.go, true)
			Rouge2_IconHelper.setItemIconAndRare(skillId, skillItem.simageIcon, skillItem.imageRare, Rouge2_Enum.ItemRareIconType.CircleIcon)

			local curRare = skillCo.rare

			for rare, go in ipairs(skillItem.goRareList) do
				gohelper.setActive(go, rare == curRare)
			end

			local array = FightStrUtil.instance:getSplitToNumberCache(skillCo.countParam, "#")

			skillItem.buffId = array and array[1]

			if array then
				skillItem.maxPoint = array[2] or 0
			end

			skillItem.skillId = skillId

			self:refreshSkillItem(skillItem)
		end
	end

	for i = index + 1, #self.skillItemList do
		gohelper.setActive(self.skillItemList[i].go, false)
	end
end

function FightViewRougeSkill2_3_7:refreshTipList()
	local index = 0

	for _, skillId in ipairs(self.skillIdList) do
		local skillCo = lua_rouge2_active_skill.configDict[skillId]

		if skillCo then
			index = index + 1

			local tipItem = self.tipItemList[index]

			if not tipItem then
				tipItem = self:createTipItem()

				table.insert(self.tipItemList, tipItem)
			end

			gohelper.setActive(tipItem.go, true)
			tipItem.skillItem:onUpdateMO(index, Rouge2_MapEnum.ItemDropViewEnum.FightTip, Rouge2_Enum.ItemDataType.Config, skillId)

			local skillItem = self.skillItemList[index]

			tipItem.skillItem:refreshFightPower(skillItem.curLayer, skillItem.maxPoint)
		end
	end

	for i = index + 1, #self.tipItemList do
		gohelper.setActive(self.tipItemList[i].go, false)
	end
end

function FightViewRougeSkill2_3_7:getBuffLayer(buffId)
	local entityMo = FightDataHelper.entityMgr:getMyVertin()

	if not entityMo then
		return 0
	end

	local buffDict = entityMo:getBuffDic()

	for _, buff in pairs(buffDict) do
		local buffMo = buff

		if buffMo.buffId == buffId then
			return buffMo.layer
		end
	end

	return 0
end

function FightViewRougeSkill2_3_7:createTipItem()
	local tipItem = self:getUserDataTb_()

	tipItem.go = gohelper.cloneInPlace(self.goTipItem)
	tipItem.goInner = gohelper.findChild(tipItem.go, "rouge2_commonskillitem")
	tipItem.skillItem = Rouge2_CommonSkillItem.Get(tipItem.goInner)

	tipItem.skillItem:initDescModeFlag(Rouge2_Enum.ItemDescModeDataKey.BackpackRelics)

	return tipItem
end

function FightViewRougeSkill2_3_7:createSkillItem()
	local skillItem = self:getUserDataTb_()

	skillItem.go = gohelper.cloneInPlace(self.goSkillItem)
	skillItem.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(gohelper.findChild(skillItem.go, "rouge2_commonskilliconitem"))
	skillItem.goRareList = self:getUserDataTb_()

	for i = 1, 3 do
		table.insert(skillItem.goRareList, gohelper.findChild(skillItem.go, "rouge2_commonskilliconitem/#go_Info/#go_Rare/" .. i))
	end

	skillItem.simageIcon = gohelper.findChildSingleImage(skillItem.go, "rouge2_commonskilliconitem/#go_Info/#simage_Icon")
	skillItem.imageRare = gohelper.findChildImage(skillItem.go, "rouge2_commonskilliconitem/#go_Info/#image_Rare")
	skillItem.click = gohelper.findChildClickWithDefaultAudio(skillItem.go, "clickarea")

	skillItem.click:AddClickListener(self.onclickItem, self)

	skillItem.goPointList = self:getUserDataTb_()
	skillItem.animatorPointList = self:getUserDataTb_()

	for i = 1, MAX_POINT do
		local go = gohelper.findChild(skillItem.go, "point/" .. i)

		table.insert(skillItem.goPointList, go)
		table.insert(skillItem.animatorPointList, go:GetComponent(gohelper.Type_Animator))
	end

	return skillItem
end

function FightViewRougeSkill2_3_7:onclickItem()
	if FightDataHelper.lockOperateMgr:isLock() then
		return
	end

	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.DouQuQu) then
		return
	end

	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.Enter) then
		return
	end

	local curOperateState = FightDataHelper.stageMgr:getCurOperateState()

	if not FightDataHelper.stageMgr:isEmptyOperateState() and curOperateState ~= FightStageMgr.OperateStateType.Discard and curOperateState ~= FightStageMgr.OperateStateType.RecordSkill and curOperateState ~= FightStageMgr.OperateStateType.DeviceDiscard then
		return
	end

	if FightViewHandCard.blockOperate then
		return
	end

	if FightDataHelper.stateMgr:getIsAuto() then
		return
	end

	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Play then
		return
	end

	gohelper.setActive(self.goTips, true)
	ZProj.UGUIHelper.RebuildLayout(self.rectContent)

	local width = recthelper.getWidth(self.rectContent)

	recthelper.setWidth(self.rectScrollDesc, width)
	recthelper.setWidth(self.rectBg, width + ScrollWidthOffset)
	gohelper.setParent(self.goTips, self.goFightRoot)
end

function FightViewRougeSkill2_3_7:tryShowGuide()
	local key = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.Rouge2_3_7Guide)
	local guided = PlayerPrefsHelper.getNumber(key, 0) ~= 0

	if guided then
		return
	end

	PlayerPrefsHelper.setNumber(key, 1)
	Rouge2_Controller.instance:openTechniqueView(26)
end

function FightViewRougeSkill2_3_7:onDestroyView()
	for _, skillItem in ipairs(self.skillItemList) do
		skillItem.simageIcon:UnLoadImage()
		skillItem.click:RemoveClickListener()
	end
end

return FightViewRougeSkill2_3_7
