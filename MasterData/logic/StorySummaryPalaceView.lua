-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/storysummary/view/StorySummaryPalaceView.lua

module("logic.extensions.storysummary.view.StorySummaryPalaceView", package.seeall)

local StorySummaryPalaceView = class("StorySummaryPalaceView", ViewComponent)

function StorySummaryPalaceView:ctor()
	StorySummaryPalaceView.super.ctor(self)
end

function StorySummaryPalaceView:buildUI()
	StorySummaryPalaceView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnRule = goutil.findChild(self.mainGO, "leftTop/btnRule")
	self._content = goutil.findChild(self.mainGO, "content")
	self._storyScrollerview = goutil.findChild(self.mainGO, "storyCol/storyScrollerview")
	self._storyScrollercell = goutil.findChild(self.mainGO, "storyCol/storyScrollercell")
	self._storyScrollList = ScrollerList.create(self._storyScrollerview, self._storyScrollercell, GameUtil.handler(self._updateStoryCell, self), GameUtil.handler(self._clearStoryCell, self))
end

function StorySummaryPalaceView:bindEvents()
	StorySummaryPalaceView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnRule, function()
		TipsFacade.instance:openRulesView("story_rule")
	end)
end

function StorySummaryPalaceView:unbindEvents()
	StorySummaryPalaceView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRule)
end

function StorySummaryPalaceView:destroyUI()
	StorySummaryPalaceView.super.destroyUI(self)
end

function StorySummaryPalaceView:onEnter()
	StorySummaryPalaceView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._curStoryPlanId = params[1] or self._curStoryPlanId

	self:_onSetUI()
	GlobalDispatcher:addListener(GlobalNotify.StorySummaryInfoRes, self._onUpdate, self)
	StorySummaryController.instance:onSendStorySummaryInfoReq()
end

function StorySummaryPalaceView:onExit()
	StorySummaryPalaceView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.StorySummaryInfoRes, self._onUpdate, self)
	self:showTabAt(self._content, "")
end

function StorySummaryPalaceView:_onSetUI()
	return
end

function StorySummaryPalaceView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function StorySummaryPalaceView:_onUpdateData()
	self:_onUpdateStoryData()
end

function StorySummaryPalaceView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdateStoryScrollerList()
	self:_onUpdateRootContent()
end

function StorySummaryPalaceView:_onUpdateStoryData()
	self._storyPlanIdList = {}

	local ssCfg = StorySummaryConfig.instance:getSsCfg()

	for _, data in ipairs(ssCfg) do
		local isInTime = StorySummaryController.instance:isStoryInTime(data.storyPlanId)

		if isInTime then
			table.insert(self._storyPlanIdList, data.storyPlanId)
		end
	end

	local isInTime = StorySummaryController.instance:isStoryInTime(self._curStoryPlanId)

	if not isInTime then
		self._curStoryPlanId = self._storyPlanIdList[1]
	end
end

function StorySummaryPalaceView:_onUpdatePlaneUI()
	return
end

function StorySummaryPalaceView:_onUpdateStoryScrollerList()
	local dataList = {}

	for _, storyPlanId in ipairs(self._storyPlanIdList) do
		local data = StorySummaryConfig.instance:getSsData(storyPlanId)

		table.insert(dataList, data)
	end

	self._storyScrollList:reloadData(dataList)
end

function StorySummaryPalaceView:_updateStoryCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local redPoint = goutil.findChild(mainGo, "redPoint")
	local UIChangeGroup = mainGo:GetComponent(ComponentType.UIChangeGroup)

	txtName.text = data.storyName

	local isSelected = self._curStoryPlanId == data.storyPlanId

	UIChangeGroup:SetState(isSelected and 1 or 0)

	local isNeedRed = StorySummaryController.instance:isStoryNeedRed(data.storyPlanId)

	GameUtil.SetActive(redPoint, isNeedRed)

	local function handler()
		self._curStoryPlanId = data.storyPlanId

		self:_onUpdate()

		if data.reportBehavior > 0 then
			SurveyController.instance:reportBehavior(data.reportBehavior)
		end
	end

	GameUtil.addClickHandler(mainGo, handler)
end

function StorySummaryPalaceView:_clearStoryCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function StorySummaryPalaceView:_onUpdateRootContent()
	self:showTabAt(self._content, "")

	local isInTime = StorySummaryController.instance:isStoryInTime(self._curStoryPlanId)

	if not isInTime then
		FloatWordMgr.instance:show("故事不在开启期限内")

		return
	end

	local viewName = ViewName.StorySummaryPartView

	self:showTabAt(self._content, viewName, self._curStoryPlanId)
end

return StorySummaryPalaceView
