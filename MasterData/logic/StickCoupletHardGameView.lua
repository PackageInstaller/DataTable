-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stickcouplet/view/StickCoupletHardGameView.lua

module("logic.extensions.stickcouplet.view.StickCoupletHardGameView", package.seeall)

local StickCoupletHardGameView = class("StickCoupletHardGameView", ViewComponent)

function StickCoupletHardGameView:ctor()
	StickCoupletHardGameView.super.ctor(self)
end

function StickCoupletHardGameView:buildUI()
	StickCoupletHardGameView.super.buildUI(self)

	self._con = self:getGo("con")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._txtTime = self:getTxt("time/txtTime")
	self._btnCheck = self:getGo("btnCheck")
	self._txtScore = self:getTxt("score/txtScore")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._middleCouplet = self:getGo("middleCouplet")
	self._middleList = {}

	for i = 1, self._middleCouplet.transform.childCount do
		local cell = {}
		local cellGo = goutil.findChild(self._middleCouplet, "word_" .. i)

		cell.go = cellGo
		cell.txtWord = goutil.findChildTextComponent(cellGo, "Text")

		table.insert(self._middleList, cell)
	end

	self._leftCouplet = self:getGo("leftCouplet")
	self._leftList = {}

	for i = 1, self._leftCouplet.transform.childCount do
		local cell = {}
		local cellGo = goutil.findChild(self._leftCouplet, "word_" .. i)

		cell.go = cellGo
		cell.txtWord = goutil.findChildTextComponent(cellGo, "Text")
		cell.type = StickCoupletController.instance.leftCoupletType
		self._enterRaycast = self:getGo("leftCouplet/word_1/enterRaycast")
		cell.emptyRaycast = self:getGo("leftCouplet/word_" .. i .. "/enterRaycast")
		cell.bgGo = goutil.findChild(cellGo, "bg")
		cell.txtAnswer = goutil.findChildTextComponent(cellGo, "txtAnswer")
		cell.drag = Framework.UIDragTrigger.Get(cell.emptyRaycast)

		table.insert(self._leftList, cell)
	end

	self._rightCouplet = self:getGo("rightCouplet")
	self._rightList = {}

	for i = 1, self._rightCouplet.transform.childCount do
		local cell = {}
		local cellGo = goutil.findChild(self._rightCouplet, "word_" .. i)

		cell.go = cellGo
		cell.txtWord = goutil.findChildTextComponent(cellGo, "Text")
		cell.type = StickCoupletController.instance.rightCoupletType
		cell.emptyRaycast = self:getGo("rightCouplet/word_" .. i .. "/enterRaycast")
		cell.bgGo = goutil.findChild(cellGo, "bg")
		cell.txtAnswer = goutil.findChildTextComponent(cellGo, "txtAnswer")
		cell.drag = Framework.UIDragTrigger.Get(cell.emptyRaycast)

		table.insert(self._rightList, cell)
	end

	self._selects = self:getGo("selects")
	self._selectList = {}

	for i = 1, 9 do
		local cell = {}
		local cellGo = goutil.findChild(self._selects, "word_" .. i)

		cell.go = cellGo
		cell.txtWord = goutil.findChildTextComponent(cellGo, "Text")
		cell.textGo = goutil.findChild(cellGo, "Text")
		cell.drag = Framework.UIDragTrigger.Get(cellGo)

		table.insert(self._selectList, cell)
	end

	self._slot = self:getGo("slot")
	self._slotText = self:getTxt("slot/Text")
	self._pointEnterHandlerDic = {}
	self._pointExitHandlerDic = {}
	self._selectEnterHandlerDic = {}
	self._selectExitHandlerDic = {}
end

function StickCoupletHardGameView:bindEvents()
	StickCoupletHardGameView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
	GameUtil.addClickHandler(self._btnCheck, self._onClickBtnCheck, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)

	for idx, cell in ipairs(self._selectList) do
		self._selectEnterHandlerDic[cell] = PointerEnterHandler.Get(cell.go):AddLuaHandler(function(_go, eventData)
			self:_onPointSelectEnter(_go, eventData, idx)
		end)

		cell.drag:AddBeginDragListener(self._onBeginDrag, self)
		cell.drag:AddDragListener(self._onDrag, self)
		cell.drag:AddEndDragListener(self._onEndDrag, self)
	end

	for idx, cell in ipairs(self._leftList) do
		cell.drag:AddBeginDragListener(self._onBeginCoupletDrag, self)
		cell.drag:AddDragListener(self._onCoupletDrag, self)
		cell.drag:AddEndDragListener(self._onEndCoupletDrag, self)
	end

	for idx, cell in ipairs(self._rightList) do
		cell.drag:AddBeginDragListener(self._onBeginCoupletDrag, self)
		cell.drag:AddDragListener(self._onCoupletDrag, self)
		cell.drag:AddEndDragListener(self._onEndCoupletDrag, self)
	end
end

function StickCoupletHardGameView:unbindEvents()
	StickCoupletHardGameView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)

	for idx, cell in ipairs(self._selectList) do
		cell.drag:RemoveBeginDragListener()
		cell.drag:RemoveDragListener()
		cell.drag:RemoveEndDragListener()
	end

	for idx, cell in ipairs(self._leftList) do
		cell.drag:RemoveBeginDragListener()
		cell.drag:RemoveDragListener()
		cell.drag:RemoveEndDragListener()
	end

	for idx, cell in ipairs(self._rightList) do
		cell.drag:RemoveBeginDragListener()
		cell.drag:RemoveDragListener()
		cell.drag:RemoveEndDragListener()
	end

	for cellGo, handler in ipairs(self._selectEnterHandlerDic) do
		PointerEnterHandler.Get(cellGo):RemoveLuaHandler(handler)
	end

	for cellGo, handler in ipairs(self._pointEnterHandlerDic) do
		PointerEnterHandler.Get(cellGo):RemoveLuaHandler(handler)
	end

	for cellGo, handler in ipairs(self._pointExitHandlerDic) do
		PointerExitHandler.Get(cellGo):RemoveLuaHandler(handler)
	end
end

function StickCoupletHardGameView:onEnter()
	StickCoupletHardGameView.super.onEnter(self)

	self._activityId = StickCoupletController.instance:getActivityId()
	self._actcfg = StickCoupletConfig.instance:getSCActData(self._activityId) or {}
	self._hardCfg = StickCoupletConfig.instance:getSCHardData() or {}
	self._hardAskNum = #self._hardCfg or 0

	if self._actcfg.wordHouse then
		self._randomWordsArr = string.split(self._actcfg.wordHouse, "#")
		self._randomWordsLength = #self._randomWordsArr
	end

	UIStateManager.instance:open(ViewName.SuppressGameStartMask, self._startGame, self)
	self:_onSetUI()
	self:_onInit()
end

function StickCoupletHardGameView:onExit()
	StickCoupletHardGameView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	removetimer(self._updateTime, self)
end

function StickCoupletHardGameView:_onSetUI()
	local skinId = self._actcfg.skinId

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)
	self._txtScore.text = 0
end

function StickCoupletHardGameView:_onInit()
	self:_initData()
	self:_initCoupletUI()
	self:_initSelectUI()
end

function StickCoupletHardGameView:_initData()
	self._stopSubmit = false
	self._askLists = {}
	self._selectDic = {}
	self._answerDics = {}
	self._answerDics[StickCoupletController.instance.leftCoupletType] = {}
	self._answerDics[StickCoupletController.instance.rightCoupletType] = {}
	self._answerNum = 0
	self._correctDics = {}
	self._correctNum = 0
	self._coupletList = {}
	self._curSelectIdx = 0
	self._curTouchingIdx = 0
	self._curSelectWord = ""
	self._curCorrectList = {}
	self._curFaultList = {}
	self._curHasCorrectWordDics = {}
	self._preDragCell = nil
	self._preTouchingType = 0
	self._preDragIdx = 0
	self._pointEnterHandlerDic = {}
	self._pointExitHandlerDic = {}

	local curAskId = math.random(1, self._hardAskNum)
	local curAskCfg = self._hardCfg[curAskId]

	if curAskCfg then
		local middleStr = curAskCfg.middleCouplet
		local leftStr = curAskCfg.leftCouplet
		local rightStr = curAskCfg.rightCouplet

		self._middleStrArr = string.split(middleStr, "#")
		self._leftStrArr = string.split(leftStr, "#")
		self._rightStrArr = string.split(rightStr, "#")

		table.insert(self._coupletList, self._leftStrArr)
		table.insert(self._coupletList, self._rightStrArr)

		self._askLists = self:_getRandomAskList(curAskCfg)

		for i, list in ipairs(self._askLists) do
			local curCoupletList = self._coupletList[i]
			local curAnswerDic = {}

			for j, idx in ipairs(list) do
				curAnswerDic[idx] = curCoupletList[idx]
				curCoupletList[idx] = ""

				self:_setAskCoupletCell(true, i, idx)
			end

			table.insert(self._correctDics, curAnswerDic)
		end

		self._selectStrList = self:_getRandomSelectList()

		for i, word in ipairs(self._selectStrList) do
			self._selectDic[i] = word
		end
	end
end

function StickCoupletHardGameView:_setAskCoupletCell(show, leftOrRight, idx)
	if leftOrRight == StickCoupletController.instance.leftCoupletType then
		local curCell = self._leftList[idx]
		local bgGo = curCell.bgGo

		GameUtil.SetActive(bgGo, show)
	else
		local curCell = self._rightList[idx]
		local bgGo = curCell.bgGo

		GameUtil.SetActive(bgGo, show)
	end
end

function StickCoupletHardGameView:_initCoupletUI()
	for i, cell in ipairs(self._middleList) do
		cell.txtWord.text = self._middleStrArr[i]
	end

	for idx, cell in ipairs(self._leftList) do
		cell.txtWord.text = self._leftStrArr[idx]

		local imgAnswerChange = goutil.findChild(cell.go, "imgCorrect"):GetComponent(ComponentType.UIImageSpriteChange)

		GameUtil.SetActive(cell.bgGo, false)
		GameUtil.SetActive(cell.txtAnswer.gameObject, false)
		GameUtil.SetActive(cell.txtWord.gameObject, true)
		GameUtil.SetActive(cell.emptyRaycast.gameObject, false)
		imgAnswerChange:SetState(0)
	end

	for idx, cell in ipairs(self._rightList) do
		cell.txtWord.text = self._rightStrArr[idx]

		local imgAnswerChange = goutil.findChild(cell.go, "imgCorrect"):GetComponent(ComponentType.UIImageSpriteChange)

		GameUtil.SetActive(cell.bgGo, false)
		GameUtil.SetActive(cell.txtAnswer.gameObject, false)
		GameUtil.SetActive(cell.txtWord.gameObject, true)
		GameUtil.SetActive(cell.emptyRaycast.gameObject, false)
		imgAnswerChange:SetState(0)
	end

	for i, curDic in ipairs(self._correctDics) do
		for idx, correctWord in pairs(curDic) do
			if i == StickCoupletController.instance.leftCoupletType then
				local cell = self._leftList[idx]

				self._pointEnterHandlerDic[cell.emptyRaycast.gameObject] = PointerEnterHandler.Get(cell.emptyRaycast.gameObject):AddLuaHandler(function(_go, eventData)
					self:_onPointEnter(_go, eventData, StickCoupletController.instance.leftCoupletType, idx)
				end)
				self._pointExitHandlerDic[cell.emptyRaycast.gameObject] = PointerExitHandler.Get(cell.emptyRaycast.gameObject):AddLuaHandler(function(_go, eventData)
					self:_onPointExit(_go, eventData, idx)
				end)

				GameUtil.SetActive(cell.txtAnswer.gameObject, false)
				GameUtil.SetActive(cell.bgGo, true)
				GameUtil.SetActive(cell.emptyRaycast.gameObject, true)
			else
				local cell = self._rightList[idx]

				self._pointEnterHandlerDic[cell.go] = PointerEnterHandler.Get(cell.emptyRaycast.gameObject):AddLuaHandler(function(_go, eventData)
					self:_onPointEnter(_go, eventData, StickCoupletController.instance.rightCoupletType, idx)
				end)
				self._pointExitHandlerDic[cell.emptyRaycast.gameObject] = PointerExitHandler.Get(cell.emptyRaycast.gameObject):AddLuaHandler(function(_go, eventData)
					self:_onPointExit(_go, eventData, idx)
				end)

				GameUtil.SetActive(cell.txtAnswer.gameObject, false)
				GameUtil.SetActive(cell.bgGo, true)
				GameUtil.SetActive(cell.emptyRaycast.gameObject, true)
			end

			self._correctNum = self._correctNum + 1
		end
	end
end

function StickCoupletHardGameView:_initSelectUI()
	for idx, cell in ipairs(self._selectList) do
		cell.txtWord.text = self._selectStrList[idx]

		GameUtil.SetActive(cell.textGo, true)
	end
end

function StickCoupletHardGameView:_onUpdate()
	self:_updateData()
	self:_updateUI()
end

function StickCoupletHardGameView:_updateData()
	self._selectDic = {}
	self._curSelectIdx = 0
	self._curTouchingIdx = 0
	self._curSelectWord = ""
end

function StickCoupletHardGameView:_updateUI()
	for idx, cell in ipairs(self._leftList) do
		cell.txtWord.text = self._leftStrArr[idx]
		cell.txtAnswer.text = self._leftStrArr[idx]
	end

	for idx, cell in ipairs(self._rightList) do
		cell.txtWord.text = self._rightStrArr[idx]
		cell.txtAnswer.text = self._rightStrArr[idx]
	end

	for idx, cell in ipairs(self._selectList) do
		GameUtil.SetActive(cell.textGo, true)
	end

	for i, cellGo in pairs(self._curCorrectList) do
		local imgAnswerChange = goutil.findChild(cellGo, "imgCorrect"):GetComponent(ComponentType.UIImageSpriteChange)
		local txtAnswer = goutil.findChildTextComponent(cellGo, "txtAnswer")
		local emptyRaycast = goutil.findChild(cellGo, "enterRaycast")

		GameUtil.SetActive(txtAnswer.gameObject, true)
		GameUtil.SetActive(emptyRaycast, false)

		txtAnswer.text = self._curHasCorrectWordDics[cellGo]

		imgAnswerChange:SetState(1)
	end

	for i, cellGo in ipairs(self._curFaultList) do
		local imgAnswerChange = goutil.findChild(cellGo, "imgCorrect"):GetComponent(ComponentType.UIImageSpriteChange)

		imgAnswerChange:SetState(2)
	end
end

function StickCoupletHardGameView:_startGame()
	self._time = 100
	self._curScore = 0
	self._winNum = 0

	settimer(1, self._updateTime, self)
end

function StickCoupletHardGameView:_getRandomAskList(curAskCfg)
	local leftCouplet = curAskCfg.leftCouplet
	local leftStrArr = string.split(leftCouplet, "#")
	local askRandomList = {}

	if leftStrArr then
		for i = 1, 2 do
			local curList = {}
			local askIdx1 = math.random(1, math.floor(#leftStrArr / 2))
			local askIdx2 = askIdx1

			table.insert(curList, askIdx1)

			while askIdx1 == askIdx2 do
				askIdx2 = math.random(askIdx1 + 2, #leftStrArr)
			end

			table.insert(curList, askIdx2)
			table.insert(askRandomList, curList)
		end
	end

	return askRandomList
end

function StickCoupletHardGameView:_getRandomSelectList()
	local selectList = {}

	for i, curDic in ipairs(self._correctDics) do
		for k, correctWord in pairs(curDic) do
			table.insert(selectList, correctWord)
		end
	end

	local curSelectNum = #selectList

	for i = #self._selectList - curSelectNum, #self._selectList do
		local curword = self._randomWordsArr[math.random(1, #self._randomWordsArr)]

		table.insert(selectList, curword)
	end

	selectList = self:_shuffle(selectList)

	return selectList
end

function StickCoupletHardGameView:_shuffle(list)
	for i = #list, 2, -1 do
		local curRandomIdx = math.random(1, i - 1)

		list[i] = list[curRandomIdx]
		list[curRandomIdx] = list[i]
	end

	return list
end

function StickCoupletHardGameView:_updateTime()
	self._time = self._time - 1
	self._txtTime.text = self._time

	if self._time <= 0 then
		removetimer(self._updateTime, self)

		local text = "本次累计答对" .. self._winNum .. "对对联"

		TipsFacade.instance:openTipWindowNoX("提示", text, function()
			StickCoupletController.instance:sendPM_StickCoupletEndGameReq(self._activityId, self._curScore)
			self:close()
		end, "退出")
	end
end

function StickCoupletHardGameView:_onBeginDrag()
	local curDragCell = self._selectList[self._curSelectIdx]

	if curDragCell.textGo.activeSelf == false then
		self._isDraging = false

		return
	end

	self._slotText.text = self._selectStrList[self._curSelectIdx]
	self._isDraging = true

	if curDragCell then
		GameUtil.SetActive(curDragCell.textGo, false)
	end

	self._slot.transform.position = uGuiUtil.GetTouchWorldPosition()
end

function StickCoupletHardGameView:_onDrag()
	self._slot.transform.position = uGuiUtil.GetTouchWorldPosition()
end

function StickCoupletHardGameView:_onEndDrag()
	self._slotText.text = ""

	if self._isDraging then
		if self._isTouching then
			local curWord = self._selectStrList[self._curSelectIdx]

			if self._curTouchingType == StickCoupletController.instance.leftCoupletType then
				local touchingCell = self._leftList[self._curTouchingIdx]
				local cellGo = goutil.findChild(touchingCell.go, "imgCorrect")
				local curDic = self._answerDics[StickCoupletController.instance.leftCoupletType]
				local imgAnswerChange = cellGo:GetComponent("UIImageSpriteChange")

				if curDic[self._curTouchingIdx] then
					local preSelectIndex = curDic[self._curTouchingIdx]
					local selectCell = self._selectList[preSelectIndex]

					GameUtil.SetActive(selectCell.textGo, true)

					curDic[self._curTouchingIdx] = self._curSelectIdx
				else
					curDic[self._curTouchingIdx] = self._curSelectIdx
					self._answerNum = self._answerNum + 1
				end

				touchingCell.txtWord.text = curWord
				touchingCell.txtAnswer.text = curWord

				GameUtil.SetActive(touchingCell.txtAnswer.gameObject, true)
				GameUtil.SetActive(touchingCell.txtWord.gameObject, false)
				imgAnswerChange:SetState(0)
			else
				local touchingCell = self._rightList[self._curTouchingIdx]
				local cellGo = goutil.findChild(touchingCell.go, "imgCorrect")
				local curDic = self._answerDics[StickCoupletController.instance.rightCoupletType]
				local imgAnswerChange = cellGo:GetComponent("UIImageSpriteChange")

				if curDic[self._curTouchingIdx] then
					local preSelectIndex = curDic[self._curTouchingIdx]
					local selectCell = self._selectList[preSelectIndex]

					GameUtil.SetActive(selectCell.textGo, true)

					curDic[self._curTouchingIdx] = self._curSelectIdx
				else
					curDic[self._curTouchingIdx] = self._curSelectIdx
					self._answerNum = self._answerNum + 1
				end

				touchingCell.txtWord.text = curWord
				touchingCell.txtAnswer.text = curWord

				GameUtil.SetActive(touchingCell.txtAnswer.gameObject, true)
				GameUtil.SetActive(touchingCell.txtWord.gameObject, false)
				imgAnswerChange:SetState(0)
			end
		else
			local curDragCell = self._selectList[self._curSelectIdx]

			if curDragCell then
				GameUtil.SetActive(curDragCell.textGo, true)
			end
		end
	end

	self._isDraging = false
end

function StickCoupletHardGameView:_onBeginCoupletDrag()
	local curDragCell = self._curTouchingType == StickCoupletController.instance.leftCoupletType and self._leftList[self._curTouchingIdx] or self._rightList[self._curTouchingIdx]

	self._preDragCell = curDragCell
	self._preTouchingType = self._curTouchingType
	self._preDragIdx = self._curTouchingIdx

	if curDragCell == nil then
		self._isDraging = false

		return
	end

	if curDragCell.txtAnswer.gameObject.activeSelf == false then
		self._isDraging = false

		return
	end

	self._slotText.text = curDragCell.txtAnswer.text
	self._isDraging = true

	if curDragCell then
		GameUtil.SetActive(curDragCell.txtAnswer.gameObject, false)
		GameUtil.SetActive(curDragCell.txtWord.gameObject, false)
	end

	self._slot.transform.position = uGuiUtil.GetTouchWorldPosition()
end

function StickCoupletHardGameView:_onCoupletDrag()
	self._slot.transform.position = uGuiUtil.GetTouchWorldPosition()
end

function StickCoupletHardGameView:_onEndCoupletDrag()
	self._slotText.text = ""

	if self._isDraging then
		if self._isTouching then
			local curTouchingCell = self._curTouchingType == StickCoupletController.instance.leftCoupletType and self._leftList[self._curTouchingIdx] or self._rightList[self._curTouchingIdx]

			GameUtil.SetActive(self._preDragCell.txtAnswer.gameObject, true)
			GameUtil.SetActive(self._preDragCell.txtWord.gameObject, true)
			GameUtil.SetActive(curTouchingCell.txtWord.gameObject, false)
			GameUtil.SetActive(curTouchingCell.txtAnswer.gameObject, true)

			local preDic = self._answerDics[self._preTouchingType]
			local curDic = self._answerDics[self._curTouchingType]

			curTouchingCell.txtAnswer.text = self._preDragCell.txtAnswer.text or ""
			curTouchingCell.txtWord.text = self._preDragCell.txtAnswer.text or ""
			self._preDragCell.txtAnswer.text = curTouchingCell.txtAnswer.text or ""
			self._preDragCell.txtWord.text = curTouchingCell.txtAnswer.text or ""
			preDic[self._preDragIdx] = curDic[self._curTouchingIdx]
			curDic[self._curTouchingIdx] = preDic[self._preDragIdx]
		else
			GameUtil.SetActive(self._preDragCell.txtAnswer.gameObject, true)
			GameUtil.SetActive(self._preDragCell.txtWord.gameObject, true)
		end
	end

	self._isDraging = false
end

function StickCoupletHardGameView:_onPointEnter(_go, eventData, coupletType, idx)
	self._isTouching = true
	self._curTouchingIdx = idx
	self._curTouchingType = coupletType
end

function StickCoupletHardGameView:_onPointExit(eventData, idx)
	self._isTouching = false
	self._curTouchingIdx = 0
	self._curTouchingType = 0
end

function StickCoupletHardGameView:_onPointSelectEnter(_go, eventData, idx)
	if not self._isDraging then
		self._curSelectIdx = idx
	end
end

function StickCoupletHardGameView:_onClickBtnClose()
	removetimer(self._updateTime, self)

	local text = "是否要退出游戏\n现阶段退出不累计当前所获得积分"

	local function okFunc()
		StickCoupletController.instance:sendPM_StickCoupletEndGameReq(self._activityId, 0)
		self:close()
	end

	local function cancelFunc()
		settimer(1, self._updateTime, self)
	end

	TipsFacade.instance:openPopupWindow("提示", text, okFunc, cancelFunc, "确定", "取消")
end

function StickCoupletHardGameView:_onClickBtnTip()
	local key = self._actcfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function StickCoupletHardGameView:_onClickBtnCheck()
	if self._stopSubmit then
		FloatWordMgr.instance:show("请2秒后作答")

		return
	end

	local leftAnswerDic = self._answerDics[StickCoupletController.instance.leftCoupletType]
	local rightAnswerDic = self._answerDics[StickCoupletController.instance.rightCoupletType]
	local leftCorrectDic = self._correctDics[StickCoupletController.instance.leftCoupletType]
	local rightCorrectDic = self._correctDics[StickCoupletController.instance.rightCoupletType]
	local isCorrect = true

	for coupletIdx, selectIdx in pairs(leftAnswerDic) do
		local cellGo = self._leftList[coupletIdx].go

		if not self._selectStrList[selectIdx] then
			local curWord = self._curHasCorrectWordDics[cellGo]
			local answerWord = leftCorrectDic[coupletIdx]
			local curWordCorrect = false

			if answerWord ~= nil and answerWord == curWord then
				curWordCorrect = true
			else
				if self._answerNum - 1 >= 0 then
					self._answerNum = self._answerNum - 1 or 0
				end

				leftAnswerDic[coupletIdx] = nil
			end

			if curWordCorrect then
				self._curHasCorrectWordDics[cellGo] = answerWord

				table.insert(self._curCorrectList, cellGo)

				local faultIdx = table.indexof(self._curFaultList, cellGo)

				if faultIdx then
					table.remove(self._curFaultList, faultIdx)
				end
			else
				table.insert(self._curFaultList, cellGo)
			end

			isCorrect = isCorrect and curWordCorrect
		end
	end

	for coupletIdx, selectIdx in pairs(rightAnswerDic) do
		local cellGo = self._rightList[coupletIdx].go
		local curWord = self._selectStrList[selectIdx]
		local answerWord = rightCorrectDic[coupletIdx]
		local curWordCorrect = false

		if answerWord ~= nil and answerWord == curWord then
			curWordCorrect = true
		else
			if self._answerNum - 1 >= 0 then
				self._answerNum = self._answerNum - 1 or 0
			end

			rightAnswerDic[coupletIdx] = nil
		end

		if curWordCorrect then
			self._curHasCorrectWordDics[cellGo] = answerWord

			table.insert(self._curCorrectList, cellGo)

			local faultIdx = table.indexof(self._curFaultList, cellGo)

			if faultIdx then
				table.remove(self._curFaultList, faultIdx)
			end
		else
			table.insert(self._curFaultList, cellGo)
		end

		isCorrect = isCorrect and curWordCorrect
	end

	if self._answerNum ~= self._correctNum then
		isCorrect = false
	end

	if isCorrect then
		FloatWordMgr.instance:show("恭喜答对，进入下一题")

		self._curScore = self._curScore + self._actcfg.hardScore
		self._winNum = self._winNum + 1
		self._txtScore.text = self._winNum

		for cellGo, handler in pairs(self._pointEnterHandlerDic) do
			PointerEnterHandler.Get(cellGo):RemoveLuaHandler(handler)
		end

		for i, handler in pairs(self._pointExitHandlerDic) do
			PointerExitHandler.Get(i):RemoveLuaHandler(handler)
		end

		self:_onInit()
	else
		FloatWordMgr.instance:show("好像有地方填的不对，还是再仔细瞧瞧吧！")

		self._stopSubmit = true

		settimer(2, self._canSubmit, self)
		self:_onUpdate()
	end
end

function StickCoupletHardGameView:_canSubmit()
	self._stopSubmit = false

	removetimer(self._canSubmit, self)
end

return StickCoupletHardGameView
