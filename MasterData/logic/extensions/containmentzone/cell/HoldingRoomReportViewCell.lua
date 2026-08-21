-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/containmentzone/cell/HoldingRoomReportViewCell.lua

local GuideActionActiveUI = require("Assets.Scripts.Lua.logic.extensions.guide.controller.action.GuideActionActiveUI")

module("logic.extensions.containmentzone.cell.HoldingRoomReportViewCell", package.seeall)

local M = class("HoldingRoomReportViewCell", UIReusableLuaBehavior)

function M:buildUI()
	self._txtDate = goutil.findChildTextComponent(self.mainGO, "txtDate")
	self._txtSerialNum = goutil.findChildTextComponent(self.mainGO, "txtMark")
	self._txtProtomerName = goutil.findChildTextComponent(self.mainGO, "txtName")
	self._imgHoldingResult = goutil.findChildImageComponent(self.mainGO, "imgHoldingResult")
	self._goPresureGroup = goutil.findChild(self.mainGO, "pressure").gameObject
	self._goPresureItem = goutil.findChild(self.mainGO, "pressure/pressure_item").gameObject
	self._btnGet = UIComponentType.ButtonAdapter(goutil.findChild(self.mainGO, "btnGet"))
	self._btnCheck = UIComponentType.ButtonAdapter(goutil.findChild(self.mainGO, "btnCheck"))
	self._goFailMark = goutil.findChild(self.mainGO, "sign").gameObject
	self._goDoingRoot = goutil.findChild(self.mainGO, "doing").gameObject
	self._imgProcess = goutil.findChildImageComponent(self.mainGO, "doing/speedUp/fill")
	self._txtProcessTime = goutil.findChildTextComponent(self.mainGO, "doing/speedUp/txtTime")
	self._btnSpeedUp = UIComponentType.ButtonAdapter(goutil.findChild(self.mainGO, "doing/speedUp/btnSpeedUp"))
end

function M:destroyUI()
	self._txtDate = nil
	self._txtSerialNum = nil
	self._txtProtomerName = nil
	self._imgHoldingResult = nil
	self._goPresureGroup = nil
	self._goPresureItem = nil
	self._btnGet = nil
	self._btnCheck = nil
	self._goFailMark = nil
	self._goDoingRoot = nil
	self._imgProcess = nil
	self._txtProcessTime = nil
	self._btnSpeedUp = nil
end

function M:bindEvents()
	self._btnGet:AddClickListener(self._onClickGet, self)
	self._btnCheck:AddClickListener(self._onClickCheck, self)
	self._btnSpeedUp:AddClickListener(self._onClickSpeedUp, self)
end

function M:unbindEvents()
	self._btnGet:RemoveClickListener()
	self._btnCheck:RemoveClickListener()
	self._btnSpeedUp:RemoveClickListener()
end

function M:onEnter()
	return
end

function M:onExit()
	self._handler = nil
	self._roomId = nil
	self._reportData = nil

	removetimer(self._timerReprotCountDown, self)
end

function M:_onClickGet()
	ContainmentZoneAgent.instance:sendReceiveReportRequest(self._roomId, self._reportData:getUuid())
end

function M:_onClickCheck()
	local _reportLst = {}

	if self._reportData then
		table.insert(_reportLst, self._reportData)
	end

	ContainmentFacade.instance:openReprotDetailView(self._roomId, _reportLst)
end

function M:_onClickSpeedUp()
	ToolTipsMgr.showFacilityHoldingReportSpeedupTips(self._roomId)
end

function M:setHandler(handler)
	self._handler = handler
end

function M:setCellData(itemData, curIndex)
	self._reportData = itemData
	self._RunningReport = itemData:getIsRunning()
	self._isRecive = itemData:getRecive()
	self._roomId = itemData:getRoomId()

	goutil.setActive(self._goDoingRoot, self._RunningReport)
	goutil.setActive(self._imgHoldingResult.gameObject, not self._RunningReport)

	local protomerMo = ProtomerModel.instance:getProtomerInfo(itemData:getProtomerId())

	self._txtSerialNum.text = protomerMo:getProtomerSerialNumShow()
	self._txtProtomerName.text = protomerMo:getProtomerName()

	if self._RunningReport then
		goutil.setActive(self._goFailMark, false)
		goutil.setActive(self._btnGet.gameObject, false)
		goutil.setActive(self._btnCheck.gameObject, false)
		self:_updateProcessShow(itemData)
		self:setPresureShow(0, 0)
	else
		goutil.setActive(self._goFailMark, itemData:getFailLevel() > 0)
		goutil.setActive(self._btnGet.gameObject, not self._isRecive)
		goutil.setActive(self._btnCheck.gameObject, self._isRecive)

		self._txtDate.text = self._RunningReport and "" or string.format("DATE_%s_%s", itemData:getReportId(), itemData:getUuid() or "")

		local resultImgCode = itemData:getScore()

		IconLoader.setSprite(self._imgHoldingResult, IconType.DynSpriteAtlas_Language, string.format("room_holding_result_%d", resultImgCode))
		self:setPresureShow(itemData:getPresure(), protomerMo:getPressureLimitEnhance())
	end
end

function M:setPresureShow(val, maxVal)
	local rootTrans = self._goPresureGroup.transform

	while maxVal > rootTrans.childCount do
		goutil.cloneAndSetParent(self._goPresureItem, rootTrans)
	end

	for i = 0, rootTrans.childCount - 1 do
		local show = i < maxVal
		local active = i < val
		local tempGo = rootTrans:GetChild(i).gameObject

		if show then
			local activeGo = tempGo.transform:GetChild(0).gameObject

			goutil.setActive(activeGo, active)
		end

		goutil.setActive(tempGo, show)
	end
end

function M:_updateProcessShow(reportData)
	removetimer(self._timerReprotCountDown, self)

	local lastRoomInfoUpdateTimeStamp = reportData:getRunningReportUpdateTimeStamp()
	local offsetTime = ServerTime.now() - lastRoomInfoUpdateTimeStamp

	self._totalTime = reportData:getRunningReportTotalSecond()
	self._remainTime = reportData:getRunningReportRemainSecond() - offsetTime
	self._remainTime = self._remainTime < 0 and 0 or self._remainTime

	local process = (self._totalTime - self._remainTime) / self._totalTime

	self:_updateRemainTime(self._remainTime, process)
	settimer(1, self._timerReprotCountDown, self, true)
end

function M:_timerReprotCountDown()
	self._remainTime = self._remainTime - 1

	if self._remainTime < 0 then
		self._remainTime = 0
	end

	local process = (self._totalTime - self._remainTime) / self._totalTime

	self:_updateRemainTime(self._remainTime, process)
end

function M:_updateRemainTime(timeStamp, process)
	process = process < 0 and 0 or process
	process = process > 1 and 1 or process
	self._txtProcessTime.text = TextFormatter.formatClockTime(timeStamp)
	self._imgProcess.fillAmount = process

	if timeStamp <= 0 then
		removetimer(self._timerReprotCountDown, self)
	end
end

return M
