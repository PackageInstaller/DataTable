-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/numberbomb/view/NumberGameView.lua

module("logic.extensions.numberbomb.view.NumberGameView", package.seeall)

local NumberGameView = class("NumberGameView", TableViewComponent)

function NumberGameView:ctor()
	NumberGameView.super.ctor(self)

	self._playerItemList = nil
	self._bubbleTimeList = nil
	self._calculatorBtns = nil
	self._choiNewsIndex = 0
	self._gameBaseInfo = nil
	self._playerInfoList = nil
	self._downTimer = 0
	self._newsTimeCD = 0
	self._choiNumber = 0
	self._numTxtList = nil
	self._boomItemList = nil
end

function NumberGameView:bindEvents()
	NumberGameView.super.bindEvents(self)
	self._newsOpenBtn:AddClickListener(self._onClickNewsOpenBtn, self)
end

function NumberGameView:unbindEvents()
	NumberGameView.super.unbindEvents(self)
	self._newsOpenBtn:RemoveClickListener()

	for _, go in pairs(self._calculatorBtns or {}) do
		if go then
			GameUtil.asBtn(go):RemoveClickListener()
		end
	end
end

function NumberGameView:onExit()
	NumberGameView.super.onExit(self)

	if self._operateEff then
		UIEffectManager.instance:stopEffect(self._operateEff)
	end

	self._operateEff = nil

	removetimer(self._calculationSurplusTime, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataPlayerGameInfo, self._updataPlayerGameInfo, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataNumberGameDoing, self._gotoNextPlayerShow, self)
	GlobalDispatcher:removeListener(GlobalNotify.NumberGameEndData, self._detectNumberGameEnd, self)
	GlobalDispatcher:removeListener(GlobalNotify.NumberGameViewClose, self.close, self)

	self._playerInfoList = nil
	self._gameBaseInfo = nil
end

function NumberGameView:destroyUI()
	NumberGameView.super.destroyUI(self)

	self._playerItemList = nil
	self._bubbleTimeList = nil
	self._calculatorBtns = nil
	self._downTimer = 0
	self._newsTimeCD = 0
	self._choiNumber = 0
	self._numTxtList = nil
	self._boomItemList = nil
end

function NumberGameView:buildUI()
	NumberGameView.super.buildUI(self)

	self._middleGo = self:getGo("middleGo")
	self._minNumTxt = goutil.findChildComponent(self._middleGo, "minNumTxt", "UIImgNumeralText")
	self._maxNumTxt = goutil.findChildComponent(self._middleGo, "maxNumTxt", "UIImgNumeralText")
	self._supTimeGo = self:getGo("supTimeGo")
	self._supTimeTxt = goutil.findChildTextComponent(self._supTimeGo, "supTimeTxt")
	self._playerItemList = {}

	for i = 1, 4 do
		local item = self:getGo("playerItem_" .. i)

		self._playerItemList[i] = {
			itemGo = item,
			bubbleTxt = goutil.findChildTextComponent(item, "bubbleGo/bubbleTxt"),
			bubbleGo = goutil.findChild(item, "bubbleGo"),
			areaTxt = goutil.findChildTextComponent(item, "areaTxt"),
			headGo = goutil.findChild(item, "headGo"),
			nameTxt = goutil.findChildTextComponent(item, "nameTxt"),
			numTxt = goutil.findChildComponent(item, "numTxt", "UIImgNumeralText"),
			indexTxt = goutil.findChildTextComponent(item, "indexTxt"),
			guessGo = goutil.findChild(item, "guessGo")
		}

		if i == 4 then
			self._playerItemList[i].winItemGo = goutil.findChild(item, "winItemGo")

			self._playerItemList[i].winItemGo:SetActive(false)
		end

		self._playerItemList[i].bubbleTxt.text = ""

		self._playerItemList[i].bubbleGo:SetActive(false)
		self._playerItemList[i].guessGo:SetActive(false)

		self._playerItemList[i].areaTxt.text = ""
		self._playerItemList[i].indexTxt.text = ""
		self._playerItemList[i].nameTxt.text = ""
	end

	self._calculatorGo = self:getGo("calculatorGo")
	self._calculatorTxt = goutil.findChildTextComponent(self._calculatorGo, "calculatorTxt2")
	self._inputNumTxt = goutil.findChildTextComponent(self._calculatorGo, "inputNumIma/inputNumTxt")

	local calculatorTran = self._calculatorGo.transform

	self._calculatorBtns = {}

	for i = 1, calculatorTran.childCount do
		local go = calculatorTran:GetChild(i - 1).gameObject
		local names = string.split(go.name, "_")

		if names and not string.nilorempty(names[2]) then
			table.insert(self._calculatorBtns, go)
			GameUtil.asBtn(go):AddClickListener(function()
				self:_onClickCalculatorBtns(names[2])
			end, self)
		end
	end

	self._newsListGo = self:getGo("newsListGo")
	self._newsOpenBtn = self:getBtn("newsOpenBtn")
	self._supTimeTxt.text = ""

	self._supTimeGo:SetActive(false)

	self._calculatorTxt.text = ""
	self._inputNumTxt.text = ""

	self._calculatorGo:SetActive(false)
	self._newsListGo:SetActive(false)
end

function NumberGameView:onEnter()
	NumberGameView.super.onEnter(self)
	NumberGameModel.instance:getAndSetGameOverData()

	if not self:_initializePlayerData() then
		printError("sr---炸弹数字 NumberGameView:onEnter()   初始化玩家数据有误")

		return
	end

	GlobalDispatcher:addListener(GlobalNotify.UpdataPlayerGameInfo, self._updataPlayerGameInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataNumberGameDoing, self._gotoNextPlayerShow, self)
	GlobalDispatcher:addListener(GlobalNotify.NumberGameEndData, self._detectNumberGameEnd, self)
	GlobalDispatcher:addListener(GlobalNotify.NumberGameViewClose, self.close, self)

	self._commonInfo = NumberGameConfig.instance:getCommonInfo()
	self._curViewDatas = NumberGameConfig.instance:getAllChatCfgs()
	self._operateEff = nil

	self:_gotoNextPlayerShow()

	self._newsTimeCD = 0

	settimer(1, self._calculationSurplusTime, self, true)
end

function NumberGameView:_initializePlayerData()
	self._newsListGo:SetActive(false)
	self:_showAndHideCalculatorPopup(false)

	if self._playerItemList == nil or #self._playerItemList < 4 then
		return
	end

	self._playerInfoList = NumberGameModel.instance:getAllPlayerData()

	if self._playerInfoList == nil or #self._playerInfoList < 4 then
		return
	end

	for i = 1, #self._playerItemList do
		local info = self._playerInfoList[i]
		local item = self._playerItemList[i]

		if info and item then
			GameUtil.rmClickHandler(item.headGo)

			item.nameTxt.text = info.headInfo.userName
			item.areaTxt.text = info.areaName

			if checknumber(info.choisNum) <= 0 then
				GameUtil.SetActive(item.numTxt, false)
				GameUtil.SetActive(item.guessGo, checknumber(info.choisNum) < 0)
			else
				GameUtil.SetActive(item.guessGo, false)
				GameUtil.SetActive(item.numTxt, true)
				item.numTxt:SetNum(info.choisNum)
			end

			item.bubbleTxt.text = ""

			item.bubbleGo:SetActive(false)

			item.indexTxt.text = tostring(info.index)

			HeadItemController.instance:setHeadCellByInfo(item.headGo, info.headInfo)
			GameUtil.addClickHandler(item.headGo, GameUtil.handler(self._onClickHeadItem, self, info.headInfo.userId, item.headGo))
		end
	end

	return true
end

function NumberGameView:_onClickHeadItem(userId, go)
	FriendController.instance:showInfoView(userId, go, true)
end

function NumberGameView:_getSortIndexByIndex(index)
	if self._playerInfoList == nil or #self._playerInfoList == 0 then
		return nil
	end

	for i = 1, #self._playerInfoList do
		if self._playerInfoList[i] and self._playerInfoList[i].index == index then
			return self._playerInfoList[i].sortIndex
		end
	end

	return nil
end

function NumberGameView:_gotoNextPlayerShow()
	self._gameBaseInfo = NumberGameModel.instance:getGameBaseInfo()

	if self._gameBaseInfo == nil or self._gameBaseInfo.doingInfo.minNum == nil then
		printError("sr---炸弹数字 NumberGameView:_gotoNextPlayerShow()      下一位数据空！")

		return
	end

	local doing = self._gameBaseInfo.doingInfo

	self._minNumTxt:SetNum(checknumber(doing.minNum))
	self._maxNumTxt:SetNum(checknumber(doing.maxNum))

	local sortIndex = self:_getSortIndexByIndex(doing.nextIndex)

	if checknumber(sortIndex) <= 0 then
		return
	end

	self._downTimer = self._commonInfo.operateTime
	self._supTimeTxt.text = self._downTimer .. "s"

	if self._playerItemList and self._playerItemList[sortIndex] then
		if self._playerInfoList and self._playerInfoList[sortIndex] and self._playerInfoList[sortIndex].isMyInfo then
			if doing.minNum + 2 == doing.maxNum then
				self:_showAndHideCalculatorPopup(true, tostring(doing.maxNum - 1))
			else
				self:_showAndHideCalculatorPopup(true)
			end
		end

		local pos = GameUtil.getLocalPos(self._playerItemList[sortIndex].guessGo)

		GameUtil.SetActive(self._playerItemList[sortIndex].numTxt, false)
		GameUtil.SetActive(self._playerItemList[sortIndex].guessGo, false)
		self._supTimeGo:SetActive(true)
		uGuiUtil.setImageGrayState(self._supTimeGo, false)
		self._supTimeGo.transform:SetParent(self._playerItemList[sortIndex].itemGo.transform, false)

		if sortIndex > 2 then
			pos.x = pos.x - 50
		end

		Framework.TransformUtil.SetLocalPos(self._supTimeGo.transform, pos.x, pos.y, pos.z)

		if self._operateEff == nil then
			self._operateEff = UIEffectManager.instance:playEffect(self, "fx_ui_zdsz/fx_ui_zdsz_ing.prefab", self._playerItemList[sortIndex].itemGo, 0, 0, true, nil, nil, nil, self)
		end

		self._operateEff:setParent(self._playerItemList[sortIndex].itemGo.transform)
		self._operateEff:setLocalPos(0, 55, 0)
		self._operateEff:setScale(1)
	end
end

function NumberGameView:_updataPlayerGameInfo(opType, sortIndex, param1, param2)
	if opType == nil or sortIndex == nil then
		printError("sr---炸弹数字 NumberGameView:_updataPlayerGameInfo()      怎么会收到这个状态！")
		self:_initializePlayerData()

		return
	end

	if checknumber(sortIndex) <= 0 then
		return
	end

	if self._playerItemList == nil or self._playerItemList[sortIndex] == nil then
		return
	end

	local item = self._playerItemList[sortIndex]

	opType = checknumber(opType)
	param1 = checknumber(param1)

	if opType == 1 then
		self._numTxtList = self._numTxtList or {}
		self._playerInfoList[sortIndex].choisNum = param1

		GameUtil.SetActive(item.numTxt, false)

		if param1 <= 0 then
			GameUtil.SetActive(item.guessGo, param1 < 0)
		else
			GameUtil.SetActive(item.guessGo, false)
			UIEffectManager.instance:playEffect(self, "fx_ui_zdsz/fx_ui_zdsz_shuaxing.prefab", item.itemGo, 0, 0, false, nil, nil, function(view, uiEffect)
				local pos = GameUtil.getLocalPos(item.guessGo)

				uiEffect:setParent(item.itemGo.transform)
				uiEffect:setLocalPos(pos.x, pos.y, 0)
				uiEffect:setScale(1)

				self._numTxtList[sortIndex] = {
					sortIndex = sortIndex,
					numTxt = item.numTxt,
					num = param1
				}
			end)
		end

		self._boomItemList = self._boomItemList or {}

		if param2 then
			if self._playerInfoList[sortIndex].isMyInfo then
				FloatWordMgr.instance:show("你猜到炸弹数字，出局，剩余玩家继续")
				GameUtil.SetActive(item.guessGo, false)
			else
				FloatWordMgr.instance:show("该名玩家猜到炸弹数字，出局，剩余玩家继续")
			end

			self._playerInfoList[sortIndex].isWait = true

			UIEffectManager.instance:playEffect(self, "fx_ui_zdsz/fx_ui_zdsz_baozha.prefab", item.itemGo, 0, 0, false, nil, nil, function(view, uiEffect)
				uiEffect:setParent(item.itemGo.transform)
				uiEffect:setLocalPos(0, 0, 0)
				uiEffect:setScale(1)

				self._boomItemList[sortIndex] = {
					timer = 2,
					sortIndex = sortIndex
				}
			end)
		else
			FloatWordMgr.instance:show("不是炸弹数字，继续")
		end

		if self._playerInfoList[sortIndex].isMyInfo then
			self:_showAndHideCalculatorPopup(false)
		end
	elseif opType == 2 then
		if param1 > 0 then
			if self._curViewDatas == nil or self._curViewDatas[param1] == nil then
				return
			end

			self._bubbleTimeList = self._bubbleTimeList or {}
			self._bubbleTimeList[sortIndex] = {
				isShow = true,
				timer = self._commonInfo.bubbleTime
			}

			item.bubbleGo:SetActive(true)

			item.bubbleTxt.text = self._curViewDatas[param1].content
		else
			item.bubbleTxt.text = ""

			item.bubbleGo:SetActive(false)

			self._bubbleTimeList[sortIndex] = nil

			if next(self._bubbleTimeList) == nil then
				self._bubbleTimeList = nil
			end
		end
	elseif opType == 3 then
		self._playerInfoList[sortIndex].isLeave = true
		self._playerInfoList[sortIndex].isWait = true

		self:_setPlayerItemGray(item)
		self:_detectNumberGameEnd(4)
		FloatWordMgr.instance:show("该名玩家退出本局游戏，剩余玩家继续")
	end
end

function NumberGameView:_setPlayerItemGray(item)
	if item == nil or item.itemGo == nil or not item.itemGo.activeSelf then
		return
	end

	if item.bubbleGo.activeSelf then
		item.bubbleTxt.text = ""

		item.bubbleGo:SetActive(false)
	end

	GameUtil.SetActive(item.numTxt, false)
	uGuiUtil.setTextGrayState(item.areaTxt.gameObject, true)
	uGuiUtil.setTextGrayState(item.indexTxt.gameObject, true)
	uGuiUtil.setTextGrayState(item.nameTxt.gameObject, true)
	uGuiUtil.setImageGrayStateRecursive(item.itemGo, true)
end

function NumberGameView:_detectNumberGameEnd(endType)
	endType = checknumber(endType)

	local sortIndex = 0

	for _, info in pairs(self._playerInfoList or {}) do
		if info and info.isMyInfo then
			sortIndex = info.sortIndex

			break
		end
	end

	if endType == 2 then
		self:_myNumberGameOverResult(sortIndex, false)

		return
	end

	if endType == 3 then
		self:_updataPlayerGameInfo(1, sortIndex, -1, true)

		return
	end

	if endType == 1 then
		for _, info in pairs(self._playerInfoList or {}) do
			if info and not info.isMyInfo and not info.isLeave then
				return
			end
		end

		self:_myNumberGameOverResult(sortIndex, true)

		return
	end

	if endType == 4 then
		if self._playerInfoList and self._playerInfoList[sortIndex] and self._playerInfoList[sortIndex].isLeave then
			self:_detectNumberGameEnd(2)

			return
		end

		for _, info in pairs(self._playerInfoList or {}) do
			if info and not info.isMyInfo and not info.isLeave then
				return
			end
		end

		self:_myNumberGameOverResult(sortIndex, true)
	end
end

function NumberGameView:_myNumberGameOverResult(mySortIndex, isWin)
	self._supTimeTxt.text = ""

	self._supTimeGo:SetActive(false)

	if not isWin or self._playerItemList == nil or self._playerItemList[mySortIndex] == nil then
		UIStateManager.instance:push(ViewName.NumberResult)

		return
	end

	if self._playerItemList[mySortIndex].winItemGo then
		self._playerItemList[mySortIndex].winItemGo:SetActive(true)
	end

	UIEffectManager.instance:playEffect(self, "fx_ui_zdsz/fx_ui_zdsz_shahua.prefab", self._playerItemList[mySortIndex].itemGo, 0, 0, false, nil, function()
		UIStateManager.instance:push(ViewName.NumberResult)
	end, function(view, uiEffect)
		uiEffect:setParent(self._playerItemList[mySortIndex].itemGo.transform)
		uiEffect:setLocalPos(0, 0, 0)
		uiEffect:setScale(1)
	end)
end

function NumberGameView:_calculationSurplusTime()
	for sortIndex, info in pairs(self._bubbleTimeList or {}) do
		if checknumber(sortIndex) > 0 and info then
			info.timer = info.timer - 1

			if info.timer <= 0 and info.isShow then
				self:_updataPlayerGameInfo(2, sortIndex)
			end
		end
	end

	for k, info in pairs(self._numTxtList or {}) do
		if info and info.sortIndex and info.numTxt then
			GameUtil.SetActive(info.numTxt, true)
			info.numTxt:SetNum(checknumber(info.num))

			self._numTxtList[k] = nil
		end
	end

	for k, info in pairs(self._boomItemList or {}) do
		if info and info.sortIndex and info.timer then
			info.timer = info.timer - 1

			if info.timer <= 0 then
				if self._playerInfoList and self._playerInfoList[k] then
					self._playerInfoList[k].isLeave = true
				end

				if self._playerItemList and self._playerItemList[k] then
					self:_setPlayerItemGray(self._playerItemList[k])
				end

				self:_detectNumberGameEnd(4)

				self._boomItemList[k] = nil
			end
		end
	end

	if self._newsTimeCD > 0 then
		self._newsTimeCD = self._newsTimeCD - 1
	end

	self._downTimer = self._downTimer - 1

	if self._downTimer <= 0 then
		self._supTimeTxt.text = "0s"

		return
	end

	self._supTimeTxt.text = self._downTimer .. "s"

	self:_checkingGameObjectActive()
end

function NumberGameView:_checkingGameObjectActive()
	if self._gameBaseInfo == nil or self._gameBaseInfo.doingInfo == nil then
		return
	end

	local doing = self._gameBaseInfo.doingInfo
	local sortIndex = self:_getSortIndexByIndex(doing.nextIndex)

	if checknumber(sortIndex) <= 0 then
		return
	end

	if self._playerItemList and self._playerItemList[sortIndex] then
		if self._playerInfoList and self._playerInfoList[sortIndex] and self._playerInfoList[sortIndex].isMyInfo then
			self:_showAndHideCalculatorPopup(true)
		end

		local pos = GameUtil.getLocalPos(self._playerItemList[sortIndex].guessGo)

		GameUtil.SetActive(self._playerItemList[sortIndex].numTxt, false)
		GameUtil.SetActive(self._playerItemList[sortIndex].guessGo, false)

		if not self._supTimeGo.activeSelf then
			self._supTimeGo:SetActive(true)
			uGuiUtil.setImageGrayState(self._supTimeGo, false)
		end

		self._supTimeGo.transform:SetParent(self._playerItemList[sortIndex].itemGo.transform, false)

		if sortIndex > 2 then
			pos.x = pos.x - 50
		end

		Framework.TransformUtil.SetLocalPos(self._supTimeGo.transform, pos.x, pos.y, pos.z)
	end
end

function NumberGameView:_onClickNewsOpenBtn()
	if self._newsListGo.activeSelf then
		return
	end

	self._choiNewsIndex = 0

	self._newsListGo:SetActive(true)

	if self._curViewDatas == nil or #self._curViewDatas == 0 then
		self._curViewDatas = NumberGameConfig.instance:getAllChatCfgs()
	end

	self._tableview:ReloadData()
end

function NumberGameView:_showAndHideCalculatorPopup(isShow, str)
	if not isShow then
		self._choiNumber = 0

		if self._calculatorGo.activeSelf then
			self._inputNumTxt.text = ""

			self._calculatorGo:SetActive(false)
		end

		return
	end

	if not self._calculatorGo.activeSelf then
		self._choiNumber = checknumber(str)

		self._calculatorGo:SetActive(true)

		self._inputNumTxt.text = string.nilorempty(str) and "?" or str
	end
end

function NumberGameView:_onClickCalculatorBtns(str)
	if string.nilorempty(str) then
		return
	end

	local doing = self._gameBaseInfo.doingInfo

	if doing.minNum + 2 == doing.maxNum and str ~= "QD" then
		FloatWordMgr.instance:show("你只有这个选择了，请点击确认哦！")

		return
	end

	if str == "CZ" then
		self._choiNumber = 0
		self._inputNumTxt.text = "?"
	elseif str == "QD" then
		if self._choiNumber <= doing.minNum or self._choiNumber >= doing.maxNum then
			FloatWordMgr.instance:show("输入数字不在数字范围内")

			return
		end

		NumberGameController.instance:csGameGuessNumberReq(self._choiNumber)
		FloatWordMgr.instance:show("发送成功")
		self:_showAndHideCalculatorPopup(false)
	else
		local num = checknumber(str)
		local tempNumber = self._choiNumber

		tempNumber = self._choiNumber <= 0 and num or self._choiNumber * 10 + num

		if tempNumber >= doing.maxNum then
			FloatWordMgr.instance:show(string.format("请输入小于%s的数", doing.maxNum))

			return
		end

		self._choiNumber = tempNumber
		self._inputNumTxt.text = tostring(self._choiNumber)
	end
end

function NumberGameView:_getPath()
	return {
		cellPath = "newsListGo/newsItem",
		viewPath = "newsListGo/newsListSR"
	}
end

function NumberGameView:_cellSize()
	return 252, 32
end

function NumberGameView:_updateCell(view, cell, data)
	GameUtil.asBtn(cell):RemoveClickListener()

	local newsTxt = goutil.findChildTextComponent(cell, "newsTxt")
	local index = data.chatMsgId

	newsTxt.text = data.content

	GameUtil.asBtn(cell):AddClickListener(function()
		self:_onClickNewsItemBtn(index)
	end, self)
end

function NumberGameView:_onClickNewsItemBtn(index)
	if checknumber(self._newsTimeCD) > 0 then
		FloatWordMgr.instance:show("让消息飞一会儿，过一会儿再发吧")

		return
	end

	self._newsListGo:SetActive(false)
	NumberGameController.instance:csSendGameChatMsgReq(index)

	self._newsTimeCD = self._commonInfo.chatCD
end

return NumberGameView
