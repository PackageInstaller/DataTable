-- chunkname: @modules/logic/survival/view/shelter/SurvivalEquipView.lua

module("modules.logic.survival.view.shelter.SurvivalEquipView", package.seeall)

local SurvivalEquipView = class("SurvivalEquipView", BaseView)

function SurvivalEquipView:onInitView()
	self._btnAttr = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_Overview")
	self._animscore = gohelper.findChildAnim(self.viewGO, "Left/Assess")
	self._txtTotalScore = gohelper.findChildTextMesh(self.viewGO, "Left/Assess/image_NumBG/#txt_Num")
	self._imageScore = gohelper.findChildImage(self.viewGO, "Left/Assess/image_NumBG/#txt_Num/txt_Assess/image_AssessIon")
	self._goscroll = gohelper.findChild(self.viewGO, "Right/scroll_collection")
	self._gocontent = gohelper.findChild(self.viewGO, "Right/scroll_collection/Viewport/Content")
	self._goinfoview = gohelper.findChild(self.viewGO, "#go_infoview")
	self._gosort = gohelper.findChild(self.viewGO, "Right/#go_sort")
	self._goplan = gohelper.findChild(self.viewGO, "Left/plans")
	self._goplanitem = gohelper.findChild(self.viewGO, "Left/plans/item")
	self._goequipitem = gohelper.findChild(self.viewGO, "Left/equips/item")
	self._gospequipitem = gohelper.findChild(self.viewGO, "Left/equips/#go_sppos/item_sppos")
	self._animskill = gohelper.findChildAnim(self.viewGO, "Left/equips/Middle")
	self._btnEquipSkill = gohelper.findChildButtonWithAudio(self.viewGO, "Left/equips/Middle/#btn_click")
	self._gohas = gohelper.findChild(self.viewGO, "Left/equips/Middle/#go_Has")
	self._imageSkill = gohelper.findChildSingleImage(self.viewGO, "Left/equips/Middle/#go_Has")
	self._imageFrequency = gohelper.findChildImage(self.viewGO, "Left/equips/Middle/#go_Has/Frequency/image_NumBG/#txt_Num/image_FrequencyIcon")
	self._txtFrequency = gohelper.findChildTextMesh(self.viewGO, "Left/equips/Middle/#go_Has/Frequency/image_NumBG/#txt_Num")
	self._goempty = gohelper.findChild(self.viewGO, "Left/equips/Middle/#go_Empty")
	self._golevel32 = gohelper.findChild(self.viewGO, "Left/equips/Middle/#level3")
	self._golevel1 = gohelper.findChild(self.viewGO, "Left/equips/Middle/#go_Has/#level1")
	self._golevel2 = gohelper.findChild(self.viewGO, "Left/equips/Middle/#go_Has/#level2")
	self._golevel3 = gohelper.findChild(self.viewGO, "Left/equips/Middle/#go_Has/#level3")
	self._btn_onekeyEquip = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_onekeyEquip")
	self._goequipred = gohelper.findChild(self.viewGO, "Left/#btn_onekeyEquip/#go_arrow")
	self._btn_onekeyUnEquip = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_onekeyUnEquip")
	self._goonekeyEquipTips = gohelper.findChild(self.viewGO, "Left/#btn_onekeyEquip/#go_tips")
	self._goonekeyEquipTipsItem = gohelper.findChild(self.viewGO, "Left/#btn_onekeyEquip/#go_tips/#go_item")
	self._anim = gohelper.findChildAnim(self.viewGO, "")
end

function SurvivalEquipView:addEvents()
	self._btnEquipSkill:AddClickListener(self.onAttrClick, self)
	self._btnAttr:AddClickListener(self.onAttrClick, self)
	self._btn_onekeyEquip:AddClickListener(self.oneKeyEquip, self)
	self._btn_onekeyUnEquip:AddClickListener(self.oneKeyUnEquip, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapBagUpdate, self._refreshBag, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnShelterBagUpdate, self._refreshBag, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnEquipInfoUpdate, self.onChangePlan, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnEquipMaxTagUpdate, self.onMaxTagChange, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnEquipRedUpdate, self.updateRed, self)
	self.addEventCb(self, GameStateMgr.instance, GameStateEvent.OnTouchScreen, self.onTouchScreen, self)
	CommonDragHelper.instance:registerDragObj(self._gocontent, self._beginDrag, self._onDrag, self._endDrag, nil, self, nil, true)
end

function SurvivalEquipView:removeEvents()
	CommonDragHelper.instance:unregisterDragObj(self._gocontent)
	self._btnEquipSkill:RemoveClickListener()
	self._btnAttr:RemoveClickListener()
	self._btn_onekeyEquip:RemoveClickListener()
	self._btn_onekeyUnEquip:RemoveClickListener()
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapBagUpdate, self._refreshBag, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnShelterBagUpdate, self._refreshBag, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnEquipInfoUpdate, self.onChangePlan, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnEquipMaxTagUpdate, self.onMaxTagChange, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnEquipRedUpdate, self.updateRed, self)
end

function SurvivalEquipView:onOpen()
	self._equipBox = SurvivalShelterModel.instance:getWeekInfo().equipBox

	local inSurvival = self:isInSurvival()

	gohelper.setActive(self._goplan, not inSurvival)

	if not inSurvival then
		self._planSelects = {}

		gohelper.CreateObjList(self, self._createPlanItem, {
			1,
			2,
			3,
			4
		}, nil, self._goplanitem)
	end

	local itemRes = self.viewContainer._viewSetting.otherRes.itemRes

	self._item = self:getResInst(itemRes, self.viewGO)

	gohelper.setActive(self._item, false)

	local dragGo = self:getResInst(itemRes, self.viewGO)
	local anim = gohelper.findChildAnim(dragGo, "")

	if anim then
		anim.enabled = false
	end

	self._dragItem = MonoHelper.addNoUpdateLuaComOnceToGo(dragGo, SurvivalBagItem)

	self._dragItem:setShowNum(false)
	gohelper.setActive(dragGo, false)

	self._equipItems = {}

	local len = #self._equipBox.slots
	local root = gohelper.findChild(self.viewGO, "Left/equips/#go_Pos1")

	self._gopos = self:getUserDataTb_()

	for i = 1, len do
		local go = gohelper.findChild(root, "pos" .. i)
		local cloneGo = gohelper.clone(self._goequipitem, go)
		local equipItem = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGo, SurvivalEquipItem)

		equipItem:initIndex(i)
		equipItem:setParentView(self)
		equipItem:setItemRes(self._item)
		equipItem:setClickCallback(self._onClickEquipItem, self)
		equipItem:setParentRoot(self.viewGO.transform)

		self._equipItems[i] = equipItem
		self._gopos[i] = go
	end

	self._spEquipItems = {}
	self._spGoPos = {}

	for i = 1, 3 do
		local go = gohelper.findChild(self.viewGO, "Left/equips/#go_sppos/#go_pos" .. i)
		local cloneGo = gohelper.clone(self._gospequipitem, go)
		local equipItem = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGo, SurvivalSpEquipItem)

		equipItem:initIndex(i)
		equipItem:setParentView(self)
		equipItem:setClickCallback(self._onClickEquipItem2, self)
		equipItem:setParentRoot(self.viewGO.transform)

		self._spEquipItems[i] = equipItem
		self._spGoPos[i] = go
	end

	gohelper.setActive(self._goequipitem, false)
	gohelper.setActive(self._gospequipitem, false)

	local sortComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._gosort, SurvivalSortAndFilterPart)
	local sortOptions = {}

	sortOptions[1] = {
		desc = luaLang("survival_sort_time"),
		type = SurvivalEnum.ItemSortType.Time
	}
	sortOptions[2] = {
		desc = luaLang("survival_sort_mass"),
		type = SurvivalEnum.ItemSortType.Mass
	}
	sortOptions[3] = {
		desc = luaLang("survival_sort_worth"),
		type = SurvivalEnum.ItemSortType.Worth
	}
	sortOptions[4] = {
		desc = luaLang("survival_sort_type"),
		type = SurvivalEnum.ItemSortType.Type
	}

	local filterOptions = {}

	for i, co in ipairs(lua_survival_equip_found.configList) do
		table.insert(filterOptions, {
			desc = co.name,
			type = co.id
		})
	end

	self._curSort = sortOptions[1]
	self._isDec = true
	self._filterList = {}

	sortComp:setOptions(sortOptions, filterOptions, self._curSort, self._isDec)
	sortComp:setOptionChangeCallback(self._onSortChange, self)

	local infoViewRes = self.viewContainer._viewSetting.otherRes.infoView
	local infoGo = self:getResInst(infoViewRes, self._goinfoview)

	self._infoPanel = MonoHelper.addNoUpdateLuaComOnceToGo(infoGo, SurvivalBagInfoPart)

	local t = {
		[SurvivalEnum.ItemSource.Map] = SurvivalEnum.ItemSource.EquipBag,
		[SurvivalEnum.ItemSource.Shelter] = SurvivalEnum.ItemSource.EquipBag
	}

	self._infoPanel:setChangeSource(t)
	self._infoPanel:setCloseShow(true, self._onTipsClose, self)

	self._simpleList = MonoHelper.addNoUpdateLuaComOnceToGo(self._goscroll, SurvivalSimpleListPart)

	self._simpleList:setCellUpdateCallBack(self._createItem, self, SurvivalBagItem, self._item)
	self:_refreshBag()
	self:onChangePlan(true)

	self._equipTagRed = self:getUserDataTb_()

	gohelper.CreateObjList(self, self._createOneKeyEquipItem, filterOptions, nil, self._goonekeyEquipTipsItem, nil, nil, nil, 1)
	self:updateRed()
end

function SurvivalEquipView:getDragIndex(position, isSp)
	if gohelper.isMouseOverGo(self._goscroll) then
		return -1
	end

	if isSp then
		for i, go in ipairs(self._spGoPos) do
			if gohelper.isMouseOverGo(go, position) then
				return i, self._spEquipItems[i]
			end
		end
	else
		for i, go in ipairs(self._gopos) do
			if gohelper.isMouseOverGo(go, position) then
				return i, self._equipItems[i]
			end
		end
	end
end

function SurvivalEquipView:_createOneKeyEquipItem(obj, data, index)
	local txtdesc = gohelper.findChildTextMesh(obj, "#txt_desc")
	local equipTagRed = gohelper.findChild(obj, "#go_arrow")

	txtdesc.text = data.desc

	local click = gohelper.getClick(obj)

	self.addClickCb(self, click, self._onClickFilterItem, self, data)

	self._equipTagRed[data.type] = equipTagRed
end

function SurvivalEquipView:updateRed()
	gohelper.setActive(self._goequipred, SurvivalEquipRedDotHelper.instance.reddotType >= 0)

	for tag, go in pairs(self._equipTagRed) do
		gohelper.setActive(go, tag == SurvivalEquipRedDotHelper.instance.reddotType)
	end
end

function SurvivalEquipView:_onClickFilterItem(data)
	GameFacade.showToast(ToastEnum.SurvivalOneKeyEquip)
	gohelper.setActive(self._goonekeyEquipTips, false)
	SurvivalWeekRpc.instance:sendSurvivalEquipOneKeyWear(data.type)
end

function SurvivalEquipView:onAttrClick()
	ViewMgr.instance:openView(ViewName.SurvivalEquipOverView)
end

function SurvivalEquipView:oneKeyEquip()
	gohelper.setActive(self._goonekeyEquipTips, not self._goonekeyEquipTips.activeSelf)
end

function SurvivalEquipView:oneKeyUnEquip()
	GameFacade.showToast(ToastEnum.SurvivalOneKeyUnEquip)
	SurvivalWeekRpc.instance:sendSurvivalEquipOneKeyDemount()
end

function SurvivalEquipView:_createPlanItem(obj, data, index)
	self._planSelects[index] = gohelper.findChild(obj, "#go_select")

	local txt = gohelper.findChildTextMesh(obj, "#txt_planId")
	local txt2 = gohelper.findChildTextMesh(obj, "#go_select/#txt_planId")

	txt.text = string.format("%02d", index)
	txt2.text = string.format("%02d", index)

	local btn = gohelper.findChildButtonWithAudio(obj, "#btn_click")

	self.addClickCb(self, btn, self._onClickPlan, self, index)
end

function SurvivalEquipView:_onClickPlan(index)
	if self._equipBox.currPlanId == index then
		return
	end

	self._lockUpdate = true

	SurvivalWeekRpc.instance:sendSurvivalEquipSwitchPlan(index, self._onServerSwitchPlan, self)
end

function SurvivalEquipView:_onServerSwitchPlan(cmd, resultCode, msg)
	if resultCode == 0 then
		self._anim:Play("switch", 0, 0)
		UIBlockHelper.instance:startBlock("SurvivalEquipView_swicth", 0.167)
		TaskDispatcher.runDelay(self.onChangePlanBySwitch, self, 0.167)
	end

	self._lockUpdate = false
end

function SurvivalEquipView:onChangePlanBySwitch()
	self:onChangePlan(true)
end

local scoreColor = {
	"#617B8E",
	"#855AA1",
	"#AF490B"
}

function SurvivalEquipView:onChangePlan(isNoAnim)
	if self._lockUpdate then
		return
	end

	if self._planSelects then
		for index, select in pairs(self._planSelects) do
			gohelper.setActive(select, self._equipBox.currPlanId == index)
		end
	end

	local totalScore = 0

	for i = 1, #self._equipItems do
		if self._equipBox.slots[i] then
			totalScore = totalScore + self._equipBox.slots[i]:getScore()
		end

		self._equipItems[i]:initData(self._equipBox.slots[i], isNoAnim)
	end

	for i = 1, #self._spEquipItems do
		if self._equipBox.jewelrySlots[i] then
			totalScore = totalScore + self._equipBox.jewelrySlots[i]:getScore()
		end

		self._spEquipItems[i]:initData(self._equipBox.jewelrySlots[i], isNoAnim)
	end

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId, true)

		self._tweenId = nil
	end

	if isNoAnim or not self._nowScore or self._nowScore == totalScore then
		self:onScoreChange(totalScore)
	else
		self._tweenId = ZProj.TweenHelper.DOTweenFloat(self._nowScore, totalScore, 1, self.onScoreChange, self.onScoreEnd, self)
	end

	self:onMaxTagChange(isNoAnim)
end

function SurvivalEquipView:onScoreEnd()
	self._tweenId = nil

	self._animscore:Play("change", 0, 0)
end

function SurvivalEquipView:onScoreChange(totalScore)
	totalScore = math.floor(totalScore)
	self._nowScore = totalScore

	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local worldLevel = weekInfo:getAttr(SurvivalEnum.AttrType.WorldLevel)
	local str = lua_survival_equip_score.configDict[worldLevel][2].level
	local level = 1

	if not string.nilorempty(str) then
		for i, v in ipairs(string.splitToNumber(str, "#")) do
			if v <= totalScore then
				level = i + 1
			end
		end
	end

	UISpriteSetMgr.instance:setSurvivalSprite(self._imageScore, "survivalequip_scoreicon_" .. level)

	self._txtTotalScore.text = string.format("<color=%s>%s</color>", scoreColor[level] or scoreColor[1], totalScore)
end

function SurvivalEquipView:onMaxTagChange(isNoAnim)
	local tagCo = lua_survival_equip_found.configDict[self._equipBox.maxTagId]
	local level = 0

	if tagCo then
		if not self._equipBox.values[tagCo.value] then
			do
				local attrNum = 0
				local arr = string.splitToNumber(tagCo.level, "#") or {}

				for k, v in ipairs(arr) do
					if v <= self._equipBox.values[tagCo.value] then
						level = k
					end
				end
			end

			if self._preLv == level and self._preTagCo == tagCo then
				if tagCo then
					UISpriteSetMgr.instance:setSurvivalSprite(self._imageFrequency, tagCo.value)

					self._txtFrequency.text = self._equipBox.values[tagCo.value] or 0
				end

				return
			end

			if self._nextLv then
				self._preLv = self._nextLv
			end
		end
	end

	TaskDispatcher.cancelTask(self._delayShowTagCo, self)

	if isNoAnim or not self._preLv then
		self._preLv = level
		self._preTagCo = tagCo

		gohelper.setActive(self._gohas, tagCo)
		gohelper.setActive(self._goempty, not tagCo)
		gohelper.setActive(self._golevel32, level == 3)
		gohelper.setActive(self._golevel1, level == 1)
		gohelper.setActive(self._golevel2, level == 2)
		gohelper.setActive(self._golevel3, level == 3)

		if tagCo then
			self._imageSkill:LoadImage(ResUrl.getSurvivalEquipIcon(tagCo.icon))
			UISpriteSetMgr.instance:setSurvivalSprite(self._imageFrequency, tagCo.value)

			self._txtFrequency.text = self._equipBox.values[tagCo.value] or 0

			self._animskill:Play("equip_in", 0, 1)
		else
			self._animskill:Play("empty_in", 0, 1)
		end
	elseif self._preTagCo ~= tagCo then
		self._preLv = level
		self._nextTagCo = tagCo

		self._animskill:Play(self._preTagCo and "equipout" or "emptyout", 0, 0)
		TaskDispatcher.runDelay(self._delayShowTagCo, self, 0.1)

		self._preTagCo = tagCo
	else
		if tagCo then
			UISpriteSetMgr.instance:setSurvivalSprite(self._imageFrequency, tagCo.value)

			self._txtFrequency.text = self._equipBox.values[tagCo.value] or 0
		end

		self._nextLv = level

		self:_delayShowLevelAnim()
	end
end

function SurvivalEquipView:_delayShowTagCo()
	gohelper.setActive(self._gohas, self._nextTagCo)
	gohelper.setActive(self._goempty, not self._nextTagCo)
	self._animskill:Play(self._nextTagCo and "equip_in" or "empty_in", 0, 0)

	if self._nextTagCo then
		self._imageSkill:LoadImage(ResUrl.getSurvivalEquipIcon(self._nextTagCo.icon))
		UISpriteSetMgr.instance:setSurvivalSprite(self._imageFrequency, self._nextTagCo.value)

		self._txtFrequency.text = self._equipBox.values[self._nextTagCo.value] or 0
	end

	gohelper.setActive(self._golevel32, self._preLv == 3)
	gohelper.setActive(self._golevel1, self._preLv == 1)
	gohelper.setActive(self._golevel2, self._preLv == 2)
	gohelper.setActive(self._golevel3, self._preLv == 3)
end

function SurvivalEquipView:_delayShowLevelAnim()
	if self._nextLv ~= self._preLv and self._preTagCo then
		if self._nextLv > self._preLv then
			self._animskill:Play("equip_levelup")
		else
			self._animskill:Play("equip_leveldown")
		end

		self._preLv = self._nextLv
		self._nextLv = nil

		gohelper.setActive(self._golevel32, self._preLv == 3)
		gohelper.setActive(self._golevel1, self._preLv == 1)
		gohelper.setActive(self._golevel2, self._preLv == 2)
		gohelper.setActive(self._golevel3, self._preLv == 3)
	end
end

function SurvivalEquipView:_onClickEquipItem(index)
	local itemMo = self._equipItems[index].mo.item

	if not itemMo:isEmpty() then
		gohelper.setActive(self._btncloseinfoview, true)
		self._infoPanel:updateMo(itemMo)
	end
end

function SurvivalEquipView:_onClickEquipItem2(index)
	local itemMo = self._spEquipItems[index].mo.item

	if not itemMo:isEmpty() then
		gohelper.setActive(self._btncloseinfoview, true)
		self._infoPanel:updateMo(itemMo)
	end
end

function SurvivalEquipView:_onSortChange(sortData, isDec, filterList)
	self._curSort = sortData
	self._isDec = isDec
	self._filterList = filterList

	self:_refreshBag()
end

function SurvivalEquipView:isInSurvival()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	return weekInfo.inSurvival
end

function SurvivalEquipView:getBag()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local bag = weekInfo:getBag(SurvivalEnum.ItemSource.Shelter)
	local bag2

	return bag, (weekInfo.inSurvival or nil) and weekInfo:getBag(SurvivalEnum.ItemSource.Map)
end

function SurvivalEquipView:_refreshBag()
	local bag, bag2 = self:getBag()
	local itemMos = {}
	local preSelectUid

	for _, itemMo in ipairs(bag.items) do
		if itemMo.co.type == SurvivalEnum.ItemType.Equip and SurvivalBagSortHelper.filterEquipMo(self._filterList, itemMo) then
			table.insert(itemMos, itemMo)

			if self._preSelectUid == itemMo.uid then
				preSelectUid = itemMo.uid
			end
		end
	end

	if bag2 then
		for _, itemMo in ipairs(bag2.items) do
			if itemMo.co.type == SurvivalEnum.ItemType.Equip and SurvivalBagSortHelper.filterEquipMo(self._filterList, itemMo) then
				table.insert(itemMos, itemMo)

				if self._preSelectUid == itemMo.uid then
					preSelectUid = itemMo.uid
				end
			end
		end
	end

	SurvivalBagSortHelper.sortItems(itemMos, self._curSort.type, self._isDec)
	SurvivalHelper.instance:makeArrFull(itemMos, SurvivalBagItemMo.Empty, 5, 4)

	self._preSelectUid = preSelectUid

	self._simpleList:setList(itemMos)
	self:_refreshInfo()
end

function SurvivalEquipView:_createItem(obj, data, index)
	obj:updateMo(data)
	obj:setClickCallback(self._onItemClick, self)

	if data.uid == self._preSelectUid and self._preSelectUid then
		obj:setIsSelect(true)
	end
end

function SurvivalEquipView:_onItemClick(item)
	if item._mo:isEmpty() then
		return
	end

	self._preSelectUid = item._mo.uid

	for comp in pairs(self._simpleList:getAllComps()) do
		comp:setIsSelect(self._preSelectUid and comp._mo.uid == self._preSelectUid)
	end

	self:_refreshInfo()
end

function SurvivalEquipView:_onTipsClose()
	self._preSelectUid = nil

	for comp in pairs(self._simpleList:getAllComps()) do
		comp:setIsSelect(false)
	end
end

function SurvivalEquipView:_refreshInfo()
	local bag, bag2 = self:getBag()
	local var_31_0 = self._preSelectUid

	if self._preSelectUid then
		var_31_0 = bag.itemsByUid[self._preSelectUid]

		if not bag.itemsByUid[self._preSelectUid] and bag2 then
			::label_31_0::

			local itemMo = bag2.itemsByUid[self._preSelectUid]

			self._infoPanel:updateMo(itemMo)
		end
	end
end

function SurvivalEquipView:onTouchScreen()
	if self._goonekeyEquipTips.activeSelf then
		if gohelper.isMouseOverGo(self._goonekeyEquipTips) or gohelper.isMouseOverGo(self._btn_onekeyEquip) then
			return
		end

		gohelper.setActive(self._goonekeyEquipTips, false)
	end
end

function SurvivalEquipView:_beginDrag(_, pointerEventData)
	ZProj.UGUIHelper.PassEvent(self._goscroll, pointerEventData, 4)

	for bagItem in pairs(self._simpleList:getAllComps()) do
		if gohelper.isMouseOverGo(bagItem.go) then
			if not bagItem._mo:isEmpty() then
				self._curPressItem = bagItem
			end

			break
		end
	end
end

function SurvivalEquipView:_onDrag(_, pointerEventData)
	local isFirst

	if not self._isDragOut then
		ZProj.UGUIHelper.PassEvent(self._goscroll, pointerEventData, 5)

		if self._curPressItem and pointerEventData.position.x - pointerEventData.pressPosition.x < -100 then
			self._isDragOut = true

			self._dragItem:updateMo(self._curPressItem._mo)
			gohelper.setActive(self._dragItem.go, true)

			isFirst = true

			ZProj.UGUIHelper.PassEvent(self._goscroll, pointerEventData, 6)
		end
	end

	if self._isDragOut then
		local anchorPos = recthelper.screenPosToAnchorPos(pointerEventData.position, self.viewGO.transform)
		local trans = self._dragItem.go.transform
		local curAnchorX, curAnchorY = recthelper.getAnchor(trans)

		if not isFirst and (math.abs(curAnchorX - anchorPos.x) > 10 or math.abs(curAnchorY - anchorPos.y) > 10) then
			ZProj.TweenHelper.DOAnchorPos(trans, anchorPos.x, anchorPos.y, 0.2)
		else
			recthelper.setAnchor(trans, anchorPos.x, anchorPos.y)
		end

		local isSp = self._curPressItem._mo.equipCo.equipType == 1
		local _, equipItem = self:getDragIndex(pointerEventData.position, isSp)

		if equipItem ~= self._curOverEquip then
			if self._curOverEquip then
				self._curOverEquip:setLightActive(false)
			end

			self._curOverEquip = equipItem

			if self._curOverEquip then
				self._curOverEquip:setLightActive(true)
			end
		end
	end
end

function SurvivalEquipView:_endDrag(_, pointerEventData)
	if self._curOverEquip then
		self._curOverEquip:setLightActive(false)

		self._curOverEquip = nil
	end

	if self._isDragOut then
		self._isDragOut = nil

		gohelper.setActive(self._dragItem.go, false)

		local itemMo = self._curPressItem._mo
		local isSp = itemMo.equipCo.equipType == 1

		self._curPressItem = nil

		local index = self:getDragIndex(pointerEventData.position, isSp)

		if index and index > 0 then
			if isSp then
				if not self._equipBox.jewelrySlots then
					local slots = self._equipBox.slots

					if not slots[index] then
						return
					end

					if not slots[index].unlock then
						GameFacade.showToast(ToastEnum.SurvivalEquipLock)

						return
					end

					if itemMo.equipLevel > slots[index].level then
						GameFacade.showToast(ToastEnum.SurvivalEquipLevelLimit)

						return false
					end

					if isSp then
						SurvivalWeekRpc.instance:sendSurvivalJewelryEquipWear(index, itemMo.uid)
					else
						SurvivalWeekRpc.instance:sendSurvivalEquipWear(index, itemMo.uid)
					end
				end
			end
		end
	else
		self._curPressItem = nil

		ZProj.UGUIHelper.PassEvent(self._goscroll, pointerEventData, 6)
	end
end

function SurvivalEquipView:onClose()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	TaskDispatcher.cancelTask(self.onChangePlanBySwitch, self)
	TaskDispatcher.cancelTask(self._delayShowTagCo, self)
end

return SurvivalEquipView
