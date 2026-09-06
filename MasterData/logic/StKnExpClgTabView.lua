-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stknexp/view/StKnExpClgTabView.lua

module("logic.extensions.stknexp.view.StKnExpClgTabView", package.seeall)

local StKnExpClgTabView = class("StKnExpClgTabView", ViewComponent)

function StKnExpClgTabView:buildUI()
	StKnExpClgTabView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._contentCol = self:getGo("contentCol")

	local tabScrView = self:getGo("tabCol/scrView")
	local tabScrCell = self:getGo("tabCol/scrCell")

	self._tabScrollList = ScrollerList.create(tabScrView, tabScrCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
end

function StKnExpClgTabView:bindEvents()
	StKnExpClgTabView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function StKnExpClgTabView:unbindEvents()
	StKnExpClgTabView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function StKnExpClgTabView:onEnter()
	StKnExpClgTabView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._zoneId = checknumber(params[2])

	if self._activityId <= 0 then
		self._activityId = StKnExpController.instance:getActivityId()
	end

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = StKnExpController.instance:getSubMo(self._activityId)

	local list = self._subMo:getChangeSetIdsInStage()

	for _, changeSetId in ipairs(list) do
		MaterialController.instance:showChangeSetInTemp(changeSetId)
	end

	self._subMo:setChangeSetIdsInStage({})
	self:_onUpdate()
	self.addGEvent(self, GlobalNotify.HandlePM_SaintKnightExpeditionInfoRes, self._onUpdate, self)
	StKnExpController.instance:sendPM_SaintKnightExpeditionInfoReq(self._activityId)
end

function StKnExpClgTabView:onExit()
	StKnExpClgTabView.super.onExit(self)
	self._tabScrollList:dispose()
	self:_onClearTabAt()
end

function StKnExpClgTabView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function StKnExpClgTabView:_onUpdateData()
	self:_updateTabData()
end

function StKnExpClgTabView:_onUpdateUI()
	self:_updateTabScrollerList()
	self:_showTabAt()
end

function StKnExpClgTabView:_updateTabData()
	self._tabDataList = {}

	local data = {}

	data.clgType = StKnExpEnum.ClgType_Stage
	data.viewName = ViewName.StKnExpStageView
	data.tabName = StKnExpEnum.ClgTypeNames[data.clgType]
	data.viewParams = {
		self._activityId,
		self._zoneId
	}
	data.redIds = {}

	table.insert(self._tabDataList, data)

	local data = {}

	data.clgType = StKnExpEnum.ClgType_Boss
	data.viewName = ViewName.StKnExpBossView
	data.tabName = StKnExpEnum.ClgTypeNames[data.clgType]
	data.viewParams = {
		self._activityId,
		self._zoneId
	}
	data.redIds = {}

	table.insert(self._tabDataList, data)

	local clgType = self._subMo:getClgTypeInZone(self._zoneId)

	self._curTabIdx = clgType and table.indexof(StKnExpEnum.ClgTypeList, clgType) or 1
	self._curTabIdx = Mathf.Min(self._curTabIdx, #self._tabDataList)
end

function StKnExpClgTabView:_updateTabScrollerList()
	self._tabScrollList:reloadData(self._tabDataList)
end

function StKnExpClgTabView:_updateTabCell(view, cell, data, tag)
	local tabIdx = cell.index + 1
	local clgType = data.clgType
	local isUnlock = self._subMo:isUnlockClgInZone(self._zoneId, clgType)
	local isPass = self._subMo:isPassClgInZone(self._zoneId, clgType)
	local mainGo = cell.gameObject
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local redpoint = goutil.findChild(mainGo, "redpoint")
	local tagLock = goutil.findChild(mainGo, "tagLock")
	local tagPass = goutil.findChild(mainGo, "tagPass")

	txtName.text = data.tabName

	GameUtil.SetActive(tagLock, not isUnlock)
	GameUtil.SetActive(tagPass, isPass)
	GameUtil.setUIGroupIdx(mainGo, self._curTabIdx == tabIdx and 1 or 0)

	if data.redIds then
		RedPointController.instance:regRedPoint(redpoint, unpack(data.redIds))
	else
		RedPointController.instance:unregRedPoint(redpoint)
	end

	GameUtil.addClickHandler(mainGo, function()
		if not isUnlock then
			FloatWordMgr.instance:show("未开启")

			return
		end

		if isPass then
			return
		end

		self._curTabIdx = tabIdx

		self:_onUpdateUI()
	end)
end

function StKnExpClgTabView:_clearTabCell(cell)
	local mainGo = cell.gameObject
	local redpoint = goutil.findChild(mainGo, "redpoint")

	GameUtil.rmClickHandler(mainGo)
	RedPointController.instance:unregRedPoint(redpoint)
end

function StKnExpClgTabView:_showTabAt()
	local data = self._tabDataList[self._curTabIdx]

	if data == nil then
		return
	end

	if self._oldTabIdx and self._oldTabIdx == self._curTabIdx then
		return
	end

	self:_onClearTabAt()

	self._oldTabIdx = self._curTabIdx

	if data.viewParams then
		self:showTabAt(self._contentCol, data.viewName, unpack(data.viewParams))
	else
		self:showTabAt(self._contentCol, data.viewName)
	end
end

function StKnExpClgTabView:_onClearTabAt()
	self:showTabAt(self._contentCol, "")

	self._oldTabIdx = nil
end

function StKnExpClgTabView:_onClickBtnTip()
	local value = StKnExpConfig.instance:getActDataValue(self._activityId, "clgRuleKey", false)

	TipsFacade.instance:openRulesView(value)
end

return StKnExpClgTabView
