-- chunkname: @modules/logic/survival/view/map/SurvivalMapUseItemView.lua

module("modules.logic.survival.view.map.SurvivalMapUseItemView", package.seeall)

local SurvivalMapUseItemView = class("SurvivalMapUseItemView", BaseView)
local uinodes = {
	"BottomRight",
	"Left",
	"Top",
	"Bottom",
	"#go_lefttop"
}
local itemScaleMax = 0.6
local itemScaleMin = 0.42
local itemSpace = 7
local itemNoScalePixel = 10
local Vector2_zero = Vector2()

function SurvivalMapUseItemView:onInitView()
	self._gotips = gohelper.findChild(self.viewGO, "#go_usedTips")
	self._txtTips = gohelper.findChildTextMesh(self.viewGO, "#go_usedTips/#txt_usedTips")
	self._scrollRectWrap = gohelper.findChildScrollRect(self.viewGO, "BottomRight/#go_bag/#scroll")
	self._scroll = self._scrollRectWrap.gameObject:GetComponent(gohelper.Type_LimitedScrollRect)
	self._goviewport = gohelper.findChild(self.viewGO, "BottomRight/#go_bag/#scroll/Viewport")
	self._goitemroot = gohelper.findChild(self.viewGO, "BottomRight/#go_bag/#scroll/Viewport/#go_item")
	self._goitem = gohelper.findChild(self.viewGO, "BottomRight/#go_bag/#scroll/Viewport/#go_item/item")
	self._allUIs = self:getUserDataTb_()

	for k, v in ipairs(uinodes) do
		self._allUIs[k] = gohelper.findChild(self.viewGO, v)
	end

	self.btnSkill = gohelper.findChildButtonWithAudio(self.viewGO, "BottomRight/#btn_skill")
	self.txtSkillTimes = gohelper.findChildTextMesh(self.viewGO, "BottomRight/#btn_skill/#txt_num")
	self.goCannotUse = gohelper.findChild(self.viewGO, "BottomRight/#btn_skill/#Image_cannotuse")
	self.imageSkill = gohelper.findChildImage(self.viewGO, "BottomRight/#btn_skill/#Image_SkillIcon")
	self.goSkillClickEffect = gohelper.findChild(self.viewGO, "BottomRight/#btn_skill/#skill_click")

	gohelper.setActive(self.goSkillClickEffect, false)

	self.goSkillCanuseEffect = gohelper.findChild(self.viewGO, "BottomRight/#btn_skill/#skill_canuse")

	gohelper.setActive(self.goSkillCanuseEffect, false)

	self.goUseSkill = gohelper.findChild(self.viewGO, "#go_useskill")
	self.btnUseSkill = gohelper.findChildButtonWithAudio(self.viewGO, "#go_useskill/skill/#btn_use")
	self.txtSkillName = gohelper.findChildTextMesh(self.viewGO, "#go_useskill/skill/#txt_name")
	self.txtSkillDesc = gohelper.findChildTextMesh(self.viewGO, "#go_useskill/skill/#scroll_tips/viewport/content/#txt_dec")
	self.txtSkillTimes2 = gohelper.findChildTextMesh(self.viewGO, "#go_useskill/#btn_skill/#txt_num")
	self.imageSkill2 = gohelper.findChildImage(self.viewGO, "#go_useskill/#btn_skill/#Image_SkillIcon")
	self._allSkillUseRangePoints = {}
end

function SurvivalMapUseItemView:addEvents()
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapBagUpdate, self._refreshQuickItems, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnUseQuickItem, self._onUseQuickItem, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnClickTipsBtn, self._onClickTipsBtn, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnRoleSkillUpdate, self._onRoleSkillUpdate, self)
	self.viewContainer:registerCallback(SurvivalEvent.OnClickSurvivalScene, self._onSceneClick, self)
	self._scrollRectWrap:AddOnValueChanged(self._onScrollRectValueChanged, self)
	CommonDragHelper.instance:registerDragObj(self._goviewport, self._onBeginDrag, self._onDrag, self._onEndDrag, nil, self, nil, true)
	self.addClickCb(self, self.btnSkill, self.onClickSkill, self)
	self.addClickCb(self, self.btnUseSkill, self.onClickUseSkill, self)
end

function SurvivalMapUseItemView:removeEvents()
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapBagUpdate, self._refreshQuickItems, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnUseQuickItem, self._onUseQuickItem, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnClickTipsBtn, self._onClickTipsBtn, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnRoleSkillUpdate, self._onRoleSkillUpdate, self)
	self.viewContainer:unregisterCallback(SurvivalEvent.OnClickSurvivalScene, self._onSceneClick, self)
	self._scrollRectWrap:RemoveOnValueChanged()
	CommonDragHelper.instance:unregisterDragObj(self._goviewport, self._onBeginDrag, nil, self._onEndDrag, nil, self, nil, true)
	self:removeClickCb(self.btnSkill)
	self:removeClickCb(self.btnUseSkill)
end

function SurvivalMapUseItemView:onClickUseSkill()
	self:confirmUseSkill()
end

function SurvivalMapUseItemView:onClickSkill()
	self:useSkill()
end

function SurvivalMapUseItemView:_onRoleSkillUpdate()
	self:refreshSkillInfo()
end

function SurvivalMapUseItemView:onOpen()
	SurvivalMapModel.instance.curUseItem = nil

	gohelper.setActive(self._gotips, false)
	gohelper.setActive(self.goUseSkill, false)

	self._txtTips.text = luaLang("survival_mainview_useitem_tips")

	local infoViewRes = self.viewContainer._viewSetting.otherRes.infoView
	local infoRoot = gohelper.create2d(self.viewGO, "#go_info")
	local infoGo = self:getResInst(infoViewRes, infoRoot)

	self._infoPanel = MonoHelper.addNoUpdateLuaComOnceToGo(infoGo, SurvivalBagInfoPart)

	self._infoPanel:setCloseShow(true)
	self._infoPanel:updateMo()

	self._itemWidth = recthelper.getWidth(self._goitem.transform)

	gohelper.setActive(self._goitem, false)

	self._contentWidth = recthelper.getWidth(self._goitemroot.transform)
	self._itemPool = self:getUserDataTb_()
	self._itemInst = self:getUserDataTb_()
	self._items = self:getUserDataTb_()
	self._curCenterIndex = 0

	self:_refreshQuickItems()
	self:refreshSkillInfo()
end

function SurvivalMapUseItemView:_refreshQuickItems()
	local list = {}
	local bagMo = SurvivalMapHelper.instance:getBagMo()

	for _, v in ipairs(bagMo.items) do
		if v.co.type == SurvivalEnum.ItemType.Quick then
			table.insert(list, v)
		end
	end

	local addNum = 5 - #list

	if addNum < 0 then
		addNum = 0
	end

	local addLeft = math.ceil(addNum / 2)
	local addRight = addNum - addLeft

	for i = 1, addLeft do
		table.insert(list, 1, SurvivalBagItemMo.Empty)
	end

	for i = 1, addRight do
		table.insert(list, SurvivalBagItemMo.Empty)
	end

	self._showItemDatas = list

	self:onViewPortScroll()
	self:showGoNum(self._curCenterIndex)
	self._infoPanel:updateMo()
end

function SurvivalMapUseItemView:_onBeginDrag(_, pointerEventData)
	ZProj.UGUIHelper.PassEvent(self._scrollRectWrap.gameObject, pointerEventData, 4)

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	self:showGoNum(nil)
	TaskDispatcher.cancelTask(self._checkScrollIsEnd, self)

	self._scroll.inertia = true
end

function SurvivalMapUseItemView:_onDrag(_, pointerEventData)
	ZProj.UGUIHelper.PassEvent(self._scrollRectWrap.gameObject, pointerEventData, 5)
end

function SurvivalMapUseItemView:_onEndDrag(_, pointerEventData)
	ZProj.UGUIHelper.PassEvent(self._scrollRectWrap.gameObject, pointerEventData, 6)

	if math.abs(self._scroll.velocity.x) > 100 then
		TaskDispatcher.runRepeat(self._checkScrollIsEnd, self, 0)
	else
		self:doTweenIndex(self._curCenterIndex)
	end
end

function SurvivalMapUseItemView:_checkScrollIsEnd()
	if math.abs(self._scroll.velocity.x) <= 100 then
		TaskDispatcher.cancelTask(self._checkScrollIsEnd, self)
		self:doTweenIndex(self._curCenterIndex)
	end
end

function SurvivalMapUseItemView:_onScrollRectValueChanged(scrollX, scrollY)
	self:onViewPortScroll()
end

function SurvivalMapUseItemView:onViewPortScroll()
	self:inPoolAll()

	local trans = self._goitemroot.transform
	local rootX = -recthelper.getAnchorX(trans)
	local itemTotalSpace = self._itemWidth * itemScaleMin + itemSpace
	local index = Mathf.Round(rootX / itemTotalSpace)
	local centerItemPos = index * itemTotalSpace
	local dis = math.abs(rootX - centerItemPos)
	local scale = itemScaleMin

	scale = dis <= itemNoScalePixel and itemScaleMax or Mathf.Lerp(itemScaleMax, itemScaleMin, (dis - itemNoScalePixel) / (self._itemWidth / 2 - itemNoScalePixel))
	self._curCenterIndex = index

	self:createItem(centerItemPos, scale, index)

	local leftScale = itemScaleMin
	local rightScale = itemScaleMin
	local leftBorder = centerItemPos - scale * self._itemWidth * 0.5 - itemSpace
	local rightBorder = centerItemPos + scale * self._itemWidth * 0.5 + itemSpace

	if centerItemPos <= rootX then
		rightScale = itemScaleMin + itemScaleMax - scale
	else
		leftScale = itemScaleMin + itemScaleMax - scale
	end

	local leftIndex = index - 1

	while rootX - leftBorder < self._contentWidth / 2 do
		local pos = leftBorder - leftScale * self._itemWidth * 0.5

		self:createItem(pos, leftScale, leftIndex)

		leftIndex = leftIndex - 1
		leftBorder = leftBorder - leftScale * self._itemWidth - itemSpace
		leftScale = itemScaleMin
	end

	local rightIndex = index + 1

	while rightBorder - rootX < self._contentWidth / 2 do
		local pos = rightBorder + rightScale * self._itemWidth * 0.5

		self:createItem(pos, rightScale, rightIndex)

		rightIndex = rightIndex + 1
		rightBorder = rightBorder + rightScale * self._itemWidth + itemSpace
		rightScale = itemScaleMin
	end

	self:refreshItemActive()

	if self._showIndex then
		self:showGoNum(self._showIndex)
	end
end

function SurvivalMapUseItemView:createItem(pos, scale, index)
	local obj = self:getFromPool()
	local itemTrans = obj.transform

	recthelper.setAnchorX(itemTrans, pos)
	transformhelper.setLocalScale(itemTrans, scale, scale, scale)

	local instGo = gohelper.findChild(obj, "#go_item/inst")
	local gonum = gohelper.findChild(obj, "#go_num")
	local txtnum = gohelper.findChildTextMesh(obj, "#go_num/#txt_num")
	local item = MonoHelper.getLuaComFromGo(instGo, SurvivalBagItem)
	local data = self:getItemMo(index)

	obj.name = "cell" .. index

	item:updateMo(data)

	item.___index = index
	self._items[index] = gonum
	txtnum.text = data.count
end

function SurvivalMapUseItemView:getItemMo(index)
	local len = #self._showItemDatas

	if len <= 0 then
		return SurvivalBagItemMo.Empty
	end

	index = index + 3
	index = index % len

	if index <= 0 then
		index = index + len
	end

	return self._showItemDatas[index]
end

function SurvivalMapUseItemView:inPoolAll()
	tabletool.clear(self._items)
	tabletool.addValues(self._itemPool, self._itemInst)
	tabletool.clear(self._itemInst)
end

function SurvivalMapUseItemView:refreshItemActive()
	for _, go in pairs(self._itemPool) do
		recthelper.setAnchorY(go.transform, 500)
	end

	for _, go in pairs(self._itemInst) do
		recthelper.setAnchorY(go.transform, 0)
	end
end

function SurvivalMapUseItemView:getFromPool()
	local item = table.remove(self._itemPool)

	if not item then
		item = gohelper.cloneInPlace(self._goitem)

		gohelper.setActive(item, true)

		local itemRes = self.viewContainer:getSetting().otherRes.itemRes
		local instGo = self:getResInst(itemRes, gohelper.findChild(item, "#go_item"), "inst")
		local itemComp = MonoHelper.addNoUpdateLuaComOnceToGo(instGo, SurvivalBagItem)

		itemComp:setShowNum(false)
		itemComp:setClickCallback(self._onItemClick, self)
		itemComp:setCanClickEmpty(true)
	end

	table.insert(self._itemInst, item)

	return item
end

function SurvivalMapUseItemView:doTweenIndex(index)
	self._scroll.velocity = Vector2_zero

	self._scroll:StopMovement()

	self._scroll.inertia = false
	self._toIndex = index

	local offsetX = -(self._itemWidth * itemScaleMin + itemSpace) * index

	self._tweenId = ZProj.TweenHelper.DOAnchorPosX(self._goitemroot.transform, offsetX, 0.2, self._onTweenEnd, self)
end

function SurvivalMapUseItemView:_onTweenEnd()
	self._scroll:StopMovement()

	self._scroll.velocity = Vector2_zero
	self._scroll.inertia = true
	self._tweenId = nil

	self:showGoNum(self._toIndex)

	self._toIndex = nil
end

function SurvivalMapUseItemView:showGoNum(index)
	if SurvivalMapModel.instance.curUseItem then
		self:cancelUseItem()
	end

	for i, item in pairs(self._items) do
		local itemMo = self:getItemMo(i)
		local haveVal = not itemMo:isEmpty()

		gohelper.setActive(item, haveVal and i == index)
	end

	self._showIndex = index
end

function SurvivalMapUseItemView:_onItemClick(item)
	if self._tweenId or not self._showIndex then
		return
	end

	if item.___index == self._showIndex then
		if item._mo == SurvivalMapModel.instance.curUseItem then
			self:cancelUseItem()

			return
		end

		if item._mo:isEmpty() then
			return
		end

		self._infoPanel:updateMo(item._mo)
	else
		self:doTweenIndex(item.___index)
	end
end

function SurvivalMapUseItemView:_onUseQuickItem(itemMo)
	local walkable = SurvivalMapModel.instance:getCurMapCo().walkables
	local playerPos = SurvivalMapModel.instance:getSceneMo().player.pos
	local effectStr = itemMo.co.effect

	if itemMo.co.subType == SurvivalEnum.ItemSubType.Quick_Fly then
		local arr = string.splitToNumber(effectStr, "#") or {}

		if not arr[1] then
			local range = 0

			self:setRangeByWalkable(playerPos, range, walkable)
		end
	elseif itemMo.co.subType == SurvivalEnum.ItemSubType.Quick_ClearFog then
		local arr = string.splitToNumber(effectStr, "#") or {}

		if not arr[1] then
			local range = 0

			self:setRangeByWalkable(playerPos, range, walkable)
		end
	elseif itemMo.co.subType == SurvivalEnum.ItemSubType.Quick_SwapPos then
		local dict = GameUtil.splitString2(effectStr, true, "#", ",")

		if not dict[1] then
			local subTypes = {}

			if dict[2] then
				if not dict[2][1] then
					local range = 0

					self:setRangeBySubType(playerPos, range, subTypes)
				end
			end
		end
	elseif itemMo.co.subType == SurvivalEnum.ItemSubType.Quick_DelObstructNPCFight then
		local range = tonumber(effectStr) or 0

		self:setRangeByBlockNPCFight(playerPos, range)
	elseif itemMo.co.subType == SurvivalEnum.ItemSubType.Quick_TransferToEvent then
		local dict = GameUtil.splitString2(effectStr, true, "#", ",")

		if not dict[1] then
			local subTypes = {}

			if dict[2] then
				if not dict[2][1] then
					local range = 0

					self:setRangeBySubType(playerPos, range, subTypes)
				end
			end
		end
	elseif itemMo.co.subType == SurvivalEnum.ItemSubType.Quick_TransferUnitOut then
		local dict = GameUtil.splitString2(effectStr, true, "#", ",")

		if dict[1] then
			if not dict[1][1] then
				local range = 0

				if not dict[2] then
					local subTypes = {}

					self:setRangeBySubType(playerPos, range, subTypes)
				end
			end
		end
	elseif itemMo.co.subType == SurvivalEnum.ItemSubType.Quick_AttractantItem then
		local dict = GameUtil.splitString2(effectStr, true, "#", ",")

		if dict[2] then
			if not dict[2][1] then
				local range = 0

				self:setRangeByWalkable(playerPos, range, walkable)
			end
		end
	else
		SurvivalInteriorRpc.instance:sendSurvivalUseItemRequest(itemMo.uid, "")

		return
	end

	SurvivalMapModel.instance.curUseItem = itemMo

	gohelper.setActive(self._gotips, true)
	self:setUIVisible(false)
	self.viewContainer:setCloseFunc(self.cancelUseItem, self)
end

function SurvivalMapUseItemView:setRangeByWalkable(playerPos, range, walkable, needPlayerPos)
	local list = SurvivalHelper.instance:getAllPointsByDis(playerPos, range)

	for i = #list, 1, -1 do
		if list[i] == playerPos or not SurvivalHelper.instance:getValueFromDict(walkable, list[i]) then
			table.remove(list, i)
		end
	end

	if needPlayerPos then
		table.insert(list, playerPos)
	end

	self:setCanUsePoints(list)
end

function SurvivalMapUseItemView:setRangeByBlockNPCFight(playerPos, range)
	local sceneMo = SurvivalMapModel.instance:getSceneMo()
	local list = SurvivalHelper.instance:getAllPointsByDis(playerPos, range)

	for i = #list, 1, -1 do
		local isBlock = sceneMo:getBlockTypeByPos(list[i]) == SurvivalEnum.UnitSubType.Block
		local haveNpcOrFight = false

		for _, unitMo in ipairs(sceneMo:getUnitByPos(list[i], true, true)) do
			if unitMo.unitType == SurvivalEnum.UnitType.NPC or unitMo.unitType == SurvivalEnum.UnitType.Battle then
				haveNpcOrFight = true

				break
			end
		end

		if list[i] == playerPos or not isBlock and not haveNpcOrFight then
			table.remove(list, i)
		end
	end

	self:setCanUsePoints(list)
end

function SurvivalMapUseItemView:setRangeByUnitType(playerPos, range, unitTypes)
	local sceneMo = SurvivalMapModel.instance:getSceneMo()
	local list = SurvivalHelper.instance:getAllPointsByDis(playerPos, range)

	for i = #list, 1, -1 do
		if list[i] == playerPos then
			table.remove(list, i)
		else
			local haveUnit = false

			for _, unitMo in ipairs(sceneMo:getUnitByPos(list[i], true, true)) do
				if tabletool.indexOf(unitTypes, unitMo.unitType) then
					haveUnit = true

					break
				end
			end

			if not haveUnit then
				table.remove(list, i)
			end
		end
	end

	self:setCanUsePoints(list)
end

function SurvivalMapUseItemView:setRangeBySubType(playerPos, range, subTypes)
	local subTypeDict = {}

	for _, subType in ipairs(subTypes) do
		subTypeDict[subType] = true
	end

	local sceneMo = SurvivalMapModel.instance:getSceneMo()
	local list = SurvivalHelper.instance:getAllPointsByDis(playerPos, range)

	for i = #list, 1, -1 do
		local units = sceneMo:getUnitByPos(list[i], true, true)
		local find = false

		for _, unitMo in ipairs(units) do
			if unitMo.co and subTypeDict[unitMo.co.subType] then
				find = true

				break
			end
		end

		if not find then
			table.remove(list, i)
		end
	end

	self:setCanUsePoints(list)
end

function SurvivalMapUseItemView:setCanUsePoints(list)
	self._allCanUsePoints = {}

	for _, v in ipairs(list) do
		table.insert(self._allCanUsePoints, v:clone())
		SurvivalMapHelper.instance:getScene().pointEffect:setPointEffectType(-1, v.q, v.r, 2)
	end
end

function SurvivalMapUseItemView:setSkillUseRangePoints(list)
	SurvivalMapHelper.instance:getScene().pointEffect:clearPointsByKey(-1)
	self:setCanUsePoints(self._allCanUsePoints)

	self._allSkillUseRangePoints = {}

	for _, v in ipairs(list) do
		table.insert(self._allSkillUseRangePoints, v:clone())
		SurvivalMapHelper.instance:getScene().pointEffect:setPointEffectType(-1, v.q, v.r, 3)
	end
end

function SurvivalMapUseItemView:_onSceneClick(hexPos, data)
	if SurvivalMapModel.instance.curUseItem then
		data.use = true

		if tabletool.indexOf(self._allCanUsePoints, hexPos) then
			SurvivalInteriorRpc.instance:sendSurvivalUseItemRequest(SurvivalMapModel.instance.curUseItem.uid, string.format("%d#%d", hexPos.q, hexPos.r))
		end

		self:cancelUseItem()

		return
	end

	local sceneMo = SurvivalMapModel.instance:getSceneMo()
	local skillInfo = sceneMo:getRoleSkillInfo()

	if skillInfo:isSkillUsing() then
		data.use = true

		if tabletool.indexOf(self._allCanUsePoints, hexPos) then
			self.selectHexPos = hexPos

			local effectRange = skillInfo:getSkillEffectRange()

			if effectRange then
				SurvivalController.instance:dispatchEvent(SurvivalEvent.OnSelectRoleSkillHexPoint, hexPos, self.onClickUseSkill, self)

				local walkable = SurvivalMapModel.instance:getCurMapCo().rawWalkables
				local points = skillInfo:getSkillEffectRangePoints(hexPos, effectRange, walkable)

				self:setSkillUseRangePoints(points)
			else
				self:cancelUseSkill()
			end
		else
			self:cancelUseSkill()
		end

		return
	end
end

function SurvivalMapUseItemView:cancelUseItem()
	gohelper.setActive(self._gotips, false)
	SurvivalMapHelper.instance:getScene().pointEffect:clearPointsByKey(-1)

	SurvivalMapModel.instance.curUseItem = nil

	self:setUIVisible(true)
	self.viewContainer:setCloseFunc()
end

function SurvivalMapUseItemView:_onClickTipsBtn()
	self._infoPanel:updateMo()
end

function SurvivalMapUseItemView:setUIVisible(isVisible)
	if self._uiVisible == isVisible then
		return
	end

	self._uiVisible = isVisible

	for k, v in ipairs(self._allUIs) do
		gohelper.setActive(v, isVisible)
	end
end

function SurvivalMapUseItemView:refreshSkillInfo()
	local sceneMo = SurvivalMapModel.instance:getSceneMo()
	local skillInfo = sceneMo:getRoleSkillInfo()
	local skillRemainTimes = skillInfo:getSkillRemainTimes()
	local cannotUse = skillRemainTimes == 0

	gohelper.setActive(self.goCannotUse, cannotUse)
	gohelper.setActive(self.goSkillCanuseEffect, false)

	local timesStr = ""

	if skillRemainTimes >= 0 then
		local maxTimes = skillInfo:getSkillMaxTimes()

		timesStr = string.format("%s/%s", skillRemainTimes, maxTimes)
	end

	self.txtSkillTimes.text = timesStr
	self.txtSkillTimes2.text = timesStr

	local res = skillInfo.skillCfg.resource

	UISpriteSetMgr.instance:setSurvivalSprite2(self.imageSkill, res, true)
	UISpriteSetMgr.instance:setSurvivalSprite2(self.imageSkill2, res, true)
end

function SurvivalMapUseItemView:useSkill()
	local sceneMo = SurvivalMapModel.instance:getSceneMo()
	local skillInfo = sceneMo:getRoleSkillInfo()

	if not skillInfo:canUseSkill() then
		GameFacade.showToast(ToastEnum.SurvivalSkillNotTimes)

		return
	end

	SurvivalController.instance:dispatchEvent(SurvivalEvent.GuideRoleSkillViewOpen)
	gohelper.setActive(self.goUseSkill, true)

	self.txtSkillName.text = skillInfo.skillName

	local walkable = SurvivalMapModel.instance:getCurMapCo().rawWalkables
	local playerPos = SurvivalMapModel.instance:getSceneMo().player.pos
	local useRange = skillInfo:getSkillUseRange()
	local effectRange = skillInfo:getSkillEffectRange()

	if useRange then
		local usePoints = skillInfo:getSkillUseRangePoints(playerPos, useRange, walkable)

		self:setCanUsePoints(usePoints)
	end

	self.txtSkillDesc.text = GameUtil.getSubPlaceholderLuaLang(skillInfo.skillCfg.desc, {
		useRange,
		effectRange
	})

	gohelper.setActive(self.btnUseSkill, effectRange == nil)
	skillInfo:setIsUsing(true)
	self:setUIVisible(false)
	self.viewContainer:setCloseFunc(self.cancelUseSkill, self)
end

function SurvivalMapUseItemView:confirmUseSkill()
	local sceneMo = SurvivalMapModel.instance:getSceneMo()
	local skillInfo = sceneMo:getRoleSkillInfo()

	skillInfo:confirmUseSkill(self.selectHexPos)
	self:cancelUseSkill()
end

function SurvivalMapUseItemView:cancelUseSkill()
	self.selectHexPos = nil

	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnSelectRoleSkillHexPoint)
	gohelper.setActive(self.goUseSkill, false)

	local sceneMo = SurvivalMapModel.instance:getSceneMo()
	local skillInfo = sceneMo:getRoleSkillInfo()

	skillInfo:setIsUsing(false)
	SurvivalMapHelper.instance:getScene().pointEffect:clearPointsByKey(-1)
	self:setUIVisible(true)
	self.viewContainer:setCloseFunc()
end

function SurvivalMapUseItemView:onDestroyView()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	SurvivalMapModel.instance.curUseItem = nil

	TaskDispatcher.cancelTask(self._checkScrollIsEnd, self)
end

return SurvivalMapUseItemView
