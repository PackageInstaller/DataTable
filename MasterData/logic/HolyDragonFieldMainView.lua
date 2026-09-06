-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holydragonfield/view/HolyDragonFieldMainView.lua

module("logic.extensions.holydragonfield.view.HolyDragonFieldMainView", package.seeall)

local HolyDragonFieldMainView = class("HolyDragonFieldMainView", ViewComponent)

function HolyDragonFieldMainView:buildUI()
	HolyDragonFieldMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/txtTitle/btnTip")
	self._txtOpenTime = self:getTxt("opentime/txt")
	self._btnRank = self:getGo("jumpBtnCol/btnRank")
	self._btnShop = self:getGo("jumpBtnCol/btnShop")
	self._btnBuff = self:getGo("jumpBtnCol/btnBuff")
	self._btnPrize = self:getGo("jumpBtnCol/btnPrize")
	self._redPointBuff = self:getGo("jumpBtnCol/btnBuff/redPoint")
	self._redPointGos = {
		self:getGo("jumpBtnCol/btnRank/redPoint"),
		self:getGo("jumpBtnCol/btnShop/redPoint"),
		self._redPointBuff,
		self:getGo("jumpBtnCol/btnPrize/redPoint")
	}
	self._fieldCells = {}

	for i = 1, 3 do
		local cellPath = string.format("fieldCol/cell%s", i)

		self._fieldCells[i] = {
			go = self:getGo(cellPath),
			txtScore = self:getTxt(cellPath .. "/score/txt"),
			tagLock = self:getGo(cellPath .. "/tagLock"),
			txtLock = self:getTxt(cellPath .. "/tagLock/txt")
		}
	end
end

function HolyDragonFieldMainView:bindEvents()
	HolyDragonFieldMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickBtnRank, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickBtnShop, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBtnBuff, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickBtnPrize, self)
end

function HolyDragonFieldMainView:unbindEvents()
	HolyDragonFieldMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnBuff)
	GameUtil.rmClickHandler(self._btnPrize)
end

function HolyDragonFieldMainView:onEnter()
	HolyDragonFieldMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = HolyDragonFieldController.instance:getActivityId()
	end

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = HolyDragonFieldController.instance:getSubMo(self._activityId)
	self._actData = HolyDragonFieldConfig.instance:getActivityData(self._activityId)

	self.addGEvent(self, GlobalNotify.HolyDragonField_InfoRefresh, self._onInfoRefresh, self)
	self.addGEvent(self, GlobalNotify.HolyDragonField_ChallengeResult, self._onChallengeResult, self)
	self.addGEvent(self, GlobalNotify.HolyDragonField_BuffUpgrade, self._onBuffUpgrade, self)
	self:_onSetStaticUI()
	RedPointController.instance:regRedPoint(self._redPointBuff, RedPointModel.ID_HOLY_DRAGON_FIELD_BUFF_UPDATE)
	self:_onUpdate()
	HolyDragonFieldController.instance:sendPM_HolyDragonFieldInfoReq(self._activityId)
end

function HolyDragonFieldMainView:onExit()
	HolyDragonFieldMainView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._redPointBuff)
	self:_clearFieldCells()
end

function HolyDragonFieldMainView:_onInfoRefresh(activityId)
	if activityId ~= self._activityId then
		return
	end

	self:_onUpdate()
end

function HolyDragonFieldMainView:_onChallengeResult(activityId)
	if activityId ~= self._activityId then
		return
	end

	self:_onUpdate()
end

function HolyDragonFieldMainView:_onBuffUpgrade(activityId)
	if activityId ~= self._activityId then
		return
	end

	self:_onUpdate()
end

function HolyDragonFieldMainView:_onSetStaticUI()
	self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)

	for _, go in ipairs(self._redPointGos) do
		GameUtil.SetActive(go, false)
	end
end

function HolyDragonFieldMainView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateFieldColUI()
end

function HolyDragonFieldMainView:_onUpdateData()
	self._fieldDataList = {}

	local fieldDatas = HolyDragonFieldConfig.instance:getFieldDatas(self._activityId)

	for fieldId, fieldData in pairs(fieldDatas) do
		local data = {}

		data.fieldId = fieldId
		data.fieldName = fieldData.name
		data.fieldData = fieldData
		data.isOpen = self:_isFieldOpen(fieldData)
		data.totalScore = self:_getFieldTotalScore(fieldId)

		table.insert(self._fieldDataList, data)
	end

	table.sort(self._fieldDataList, function(a, b)
		return a.fieldId < b.fieldId
	end)
end

function HolyDragonFieldMainView:_onUpdateFieldColUI()
	for index, cell in ipairs(self._fieldCells) do
		self:_updateFieldCell(cell, self._fieldDataList[index])
	end
end

function HolyDragonFieldMainView:_updateFieldCell(cell, data)
	local mainGo = cell.go

	GameUtil.rmClickHandler(mainGo)
	GameUtil.SetActive(mainGo, data ~= nil)

	if data == nil then
		return
	end

	cell.txtScore.text = string.format("我的积分：%s", data.totalScore)

	GameUtil.SetActive(cell.tagLock, not data.isOpen)

	if not data.isOpen then
		cell.txtLock.text = self:_getFieldOpenTimeText(data.fieldData)
	end

	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickFieldCell, self, data))
end

function HolyDragonFieldMainView:_clearFieldCell(cell)
	local mainGo = cell.go

	GameUtil.rmClickHandler(mainGo)
end

function HolyDragonFieldMainView:_clearFieldCells()
	for _, cell in ipairs(self._fieldCells or {}) do
		self:_clearFieldCell(cell)
	end
end

function HolyDragonFieldMainView:_isFieldOpen(fieldData)
	return GameUtil.getTimePeriod(fieldData.openTime, nil) == GameUtil.inTimePeriod
end

function HolyDragonFieldMainView:_getFieldOpenTimeText(fieldData)
	return GameUtil.formatTimeString("%Y.%m.%d %H:%M 开启", fieldData.openTime)
end

function HolyDragonFieldMainView:_getFieldTotalScore(fieldId)
	local totalScore = 0
	local stageDatas = HolyDragonFieldConfig.instance:getStageDatas(self._activityId, fieldId)

	for stageId, _ in pairs(stageDatas) do
		totalScore = totalScore + self._subMo:getStageScore(fieldId, stageId)
	end

	return totalScore
end

function HolyDragonFieldMainView:_onClickFieldCell(data)
	if not data.isOpen then
		FloatWordMgr.instance:show(self:_getFieldOpenTimeText(data.fieldData))

		return
	end

	UIStateManager.instance:push(ViewName.HolyDragonFieldStageView, self._activityId, data.fieldId)
end

function HolyDragonFieldMainView:_onClickBtnTip()
	TipsFacade.instance:openRulesView(self._actData.mainRuleKey)
end

function HolyDragonFieldMainView:_onClickBtnRank()
	HolyDragonFieldController.instance:openRankView(self._activityId)
end

function HolyDragonFieldMainView:_onClickBtnShop()
	GotoMgr.gotoByString(self._actData.jumpToShop)
end

function HolyDragonFieldMainView:_onClickBtnBuff()
	UIStateManager.instance:push(ViewName.HolyDragonFieldBuffView, self._activityId)
end

function HolyDragonFieldMainView:_onClickBtnPrize()
	UIStateManager.instance:push(ViewName.HolyDragonFieldPrizeView, self._activityId)
end

return HolyDragonFieldMainView
