-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuobirthday/view/LinkageSignInView.lua

module("logic.extensions.xiaonuobirthday.view.LinkageSignInView", package.seeall)

local LinkageSignInView = class("LinkageSignInView", ViewComponent)

function LinkageSignInView:ctor()
	LinkageSignInView.super.ctor(self)
end

function LinkageSignInView:unbindEvents()
	LinkageSignInView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnPgetour)
end

function LinkageSignInView:bindEvents()
	LinkageSignInView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnPgetour, self._onClickPagetour, self)
end

function LinkageSignInView:buildUI()
	self._txtTime = self:getTxt("time/txtTime")
	self._btnPgetour = self:getBtn("btnPagetour")
	self._txtLeft = self:getTxt("txtLeft")
	self._txtRight = self:getTxt("txtRight")
	self._txtTimeRight = self:getTxt("time_2/txtTime")
	self._cellUp = self:getGo("cell_left")
	self._cellDown = self:getGo("cell_right")
	self._cell = self:getGo("cell")
	self._tableviewUp = self:getGo("tableview_left")
	self._tableviewDown = self:getGo("tableview_right")
	self._tableview = self:getGo("tableview")
	self._scrollViewUp = ScrollerList.create(self._tableviewUp, self._cellUp, GameUtil.handler(self._updateUpCell, self), GameUtil.handler(self._clearUpView, self))
	self._scrollViewDown = ScrollerList.create(self._tableviewDown, self._cellDown, GameUtil.handler(self._updateDownCell, self), GameUtil.handler(self._clearDownView, self))
	self._scrollView = ScrollerList.create(self._tableview, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function LinkageSignInView:onExit()
	LinkageSignInView.super.onExit(self)
	self._scrollViewUp:dispose()
	self._scrollViewDown:dispose()
	self._scrollView:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.ActivitySummaryUpdate, self._onRefreshUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.ActivityGainPrize, self._gainPrize, self)
end

function LinkageSignInView:onEnter()
	LinkageSignInView.super.onEnter(self)

	local param = self:getFirstParam().parameter
	local actIdList = string.splitToNumber(param, "#")

	self._activityIdList = actIdList or {}
	self._sendMsgIdx = 1
	self._effList = {}

	GlobalDispatcher:addListener(GlobalNotify.ActivitySummaryUpdate, self._onRefreshUI, self)
	GlobalDispatcher:addListener(GlobalNotify.ActivityGainPrize, self._gainPrize, self)
	self:_onRefreshUI()
end

function LinkageSignInView:sendGetSignInfoMsg()
	self._activityIdList = self._activityIdList or {}
	self._sendMsgIdx = self._sendMsgIdx or 1

	if self._sendMsgIdx <= #self._activityIdList then
		local actId = self._activityIdList[self._sendMsgIdx]

		if ActivityDefineController.instance:checkIsInActivityTimeByActivityId(actId) then
			ActivitySummaryController.instance:sendGetSignInfo(actId)

			self._sendMsgIdx = self._sendMsgIdx + 1
		end
	end
end

function LinkageSignInView:_onRefreshUI()
	self:sendGetSignInfoMsg()

	if #self._activityIdList <= 0 then
		return
	end

	local actId1 = self._activityIdList[1]
	local actId2 = self._activityIdList[2]
	local actId3 = self._activityIdList[3]

	self:updateList(actId1, self._scrollViewUp, self._txtLeft, self._txtTime)

	self._rightActId = actId2

	if actId3 ~= nil and ActivityDefineController.instance:checkIsInActivityTimeByActivityId(actId3) then
		self._rightActId = actId3
	end

	self:updateList(self._rightActId, self._scrollViewDown, self._txtRight, self._txtTimeRight)

	local cfgList = XiaonuoBirthConfig.instance:getSignInList(self._rightActId)
	local list = {}

	for i, v in pairs(cfgList) do
		if checknumber(i) > 0 then
			table.insert(list, v)
		end
	end

	table.sort(list, function(a, b)
		return a.signInDays < b.signInDays
	end)
	self._scrollView:reloadData(list)
end

function LinkageSignInView:updateList(actId, scrollerList, txtName, txtTime)
	self._infoMap = self._infoMap or {}

	local obj = {}
	local info = ActivitySummaryModel.instance:getSignInfo(actId) or {}

	obj.info = info
	obj.onlineDay = checknumber(info.onlineDay)
	obj.signInMap = {}
	obj.codeMap = {}

	for _, day in pairs(info.hasGainPrizeDays or {}) do
		obj.signInMap[day] = true
	end

	for _, info in ipairs(info.exchangeCodes or {}) do
		obj.codeMap[info.day] = info.exchangeCode
	end

	self._infoMap[actId] = obj

	local cfgList = XiaonuoBirthConfig.instance:getSignInList(actId)
	local list = {}

	for i, v in pairs(cfgList) do
		if checknumber(i) > 0 then
			table.insert(list, v)
		end
	end

	table.sort(list, function(a, b)
		return a.signInDays < b.signInDays
	end)
	scrollerList:reloadData(list)

	local activityCfg = ActivityDefineConfig.instance:getCfgByActivitYId(actId) or {}

	txtName.text = activityCfg.activityName

	local startTime = GameUtil.string2date(activityCfg.startTime)
	local endTime = GameUtil.string2date(activityCfg.endTime)

	txtTime.text = actId == self._activityIdList[1] and "活动时间：12.30 05:00 - 02.03 05:00" or string.format("活动时间：%02d.%02d %02d:%02d - %02d.%02d %02d:%02d", startTime.month, startTime.day, startTime.hour, startTime.min, endTime.month, endTime.day, endTime.hour, endTime.min)
end

function LinkageSignInView:_gainPrize(activityId, exchangeCode)
	if not string.nilorempty(exchangeCode) then
		UIStateManager.instance:push(ViewName.BirthdaytipsView, exchangeCode)
	end
end

function LinkageSignInView:_updateUpCell(view, cell, data)
	self:_refreshCell(view, cell, data)
end

function LinkageSignInView:_clearUpView(cell)
	local item = goutil.findChildImageComponent(cell, "item")

	MaterialMgr.clearIcon(item)
	self:_clearEffect(cell)
end

function LinkageSignInView:_updateDownCell(view, cell, data)
	self:_refreshCell(view, cell, data)
end

function LinkageSignInView:_clearDownView(cell)
	self:_clearEffect(cell)

	local item = goutil.findChildImageComponent(cell, "item")
	local item2 = goutil.findChildImageComponent(cell, "cell_2/item")

	MaterialMgr.clearIcon(item)
	MaterialMgr.clearIcon(item2)
end

function LinkageSignInView:_clearEffect(cell)
	if self._effList[cell] then
		UIEffectManager.instance:stopEffect(self._effList[cell])

		self._effList[cell] = nil
	end
end

function LinkageSignInView:_addCellEffect(view, cell, effect)
	local effPath = "fx_ui_qirirenwu/fx_ui_kelingqu_ceshihuikui.prefab"
	local pmEff = UIEffectManager.instance:playEffect(self, effPath, effect, 0, 0, true, nil, nil, function(target, eff)
		eff:setClipping(view:GetViewport())
	end, self)

	pmEff:setParent(effect.transform)
	pmEff:setScale(1)
	pmEff:setLocalPos(0, 0, 0)

	self._effList[cell] = pmEff
end

function LinkageSignInView:_refreshCell(view, cell, data)
	local bg = goutil.findChild(cell, "bg")
	local top = goutil.findChild(cell, "top")
	local effect = goutil.findChild(cell, "effect")
	local receive = goutil.findChild(cell, "receive")
	local lock = goutil.findChild(cell, "lock")
	local item = goutil.findChildImageComponent(cell, "item")
	local txtTitle = goutil.findChildTextComponent(cell, "txtTitle")
	local txtNum = goutil.findChildTextComponent(cell, "txtNum")
	local btnExchangeCode = goutil.findChildButtonComponent(cell, "btnExchangeCode")
	local txtExchangeCode = goutil.findChild(cell, "btnExchangeCode/Text")

	txtTitle.text = "第" .. data.signInDays .. "天"

	local activityId = data.activityId
	local obj = self._infoMap[activityId]

	if not string.nilorempty(data.showPrize) then
		local prizeStr = MaterialMgr.changeItemStrArr(data.showPrize)
		local matType, matId, matNum = MaterialMgr.getMatParams(prizeStr[1])

		txtNum.text = "x" .. checknumber(matNum)

		MaterialMgr.setIcon(item, matType, matId)

		local isUnlockAsSignDay = ActivitySummaryController.instance:isUnlockAsSignDay(activityId, data.signInDays)

		GameUtil.SetActive(lock, not isUnlockAsSignDay)
		self:_clearEffect(cell)

		if data.signInDays <= obj.onlineDay and obj.signInMap[data.signInDays] == nil and isUnlockAsSignDay then
			self:_addCellEffect(view, cell, effect)
		end

		local function clickFunc()
			if data.signInDays <= obj.onlineDay and obj.signInMap[data.signInDays] == nil then
				ActivitySummaryController.instance:sendGetSignInPrize(activityId, data.signInDays)

				if activityId == self._rightActId and checknumber(data.reportBehavior) > 0 then
					SurveyController.instance:reportBehavior(checknumber(data.reportBehavior))
				end
			elseif prizeStr and prizeStr[1] then
				CommonTipsMgr.instance:openTipsByConfStr(item, prizeStr[1])
			end
		end

		GameUtil.addClickHandler(top, clickFunc)

		local isBigPrize = XiaonuoBirthConfig.instance:getSignInDayData(activityId, data.signInDays).bigPrize == "1"

		GameUtil.setUIImageSpriteIdx(bg, isBigPrize == true and 1 or 0)
		GameUtil.setUIImageSpriteIdx(btnExchangeCode, isBigPrize == true and 1 or 0)
		GameUtil.setUITextColorIdx(txtExchangeCode, isBigPrize == true and 1 or 0)
		GameUtil.SetActive(receive, obj.signInMap[data.signInDays] ~= nil)
		GameUtil.SetActive(btnExchangeCode, not string.nilorempty(obj.codeMap[data.signInDays]))
		GameUtil.addClickHandler(btnExchangeCode, function()
			UIStateManager.instance:push(ViewName.BirthdaytipsView, obj.codeMap[data.signInDays])

			if checknumber(data.reportBehavior) > 0 then
				SurveyController.instance:reportBehavior(checknumber(data.reportBehavior))
			end
		end)
	end
end

function LinkageSignInView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)

	if cell.item and cell.txtNum and not string.nilorempty(data.showPagePrize) then
		local showPagePrize = MaterialMgr.changeItemStrArr(data.showPagePrize)
		local type, id, num = MaterialMgr.getMatParams(showPagePrize[1])

		cell.txtNum.text = "x" .. checknumber(num)
		cell.txtTitle.text = "第" .. data.signInDays .. "天"

		MaterialMgr.setIcon(cell.item, type, id)
		GameUtil.addClickHandler(cell.item, function()
			if showPagePrize and showPagePrize[1] then
				CommonTipsMgr.instance:openTipsByConfStr(cell.item, showPagePrize[1])
			end
		end)
	end
end

function LinkageSignInView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.item = goutil.findChild(goCell, "item")
	cell.txtNum = goutil.findChildTextComponent(goCell, "txtNum")
	cell.txtTitle = goutil.findChildTextComponent(goCell, "txtTitle")

	MaterialMgr.resetAll(cell.item)

	return cell
end

function LinkageSignInView:_onClickPagetour()
	local isOffical = SDKManager.isOfficial()

	if isOffical then
		local str = XiaonuoBirthConfig.instance:getCommonValue("H5_URL")

		UnityEngine.Application.OpenURL(str)
	else
		TipsFacade.instance:openTipWindow("提示", lang("浏览器搜索【奥奇传说H5】或登录百田网，即可登录奥奇传说页游，领取超多福利！"), function()
			ViewMgr.instance:close(ViewName.Popupwindow)
		end)
	end
end

return LinkageSignInView
