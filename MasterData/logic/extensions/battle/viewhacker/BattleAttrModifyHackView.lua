-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewhacker/BattleAttrModifyHackView.lua

module("logic.extensions.battle.viewhacker.BattleAttrModifyHackView", package.seeall)

local M = class("BattleAttrModifyHackView", ViewComponent)

function M:buildUI()
	self._signGo = goutil.findChild(self.mainGO, "signGo")
	self._loopListHelper = LoopListHelper.New(self:getGo("skill_modify_view_-1389342960"))

	self._loopListHelper:InitListView(0, self._onCellUpdate, self)

	self._saveBtn = Astral.ButtonAdapter.GetFrom(self.mainGO, "saveBtn")
	self._idTxt = goutil.findChildTextComponent(self.mainGO, "content2/leftContent/txtCDKEY")
	self._nameTxt = goutil.findChildTextComponent(self.mainGO, "content2/leftContent/txtName")
	self._codeTxt = goutil.findChildTextComponent(self.mainGO, "content2/leftContent/txtID")
	self._levelTxt = goutil.findChildTextComponent(self.mainGO, "content2/leftContent/LEVEL")
	self._curHpInputField = Astral.InputFieldAdapter.Get(goutil.findChild(self.mainGO, "content2/centerContent/InputField2"))
	self._maxHpTxt = goutil.findChildTextComponent(self.mainGO, "content2/centerContent/txtHP2")
	self._curSanInputField = Astral.InputFieldAdapter.Get(goutil.findChild(self.mainGO, "content2/centerContent/InputField3"))
	self._backCountInputField = Astral.InputFieldAdapter.Get(goutil.findChild(self.mainGO, "inputBackCount"))
	self._careerDropHandler = Astral.SimpleLuaComponentContainer.Add(goutil.findChild(self.mainGO, "content2/leftContent/filter7"), BattleDropDownBtnHandler)
	self._colorDropHandler = Astral.SimpleLuaComponentContainer.Add(goutil.findChild(self.mainGO, "content2/leftContent/filter8"), BattleDropDownBtnHandler)
	self._campDropHandler = Astral.SimpleLuaComponentContainer.Add(goutil.findChild(self.mainGO, "content2/leftContent/filter9"), BattleDropDownBtnHandler)
	self._battleCampDropHandler = Astral.SimpleLuaComponentContainer.Add(goutil.findChild(self.mainGO, "content2/leftContent/filter10"), BattleDropDownBtnHandler)
	self._monsterDropGo = goutil.findChild(self.mainGO, "content2/leftContent/filter11")
	self._monsterDropHandler = Astral.SimpleLuaComponentContainer.Add(self._monsterDropGo, BattleDropDownBtnHandler)
	self._stepConditionDropHandler = Astral.SimpleLuaComponentContainer.Add(goutil.findChild(self.mainGO, "content2/centerContent/filter4"), BattleDropDownBtnHandler)

	self._careerDropHandler:setDropChangeCallBack(self._onDropChanged, self)
	self._colorDropHandler:setDropChangeCallBack(self._onDropChanged, self)
	self._campDropHandler:setDropChangeCallBack(self._onDropChanged, self)
	self._battleCampDropHandler:setDropChangeCallBack(self._onDropChanged, self)
	self._monsterDropHandler:setDropChangeCallBack(self._onDropChanged, self)
	self._stepConditionDropHandler:setDropChangeCallBack(self._onDropChanged, self)

	self._monsterHeadTxtGo = goutil.findChild(self.mainGO, "content2/leftContent/txt11")

	local career2NameCfg = {
		[GameEnum.CareerEnum.Sentinel] = "幻影",
		[GameEnum.CareerEnum.Assault] = "守卫",
		[GameEnum.CareerEnum.Sniper] = "狙击",
		[GameEnum.CareerEnum.Super] = "特异",
		[GameEnum.CareerEnum.Heavy] = "陨灭",
		[GameEnum.CareerEnum.Cure] = "支援",
		[GameEnum.CareerEnum.Grox] = "Grox",
		[GameEnum.CareerEnum.Myth] = "神话"
	}
	local color2NameCfg = {
		"红色",
		"蓝色",
		"绿色",
		"灰色"
	}
	local camp2NameCfg = {
		[1] = "无",
		[GameEnum.CampEnum.OAD + 1] = "OAD",
		[GameEnum.CampEnum.TreeOfEden + 1] = "伊甸之树",
		[GameEnum.CampEnum.BrotherhoodOfTruth + 1] = "真理兄弟会",
		[GameEnum.CampEnum.SilverDawnAssociation + 1] = "白银黎明协会",
		[GameEnum.CampEnum.Noah + 1] = "诺亚",
		[GameEnum.CampEnum.StarrySkyChurch + 1] = "星空教会",
		[GameEnum.CampEnum.WaterDroplets + 1] = "水滴结社"
	}
	local battleCamp2NameCfg = {
		"敌方",
		"友方",
		"己方"
	}
	local monster2NameCfg = {
		"小怪",
		"精英",
		"BOSS"
	}
	local step2NameCfg = {
		[1] = "未行动",
		[2] = "已行动"
	}

	self._careerDropHandler:setIndex2Name(career2NameCfg)
	self._colorDropHandler:setIndex2Name(color2NameCfg)
	self._campDropHandler:setIndex2Name(camp2NameCfg)
	self._battleCampDropHandler:setIndex2Name(battleCamp2NameCfg)
	self._monsterDropHandler:setIndex2Name(monster2NameCfg)
	self._stepConditionDropHandler:setIndex2Name(step2NameCfg)

	self._addBuffBtn = Astral.ButtonAdapter.GetFrom(self.mainGO, "content2/centerContent/buff_item/addBtn")
	self._addSkillBtn = Astral.ButtonAdapter.GetFrom(self.mainGO, "content2/centerContent/skill_item/btn")
	self._clearSkillCDBtn = Astral.ButtonAdapter.GetFrom(self.mainGO, "content2/centerContent/skill_item/clear")
	self._buffListHelper = LoopListHelper.New(goutil.findChild(self.mainGO, "content2/centerContent/buffScroll"))

	self._buffListHelper:InitListView(0, self._onBuffCellUpdate, self)

	self._skillListHelper = LoopListHelper.New(goutil.findChild(self.mainGO, "content2/centerContent/skillScroll"))

	self._skillListHelper:InitListView(0, self._onSkillCellUpdate, self)

	self._attrPartContentGo = goutil.findChild(self.mainGO, "content2/rightContent/contentScroll/viewPort/attributeLayout")
	self._attrPartCurTxtList = {}
	self._attrPartHackInputFiledList = {}

	local atrrGoList = Astral.GameObjectUtil.GetChildren(self._attrPartContentGo)
	local attrPartEnum = BattleExtension_pb.AttributePart

	for index = 0, atrrGoList.Length - 1 do
		local attrGo = atrrGoList[index]
		local code = checkint(attrGo.name)

		if code and code ~= 0 then
			local nameTxt = goutil.findChildTextComponent(attrGo, "txt4")
			local partCO = AttributeDefineConfig.instance:getAttributePartDefineCO(code)

			nameTxt.text = partCO.name

			local serverCode = attrPartEnum[partCO.programming]

			self._attrPartCurTxtList[serverCode] = goutil.findChildTextComponent(attrGo, "txtCurrentValue")
			self._attrPartHackInputFiledList[serverCode] = Astral.InputFieldAdapter.Get(goutil.findChild(attrGo, "InputField3"))
		end
	end

	self._finalHpTxt = goutil.findChildTextComponent(self._attrPartContentGo, "finalHP/txtCurrentValue")
	self._finalAtkTxt = goutil.findChildTextComponent(self._attrPartContentGo, "finalATK/txtCurrentValue")
	self._finalDefTxt = goutil.findChildTextComponent(self._attrPartContentGo, "finalDEF/txtCurrentValue")
	self._finalMagTxt = goutil.findChildTextComponent(self._attrPartContentGo, "finalMAG/txtCurrentValue")
	self._finalMagDefTxt = goutil.findChildTextComponent(self._attrPartContentGo, "finalMAGDEF/txtCurrentValue")
end

function M:bindEvents()
	self._saveBtn:AddClickListener(self._onClickSaveBtn, self)
	self._addBuffBtn:AddClickListener(self._onClickAddBuffBtn, self)
	self._addSkillBtn:AddClickListener(self._onClickAddSkillBtn, self)
	self._clearSkillCDBtn:AddClickListener(self._onClearSkillCD, self)
	self._curHpInputField:AddOnEndEdit(self._onEndEditCurHp, self)
	self._curSanInputField:AddOnEndEdit(self._onEndCurSan, self)
	self._backCountInputField:AddOnEndEdit(self._onEndBackCountEdit, self)

	for code, v in pairs(self._attrPartHackInputFiledList) do
		v:AddOnEndEdit(function()
			self:_onEndAttrEdit(code)
		end, self)
	end
end

function M:unbindEvents()
	self._saveBtn:RemoveClickListener()
	self._addBuffBtn:RemoveClickListener()
	self._addSkillBtn:RemoveClickListener()
	self._clearSkillCDBtn:RemoveClickListener()
	self._curHpInputField:RemoveOnEndEdit()
	self._curSanInputField:RemoveOnEndEdit()
	self._backCountInputField:RemoveOnEndEdit()

	for code, v in pairs(self._attrPartHackInputFiledList) do
		v:RemoveOnEndEdit()
	end
end

function M:_onClickAddBuffBtn()
	local newBuffNO = GmExtension_pb.BattleHackableBuffNO()

	newBuffNO.id = 0
	newBuffNO.code = 0
	newBuffNO.round = 1
	newBuffNO.layer = 0

	table.insert(self._buffList, newBuffNO)
	self:_refreshBuffPanel()
end

function M:_onClearSkillCD()
	local entityNO = self._entityList[self._selectIndex]

	entityNO.clearSkillCd = true

	self:_sendChangeAgent()
end

function M:_onClickAddSkillBtn()
	local newSkillNO = GmExtension_pb.BattleHackableSkillNO()

	newSkillNO.code = 0
	newSkillNO.type = 1

	table.insert(self._skillList, newSkillNO)
	self:_refreshSkillPanel()
end

function M:_onClickSaveBtn()
	self:_saveAddAndDeleteSkill()

	local entityNO = self._entityList[self._selectIndex]

	table.clear(entityNO.skills)

	for i, v in ipairs(self._skillList) do
		table.insert(entityNO.skills, v)
	end

	table.clear(entityNO.buffs)

	for i, v in ipairs(self._buffList) do
		table.insert(entityNO.buffs, v)
	end

	local battle = BattleAttrHackModel.instance:getBattleAttrInfo()

	HackToolAgent.instance:sendHackBattleInfoRequest(battle)
end

function M:_saveAddAndDeleteSkill()
	local entityNO = self._entityList[self._selectIndex]
	local id = entityNO.id
	local unit = BattleMgr.instance:getUnitMgr():getUnit(id)
	local skillComp = unit.skill
	local allSkillList = skillComp:getActiveSkillList()
	local removeSkillList = {}
	local addSkillList = {}

	for k, skillMO in pairs(allSkillList) do
		local hasSkill = false

		for i, skillNO in ipairs(self._skillList) do
			if skillMO:getSkillId() == skillNO.code then
				hasSkill = true
			end
		end

		if not hasSkill then
			table.insert(removeSkillList, skillMO:getSkillId())
		end
	end

	for i, skillNO in ipairs(self._skillList) do
		local hasSkill = false

		for k, skillMO in pairs(allSkillList) do
			if skillMO:getSkillId() == skillNO.code then
				hasSkill = true
			end
		end

		if not hasSkill then
			table.insert(addSkillList, skillNO.code)
		end
	end

	BattleAttrHackModel.instance:setAddAndRemoveSkillList(addSkillList, removeSkillList)
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.HACK_BATTLE_INFO_INIT, self._refreshView, self)
	else
		GlobalDispatcher:removeEventListener(EventType.HACK_BATTLE_INFO_INIT, self._refreshView, self)
	end
end

function M:onExit()
	self._loopListHelper:ClearCells()
	self._buffListHelper:ClearCells()
	self._skillListHelper:ClearCells()
	self:setEvent(false)
end

function M:destroyUI()
	self._loopListHelper:Dispose()

	self._loopListHelper = nil

	self._buffListHelper:Dispose()

	self._buffListHelper = nil

	self._skillListHelper:Dispose()

	self._skillListHelper = nil
	self._backCountInputField = nil
end

function M:onEnter()
	BattleAttrHackModel.instance:clearNeedRemoveSkillList()
	self:_sendAgent()

	self._selectIndex = 1

	self:setEvent(true)
end

function M:_sendAgent()
	HackToolAgent.instance:sendGetBattleHackableInfoRequest()
end

function M:_removeSign()
	goutil.setActive(self._signGo, false)
end

function M:_refreshView()
	goutil.setActive(self._signGo, true)
	settimer(3, self._removeSign, self, false)

	local battle = BattleAttrHackModel.instance:getBattleAttrInfo()

	self._entityList = BattleAttrHackModel.instance:getEntityInfoList()

	self._loopListHelper:SetListItemCount(#self._entityList, true)
	self._loopListHelper:RefreshAllShownItem()
	self._backCountInputField:SetText(battle.leftBackCount)
	self:_initScrollList()
	self:_refreshRightPanel()
	self:_addAndRemoveSkill()
end

function M:_addAndRemoveSkill()
	local addSkillList, removeSkillList = BattleAttrHackModel.instance:getNeedAddAndRemoveSkillList()
	local entityNO = self._entityList[self._selectIndex]
	local id = entityNO.id
	local unit = BattleMgr.instance:getUnitMgr():getUnit(id)
	local skillComp = unit.skill

	for i, v in ipairs(removeSkillList) do
		skillComp:removeSkill(v)
	end

	BattleAttrHackModel.instance:clearNeedRemoveSkillList()
end

function M:_initScrollList()
	local entityNO = self._entityList[self._selectIndex]

	self._skillList = {}
	self._buffList = {}

	for _, skillNO in ipairs(entityNO.skills or {}) do
		local newSkillNO = GmExtension_pb.BattleHackableSkillNO()

		newSkillNO.code = skillNO.code
		newSkillNO.type = skillNO.type

		table.insert(self._skillList, newSkillNO)
	end

	for _, buffNO in ipairs(entityNO.buffs or {}) do
		local newBuffNO = GmExtension_pb.BattleHackableBuffNO()

		newBuffNO.id = buffNO.id
		newBuffNO.code = buffNO.code
		newBuffNO.round = buffNO.round
		newBuffNO.layer = buffNO.layer

		table.insert(self._buffList, newBuffNO)
	end
end

function M:_refreshRightPanel()
	self:_refreshLeftAndCenterPanel()
	self:_refreshBuffPanel()
	self:_refreshSkillPanel()
	self:_refreshAttrPartPanel()
end

function M:_refreshLeftAndCenterPanel()
	local entityNO = self._entityList[self._selectIndex]
	local id = entityNO.id
	local unit = BattleMgr.instance:getUnitMgr():getUnit(id)
	local propertyComp = unit.property

	self._idTxt.text = id
	self._nameTxt.text = propertyComp:getName()
	self._codeTxt.text = propertyComp:getEntityCode()
	self._maxHpTxt.text = string.format("/%d", propertyComp:getMaxHp())
	self._levelTxt.text = propertyComp:getLevel()

	self._curHpInputField:SetText(entityNO.currentHp)
	self._curSanInputField:SetText(entityNO.currentSanity or 0)
	self._careerDropHandler:setSelectIndex(entityNO.career)
	self._colorDropHandler:setSelectIndex(entityNO.color)
	self._campDropHandler:setSelectIndex(entityNO.camp + 1)

	local model = BattleMgr.instance:getModel()
	local selfCamp = model:getOperateCampId()
	local relationType = model:getCampRelation(selfCamp, propertyComp:getCampId())

	self._battleCampDropHandler:setSelectIndex(relationType)

	if BattleUnitUtil.isMonster(unit) then
		goutil.setActive(self._monsterHeadTxtGo, true)
		goutil.setActive(self._monsterDropGo, true)
		self._monsterDropHandler:setSelectIndex(entityNO.monsterType + 1)
	else
		goutil.setActive(self._monsterHeadTxtGo, false)
		goutil.setActive(self._monsterDropGo, false)
	end

	self._stepConditionDropHandler:setSelectIndex(entityNO.steppable and 1 or 2)
end

function M:_onDropChanged()
	local entityNO = self._entityList[self._selectIndex]

	entityNO.career = self._careerDropHandler:getSelectIndex()
	entityNO.color = self._colorDropHandler:getSelectIndex()
	entityNO.camp = self._campDropHandler:getSelectIndex() - 1
	entityNO.monsterType = self._monsterDropHandler:getSelectIndex() - 1
	entityNO.steppable = self._stepConditionDropHandler:getSelectIndex() == 1 and true or false

	self:_sendChangeAgent()
end

function M:_refreshBuffPanel()
	self._buffListHelper:SetListItemCount(#self._buffList, true)
	self._buffListHelper:RefreshAllShownItem()
end

function M:_refreshSkillPanel()
	self._skillListHelper:SetListItemCount(#self._skillList, true)
	self._skillListHelper:RefreshAllShownItem()
end

function M:_refreshAttrPartPanel()
	local entityNO = self._entityList[self._selectIndex]

	self._attrPartList = {}

	for i, v in ipairs(entityNO.attributes) do
		self._attrPartList[v.key] = v
	end

	for code, txt in pairs(self._attrPartCurTxtList) do
		txt.text = self._attrPartList[code] and self._attrPartList[code].currentValue or -1
	end

	for code, inputField in pairs(self._attrPartHackInputFiledList) do
		inputField:SetText(self._attrPartList[code] and self._attrPartList[code].modifiableValue or 0)
	end

	self:_refreshFinalCount()
end

function M:_refreshFinalCount()
	self._finalHpTxt.text = self:_calculateFinal(BattleExtension_pb.AttributePart.PART_MAX_HP_BASE)
	self._finalAtkTxt.text = self:_calculateFinal(BattleExtension_pb.AttributePart.PART_ATK_PHY_BASE)
	self._finalDefTxt.text = self:_calculateFinal(BattleExtension_pb.AttributePart.PART_DEF_PHY_BASE)
	self._finalMagTxt.text = self:_calculateFinal(BattleExtension_pb.AttributePart.PART_ATK_MAG_BASE)
	self._finalMagDefTxt.text = self:_calculateFinal(BattleExtension_pb.AttributePart.PART_DEF_MAG_BASE)
end

function M:_calculateFinal(attrEnumCode)
	local base = self._attrPartList[attrEnumCode].currentValue
	local increase = self._attrPartList[attrEnumCode + 1].currentValue
	local extra = self._attrPartList[attrEnumCode + 2].currentValue

	return base * (1 + increase) + extra
end

function M:_onCellUpdate(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local unit = self._entityList[curIndex]
	local item = self._loopListHelper:NewListViewItem("value1")
	local shower = Astral.SimpleLuaComponentContainer.Add(item.gameObject, BattleHackEntityCell)

	shower:setData(unit, curIndex)
	shower:setClickCallBack(self._onClickItem, self)
	shower:setSelectStatus(curIndex == self._selectIndex)

	return item
end

function M:_onBuffCellUpdate(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local data = self._buffList[curIndex]
	local item = self._buffListHelper:NewListViewItem("buff_item1")
	local shower = Astral.SimpleLuaComponentContainer.Add(item.gameObject, BattleHackBuffCell)

	shower:setData(data, curIndex)
	shower:setClickCallBack(self._onClickDeleteBuff, self)

	return item
end

function M:_onSkillCellUpdate(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local data = self._skillList[curIndex]
	local item = self._skillListHelper:NewListViewItem("skill_item1")
	local shower = Astral.SimpleLuaComponentContainer.Add(item.gameObject, BattleHackSkillCell)

	shower:setData(data, curIndex)
	shower:setClickCallBack(self._onClickDeleteSkill, self)

	return item
end

function M:_onClickDeleteBuff(index)
	table.remove(self._buffList, index)
	self:_refreshBuffPanel()
end

function M:_onClickDeleteSkill(index)
	table.remove(self._skillList, index)
	self:_refreshSkillPanel()
end

function M:_onClickItem(index)
	if self._selectIndex == index then
		return
	end

	self._selectIndex = index

	self._loopListHelper:RefreshAllShownItem()
	self:_initScrollList()
	self:_refreshRightPanel()
end

function M:_onEndEditCurHp()
	if self._curHpInputField:GetText() ~= "" then
		local hp = tonumber(self._curHpInputField:GetText())

		if self._entityList[self._selectIndex].currentHp == hp then
			return
		end

		self._entityList[self._selectIndex].currentHp = hp

		self:_sendChangeAgent()
	end
end

function M:_onEndCurSan()
	if self._curHpInputField:GetText() ~= "" then
		local san = tonumber(self._curSanInputField:GetText())

		if self._entityList[self._selectIndex].currentSanity == san then
			return
		end

		self._entityList[self._selectIndex].currentSanity = san

		self:_sendChangeAgent()
	end
end

function M:_onEndBackCountEdit()
	local battle = BattleAttrHackModel.instance:getBattleAttrInfo()

	battle.leftBackCount = checkint(self._backCountInputField:GetText())

	self:_sendChangeAgent()
end

function M:_onEndAttrEdit(attrServerCode)
	if self._attrPartHackInputFiledList[attrServerCode]:GetText() ~= "" then
		local attr = tonumber(self._attrPartHackInputFiledList[attrServerCode]:GetText())
		local entityNO = self._entityList[self._selectIndex]

		self._attrPartList = {}

		for i, v in ipairs(entityNO.attributes) do
			if v.key == attrServerCode then
				if v.modifiableValue == attr then
					return
				end

				v.modifiableValue = attr

				break
			end
		end

		self:_sendChangeAgent()
	end
end

function M:_sendChangeAgent()
	BattleAttrHackModel.instance:clearNeedRemoveSkillList()

	local battle = BattleAttrHackModel.instance:getBattleAttrInfo()

	HackToolAgent.instance:sendHackBattleInfoRequest(battle)
end

return M
