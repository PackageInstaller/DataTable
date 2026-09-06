-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fusionsoul/view/FusionSoulFinalView.lua

module("logic.extensions.fusionsoul.view.FusionSoulFinalView", package.seeall)

local FusionSoulFinalView = class("FusionSoulFinalView", ViewComponent)
local UIEFFECT_XUNHUAN = "20250725/rongheliliang/fx_ui_gouyu_xunhuan.prefab"
local UIEFFECT_RONGHE = "20250725/rongheliliang/fx_ui_ronghe_fx.prefab"

function FusionSoulFinalView:ctor()
	FusionSoulFinalView.super.ctor(self)
end

function FusionSoulFinalView:unbindEvents()
	FusionSoulFinalView.super.unbindEvents(self)
	self._dragLeft:RemoveDragListener()
	self._dragLeft:RemoveBeginDragListener()
	self._dragLeft:RemoveEndDragListener()
	self._dragRight:RemoveDragListener()
	self._dragRight:RemoveBeginDragListener()
	self._dragRight:RemoveEndDragListener()
	GameUtil.rmClickHandler(self._btnClose)
end

function FusionSoulFinalView:bindEvents()
	FusionSoulFinalView.super.bindEvents(self)
	self._dragLeft:AddDragListener(self._onDragLeft, self)
	self._dragLeft:AddBeginDragListener(self._onDragLeftBegin, self)
	self._dragLeft:AddEndDragListener(self._onDragLeftEnd, self)
	self._dragRight:AddDragListener(self._onDragRight, self)
	self._dragRight:AddBeginDragListener(self._onDragRightBegin, self)
	self._dragRight:AddEndDragListener(self._onDragRightEnd, self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
end

function FusionSoulFinalView:buildUI()
	FusionSoulFinalView.super.buildUI(self)

	self._centerContainer = self:getGo("centerContainer")
	self._itemShowLeft = self:getGo("centerContainer/itemLeft")
	self._itemShowRight = self:getGo("centerContainer/itemRight")
	self._itemLeft = self:getGo("itemLeft")
	self._effectLeftGo = self:getGo("itemLeft/effectGo")
	self._dragLeft = Framework.UIDragTrigger.Get(self._itemLeft.gameObject)
	self._itemRight = self:getGo("itemRight")
	self._effectRightGo = self:getGo("itemRight/effectGo")
	self._dragRight = Framework.UIDragTrigger.Get(self._itemRight.gameObject)
	self._effectCon = self:getGo("effectCon")
	self._btnClose = self:getGo("btnClose")
end

function FusionSoulFinalView:onExit()
	FusionSoulFinalView.super.onExit(self)
end

function FusionSoulFinalView:onEnter()
	FusionSoulFinalView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._zoneId = checknumber(params[2])

	local zoneInfo = FusionSoulModel.instance:getZoneInfo(self._activityId, self._zoneId)

	self._eventId = zoneInfo.eventId
	self._startEnd = false
	self._isSetLeft = false
	self._isSetRight = false

	GameUtil.SetActive(self._itemShowLeft, self._isSetLeft)
	GameUtil.SetActive(self._itemShowRight, self._isSetRight)
	GameUtil.SetActive(self._itemLeft, not self._isSetLeft)
	GameUtil.setAnchoredPos(self._itemLeft, -386.9, -116.7)
	GameUtil.SetActive(self._itemRight, not self._isSetRight)
	GameUtil.setAnchoredPos(self._itemRight, 379.4, -138)

	self.containerPos = GameUtil.getLocalPos(self._centerContainer)
	self.containerWidth = GameUtil.getHeight(self._centerContainer)
	self.containerHeight = GameUtil.getHeight(self._centerContainer)

	FusionSoulController.instance:setNewEvent(self._activityId, self._zoneId, zoneInfo.eventId)
	self:playViewEffectUniGo(UIEFFECT_XUNHUAN, self._effectLeftGo, nil, true)
	self:playViewEffectUniGo(UIEFFECT_XUNHUAN, self._effectRightGo, nil, true)
end

function FusionSoulFinalView:_onDragLeft(eventData)
	local pos = GameUtil.getLocalPos(self._itemLeft)
	local rectTransform = ViewMgr.instance:getUIRoot():GetComponent("RectTransform")
	local posEvent = goutil.screenToLocalPos(eventData.position, rectTransform)

	GameUtil.setLocalPos(self._itemLeft.gameObject, posEvent.x, posEvent.y, pos.z)
end

function FusionSoulFinalView:_onDragLeftBegin(eventData)
	return
end

function FusionSoulFinalView:_onDragLeftEnd(eventData)
	local itemPos = GameUtil.getLocalPos(self._itemLeft)

	if itemPos.x > self.containerPos.x - self.containerWidth / 2 and itemPos.x < self.containerPos.x + self.containerWidth / 2 and itemPos.y > self.containerPos.y - self.containerHeight / 2 and itemPos.y < self.containerPos.y + self.containerHeight / 2 then
		self._isSetLeft = true

		GameUtil.SetActive(self._itemShowLeft, self._isSetLeft)
		GameUtil.SetActive(self._itemLeft, not self._isSetLeft)
		self:checkSet()
	end
end

function FusionSoulFinalView:_onDragRight(eventData)
	local pos = GameUtil.getLocalPos(self._itemRight)
	local rectTransform = ViewMgr.instance:getUIRoot():GetComponent("RectTransform")
	local posEvent = goutil.screenToLocalPos(eventData.position, rectTransform)

	GameUtil.setLocalPos(self._itemRight.gameObject, posEvent.x, posEvent.y, pos.z)
end

function FusionSoulFinalView:_onDragRightBegin(eventData)
	return
end

function FusionSoulFinalView:_onDragRightEnd(eventData)
	local itemPos = GameUtil.getLocalPos(self._itemRight)

	if itemPos.x > self.containerPos.x - self.containerWidth / 2 and itemPos.x < self.containerPos.x + self.containerWidth / 2 and itemPos.y > self.containerPos.y - self.containerHeight / 2 and itemPos.y < self.containerPos.y + self.containerHeight / 2 then
		self._isSetRight = true

		GameUtil.SetActive(self._itemShowRight, self._isSetRight)
		GameUtil.SetActive(self._itemRight, not self._isSetRight)
		self:checkSet()
	end
end

function FusionSoulFinalView:checkSet()
	if self._isSetLeft == true and self._isSetRight == true then
		self._startEnd = true

		self:playViewEffectUniGo(UIEFFECT_RONGHE, self._effectCon, nil, false, function()
			self:_showStory()
		end)
	end
end

function FusionSoulFinalView:_showStory()
	local result = FuYaoStoryController.instance:tryPlayPlotOnce(FuYaoStoryEnum.Story_Plot_7, function()
		self:_endStory()
	end)
end

function FusionSoulFinalView:_endStory()
	FusionSoulController.instance:sendPM_FusionSoulFinishFinalEventReq(self._activityId, self._zoneId, self._eventId)
	self:close()
end

function FusionSoulFinalView:_onClickClose()
	if self._startEnd == true then
		FloatWordMgr.instance:show(lang("正在融合中，无法退出"))
	else
		self:close()
	end
end

return FusionSoulFinalView
