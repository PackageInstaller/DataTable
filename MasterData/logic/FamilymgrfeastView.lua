-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/FamilymgrfeastView.lua

module("logic.extensions.family.view.FamilymgrfeastView", package.seeall)

local FamilymgrfeastView = class("FamilymgrfeastView", ViewComponent)

function FamilymgrfeastView:ctor()
	FamilymgrfeastView.super.ctor(self)
end

function FamilymgrfeastView:unbindEvents()
	FamilymgrfeastView.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()

	for k, v in pairs(self._daysCell) do
		GameUtil.rmClickHandler(v.btn)
	end

	self._btnHour:RemoveClickListener()
	self._btnMin:RemoveClickListener()
	self._customInputHour:RemoveListener()
	self._customInputMin:RemoveListener()
end

function FamilymgrfeastView:bindEvents()
	FamilymgrfeastView.super.bindEvents(self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)

	for k, v in pairs(self._daysCell) do
		GameUtil.addClickHandler(v.btn, GameUtil.handler(self._onClickDayCell, self, k))
	end

	self._btnHour:AddClickListener(self._onClicktxtHour, self)
	self._btnMin:AddClickListener(self._onClicktxtMin, self)
	self._customInputHour:AddListener(self._onHourCustomInputCallback, self)
	self._customInputMin:AddListener(self._onMinCustomInputCallback, self)
end

function FamilymgrfeastView:buildUI()
	FamilymgrfeastView.super.buildUI(self)

	self._btnSure = self:getBtn("btnSure")
	self._txtSelect = self:getTxt("txtSelect")
	self._tableviewGoMin = self:getGo("mincontent/tableview")
	self._cellGo = self:getGo("cell")
	self._tableviewGoHour = self:getGo("hourcontent/tableview")

	self:_buildDaysCell()

	self._scrollerListMin = ScrollerList.create(self._tableviewGoMin, self._cellGo, GameUtil.handler(self._updateMinCell, self), GameUtil.handler(self._clearMinCell, self))
	self._scrollerListHour = ScrollerList.create(self._tableviewGoHour, self._cellGo, GameUtil.handler(self._updateHourCell, self), GameUtil.handler(self._clearHourCell, self))
	self._txtHour = self:getTxt("txtHour")
	self._txtMin = self:getTxt("txtMin")
	self._btnHour = self:getBtn("txtHour")
	self._btnMin = self:getBtn("txtMin")
	self._hourcontentGo = self:getGo("hourcontent")
	self._mincontentGo = self:getGo("mincontent")
	self._customInputHour = UICustomInput.Get(self._hourcontentGo)
	self._customInputMin = UICustomInput.Get(self._mincontentGo)
end

function FamilymgrfeastView:_buildDaysCell()
	self._daysGo = self:getGo("days")
	self._daysCell = {}

	for i = 1, 7 do
		local go = goutil.findChild(self._daysGo, "day" .. i)
		local var_5_0 = {
			btn = goutil.findChild(go, "btn"),
			selectGo = goutil.findChild(go, "select")
		}

		var_5_0.change = goutil.findChild(go, "bg"):GetComponent(ComponentType.UIImageSpriteChange)
		var_5_0.txtChange = goutil.findChild(go, "txt"):GetComponent(ComponentType.UITextColorChange)
		self._daysCell[i] = var_5_0

		local txt = goutil.findChildTextComponent(go, "txt")

		txt.text = i == 7 and "星期日" or string.format("星期%s", GameUtil.getChineseNumber(i))
	end
end

function FamilymgrfeastView:onExit()
	FamilymgrfeastView.super.onExit(self)
	self._scrollerListMin:dispose()
	self._scrollerListHour:dispose()
end

function FamilymgrfeastView:onEnter()
	FamilymgrfeastView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.ScheduleOpenPartyRes, self._onScheduleOpenPartyRes, self)

	self._isChief = FamilyModel.instance:isFamilyChief()
	self._maxSelectDay = checknumber(FamilyPartyConfig.instance:getCommonValue("WEEKLY_OPEN_PARTY_TIMES"))
	self._showHourContent = false
	self._showMinContent = false

	self:_initInfo()
	self:_initHourMinDatas()
	self:_updateUI()
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_FAMILY_MGR_PARTY, false)
	GlobalDispatcher:dispatch(GlobalNotify.FamilyUpdateTabRedpoints)
end

function FamilymgrfeastView:_initInfo()
	self._info = FamilyModel.instance:getManagePanelInfo()
	self._partySchedule = FamilyModel.instance:getPartySchedule()
	self._dayOfWeeks = {}
	self._openHour = 18
	self._openMinute = 0

	if self._partySchedule then
		for i, v in ipairs(self._partySchedule.dayOfWeeks) do
			self._dayOfWeeks[v] = true
		end

		self._openHour = self._partySchedule.hour
		self._openMinute = self._partySchedule.minute
	end
end

function FamilymgrfeastView:_initHourMinDatas()
	self._timeLimitStr = FamilyPartyConfig.instance:getCommonValue("PARTY_BAN_OPEN_HOUR_RANGE")

	local timeList = string.split(self._timeLimitStr, ",")
	local dayMaxSec = 86400

	self._limitTimes = {}

	local tempHour = {}

	for i, v in ipairs(timeList) do
		local times = string.split(v, "-")
		local time = string.split(times[1], ":")
		local shour = checknumber(time[1])
		local smin = checknumber(time[2])
		local startSec = shour * 3600 + smin * 60

		time = string.split(times[2], ":")

		local ehour = checknumber(time[1])
		local emin = checknumber(time[2])
		local endSec = ehour * 3600 + emin * 60

		if endSec < startSec then
			table.insert(self._limitTimes, {
				startSec = startSec,
				endSec = dayMaxSec
			})
			table.insert(self._limitTimes, {
				startSec = 0,
				endSec = endSec
			})

			for i = ehour, shour do
				tempHour[i] = i
			end
		else
			table.insert(self._limitTimes, {
				startSec = startSec,
				endSec = endSec
			})

			if startSec == 0 then
				table.insert(self._limitTimes, {
					startSec = dayMaxSec,
					endSec = dayMaxSec
				})
			end

			tempHour[shour] = shour

			for i = ehour, 23 do
				tempHour[i] = i
			end
		end
	end

	self._hourList = table.values(tempHour)

	table.sort(self._hourList, function(a, b)
		return a < b
	end)

	self._minList = {
		0,
		30
	}
end

function FamilymgrfeastView:_updateUI()
	self:_updateSelectState()
	self:_updateContentState()
	self:_modHourMin()
	self:_updateContents()
	self:_updateTxtTime()
end

function FamilymgrfeastView:_checkTimeOk()
	local nowSec = self._openHour * 3600 + self._openMinute * 60

	for _, v in ipairs(self._limitTimes) do
		if nowSec >= v.startSec and nowSec <= v.endSec then
			return false
		end
	end

	return true
end

function FamilymgrfeastView:_getMinOpenHourMin()
	for _, hour in ipairs(self._hourList) do
		for _, min in ipairs(self._minList) do
			local isOk = true
			local sec = hour * 3600 + min * 60

			for _, v in ipairs(self._limitTimes) do
				if sec >= v.startSec and sec <= v.endSec then
					isOk = false

					break
				end
			end

			if isOk then
				return hour, min
			end
		end
	end

	return 0, 0
end

function FamilymgrfeastView:_modHourMin()
	local isOk = self:_checkTimeOk()

	if not isOk then
		self._openHour, self._openMinute = self:_getMinOpenHourMin()
	end
end

function FamilymgrfeastView:_updateContentState()
	goutil.setActive(self._hourcontentGo, self._showHourContent)
	goutil.setActive(self._mincontentGo, self._showMinContent)
end

function FamilymgrfeastView:_onClickbtnSure()
	if not self._isChief then
		FloatWordMgr.instance:show("族长或副族长才可操作")

		return
	end

	local isOk = self:_checkTimeOk()

	if not isOk then
		FloatWordMgr.instance:show("禁止开启时间段：" .. self._timeLimitStr)

		return
	end

	local schedule = FamilyExtension_pb.PartySchedule()

	schedule.hour = self._openHour
	schedule.minute = self._openMinute

	for k, v in pairs(self._dayOfWeeks) do
		if v then
			schedule.dayOfWeeks:append(k)
		end
	end

	FamilyController.instance:sendScheduleOpenPartyReq(schedule)
end

function FamilymgrfeastView:_onClickDayCell(index)
	if not self._dayOfWeeks[index] and table.nums(self._dayOfWeeks) >= self._maxSelectDay then
		FloatWordMgr.instance:show("已达到开启上限")

		return
	end

	if self._dayOfWeeks[index] then
		self._dayOfWeeks[index] = nil
	else
		self._dayOfWeeks[index] = true
	end

	self:_updateSelectState()
end

function FamilymgrfeastView:_updateSelectState()
	for k, v in pairs(self._daysCell) do
		goutil.setActive(v.selectGo, self._dayOfWeeks[k])
		v.change:SetState(self._dayOfWeeks[k] and 0 or 1)
		v.txtChange:SetState(self._dayOfWeeks[k] and 1 or 0)
	end

	self._txtSelect.text = string.format("(%s/%s)", table.nums(self._dayOfWeeks), self._maxSelectDay)
end

function FamilymgrfeastView:_updateMinCell(view, cell, data, tag)
	local txt = goutil.findChildTextComponent(cell, "txt")
	local btn = Framework.ButtonAdapter.Get(cell.gameObject)

	txt.text = string.format("%02d", data)

	btn:AddClickListener(function()
		self._openMinute = data

		self:_onClicktxtMin()
		self:_updateTxtTime()
	end)
end

function FamilymgrfeastView:_clearMinCell(cell)
	return
end

function FamilymgrfeastView:_updateHourCell(view, cell, data, tag)
	local txt = goutil.findChildTextComponent(cell, "txt")
	local btn = Framework.ButtonAdapter.Get(cell.gameObject)

	txt.text = string.format("%02d", data)

	btn:AddClickListener(function()
		self._openHour = data

		self:_onClicktxtHour()
		self:_updateTxtTime()
	end)
end

function FamilymgrfeastView:_clearHourCell(cell)
	return
end

function FamilymgrfeastView:_onClicktxtHour()
	self._showHourContent = not self._showHourContent

	self:_updateContentState()
end

function FamilymgrfeastView:_onClicktxtMin()
	self._showMinContent = not self._showMinContent

	self:_updateContentState()
end

function FamilymgrfeastView:_updateContents()
	self._scrollerListHour:reloadData(self._hourList)
	self._scrollerListMin:reloadData(self._minList)
end

function FamilymgrfeastView:_updateTxtTime()
	self._txtHour.text = string.format("%02d", self._openHour)
	self._txtMin.text = string.format("%02d", self._openMinute)
end

function FamilymgrfeastView:_onHourCustomInputCallback(hover)
	if not hover then
		self._showHourContent = false

		self:_updateContentState()
	end
end

function FamilymgrfeastView:_onMinCustomInputCallback(hover)
	if not hover then
		self._showMinContent = false

		self:_updateContentState()
	end
end

function FamilymgrfeastView:_onScheduleOpenPartyRes()
	self:_initInfo()
	self:_updateUI()
end

return FamilymgrfeastView
