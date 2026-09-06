-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexiuerclg/view/DivineXiuErClgExtView.lua

module("logic.extensions.divinexiuerclg.view.DivineXiuErClgExtView", package.seeall)

local DivineXiuErClgExtView = class("DivineXiuErClgExtView", ViewComponent)

function DivineXiuErClgExtView:buildUI()
	DivineXiuErClgExtView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "leftTop/txtTitle")

	local tabScrollerview = goutil.findChild(self.mainGO, "tabCol/tabScrollerview")
	local tabScrollercell = goutil.findChild(self.mainGO, "tabCol/tabScrollercell")

	self._contentCol = goutil.findChild(self.mainGO, "contentCol")
	self._tabScrollList = ScrollerList.create(tabScrollerview, tabScrollercell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
end

function DivineXiuErClgExtView:bindEvents()
	DivineXiuErClgExtView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function DivineXiuErClgExtView:unbindEvents()
	DivineXiuErClgExtView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function DivineXiuErClgExtView:onEnter()
	DivineXiuErClgExtView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._activityType = DivineXiuErClgController.instance:getActivityType()

	local isInTime = DivineXiuErClgController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._actData = DivineXiuErClgConfig.instance:getDxecActData(self._activityId)

	self.addGEvent(self, GlobalNotify.handlePM_DivineXiuErClgGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.handlePM_DivineXiuErExtremeFightConfirmRes, self._sendInfoReq, self)
	self:_onSetUI()
	self:_sendInfoReq()
end

function DivineXiuErClgExtView:onExit()
	DivineXiuErClgExtView.super.onExit(self)
	self:_onClear()
end

function DivineXiuErClgExtView:_sendInfoReq()
	DivineXiuErClgController.instance:sendPM_DivineXiuErClgGetInfoReq(self._activityId)
end

function DivineXiuErClgExtView:_onSetUI()
	return
end

function DivineXiuErClgExtView:_onUpdate()
	self:_onUpdateData()

	if DivineXiuErClgController.instance:isPassOfExt(self._activityId) then
		local info = {}

		info.desc1 = "恭喜通关"
		info.desc2 = "是非之力已达成平衡"

		function info.closeCallBack()
			self:close()
		end

		UIStateManager.instance:push(ViewName.DivineXiuErClgExtTruefalseSuccessView, info)
	end

	self:_onUpdateUI()
end

function DivineXiuErClgExtView:_onClear()
	self:_onClearTabAt()
	self:_onClearTabScrollerList()
end

function DivineXiuErClgExtView:_onUpdateData()
	self:_onUpdateTabData()
end

function DivineXiuErClgExtView:_onUpdateUI()
	self:_onUpdateTabScrollerList()
	self:_showTabAt()
end

function DivineXiuErClgExtView:_onUpdateTabData()
	self._tabInfoList = {}

	local cfg = DivineXiuErClgConfig.instance:getDxecExtTierCfg(self._activityId)

	for idx, data in ipairs(cfg) do
		local info = {}

		info.idx = idx
		info.tierId = data.tierId
		info.data = data
		self._tabInfoList[idx] = info
	end

	self._curTabIdx = 0

	for tabIdx, info in ipairs(self._tabInfoList) do
		local result, tips = DivineXiuErClgController.instance:getTryEnterExtTierClgResultAndTips(self._activityId, info.tierId)

		if result == GameEnum.ResultCode.IsPass then
			self._curTabIdx = tabIdx
		end

		if result == GameEnum.ResultCode.Success then
			self._curTabIdx = tabIdx

			break
		end
	end
end

function DivineXiuErClgExtView:_onUpdateTabScrollerList()
	self._tabScrollList:reloadData(self._tabInfoList)
end

function DivineXiuErClgExtView:_onClearTabScrollerList()
	self._tabScrollList:dispose()
end

function DivineXiuErClgExtView:_updateTabCell(view, cell, info, tag)
	local tabIdx = cell.index + 1
	local data = info.data
	local tierId = info.tierId
	local isSelected = self._curTabIdx == tabIdx
	local result, tips = DivineXiuErClgController.instance:getTryEnterExtTierClgResultAndTips(self._activityId, tierId)
	local mainGo = cell.gameObject
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local imgSelected = goutil.findChild(mainGo, "imgSelected")
	local redPoint = goutil.findChild(mainGo, "redPoint")
	local imgPass = goutil.findChild(mainGo, "imgPass")
	local lock = goutil.findChild(mainGo, "lock")
	local lock_txt1 = goutil.findChildTextComponent(mainGo, "lock/txt1")
	local lock_txt2 = goutil.findChildTextComponent(mainGo, "lock/txt2")

	GameUtil.SetActive(imgPass, false)
	GameUtil.SetActive(lock, false)
	GameUtil.SetActive(imgSelected, false)
	GameUtil.SetActive(imgSelected, isSelected)

	txtName.text = data.name

	if result == GameEnum.ResultCode.Success then
		-- block empty
	elseif result == GameEnum.ResultCode.IsPass then
		GameUtil.SetActive(imgPass, true)
	elseif result == GameEnum.ResultCode.ErrorTime or result == GameEnum.ResultCode.NotUnlockCond then
		local timeStr = ""
		local timePeriod = DivineXiuErClgController.instance:getTimePeriodOfTierOfExt(self._activityId, tierId)

		if timePeriod <= GameUtil.beforeTimePeriod and not string.nilorempty(data.openTime) then
			timeStr = GameUtil.getFormatTimeByStamp(GameUtil.string2time(data.openTime), nil)
		end

		if not string.nilorempty(timeStr) then
			lock_txt2.text = string.format("%s后开启", timeStr)

			GameUtil.SetActive(lock_txt2.gameObject, true)
		else
			GameUtil.SetActive(lock_txt2.gameObject, false)
		end

		lock_txt1.text = "通关上一层"

		GameUtil.SetActive(lock, true)
	end

	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._clickTabCell, self, tabIdx))
end

function DivineXiuErClgExtView:_clearTabCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function DivineXiuErClgExtView:_clickTabCell(tabIdx)
	local info = self._tabInfoList[tabIdx]
	local tierId = info.tierId
	local result, tips = DivineXiuErClgController.instance:getTryEnterExtTierClgResultAndTips(self._activityId, tierId)

	if result == GameEnum.ResultCode.Success or result == GameEnum.ResultCode.IsPass then
		self._curTabIdx = tabIdx

		self:_onUpdateUI()
	else
		FloatWordMgr.instance:show(tips)
	end
end

function DivineXiuErClgExtView:_showTabAt()
	local info = self._tabInfoList[self._curTabIdx]

	if info == nil then
		return
	end

	local data = info.data

	if self._oldTabIdx and self._oldTabIdx == self._curTabIdx then
		return
	end

	self:_onClearTabAt()

	self._oldTabIdx = self._curTabIdx

	if not string.nilorempty(data.viewParams) then
		local arr = string.split(data.viewParams, "#")

		self:showTabAt(self._contentCol, data.viewName, unpack(arr))
	else
		self:showTabAt(self._contentCol, data.viewName)
	end
end

function DivineXiuErClgExtView:_onClearTabAt()
	self:showTabAt(self._contentCol, "")

	self._oldTabIdx = nil
end

function DivineXiuErClgExtView:_onClickBtnTip()
	local key = DivineXiuErClgConfig.instance:getDxecCommonValue(self._activityId, "ruleKeyExt")

	TipsFacade.instance:openRulesView(key)
end

return DivineXiuErClgExtView
