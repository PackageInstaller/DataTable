-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotRoomView.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotRoomView", package.seeall)

local V1a6_CachotRoomView = class("V1a6_CachotRoomView", BaseView)

function V1a6_CachotRoomView:onInitView()
	self._viewAnim = gohelper.findChild(self.viewGO, "#go_excessive"):GetComponent(typeof(UnityEngine.Animator))
	self._viewAnim.keepAnimatorStateOnDisable = true
	self._txttest = gohelper.findChildTextMesh(self.viewGO, "#txt_test")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a6_CachotRoomView:addEvents()
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._checkHaveViewOpen, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onCloseView, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.CheckOpenEnding, self._checkShowEnding, self)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.RoomChangeBegin, self._beginSwitchScene, self)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.RoomChangePlayAnim, self._endSwitchScene, self)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.OnUpdateRogueInfo, self.____testShowInfo, self)
end

function V1a6_CachotRoomView:removeEvents()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self._checkHaveViewOpen, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._onCloseView, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.CheckOpenEnding, self._checkShowEnding, self)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.RoomChangeBegin, self._beginSwitchScene, self)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.RoomChangePlayAnim, self._endSwitchScene, self)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.OnUpdateRogueInfo, self.____testShowInfo, self)
end

function V1a6_CachotRoomView:_checkHaveViewOpen()
	local haveOpenView = self:isOpenView()

	if haveOpenView then
		transformhelper.setLocalPos(self.viewGO.transform, 0, -99999, 0)
	else
		transformhelper.setLocalPos(self.viewGO.transform, 0, 0, 0)
	end

	if not haveOpenView then
		self:_checkShowEnding()
	end
end

function V1a6_CachotRoomView:isOpenView()
	local haveOpenView = not ViewHelper.instance:checkViewOnTheTop(ViewName.V1a6_CachotRoomView, {
		ViewName.GuideView,
		ViewName.GuideView2,
		ViewName.GuideStepEditor
	})

	return (PopupController.instance:getPopupCount() > 0 or nil) and true
end

function V1a6_CachotRoomView:_checkShowEnding()
	if self:isOpenView() then
		return
	end

	local rogueEndingInfo = V1a6_CachotModel.instance:getRogueEndingInfo()

	if rogueEndingInfo then
		V1a6_CachotController.instance:openV1a6_CachotFinishView()
	end
end

function V1a6_CachotRoomView:_onCloseView(viewName)
	self:_checkHaveViewOpen()
end

function V1a6_CachotRoomView:_onCloseViewFinish(viewName)
	if viewName == ViewName.V1a6_CachotLoadingView then
		gohelper.setActive(self.viewGO, false)
		gohelper.setActive(self.viewGO, true)
	end
end

function V1a6_CachotRoomView:_beginSwitchScene()
	self._viewAnim:Play("open", 0, 0)
	TaskDispatcher.runDelay(self._onOpenAnimEnd, self, 1)
end

function V1a6_CachotRoomView:onClose()
	TaskDispatcher.cancelTask(self._onOpenAnimEnd, self)
end

function V1a6_CachotRoomView:_onOpenAnimEnd()
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.RoomViewOpenAnimEnd)
end

function V1a6_CachotRoomView:_endSwitchScene(isChangeRoom)
	self._viewAnim:Play("close", 0, isChangeRoom and 0 or 1)
	self.viewContainer:dispatchEvent(V1a6_CachotEvent.RoomChangeAnimEnd)
end

function V1a6_CachotRoomView:onOpen()
	gohelper.setActive(self._txttest, false)

	self._isShowGo = true

	self:_checkHaveViewOpen()
	self._viewAnim:Play("close", 0, 1)
	self:____testShowInfo()
end

function V1a6_CachotRoomView:____testShowInfo()
	if not isDebugBuild then
		return
	end

	self._rogueInfo = V1a6_CachotModel.instance:getRogueInfo()

	if not self._rogueInfo then
		return
	end

	local roomIndex, total = V1a6_CachotRoomConfig.instance:getRoomIndexAndTotal(self._rogueInfo.room)
	local eventStrs = {}

	for i = 1, #self._rogueInfo.currentEvents do
		local eventMo = self._rogueInfo.currentEvents[i]

		table.insert(eventStrs, eventMo.eventId .. ":" .. eventMo.status .. ">>" .. eventMo.eventData)
	end

	local str = ""

	str = str .. string.format("当前房间：%d (%d / %d)\n", self._rogueInfo.room, roomIndex, total)
	str = str .. string.format("当前房间事件：\n" .. table.concat(eventStrs, "\n"))
	self._txttest.text = str
end

return V1a6_CachotRoomView
