-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holydragontemple/view/HolyDragonTempleMainView.lua

module("logic.extensions.holydragontemple.view.HolyDragonTempleMainView", package.seeall)

local HolyDragonTempleMainView = class("HolyDragonTempleMainView", ViewComponent)
local _curFloorId = 0
local _autoSelectDefaultFloorOnNextEnter = true
local _FloorViewNames = {
	ViewName.HolyDragonTempleGoldFloorView,
	ViewName.HolyDragonTempleGoldFloorView,
	ViewName.HolyDragonTempleLightFloorView
}

function HolyDragonTempleMainView:buildUI()
	HolyDragonTempleMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/txtTitle/btnTip")
	self._contentCol = self:getGo("content")
	self._btnBuff = self:getGo("jumpBtnCol/btnBuff")
	self._redPointBuff = self:getGo("jumpBtnCol/btnBuff/redPoint")
	self._btnPower = self:getGo("jumpBtnCol/btnPower")

	local tabScrView = self:getGo("tabCol/scrView")
	local tabScrCell = self:getGo("tabCol/scrCell")

	self._tabScrollerList = ScrollerList.create(tabScrView, tabScrCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
end

function HolyDragonTempleMainView:bindEvents()
	HolyDragonTempleMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBtnBuff, self)
	GameUtil.addClickHandler(self._btnPower, self._onClickBtnPower, self)
end

function HolyDragonTempleMainView:unbindEvents()
	HolyDragonTempleMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnBuff)
	GameUtil.rmClickHandler(self._btnPower)
end

function HolyDragonTempleMainView:onEnter()
	HolyDragonTempleMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._openFloorId = checknumber(params[2])
	self._needAutoSelectDefaultFloor = self._openFloorId <= 0 and _autoSelectDefaultFloorOnNextEnter
	_autoSelectDefaultFloorOnNextEnter = false

	if self._activityId <= 0 then
		self._activityId = HolyDragonTempleController.instance:getActivityId()
	end

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = HolyDragonTempleController.instance:getSubMo(self._activityId)
	self._actData = HolyDragonTempleConfig.instance:getActivityData(self._activityId)

	self.addGEvent(self, GlobalNotify.HandlePM_HolyDragonTempleInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_HolyDragonTempleSignInRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_HolyDragonTempleNotifyChallengeRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.OnViewClose, self._onViewClose, self)
	self.addGEvent(self, GlobalNotify.ItemGetViewDoClosed, self._onItemGetViewClosed, self)
	self:_onUpdate()
	HolyDragonTempleController.instance:sendPM_HolyDragonTempleInfoReq(self._activityId)
end

function HolyDragonTempleMainView:onEnterFinished()
	HolyDragonTempleMainView.super.onEnterFinished(self)
	self:_tryOpenPendingPopups()
end

function HolyDragonTempleMainView:onExit()
	HolyDragonTempleMainView.super.onExit(self)
	self._tabScrollerList:dispose()
	self:_onClearTabAt()
end

function HolyDragonTempleMainView:_onUpdate(msg)
	local isInfoRes = type(msg) == "table" and msg.floorInfo ~= nil

	self:_onUpdateData(isInfoRes)
	self:_onUpdateUI()
end

function HolyDragonTempleMainView:_onViewClose()
	self:_tryOpenPendingPopups()
end

function HolyDragonTempleMainView:_onItemGetViewClosed()
	if not self._isWaitingRewardPopupClose then
		return
	end

	self._isWaitingRewardPopupClose = false

	self:_tryOpenPassPopWin()
end

function HolyDragonTempleMainView:_onUpdateData(isInfoRes)
	self._tabDataList = {}

	local floorDatas = HolyDragonTempleConfig.instance:getFloorDatas(self._activityId)

	for floorId, floorData in pairs(floorDatas or {}) do
		local data = {}

		data.floorId = floorId
		data.floorName = floorData.name or ""
		data.floorData = floorData
		data.viewName = _FloorViewNames[floorId]
		data.viewParams = {
			self._activityId,
			floorId
		}
		data.isOpen = GameUtil.checkIsInTimePeriod(floorData.openTime, floorData.endTime)
		data.isAllPassed = self:_isFloorAllPassed(floorId)

		table.insert(self._tabDataList, data)
	end

	table.sort(self._tabDataList, function(a, b)
		return a.floorId < b.floorId
	end)

	local targetFloorId = _curFloorId

	if self._openFloorId > 0 then
		targetFloorId = self._openFloorId
		self._needAutoSelectDefaultFloor = false
	elseif self._needAutoSelectDefaultFloor and isInfoRes then
		targetFloorId = self:_getDefaultFloorId()
		self._needAutoSelectDefaultFloor = false
	end

	local targetData = self:_getTabData(targetFloorId)

	self._openFloorId = 0
	_curFloorId = self:_canSwitchFloor(targetData) and targetFloorId or self:_getDefaultFloorId()
end

function HolyDragonTempleMainView:_onUpdateUI()
	self:_onUpdateTabColUI()
	self:_showTabAt()
	self:_onUpdateBuffRedPoint()
end

function HolyDragonTempleMainView:_onUpdateTabColUI()
	self._tabScrollerList:reloadData(self._tabDataList)

	local index = -1

	for i, data in ipairs(self._tabDataList) do
		if data.floorId == _curFloorId then
			index = i - 1

			break
		end
	end

	if index >= 0 then
		self._tabScrollerList:MoveCellToCenter(index)
	end
end

function HolyDragonTempleMainView:_updateTabCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local tagPass = goutil.findChild(mainGo, "tagPass")
	local tagLock = goutil.findChild(mainGo, "tagLock")
	local txtLock = goutil.findChildTextComponent(mainGo, "tagLock/txt")

	txtName.text = data.floorName

	GameUtil.setUIGroupIdx(mainGo, _curFloorId == data.floorId and 1 or 0)
	GameUtil.SetActive(tagPass, data.isAllPassed)
	GameUtil.SetActive(tagLock, not data.isOpen)

	if not data.isOpen and txtLock then
		txtLock.text = self:_getFloorOpenTimeText(data.floorData)
	end

	GameUtil.addClickHandler(mainGo, function()
		if not self:_canSwitchFloor(data) then
			self:_showFloorLockedTips(data)

			return
		end

		_curFloorId = data.floorId
		self._needAutoSelectDefaultFloor = false

		self:_onUpdateUI()
	end)
end

function HolyDragonTempleMainView:_clearTabCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function HolyDragonTempleMainView:_showTabAt()
	local data = self:_getCurTabData()

	if data == nil then
		self:_onClearTabAt()

		return
	end

	if self._oldFloorId and self._oldFloorId == _curFloorId then
		return
	end

	self:_onClearTabAt()

	self._oldFloorId = _curFloorId

	self:showTabAt(self._contentCol, data.viewName, unpack(data.viewParams))
end

function HolyDragonTempleMainView:_onClearTabAt()
	self:showTabAt(self._contentCol, "")

	self._oldFloorId = nil
end

function HolyDragonTempleMainView:_getDefaultFloorId()
	for _, data in ipairs(self._tabDataList) do
		if data.isOpen and not data.isAllPassed then
			return data.floorId
		end
	end

	for _, data in ipairs(self._tabDataList) do
		if data.isOpen then
			return data.floorId
		end
	end

	return 0
end

function HolyDragonTempleMainView:_getCurTabData()
	return self:_getTabData(_curFloorId)
end

function HolyDragonTempleMainView:_getTabData(floorId)
	for _, data in ipairs(self._tabDataList) do
		if data.floorId == floorId then
			return data
		end
	end

	return nil
end

function HolyDragonTempleMainView:_canSwitchFloor(data)
	return data ~= nil and data.isOpen
end

function HolyDragonTempleMainView:_isFloorAllPassed(floorId)
	local stageDatas = HolyDragonTempleConfig.instance:getStageDatas(self._activityId, floorId)
	local hasStage = false

	for stageId, _ in pairs(stageDatas or {}) do
		hasStage = true

		if not self._subMo:isStagePassed(floorId, stageId) then
			return false
		end
	end

	return hasStage
end

function HolyDragonTempleMainView:_getFloorOpenTimeText(floorData)
	if floorData == nil or floorData.openTime == nil or floorData.openTime == "" then
		return ""
	end

	local date = GameUtil.string2date(floorData.openTime)

	return langPara("%s.%s.%s开启", date.year, date.month, date.day)
end

function HolyDragonTempleMainView:_showFloorLockedTips(data)
	local tips = data and self:_getFloorOpenTimeText(data.floorData) or ""

	if tips == "" then
		tips = lang("未开启")
	end

	FloatWordMgr.instance:show(tips)
end

function HolyDragonTempleMainView:_onUpdateBuffRedPoint()
	GameUtil.SetActive(self._redPointBuff, self:_canSignInCurFloorToday())
end

function HolyDragonTempleMainView:_canSignInCurFloorToday()
	local data = self:_getCurTabData()

	if not self:_canSwitchFloor(data) then
		return false
	end

	if self._subMo == nil or self._subMo:isTodaySignUp(_curFloorId) then
		return false
	end

	local signInDays = self._subMo:getSignInDays(_curFloorId)
	local buffDatas = HolyDragonTempleConfig.instance:getSignInBuffDatas(self._activityId, _curFloorId)
	local maxSignInDays = 0

	for _, buffData in pairs(buffDatas or {}) do
		maxSignInDays = math.max(maxSignInDays, checknumber(buffData.signInDays))
	end

	return maxSignInDays > 0 and signInDays < maxSignInDays
end

function HolyDragonTempleMainView:_tryOpenPendingPopups()
	if UIStateManager.instance:getTopName() ~= ViewName.HolyDragonTempleMainView then
		return
	end

	if self:_tryOpenRewardPopWin() then
		return
	end

	self:_tryOpenPassPopWin()
end

function HolyDragonTempleMainView:_tryOpenRewardPopWin()
	if self._isWaitingRewardPopupClose then
		return true
	end

	local changeSetId = HolyDragonTempleController.instance:consumePendingRewardChangeSetId(self._activityId)

	if changeSetId <= 0 then
		return false
	end

	MaterialController.instance:setChangeSetPopup(changeSetId)

	local items = MaterialController.instance:showChangeSetInTemp(changeSetId)

	if items and next(items) ~= nil then
		self._isWaitingRewardPopupClose = true

		return true
	end

	return false
end

function HolyDragonTempleMainView:_tryOpenPassPopWin()
	if self._isWaitingRewardPopupClose then
		return
	end

	if UIStateManager.instance:getTopName() ~= ViewName.HolyDragonTempleMainView then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.HolyDragonTemplePassPopWin) then
		return
	end

	local floorId = HolyDragonTempleController.instance:consumePendingPassPopWinFloorId(self._activityId)

	if floorId <= 0 then
		return
	end

	local floorData = HolyDragonTempleConfig.instance:getFloorData(self._activityId, floorId)
	local fieldActivityId = HolyDragonFieldController.instance:getActivityId()
	local fieldId = floorData and checknumber(floorData.relevantFieldId) or 0

	ViewMgr.instance:open(ViewName.HolyDragonTemplePassPopWin, self._activityId, floorId, fieldActivityId, fieldId)
end

function HolyDragonTempleMainView:_onClickBtnClose()
	_autoSelectDefaultFloorOnNextEnter = true

	self:close()
end

function HolyDragonTempleMainView:_onClickBtnTip()
	local key = self._actData.mainRuleKey

	TipsFacade.instance:openRulesView(key)
end

function HolyDragonTempleMainView:_onClickBtnBuff()
	local data = self:_getCurTabData()

	if not self:_canSwitchFloor(data) then
		self:_showFloorLockedTips(data)

		return
	end

	ViewMgr.instance:open(ViewName.HolyDragonTempleBuffView, self._activityId, _curFloorId)
end

function HolyDragonTempleMainView:_onClickBtnPower()
	local activityId = HolyDragonFieldController.instance:getActivityId()

	UIStateManager.instance:push(ViewName.HolyDragonFieldBuffView, activityId)
end

return HolyDragonTempleMainView
