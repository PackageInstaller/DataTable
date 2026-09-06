-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/romanticgifts/view/RomanticGiftsView.lua

module("logic.extensions.romanticgifts.view.RomanticGiftsView", package.seeall)

local RomanticGiftsView = class("RomanticGiftsView", ViewComponent)

function RomanticGiftsView:ctor()
	RomanticGiftsView.super.ctor(self)
end

function RomanticGiftsView:unbindEvents()
	RomanticGiftsView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnJumpTo:RemoveClickListener()
	self._btnFriend:RemoveClickListener()
	self._btnRecord:RemoveClickListener()
	self._btnSearch:RemoveClickListener()
	self._btnClear:RemoveClickListener()
	self._btnBuyPassPort:RemoveClickListener()
	self._btnTips:RemoveClickListener()
end

function RomanticGiftsView:bindEvents()
	RomanticGiftsView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._closeView, self)
	self._btnJumpTo:AddClickListener(self._jumpToOnClick, self)
	self._btnFriend:AddClickListener(self._friendOnClick, self)
	self._btnRecord:AddClickListener(self._recordOnClick, self)
	self._btnSearch:AddClickListener(self._onSearchTextChanged, self)
	self._btnClear:AddClickListener(self._onClearSearchClick, self)
	self._btnBuyPassPort:AddClickListener(self._onClickBtnBuyPassport, self)
	self._btnTips:AddClickListener(self._btnTipsOnClick, self)
end

function RomanticGiftsView:onExit()
	RomanticGiftsView.super.onExit(self)
	self._tabList:dispose()
	self._tabLeftList:dispose()
	self._tabRecordList:dispose()
	UIEffectManager.instance:stopEffect(self._baoxiangEff)
	GlobalDispatcher:removeListener(GlobalNotify.QiXiSendGiftGetInfoReq, self._refreshSendUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.QiXiSendGiftSendReq, self._refreshFriendList, self)
	GlobalDispatcher:removeListener(GlobalNotify.PassportStateUpdate, self._refreshUI, self)
	RedPointController.instance:unregRedPoint(self._btnJumpToRed, RedPointModel.ID_ROMANTIC_TASK)
end

function RomanticGiftsView:buildUI()
	RomanticGiftsView.super.buildUI(self)

	self._inputSearch = self:getInput("sendfriend/InputC_Search")
	self._btnClear = self:getBtn("sendfriend/InputC_Search/BtnClear")
	self._btnSearch = self:getBtn("sendfriend/InputC_Search/btnSearch")
	self._btnTips = self:getBtn("leftTop/btnTip")
	self._cell = self:getGo("passport/cell")
	self._tableview = self:getGo("passport/tableview")
	self._tabViewport = self:getGo("passport/tableview/Viewport"):GetComponent(goutil.Type_RectTransform)
	self._txtProgressRoman = self:getTxt("passport/txtProgress")
	self._progress = self:getSlider("passport/tableview/Viewport/Content/progress")
	self._cellLeft = self:getGo("sendfriend/cell_left")
	self._tabLeft = self:getGo("sendfriend/tableview_left")
	self._cellRecord = self:getGo("sendfriend/cell_record")
	self._tabRecord = self:getGo("sendfriend/tableview_record")
	self._btnJumpToRed = self:getGo("btnJumpTo/red")
	self._btnFriendSelect = self:getGo("sendfriend/btnFriend/select")
	self._btnRecordSelect = self:getGo("sendfriend/btnRecord/select")
	self._tipsGO = self:getGo("sendfriend/tableview_left/txtTips")
	self._btnFriend = self:getBtn("sendfriend/btnFriend")
	self._btnRecord = self:getBtn("sendfriend/btnRecord")
	self._btnJumpTo = self:getBtn("btnJumpTo")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnBuyPassPort = self:getBtn("passport/btnBuyPassPort")
	self._openDate = self:getTxt("time/txtTime")
	self._tabList = ScrollerList.create(self._tableview, self._cell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
	self._tabLeftList = ScrollerList.create(self._tabLeft, self._cellLeft, GameUtil.handler(self._updateLeftCell, self), GameUtil.handler(self._clearLeftCell, self))
	self._tabRecordList = ScrollerList.create(self._tabRecord, self._cellRecord, GameUtil.handler(self._updateRecordCell, self), GameUtil.handler(self._clearRecordCell, self))
end

function RomanticGiftsView:onEnter()
	RomanticGiftsView.super.onEnter(self)

	self._curActId = RomanticGiftsModel.instance:getActId()

	if self._curActId == 0 then
		FloatWordMgr.instance:show("不在活动时间")
		self:close()

		return
	end

	self._actCfg = RomanticGiftsConfig.instance:getCfgById(self._curActId)
	self._passPortFuncId = self._actCfg.passPortType

	local startDate, endDate = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.QIXI_SEND, self._curActId)
	local startDateTable = GameUtil.time2date(startDate)
	local endDateTable = GameUtil.time2date(endDate)

	self._openDate.text = string.format("活动时间：%02d.%02d %02d:%02d-%02d.%02d %02d:%02d", startDateTable.month, startDateTable.day, startDateTable.hour, startDateTable.min, endDateTable.month, endDateTable.day, endDateTable.hour, endDateTable.min)
	self._curSearchStr = ""
	self._effectList = {}
	self._effectRightList = {}

	self:_sendInfoReq()
	self:_friendOnClick()
	GlobalDispatcher:addListener(GlobalNotify.QiXiSendGiftGetInfoReq, self._refreshSendUI, self)
	GlobalDispatcher:addListener(GlobalNotify.QiXiSendGiftSendReq, self._refreshFriendList, self)
	GlobalDispatcher:addListener(GlobalNotify.PassportStateUpdate, self._refreshUI, self)
	RedPointController.instance:regRedPoint(self._btnJumpToRed, RedPointModel.ID_ROMANTIC_TASK)
end

function RomanticGiftsView:_updateTabCell(view, cell, data)
	local left = goutil.findChild(cell, "left")
	local leftItem = goutil.findChild(cell, "left/item")
	local leftTxtNum = goutil.findChild(cell, "left/txtNum")
	local leftEffect = goutil.findChild(cell, "left/effect")
	local leftBtn = goutil.findChild(cell, "left/btn")
	local leftmMrkGet = goutil.findChild(cell, "left/markGet")
	local progressTxt = goutil.findChildTextComponent(cell, "left/txtTitle")
	local right = goutil.findChild(cell, "right")
	local rightItem = goutil.findChild(cell, "right/item")
	local rightTxtNum = goutil.findChild(cell, "right/txtNum")
	local rightEffect = goutil.findChild(cell, "right/effect")
	local rightBtn = goutil.findChild(cell, "right/btn")
	local rightMarkGet = goutil.findChild(cell, "right/markGet")
	local lock = goutil.findChild(cell, "right/lock")
	local leftState = not data.freeState and checknumber(data.progressKey) <= self._curData.progress
	local rightState = not data.superState and checknumber(data.progressKey) <= self._curData.progress

	MaterialMgr.resetAll(leftItem)
	MaterialMgr.resetAll(rightItem)

	if not next(data) then
		goutil.setActive(left, false)
		goutil.setActive(right, false)
	else
		goutil.setActive(left, true)
		goutil.setActive(right, true)
	end

	progressTxt.text = data.progressKey

	MaterialMgr.setCellByCfg(data.freePrize, leftItem)
	MaterialMgr.setCellByCfg(data.payedPrize, rightItem)
	goutil.setActive(leftmMrkGet, data.freeState)
	goutil.setActive(rightMarkGet, data.superState)
	goutil.setActive(lock, not self._curData.hasPay)
	goutil.setActive(leftBtn, not data.freeState and checknumber(data.progressKey) <= self._curData.progress)
	goutil.setActive(rightBtn, not data.superState and checknumber(data.progressKey) <= self._curData.progress)
	GameUtil.rmClickHandler(leftBtn)
	GameUtil.addClickHandler(leftBtn, function()
		if data.freeState then
			FloatWordMgr.instance:show("已经领过")
		else
			PassportController.instance:sendGainPrizeReq(self._curData.actId, self._curData.funcId, data.id - 1, false, false, GameUtil.handler(self._refreshUI, self))
		end
	end, self)
	GameUtil.rmClickHandler(rightBtn)
	GameUtil.addClickHandler(rightBtn, function()
		if not self._curData.hasPay then
			FloatWordMgr.instance:show("未购买")

			return
		end

		if data.superState then
			FloatWordMgr.instance:show("已经领过")
		else
			PassportController.instance:sendGainPrizeReq(self._curData.actId, self._curData.funcId, data.id - 1, true, false, GameUtil.handler(self._refreshUI, self))
		end
	end, self)
	self:_stopEff(cell, self._effectList)
	self:_stopEff(cell, self._effectRightList)

	if leftState then
		self:_playEff(leftEffect, cell, self._effectList)
	end

	if rightState then
		self:_playEff(rightEffect, cell, self._effectRightList)
	end
end

function RomanticGiftsView:_updateLeftCell(view, cell, data)
	local head = goutil.findChild(cell, "head")
	local btnSend = goutil.findChild(cell, "btnSend")
	local online = goutil.findChild(cell, "online")
	local txtNum = goutil.findChildTextComponent(cell, "txtNum")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtAera = goutil.findChildTextComponent(cell, "arean/txtAera")
	local friendInfo = FriendModel.instance:getFriendMo(data.userId)

	if not friendInfo then
		printError("lbc=========好友id不在好友列表里? userId:", data.userId)

		return
	end

	local isOnline = friendInfo:Online()

	goutil.setActive(online, isOnline)
	goutil.clearChildren(head)

	if friendInfo.headInfo then
		local proxy = HeadItemController.instance:setHeadCellByInfo(head, friendInfo.headInfo)

		if proxy then
			proxy:setCallBack(function()
				FriendController.instance:showInfoView(friendInfo.headInfo.userId, head)
			end)
		end

		txtName.text = friendInfo.headInfo.userName
		txtAera.text = friendInfo.headInfo.areaName
		txtNum.text = string.format("浪漫值:%s", data.value)
	end

	GameUtil.rmClickHandler(btnSend)
	GameUtil.addClickHandler(btnSend, function()
		UIStateManager.instance:push(ViewName.QixiSendflowerView, friendInfo.headInfo)
	end, self)
end

function RomanticGiftsView:_updateRecordCell(view, cell, data)
	local txtNum = goutil.findChildTextComponent(cell, "txtNum")
	local txtTime = goutil.findChildTextComponent(cell, "txtTime")
	local txtFriend = goutil.findChildTextComponent(cell, "txtFriend")
	local txtSend = goutil.findChildTextComponent(cell, "btnSend/Text")
	local btnSend = goutil.findChild(cell, "btnSend")
	local flowerCfg = RomanticGiftsModel.instance:getFlowerCfg(data.id)
	local propName = MaterialMgr.getMaterialsNameByCfg(flowerCfg.itemKey)

	txtFriend.text = string.format(data.result == 1 and "您给%s赠送了" or "好友%s赠送了", data.userName)
	txtSend.text = data.result == 1 and "继续赠送" or "一键回赠"
	txtNum.text = string.format("%s*%s", propName, data.num)
	txtTime.text = GameUtil.formatTimeStamp("%Y.%m.%d %H:%M:%S", data.time / 1000)

	GameUtil.rmClickHandler(btnSend)
	GameUtil.addClickHandler(btnSend, function()
		UIStateManager.instance:push(ViewName.QixiSendflowerView, {
			userId = data.userId,
			userName = data.userName
		})
	end, self)
end

function RomanticGiftsView:_closeView()
	self:close()
end

function RomanticGiftsView:_jumpToOnClick()
	UIStateManager.instance:push(ViewName.PassporttaskcommonView, {
		parameter = 1,
		activityId = self._curActId
	})
end

function RomanticGiftsView:_friendOnClick()
	goutil.setActive(self._tabRecord, false)
	goutil.setActive(self._tabLeft, true)
	self:_btnState(true)
end

function RomanticGiftsView:_recordOnClick()
	goutil.setActive(self._tabRecord, true)
	goutil.setActive(self._tabLeft, false)
	self:_btnState(false)
end

function RomanticGiftsView:_refreshUI()
	self._curData = PassportModel.instance:getInfo(self._passPortFuncId)

	local dataList = self:_creatCellDataList()

	self._tabList:reloadData(dataList)

	self._txtProgressRoman.text = self._curData.progress

	self._progress:SetValue(self:_getSliderValue(self._curData.progress, dataList))
end

function RomanticGiftsView:_refreshSendUI()
	local text = self._inputSearch:GetText()
	local records, friends

	if string.nilorempty(text) then
		records, friends = RomanticGiftsModel.instance:getTabInfo()
	else
		records, friends = RomanticGiftsModel.instance:getTabInfoByKeyWord(text)
	end

	self._tabLeftList:reloadData(friends)
	self._tabRecordList:reloadData(records)

	if friends and #friends > 0 then
		goutil.setActive(self._tipsGO, false)
	else
		goutil.setActive(self._tipsGO, true)
	end
end

function RomanticGiftsView:_refreshFriendList()
	self:_sendInfoReq()
end

function RomanticGiftsView:_sendInfoReq()
	QiXiSendGiftAgent.instance:sendPM_QiXiSendGiftGetInfoReq(self._curActId)
	PassportController.instance:sendGetInfoReq(self._actCfg.passPortType, GameUtil.handler(self._refreshUI, self))
end

function RomanticGiftsView:_creatCellDataList()
	local dataList = {}

	for index, v in ipairs(self._curData.prizeCfgs) do
		local data = {}

		data.id = index

		if self._curData.funcId == 4 then
			local params = string.split(v.thresholdParam, "-")

			data.progressKey = string.format("第%s章", checkint(params[1]) - 1000)
		else
			data.progressKey = checknumber(v.thresholdParam)
		end

		data.freePrize = v.freePrize
		data.payedPrize = v.payedPrize
		data.freeState = self._curData.normalPrizeState[index]
		data.superState = self._curData.superPrizeState[index]
		data.isLast = false

		table.insert(dataList, data)
	end

	return dataList
end

function RomanticGiftsView:_onClickBtnBuyPassport()
	if self._curData.hasPay then
		FloatWordMgr.instance:show("已经购买")

		return
	end

	UIStateManager.instance:push(ViewName.PassportbuyView, self._curData.actCfg, self._curData.funcCfg, 1, self._curData.sldValue, nil)
end

function RomanticGiftsView:_onSearchTextChanged()
	local text = self._inputSearch:GetText()

	if text ~= self._curSearchStr then
		if string.nilorempty(text) then
			self:_refreshSendUI()
		else
			local records, friends = RomanticGiftsModel.instance:getTabInfoByKeyWord(text)

			self._tabLeftList:reloadData(friends)
			self._tabRecordList:reloadData(records)
		end

		self._curSearchStr = text
	end
end

function RomanticGiftsView:_onClearSearchClick()
	self._inputSearch.input.text = ""

	self:_onSearchTextChanged()
end

function RomanticGiftsView:_btnState(isShow)
	goutil.setActive(self._btnFriendSelect, isShow)
	goutil.setActive(self._btnRecordSelect, not isShow)
end

function RomanticGiftsView:_btnTipsOnClick()
	UIStateManager.instance:push(ViewName.RulesView, "romanticgifts_rule")
end

function RomanticGiftsView:_getSliderValue(curScore, progressPrizeDatas)
	if progressPrizeDatas then
		if not (#progressPrizeDatas - 1) then
			local count = 0

			if count == 0 or curScore <= 0 then
				return 0
			end

			local once = 1 / count
			local value = 0

			for i = 1, count do
				if progressPrizeDatas[i] and progressPrizeDatas[i].progressKey > 0 then
					if curScore > progressPrizeDatas[i].progressKey then
						value = value + once
					else
						local syc = 0

						if progressPrizeDatas[i - 1] and progressPrizeDatas[i - 1].progressKey > 0 then
							syc = progressPrizeDatas[i - 1].progressKey
						end

						local temp = (curScore - syc) * once / (progressPrizeDatas[i].progressKey - syc)

						value = value + temp

						break
					end
				end
			end

			return value
		end
	end
end

function RomanticGiftsView:_playEff(go, index, list)
	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, go.transform, 0, 0, true, false, nil, function(target, eff)
		if not goutil.isNil(self._tabViewport) then
			eff:setClipping(self._tabViewport)
		end
	end)

	uiEffect:setParent(go.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScale(1)

	list[index] = uiEffect
end

function RomanticGiftsView:_stopEff(index, list)
	if list[index] then
		UIEffectManager.instance:stopEffect(list[index])

		list[index] = nil
	end
end

return RomanticGiftsView
