-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscontest/view/card/GodDessContestCardAdjustView.lua

module("logic.extensions.goddesscontest.view.card.GodDessContestCardAdjustView", package.seeall)

local GodDessContestCardAdjustView = class("GodDessContestCardAdjustView", ViewComponent)
local emptyTb = {}

function GodDessContestCardAdjustView:ctor()
	GodDessContestCardAdjustView.super.ctor(self)

	self._groupUnitPool = {}
	self._boundingBox2D = BoundingBox2D.New()
end

function GodDessContestCardAdjustView:buildUI()
	GodDessContestCardAdjustView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")

	local cardScrView = goutil.findChild(self.mainGO, "cardCol/cardScrView")
	local cardScrCell = goutil.findChild(self.mainGO, "cardCol/cardScrCell")

	self._cardCol_emptyGo = goutil.findChild(self.mainGO, "cardCol/emptyGo")
	self._cardScrollList = ScrollerList.create(cardScrView, cardScrCell, GameUtil.handler(self._updateCardCell, self), GameUtil.handler(self._clearCardCell, self))
	self._cardScrollListView = self._cardScrollList:getView()

	self._cardScrollList:setDragCallBack("imgBg", GameUtil.handler(self._onDragBegin, self), GameUtil.handler(self._onDragMove, self), GameUtil.handler(self._onDragEnd, self))

	self._dragContainer = cardScrView:GetComponent("UIDragContainerForLua")
	self._dragCanvas = UGUIToolHelper.FindCanvas(cardScrView)
	self._groupCol = goutil.findChild(self.mainGO, "groupCol")

	local groupScrView = goutil.findChild(self.mainGO, "groupCol/groupScrView")
	local groupScrCell = goutil.findChild(self.mainGO, "groupCol/groupScrCell")

	self._groupScrollList = ScrollerList.create(groupScrView, groupScrCell, GameUtil.handler(self._updateGroupCell, self), GameUtil.handler(self._clearGroupCell, self))
	self._mainGoRect = self.mainGO:GetComponent(goutil.Type_RectTransform)
	self._dragObj = self:getGo("dragObj")
end

function GodDessContestCardAdjustView:bindEvents()
	GodDessContestCardAdjustView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function GodDessContestCardAdjustView:unbindEvents()
	GodDessContestCardAdjustView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function GodDessContestCardAdjustView:destroyUI()
	GodDessContestCardAdjustView.super.destroyUI(self)
end

function GodDessContestCardAdjustView:onEnter()
	GodDessContestCardAdjustView.super.onEnter(self)

	self._isDraging = false
	self._curDraggingData = nil
	self._dragHandlerMap = {}

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._activityType = GoddessContestController.instance:getActivityType()

	local isInTime = GoddessContestController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._cardBagMgr = GoddessContestModel.instance:getGdcCardBagMgr(self._activityId)
	self._cardStepMgr = GoddessContestController.instance:getGdcCardStepMgr(self._activityId)
	self._selectIndex = 0

	self.addGEvent(self, GlobalNotify.GoddessContestGetInfo, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.handlePM_GoddessContestGetCardInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.handlePM_GoddessContestFlopRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.handlePM_GoddessContestSetCardRes, self._onUpdate, self)
	self:_onUpdate()
end

function GodDessContestCardAdjustView:onExit()
	GodDessContestCardAdjustView.super.onExit(self)

	if GoddessContestController.instance:isEnoughAdjustCardGrade() and self._curInterval >= GdcCardEnum.ConInterval_Set and self._curInterval < GdcCardEnum.ConInterval_Public then
		local cardList = {}

		for i, v in ipairs(self._groupInfoList) do
			if v.cardId ~= nil then
				table.insert(cardList, v.cardId)
			else
				table.insert(cardList, 0)
			end
		end

		GoddessContestController.instance:sendPM_GoddessContestSetCardReq(self._activityId, self._curStepId, cardList)
	end

	self:_onClear()
end

function GodDessContestCardAdjustView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function GodDessContestCardAdjustView:_onClear()
	self:_onClearCardCol()
	self:_onClearGroupCol()
end

function GodDessContestCardAdjustView:_onUpdateData()
	self._curStepId = GoddessContestController.instance:getCurStep(self._activityId)
	self._curInterval = GoddessContestController.instance:getStepInterval(self._activityId, self._curStepId)

	local cardCfg = GoddessContestConfig.instance:getCardCfg(self._activityId, self._curStepId)

	self._cardCellList = {}

	for _, data in ipairs(cardCfg) do
		local cell = {}
		local stepId = self._curStepId
		local cardId = data.cardId
		local cardMo = self._cardBagMgr:getCardMo(stepId, cardId)

		cell._stepId = stepId
		cell._cardId = cardId
		cell._cardMo = cardMo

		if cardMo == nil then
			printError(string.format("空卡( activityId = %s | stepId = %s | cardId = %s )", self._activityId, stepId, cardId))
		else
			local isWith = cardMo:isWith()
			local cardType = cardMo:getCardType()

			if isWith then
				table.insert(self._cardCellList, cell)
			end
		end
	end

	table.sort(self._cardCellList, function(aCell, bCell)
		local aMo, bMo = aCell._cardMo, bCell._cardMo
		local posIdA, posIdB = aMo:getPosId(), bMo:getPosId()

		if posIdA ~= posIdB then
			if posIdA == 0 or posIdB == 0 then
				return posIdB < posIdA
			else
				return posIdA < posIdB
			end
		end

		local isShowA, isShowB = aMo:isShowValue(), bMo:isShowValue()
		local showA = isShowA and 1 or 0
		local showB = isShowB and 1 or 0

		if showA ~= showB then
			return showB < showA
		end

		local valueA, valueB = aMo:getValue(), bMo:getValue()

		if valueA ~= valueB then
			return valueB < valueA
		end

		return false
	end)

	local cardGridNum = GoddessContestController.instance:getCardGridNum(self._activityId)

	self._groupInfoList = {}

	for posId = 1, cardGridNum do
		self._groupInfoList[posId] = emptyTb
	end

	for _, cardCell in ipairs(self._cardCellList) do
		local cardMo = cardCell._cardMo
		local posId = cardMo:getPosId()

		if posId > 0 then
			self._groupInfoList[posId] = cardMo
		end
	end
end

function GodDessContestCardAdjustView:_onUpdateUI()
	self:_onUpdateCardColUI()
	self:_onUpdateGroupColUI()
end

function GodDessContestCardAdjustView:_onUpdateCardColUI()
	self._cardScrollList:reloadData(self._cardCellList)
	GameUtil.SetActive(self._cardCol_emptyGo, #self._cardCellList <= 0)
end

function GodDessContestCardAdjustView:_onClearCardCol()
	self._cardScrollList:dispose()
end

function GodDessContestCardAdjustView:_updateCardCell(view, cell, cardCell, tag)
	local mainGo = cell.gameObject
	local index = cell.index + 1
	local cardMo = cardCell._cardMo
	local cardType = cardMo:getCardType()
	local isWith = cardMo:isWith()
	local value = cardMo:getValue()
	local isShowValue = cardMo:isShowValue()
	local posId = cardMo:getPosId()
	local imgNum = goutil.findChild(mainGo, "imgBg/imgNum")
	local imgRandom = goutil.findChild(mainGo, "imgRandom")
	local notGetTag = goutil.findChild(mainGo, "notGetTag")
	local tips = goutil.findChild(mainGo, "tips")
	local tips_txt = goutil.findChildTextComponent(mainGo, "tips/txt")
	local group = goutil.findChild(mainGo, "group")
	local group_txt = goutil.findChildTextComponent(mainGo, "group/txt")
	local selected = goutil.findChild(mainGo, "selected")

	if isShowValue then
		GameUtil.setUIImageSpriteIdx(imgNum, value)
		GameUtil.SetActive(imgNum, true)
		GameUtil.SetActive(imgRandom, false)
		GameUtil.SetActive(tips.gameObject, false)
	else
		GameUtil.SetActive(imgNum, false)
		GameUtil.SetActive(imgRandom, true)
		GameUtil.SetActive(tips.gameObject, true)
	end

	if posId > 0 then
		group_txt.text = string.format("%s组", GdcCardEnum.CardGroupNames[posId])

		GameUtil.SetActive(group, true)
	else
		GameUtil.SetActive(group, false)
	end

	GameUtil.SetActive(selected, self._selectIndex == index)
end

function GodDessContestCardAdjustView:_onDragBegin(eventData, data, cell)
	local mo = data._cardMo
	local go = goutil.findChild(cell, "imgBg")

	self:_OnDragPetBegin(mo, go)
end

function GodDessContestCardAdjustView:_onDragMove(eventData, data)
	local mo = data._cardMo

	self:_OnDragPetMoved(nil, mo)
end

function GodDessContestCardAdjustView:_onDragEnd(eventData, data)
	local mo = data._cardMo

	self:_OnDragPetEnded(nil, mo)
end

function GodDessContestCardAdjustView:_clearCardCell(cell)
	return
end

function GodDessContestCardAdjustView:_OnDragPetBegin(data, cell)
	if not GoddessContestController.instance:isEnoughAdjustCardGrade() then
		FloatWordMgr.instance:show("非团长没有权限进行调整")

		return
	end

	if self._curInterval < GdcCardEnum.ConInterval_Set or self._curInterval >= GdcCardEnum.ConInterval_Public then
		FloatWordMgr.instance:show("不在调整时间范围内")

		return
	end

	if data.cardId ~= nil then
		local isShowValue = data:isShowValue()

		if isShowValue == false then
			FloatWordMgr.instance:show("请提醒副团长翻牌")

			return
		end
	end

	if self._isDraging == false and data.cardId ~= nil then
		self._isDraging = true
		self._curDraggingData = data

		goutil.clearChildren(self._dragObj)

		local go = goutil.clone(cell.gameObject)

		goutil.addChildToParent(go, self._dragObj)
		GameUtil.setAnchoredPos(go, 0, 0)
		GameUtil.SetActive(self._dragObj, true)

		local images = go:GetComponents(ComponentType.Image)

		for i = 0, images.Length - 1 do
			images[i].raycastTarget = false
		end

		self._dragObj.transform.position = uGuiUtil.GetTouchWorldPosition()
	end
end

function GodDessContestCardAdjustView:_OnDragPetMoved(go, data)
	if self._isDraging then
		self._dragObj.transform.position = uGuiUtil.GetTouchWorldPosition()
	end
end

function GodDessContestCardAdjustView:_OnDragPetEnded(go, data)
	if self._isDraging == true then
		self._isDraging = false
		self._curDraggingData = nil

		GameUtil.SetActive(self._dragObj, false)
		self._groupScrollList:reloadData(self._groupInfoList)
		ArraySort.sortOn(self._cardCellList, {
			function(data)
				local mo = data._cardMo
				local posIdx = mo:getPosId()

				if posIdx == 0 then
					return math.huge
				else
					return posIdx
				end
			end,
			function(data)
				local mo = data._cardMo

				return mo:isShowValue() and 1 or 0
			end,
			function(data)
				local mo = data._cardMo

				return mo:getValue()
			end,
			function(data)
				local mo = data._cardMo

				return checknumber(mo.cardId)
			end
		}, {
			ArraySort.NUMERIC,
			ArraySort.DESCENDING,
			ArraySort.DESCENDING,
			ArraySort.NUMERIC
		})
		self._cardScrollList:reloadData(self._cardCellList)
	end
end

function GodDessContestCardAdjustView:_OnDropDown(go, toPosId)
	if self._isDraging == true then
		local fromCardMo = self._curDraggingData
		local fromPosId = fromCardMo:getPosId()
		local toCardMo = self._groupInfoList[toPosId]

		if toPosId > 0 then
			self._groupInfoList[toPosId] = fromCardMo
		end

		if fromPosId > 0 then
			self._groupInfoList[fromPosId] = toCardMo
		end

		if fromCardMo and fromCardMo.cardId ~= nil then
			fromCardMo:setPosId(toPosId)
		end

		if toCardMo and toCardMo.cardId ~= nil then
			toCardMo:setPosId(fromPosId)
		end
	end
end

function GodDessContestCardAdjustView:_onUpdateGroupColUI()
	table.clear(self._groupUnitPool)
	self._groupScrollList:reloadData(self._groupInfoList)
end

function GodDessContestCardAdjustView:_onClearGroupCol()
	self._groupScrollList:dispose()
end

function GodDessContestCardAdjustView:_updateGroupCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local index = cell.index + 1
	local cardMo = data
	local isHaveCard = cardMo ~= nil and cardMo.cardId ~= nil
	local unit = self._groupUnitPool[index]

	if unit == nil then
		unit = {
			_boundingBox2D = BoundingBox2D.New()
		}
		self._groupUnitPool[index] = unit
	end

	unit._mainGo = mainGo

	local imgBg = goutil.findChild(mainGo, "imgBg")

	unit._txtTips = goutil.findChildTextComponent(mainGo, "txtTips")
	unit._name_txt = goutil.findChildTextComponent(mainGo, "name/txt")
	unit._selected = goutil.findChild(mainGo, "selected")
	unit._colliderBox = goutil.findChild(mainGo, "colliderBox")
	unit._imgNum = goutil.findChild(mainGo, "imgBg/imgNum")
	unit._imgRandom = goutil.findChild(mainGo, "imgRandom")
	unit._notGetTag = goutil.findChild(mainGo, "notGetTag")

	GameUtil.SetActive(unit._imgNum.gameObject, isHaveCard)
	GameUtil.SetActive(unit._selected, false)

	if isHaveCard then
		GameUtil.setUIImageSpriteIdx(unit._imgNum, cardMo:getValue())
	end

	unit._name_txt.text = string.format("%s组", GdcCardEnum.CardGroupNames[index])

	if self._dragHandlerMap[cell] == nil then
		self._dragHandlerMap[cell] = true

		BeginDragHandler.Get(cell.gameObject):AddLuaHandler(function(go, edata)
			local mo = self._groupInfoList[index]

			self:_OnDragPetBegin(mo, imgBg)
		end)
		DragHandler.Get(cell.gameObject):AddLuaHandler(function(_go, edata)
			local mo = self._groupInfoList[index]

			self:_OnDragPetMoved(_go, mo)
		end)
		EndDragHandler.Get(cell.gameObject):AddLuaHandler(function(_go, edata)
			local mo = self._groupInfoList[index]

			self:_OnDragPetEnded(_go, mo)
		end)
		DropHandler.Get(cell.gameObject):AddLuaHandler(function(_go, eventData)
			self:_OnDropDown(_go, cell.data)
		end)
		PointerEnterHandler.Get(cell.gameObject):AddLuaHandler(function(_go, eventData)
			self:_onMovieIn(_go, cell)
		end)
		PointerExitHandler.Get(cell.gameObject):AddLuaHandler(function(_go, eventData)
			self:_onMoveOut(_go, cell)
		end)
	end
end

function GodDessContestCardAdjustView:_onMovieIn(_go, cell)
	if self._isDraging == true then
		local cardMo = self._curDraggingData
		local fromPosId = cardMo:getPosId()

		if checknumber(fromPosId) ~= cell.data then
			local selected = goutil.findChild(cell, "selected")

			GameUtil.SetActive(selected, true)
		end
	end
end

function GodDessContestCardAdjustView:_onMoveOut(_go, cell)
	if self._isDraging == true then
		local selected = goutil.findChild(cell, "selected")

		GameUtil.SetActive(selected, false)
	end
end

function GodDessContestCardAdjustView:_clearGroupCell(cell)
	return
end

return GodDessContestCardAdjustView
