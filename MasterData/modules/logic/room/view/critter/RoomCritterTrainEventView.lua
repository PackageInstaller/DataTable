-- chunkname: @modules/logic/room/view/critter/RoomCritterTrainEventView.lua

module("modules.logic.room.view.critter.RoomCritterTrainEventView", package.seeall)

local RoomCritterTrainEventView = class("RoomCritterTrainEventView", BaseView)

function RoomCritterTrainEventView:onInitView()
	self._goeventitem = gohelper.findChild(self.viewGO, "go_content/#go_event_item")
	self._txtname = gohelper.findChildText(self.viewGO, "go_content/#go_event_item/#txt_name")
	self._txtnum = gohelper.findChildText(self.viewGO, "go_content/#go_event_item/#txt_num")
	self._btnevent = gohelper.findChildButtonWithAudio(self.viewGO, "go_content/#go_event_item/#btn_event")
	self._gopos41 = gohelper.findChild(self.viewGO, "go_content/#go_pos4_1")
	self._gopos42 = gohelper.findChild(self.viewGO, "go_content/#go_pos4_2")
	self._gopos43 = gohelper.findChild(self.viewGO, "go_content/#go_pos4_3")
	self._gopos44 = gohelper.findChild(self.viewGO, "go_content/#go_pos4_4")
	self._gorighttopbtns = gohelper.findChild(self.viewGO, "#go_righttopbtns")
	self._btncurrency = gohelper.findChildButtonWithAudio(self.viewGO, "#go_righttopbtns/#go_container/currency/#btn_currency")
	self._imagecurrency = gohelper.findChildImage(self.viewGO, "#go_righttopbtns/#go_container/currency/#image")
	self._btnadd = gohelper.findChildButtonWithAudio(self.viewGO, "#go_righttopbtns/#go_container/currency/#btn_add")
	self._txtcurrency = gohelper.findChildText(self.viewGO, "#go_righttopbtns/#go_container/currency/content/#txt")
	self._goBackBtns = gohelper.findChild(self.viewGO, "#go_BackBtns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomCritterTrainEventView:addEvents()
	self._btncurrency:AddClickListener(self._btncurrencyOnClick, self)
	self._btnadd:AddClickListener(self._btnaddOnClick, self)
	self._btnevent:AddClickListener(self._btneventOnClick, self)
end

function RoomCritterTrainEventView:removeEvents()
	self._btncurrency:RemoveClickListener()
	self._btnadd:RemoveClickListener()
	self._btnevent:RemoveClickListener()
end

function RoomCritterTrainEventView:_btncurrencyOnClick()
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.RoomCritterTrain, false, nil, false)
end

function RoomCritterTrainEventView:_btnaddOnClick()
	local currencys = {
		MaterialEnum.MaterialType.Currency,
		CurrencyEnum.CurrencyType.RoomCritterTrain,
		1
	}

	RoomCritterController.instance:openExchangeView(currencys)
end

function RoomCritterTrainEventView:_btneventOnClick()
	return
end

function RoomCritterTrainEventView:_refreshCurrency()
	local currencyMO = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.RoomCritterTrain)
	local currencyCO = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.RoomCritterTrain)

	self._txtcurrency.text = GameUtil.numberDisplay(currencyMO.quantity)

	UISpriteSetMgr.instance:setCurrencyItemSprite(self._imagecurrency, currencyCO.icon .. "_1")
end

function RoomCritterTrainEventView:_editableInitView()
	local parantGos = {
		self._gopos41,
		self._gopos42,
		self._gopos43,
		self._gopos44
	}

	self._numPostDict = {
		[3] = {
			80,
			0,
			204,
			-41,
			252.8,
			97.4
		}
	}
	self._eventIconDict = {
		[203] = "room_train_btn_3",
		[202] = "room_train_btn_4",
		[201] = "room_train_btn_1",
		[CritterEnum.EventType.Special] = "room_train_btn_2",
		[CritterEnum.EventType.ActiveTime] = "room_train_btn_1"
	}
	self._eventTbList = self:getUserDataTb_()

	for i = 1, #parantGos do
		local go = gohelper.clone(self._goeventitem, parantGos[i])

		table.insert(self._eventTbList, self:_initCreateTB(go))
	end

	gohelper.setActive(self._goeventitem, false)
end

function RoomCritterTrainEventView:onUpdateParam()
	return
end

function RoomCritterTrainEventView:onOpen()
	self.addEventCb(self, CritterController.instance, CritterEvent.TrainSelectEventOptionReply, self._refreshUI, self)
	CurrencyController.instance:registerCallback(CurrencyEvent.CurrencyChange, self._refreshCurrency, self)

	self._critterUid = self.viewParam and self.viewParam.critterUid

	self:_refreshUI()
end

function RoomCritterTrainEventView:onClose()
	CurrencyController.instance:unregisterCallback(CurrencyEvent.CurrencyChange, self._refreshCurrency, self)

	for i = 1, #self._eventTbList do
		self._eventTbList[i]._btnevent:RemoveClickListener()
	end
end

function RoomCritterTrainEventView:onDestroyView()
	return
end

function RoomCritterTrainEventView:_initCreateTB(go)
	local tb = self:getUserDataTb_()

	tb.go = go
	tb.goTrs = go.transform
	tb._gospecialbg = gohelper.findChild(go, "specialbg")
	tb._gonormalbg = gohelper.findChild(go, "normalbg")
	tb._gonumbg = gohelper.findChild(go, "numbg")
	tb._txtname = gohelper.findChildText(go, "#txt_name")
	tb._txtnum = gohelper.findChildText(go, "#txt_num")
	tb._imageicon = gohelper.findChildImage(go, "#image_icon")
	tb._btnevent = gohelper.findChildButtonWithAudio(go, "#btn_event")

	tb._btnevent:AddClickListener(self._onItemEventClick, self, tb)

	tb._gograyList = {
		tb._imageicon.gameObject,
		tb._gospecialbg,
		tb._gonormalbg,
		tb._gonumbg
	}
	tb.eventMO = nil

	return tb
end

function RoomCritterTrainEventView:_refreshTB(tb, eventMO, critterUid)
	if not tb then
		return
	end

	tb.eventMO = eventMO
	tb.critterUid = critterUid

	if eventMO then
		local isSpecial = eventMO:getEventType() == CritterEnum.EventType.Special
		local deCfg = eventMO:getDefineCfg()

		tb._txtname.text = deCfg and deCfg.name
		tb._txtnum.text = eventMO.remainCount

		gohelper.setActive(tb._gospecialbg, isSpecial)
		gohelper.setActive(tb._gonormalbg, not isSpecial)

		local grayValue = eventMO:isHasEventAction() and 0 or 1

		for _, gameObject in ipairs(tb._gograyList) do
			ZProj.UGUIHelper.SetGrayFactor(gameObject, grayValue)
		end

		local eventIconId = deCfg and deCfg.id

		if not self._eventIconDict[eventIconId] then
			local nameStr = self._eventIconDict[CritterEnum.EventType.Special]

			UISpriteSetMgr.instance:setCritterSprite(tb._imageicon, nameStr)
		end
	end
end

function RoomCritterTrainEventView:_onItemEventClick(tb)
	local eventMO = tb.eventMO
	local critterMO = self:getCritterMO()

	if critterMO and eventMO and eventMO:isHasEventAction() then
		local processTime = critterMO.trainInfo:getProcessTime()

		if processTime >= eventMO.activeTime then
			local eventCfg = CritterConfig.instance:getCritterTrainEventCfg(eventMO.eventId)

			if not eventCfg then
				return
			end

			local costList = string.splitToNumber(eventCfg.cost, "#")
			local itemType = costList and costList[1]
			local itemId = costList and costList[2]
			local itemCount = costList and costList[3]

			if itemCount and itemCount > 0 and itemCount > ItemModel.instance:getItemQuantity(itemType, itemId) then
				GameFacade.showMessageBox(MessageBoxIdDefine.RoomCritterTrainItemInsufficiency, MsgBoxEnum.BoxType.Yes_No, self._onYesOpenTradeView, nil, nil, self, nil, nil)

				return
			end

			self:closeThis()

			local heroId = critterMO and critterMO.trainInfo.heroId

			RoomCritterController.instance:startTrain(eventMO.eventId, self._critterUid, heroId)
		end
	end
end

function RoomCritterTrainEventView:_onYesOpenTradeView()
	GameFacade.jump(JumpEnum.JumpId.RoomStoreTabFluff)
end

function RoomCritterTrainEventView:_refreshUI()
	local critterMO = self:getCritterMO()

	if not critterMO or not critterMO.trainInfo or critterMO.trainInfo:isFinishAllEvent() then
		self:closeThis()

		return
	end

	self:_refreshEventBnts(critterMO.trainInfo.events)
	self:_refreshCurrency()
end

function RoomCritterTrainEventView:_refreshEventBnts(eventMOList)
	local count = 0

	if eventMOList then
		for i, eventMO in ipairs(eventMOList) do
			if CritterEnum.NeedActionEventTypeDict[eventMO:getEventType()] and self:_checkEventMOShow(eventMO) then
				count = count + 1

				local tb = self._eventTbList[count]

				self:_refreshTB(tb, eventMO, self._critterUid)
			end
		end
	end

	local posNunList = self._numPostDict[count]

	for i = 1, #self._eventTbList do
		local tb = self._eventTbList[i]

		gohelper.setActive(tb.go, i <= count)

		if posNunList then
			if not posNunList[2 * i - 1] then
				local anchorX = 0

				if posNunList then
					if not posNunList[2 * i] then
						local anchorY = 0

						recthelper.setAnchor(tb.goTrs, anchorX, anchorY)
					end
				end
			end
		end
	end
end

function RoomCritterTrainEventView:_checkEventMOShow(eventMO)
	if eventMO:getEventType() == CritterEnum.EventType.Special then
		return eventMO:isEventActive()
	end

	return true
end

function RoomCritterTrainEventView:getCritterMO()
	return CritterModel.instance:getCritterMOByUid(self._critterUid)
end

return RoomCritterTrainEventView
