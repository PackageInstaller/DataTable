-- chunkname: @modules/logic/survival/view/map/SurvivalCommitItemView.lua

module("modules.logic.survival.view.map.SurvivalCommitItemView", package.seeall)

local SurvivalCommitItemView = class("SurvivalCommitItemView", BaseView)

function SurvivalCommitItemView:onInitView()
	self._goempty = gohelper.findChild(self.viewGO, "Center/#go_empty")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_close")
	self._btncommit = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_list/#btn_commit")
	self._gocommitgray = gohelper.findChild(self.viewGO, "Right/#go_list/#go_commit_gray")
	self._btncancledrop = gohelper.findChildClick(self.viewGO, "Right/#go_drop/#btn_close")
	self._goheavy = gohelper.findChild(self.viewGO, "Left/#go_heavy")
	self._gosort = gohelper.findChild(self.viewGO, "Left/#go_sort")
	self._goleftscroll = gohelper.findChild(self.viewGO, "Left/#go_list/scroll_collection")
	self._goleftempty = gohelper.findChild(self.viewGO, "Left/#go_list/#go_empty")
	self._goleftcontent = gohelper.findChild(self.viewGO, "Left/#go_list/scroll_collection/Viewport/Content")
	self._goleftitem = gohelper.findChild(self.viewGO, "Left/#go_list/scroll_collection/Viewport/Content/go_bagitem")
	self._gorightitem = gohelper.findChild(self.viewGO, "Right/#go_list/scroll_collection/Viewport/Content/go_bagitem")
	self._gorightcontent = gohelper.findChild(self.viewGO, "Right/#go_list/scroll_collection/Viewport/Content")
	self._gorightempty = gohelper.findChild(self.viewGO, "Right/#go_list/#go_empty")
	self._gorightscroll = gohelper.findChild(self.viewGO, "Right/#go_list/scroll_collection")
	self._gorightinfo = gohelper.findChild(self.viewGO, "Right/#go_list")
	self._gorighttips = gohelper.findChild(self.viewGO, "Right/#go_tips")
	self._godroparea = gohelper.findChild(self.viewGO, "Right/#go_droparea")
	self._godroptips = gohelper.findChild(self.viewGO, "Right/#go_drop")
	self._animtips = gohelper.findChildAnim(self._godroptips, "#go_droptips")
	self._txttotalvalue = gohelper.findChildTextMesh(self.viewGO, "Right/#go_value/tag1/#txt_tag1")
	self._txtitemvalue = gohelper.findChildTextMesh(self.viewGO, "Right/#go_tips/#txt_needcount")
	self._txthave = gohelper.findChildTextMesh(self.viewGO, "Right/#go_drop/#go_droptips/#txt_have")
	self._txtafter = gohelper.findChildTextMesh(self.viewGO, "Right/#go_drop/#go_droptips/#txt_after")
	self._inputtipnum = gohelper.findChildTextMeshInputField(self.viewGO, "Right/#go_drop/#go_droptips/#go_num/valuebg/#input_value")
	self._btnaddnum = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_drop/#go_droptips/#go_num/#btn_add")
	self._btnsubnum = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_drop/#go_droptips/#go_num/#btn_sub")
	self._btnput = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_drop/#go_droptips/#btn_put")
	self._gotipitem = gohelper.findChild(self.viewGO, "Right/#go_drop/itembg/#go_item")
end

function SurvivalCommitItemView:addEvents()
	self._btnclose:AddClickListener(self.closeThis, self)
	self._btncommit:AddClickListener(self.commitItems, self)
	self._btncancledrop:AddClickListener(self.cancelDrop, self)
	self._inputtipnum:AddOnEndEdit(self._ontipnuminputChange, self)
	self._btnaddnum:AddClickListener(self._addtipnum, self, 1)
	self._btnsubnum:AddClickListener(self._addtipnum, self, -1)
	self._btnput:AddClickListener(self._putItemToRight, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnClickTipsBtn, self._onTipsClick, self)
	CommonDragHelper.instance:registerDragObj(self._goleftcontent, self._beginLeftDrag, self._onLeftDrag, self._endLeftDrag, nil, self, nil, true)
	CommonDragHelper.instance:registerDragObj(self._gorightcontent, self._beginRightDrag, self._onRightDrag, self._endRightDrag, nil, self, nil, true)
end

function SurvivalCommitItemView:removeEvents()
	CommonDragHelper.instance:unregisterDragObj(self._goleftcontent)
	CommonDragHelper.instance:unregisterDragObj(self._gorightcontent)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnClickTipsBtn, self._onTipsClick, self)
	self._btnclose:RemoveClickListener()
	self._btncommit:RemoveClickListener()
	self._btncancledrop:RemoveClickListener()
	self._inputtipnum:RemoveOnEndEdit()
	self._btnaddnum:RemoveClickListener()
	self._btnsubnum:RemoveClickListener()
	self._btnput:RemoveClickListener()
end

function SurvivalCommitItemView:onOpen()
	self._choiceMo = self.viewParam

	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_mail_open)

	local infoViewRes = self.viewContainer._viewSetting.otherRes.infoView
	local infoRoot = gohelper.findChild(self.viewGO, "Center/#go_info")
	local infoRoot2 = gohelper.findChild(self.viewGO, "Center/#go_info/go_infoview")
	local infoGo = self:getResInst(infoViewRes, infoRoot2)

	self._infoPanel = MonoHelper.addNoUpdateLuaComOnceToGo(infoGo, SurvivalBagInfoPart)

	self._infoPanel:setHideParent(infoRoot)
	self._infoPanel:setCloseShow(true, self.closeInfoView, self)
	self._infoPanel:updateMo()
	gohelper.setActive(self._godroptips, false)
	gohelper.setActive(self._goempty, true)
	self:setShowRightTips(false)

	local bag = SurvivalMapHelper.instance:getBagMo()
	local allItems = {}

	for i, itemMo in ipairs(bag.items) do
		local co = itemMo.co

		if co.worth > 0 then
			local cloneItem = itemMo:clone()

			cloneItem.source = SurvivalEnum.ItemSource.Commit

			table.insert(allItems, cloneItem)
		end
	end

	for i = 1, 3 do
		local txt = gohelper.findChildTextMesh(self.viewGO, "Left/#go_tag/tag" .. i .. "/#txt_tag" .. i)

		txt.text = bag:getCurrencyNum(i)
	end

	local itemRes = self.viewContainer._viewSetting.otherRes.itemRes
	local dragGo = self:getResInst(itemRes, self.viewGO)
	local anim = gohelper.findChildAnim(dragGo, "")

	if anim then
		anim.enabled = false
	end

	self._dragItem = MonoHelper.addNoUpdateLuaComOnceToGo(dragGo, SurvivalBagItem)

	local tipsGo = self:getResInst(itemRes, self._gotipitem)

	self._tipsItem = MonoHelper.addNoUpdateLuaComOnceToGo(tipsGo, SurvivalBagItem)

	self._tipsItem:setShowNum(false)

	self._simpleLeftList = MonoHelper.addNoUpdateLuaComOnceToGo(self._goleftscroll, SurvivalSimpleListPart)

	self._simpleLeftList:setCellUpdateCallBack(self._createLeftItem, self, nil, self._goleftitem)

	self._simpleRightList = MonoHelper.addNoUpdateLuaComOnceToGo(self._gorightscroll, SurvivalSimpleListPart)

	self._simpleRightList:setCellUpdateCallBack(self._createRightItem, self, nil, self._gorightitem)

	self._curSelectUid = nil
	self._isSelectLeft = false

	gohelper.setActive(dragGo, false)

	self.leftItems = allItems
	self.rightItems = {}

	self:initWeightAndSort()
	self:updateView()
end

function SurvivalCommitItemView:_beginLeftDrag(_, pointerEventData)
	ZProj.UGUIHelper.PassEvent(self._goleftscroll, pointerEventData, 4)

	for go in pairs(self._simpleLeftList:getAllGos()) do
		local instGo = gohelper.findChild(go, "inst")

		if gohelper.isMouseOverGo(instGo) then
			local bagItem = MonoHelper.getLuaComFromGo(instGo, SurvivalBagItem)

			if bagItem and not bagItem._mo:isEmpty() then
				self._curPressItem = bagItem
			end

			break
		end
	end
end

function SurvivalCommitItemView:_onLeftDrag(_, pointerEventData)
	local isFirst

	if not self._isDragOut then
		ZProj.UGUIHelper.PassEvent(self._goleftscroll, pointerEventData, 5)

		if self._curPressItem and pointerEventData.position.x - pointerEventData.pressPosition.x > 100 then
			self._isDragOut = true

			self._dragItem:updateMo(self._curPressItem._mo)
			gohelper.setActive(self._dragItem.go, true)

			isFirst = true

			ZProj.UGUIHelper.PassEvent(self._goleftscroll, pointerEventData, 6)
			self._inputtipnum:SetText("1")
			self:updateTipCount()
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

		local isInRight = gohelper.isMouseOverGo(self._godroparea)

		self:setShowRightTips(isInRight)
	end
end

function SurvivalCommitItemView:_endLeftDrag(_, pointerEventData)
	if self._isDragOut then
		self._isDragOut = nil

		gohelper.setActive(self._dragItem.go, false)

		local isInRight = gohelper.isMouseOverGo(self._godroparea)

		if isInRight then
			local mo = self._curPressItem._mo

			if mo.count > 1 then
				self._tipsItem:updateMo(self._curPressItem._mo)
				gohelper.setActive(self._godroptips, true)
			else
				self:setShowRightTips(false)
				self:moveData(self.leftItems, self.rightItems, mo, 1, SurvivalEnum.ItemSource.Commited)

				self._curPressItem = nil
			end
		end
	else
		self._curPressItem = nil

		ZProj.UGUIHelper.PassEvent(self._goleftscroll, pointerEventData, 6)
	end
end

function SurvivalCommitItemView:setShowRightTips(isShow)
	if self._isShowTips == isShow then
		return
	end

	self._isShowTips = isShow

	gohelper.setActive(self._gorightinfo, not isShow)
	gohelper.setActive(self._gorighttips, isShow)
end

function SurvivalCommitItemView:cancelDrop()
	self._animtips:Play("close", 0, 0)
	TaskDispatcher.runDelay(self._delayHideTips, self, 0.167)
	UIBlockHelper.instance:startBlock("SurvivalCommitItemView_closetips", 0.167)
end

function SurvivalCommitItemView:_delayHideTips()
	gohelper.setActive(self._godroptips, false)
	self:setShowRightTips(false)

	self._curPressItem = nil
end

function SurvivalCommitItemView:_ontipnuminputChange()
	local count = tonumber(self._inputtipnum:GetText()) or 0

	count = Mathf.Clamp(count, 1, self._curPressItem._mo.count)

	if tostring(count) ~= self._inputtipnum:GetText() then
		self._inputtipnum:SetText(tostring(count))
		self:updateTipCount()
	end
end

function SurvivalCommitItemView:_addtipnum(value)
	local count = tonumber(self._inputtipnum:GetText()) or 0

	count = count + value
	count = Mathf.Clamp(count, 1, self._curPressItem._mo.count)

	self._inputtipnum:SetText(tostring(count))
	self:updateTipCount()
end

function SurvivalCommitItemView:updateTipCount()
	local count = tonumber(self._inputtipnum:GetText()) or 0

	self._txthave.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_bag_have"), self._curPressItem._mo.count)
	self._txtafter.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_bag_place"), self._curPressItem._mo.count - count)

	local weekMo = SurvivalShelterModel.instance:getWeekInfo()

	self._txtitemvalue.text = count * weekMo:getAttr(SurvivalEnum.AttrType.NpcRecruitment, self._curPressItem._mo.co.worth)
end

function SurvivalCommitItemView:_putItemToRight()
	local count = tonumber(self._inputtipnum:GetText()) or 0

	self:moveData(self.leftItems, self.rightItems, self._curPressItem._mo, count, SurvivalEnum.ItemSource.Commited)
	self:cancelDrop()
end

function SurvivalCommitItemView:moveData(fromList, toList, mo, count, source)
	local uid = mo.uid

	mo.count = mo.count - count

	if mo.count == 0 then
		tabletool.removeValue(fromList, mo)
	end

	local isFind = false

	for _, v in ipairs(toList) do
		if v.uid == uid then
			v.count = v.count + count
			isFind = true

			break
		end
	end

	if not isFind then
		local newMo = mo:clone()

		newMo.count = count
		newMo.source = source

		table.insert(toList, newMo)
	end

	self:updateView()
end

function SurvivalCommitItemView:updateView()
	self:_refreshLeftView()
	self:_refreshRightView()
	self:closeInfoView()
end

function SurvivalCommitItemView:initWeightAndSort()
	MonoHelper.addNoUpdateLuaComOnceToGo(self._goheavy, SurvivalWeightPart)

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

	filterOptions[1] = {
		desc = luaLang("survival_filter_material"),
		type = SurvivalEnum.ItemFilterType.Material
	}
	filterOptions[2] = {
		desc = luaLang("survival_filter_equip"),
		type = SurvivalEnum.ItemFilterType.Equip
	}
	filterOptions[3] = {
		desc = luaLang("survival_filter_consume"),
		type = SurvivalEnum.ItemFilterType.Consume
	}
	self._curSort = sortOptions[1]
	self._isDec = true
	self._filterList = {}

	sortComp:setOptions(sortOptions, filterOptions, self._curSort, self._isDec)
	sortComp:setOptionChangeCallback(self._onSortChange, self)
end

function SurvivalCommitItemView:_onSortChange(sortData, isDec, filterList)
	self._curSort = sortData
	self._isDec = isDec
	self._filterList = filterList

	self:_refreshLeftView()
end

function SurvivalCommitItemView:_refreshLeftView()
	local showItems = {}

	for _, itemMo in ipairs(self.leftItems) do
		if SurvivalBagSortHelper.filterItemMo(self._filterList, itemMo) then
			table.insert(showItems, itemMo)
		end
	end

	SurvivalBagSortHelper.sortItems(showItems, self._curSort.type, self._isDec)
	SurvivalHelper.instance:makeArrFull(showItems, SurvivalBagItemMo.Empty, 3, 5)
	self._simpleLeftList:setList(showItems)
	gohelper.setActive(self._goleftscroll, #showItems > 0)
	gohelper.setActive(self._goleftempty, #showItems == 0)
end

function SurvivalCommitItemView:_createLeftItem(obj, data, index)
	local itemRes = self.viewContainer._viewSetting.otherRes.itemRes
	local go = gohelper.findChild(obj, "inst")

	go = go or self:getResInst(itemRes, obj, "inst")

	local item = MonoHelper.addNoUpdateLuaComOnceToGo(go, SurvivalBagItem)

	item:updateMo(data)
	item:setClickCallback(self._onLeftItemClick, self)

	if self._isSelectLeft then
		item:setIsSelect(self._isSelectLeft and self._isSelectLeft == item._mo.uid)
	end
end

function SurvivalCommitItemView:_createRightItem(obj, data, index)
	local itemRes = self.viewContainer._viewSetting.otherRes.itemRes
	local go = gohelper.findChild(obj, "inst")

	go = go or self:getResInst(itemRes, obj, "inst")

	local item = MonoHelper.addNoUpdateLuaComOnceToGo(go, SurvivalBagItem)

	item:updateMo(data)
	item:setClickCallback(self._onRightItemClick, self)

	local uid = not self._isSelectLeft and self._curSelectUid

	item:setIsSelect(uid and uid == item._mo.uid)
end

function SurvivalCommitItemView:_onLeftItemClick(item)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_checkpoint_resources_Click)
	self._infoPanel:updateMo(item._mo)
	gohelper.setActive(self._goempty, false)

	self._curSelectUid = item._mo.uid
	self._isSelectLeft = true

	self:updateItemSelect()
end

function SurvivalCommitItemView:_onRightItemClick(item)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_checkpoint_resources_Click)
	self._infoPanel:updateMo(item._mo)
	gohelper.setActive(self._goempty, false)

	self._curSelectUid = item._mo.uid
	self._isSelectLeft = false

	self:updateItemSelect()
end

function SurvivalCommitItemView:_refreshRightView()
	self._simpleRightList:setList(self.rightItems)
	gohelper.setActive(self._gorightscroll, #self.rightItems > 0)
	gohelper.setActive(self._gorightempty, #self.rightItems == 0)

	local weekMo = SurvivalShelterModel.instance:getWeekInfo()
	local totalWorth = 0

	for i = 1, #self.rightItems do
		totalWorth = totalWorth + weekMo:getAttr(SurvivalEnum.AttrType.NpcRecruitment, self.rightItems[i].co.worth) * self.rightItems[i].count
	end

	local isCanCommit = totalWorth >= self.viewParam.npcWorthCheck

	self._txttotalvalue.text = isCanCommit and string.format("%d/%d", totalWorth, self.viewParam.npcWorthCheck) or string.format("<#D74242>%d</COLOR>/%d", totalWorth, self.viewParam.npcWorthCheck)

	gohelper.setActive(self._btncommit, isCanCommit)
	gohelper.setActive(self._gocommitgray, not isCanCommit)
end

function SurvivalCommitItemView:onClickModalMask()
	self:closeThis()
end

function SurvivalCommitItemView:commitItems()
	local params = tostring(self._choiceMo.param)
	local allItems = {}

	for i, itemMo in ipairs(self.rightItems) do
		table.insert(allItems, string.format("%s:%s", itemMo.uid, itemMo.count))
	end

	if allItems[1] then
		params = params .. "#" .. table.concat(allItems, "&")
	end

	SurvivalStatHelper.instance:statSurvivalMapUnit("SelectOption", self._choiceMo.unitId, self._choiceMo.param, self._choiceMo.treeId)
	SurvivalInteriorRpc.instance:sendSurvivalSceneOperation(SurvivalEnum.OperType.SelectOption, params)
	self:closeThis()
end

function SurvivalCommitItemView:_beginRightDrag(_, pointerEventData)
	ZProj.UGUIHelper.PassEvent(self._gorightscroll, pointerEventData, 4)

	for go in pairs(self._simpleRightList:getAllGos()) do
		local instGo = gohelper.findChild(go, "inst")

		if gohelper.isMouseOverGo(instGo) then
			local bagItem = MonoHelper.getLuaComFromGo(instGo, SurvivalBagItem)

			if bagItem and not bagItem._mo:isEmpty() then
				self._curPressItem = bagItem
			end

			break
		end
	end
end

function SurvivalCommitItemView:_onRightDrag(_, pointerEventData)
	local isFirst

	if not self._isDragOut then
		ZProj.UGUIHelper.PassEvent(self._goleftscroll, pointerEventData, 5)

		if self._curPressItem and pointerEventData.position.x - pointerEventData.pressPosition.x < -100 then
			self._isDragOut = true

			self._dragItem:updateMo(self._curPressItem._mo)
			gohelper.setActive(self._dragItem.go, true)

			isFirst = true

			ZProj.UGUIHelper.PassEvent(self._goleftscroll, pointerEventData, 6)
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
	end
end

function SurvivalCommitItemView:_endRightDrag(_, pointerEventData)
	if self._isDragOut then
		self._isDragOut = nil

		gohelper.setActive(self._dragItem.go, false)

		local isInRight = gohelper.isMouseOverGo(self._godroparea)

		if not isInRight then
			self:moveData(self.rightItems, self.leftItems, self._curPressItem._mo, self._curPressItem._mo.count, SurvivalEnum.ItemSource.Commit)
		end
	else
		ZProj.UGUIHelper.PassEvent(self._goleftscroll, pointerEventData, 6)
	end

	self._curPressItem = nil
end

function SurvivalCommitItemView:_onTipsClick(type, mo, count)
	if type == "Place" then
		self:moveData(self.leftItems, self.rightItems, mo, count, SurvivalEnum.ItemSource.Commited)
	elseif type == "UnPlace" then
		self:moveData(self.rightItems, self.leftItems, mo, count, SurvivalEnum.ItemSource.Commit)
	end

	self:closeInfoView()
end

function SurvivalCommitItemView:closeInfoView()
	self._infoPanel:updateMo()
	gohelper.setActive(self._goempty, true)

	self._curSelectUid = nil
	self._isSelectLeft = false

	self:updateItemSelect()
end

function SurvivalCommitItemView:updateItemSelect()
	for go in pairs(self._simpleLeftList:getAllGos()) do
		local instGo = gohelper.findChild(go, "inst")
		local bagItem = MonoHelper.getLuaComFromGo(instGo, SurvivalBagItem)

		if bagItem and not bagItem._mo:isEmpty() then
			bagItem:setIsSelect(self._isSelectLeft and self._curSelectUid == bagItem._mo.uid)
		end
	end

	for go in pairs(self._simpleRightList:getAllGos()) do
		local instGo = gohelper.findChild(go, "inst")
		local bagItem = MonoHelper.getLuaComFromGo(instGo, SurvivalBagItem)

		if bagItem and not bagItem._mo:isEmpty() then
			bagItem:setIsSelect(not self._isSelectLeft and self._curSelectUid == bagItem._mo.uid)
		end
	end
end

function SurvivalCommitItemView:onClose()
	TaskDispatcher.cancelTask(self._delayHideTips, self)
end

return SurvivalCommitItemView
