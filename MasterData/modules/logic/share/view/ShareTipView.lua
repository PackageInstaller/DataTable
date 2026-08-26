-- chunkname: @modules/logic/share/view/ShareTipView.lua

module("modules.logic.share.view.ShareTipView", package.seeall)

local ShareTipView = class("ShareTipView", BaseView)

function ShareTipView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "bg/#btn_close")
	self._gorawImage = gohelper.findChild(self.viewGO, "bg/#go_rawImage")
	self._btnshare = gohelper.findChildButtonWithAudio(self.viewGO, "bg/#go_rawImage/#btn_share")
	self._simagelogo = gohelper.findChildSingleImage(self.viewGO, "#simage_logo")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ShareTipView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnshare:AddClickListener(self._btnshareOnClick, self)
end

function ShareTipView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnshare:RemoveClickListener()
end

function ShareTipView:_btncloseOnClick()
	self:closeThis()
end

function ShareTipView:_btnshareOnClick()
	if not self._viewOpen then
		return
	end

	self._openShareEditor = true

	self:closeThis()
	ShareController.instance:openShareEditorView(self._texture)
end

function ShareTipView:_editableInitView()
	self._bgGO = gohelper.findChild(self.viewGO, "bg")
	self._bgTr = self._bgGO.transform
	self._touchGO = gohelper.findChild(self.viewGO, "touch")
	self._touch = TouchEventMgrHepler.getTouchEventMgr(self._touchGO)

	self._touch:SetIgnoreUI(true)
	self._touch:SetOnlyTouch(true)
	self._touch:SetOnTouchDownCb(self._onTouch, self)

	self._viewOpen = false
end

function ShareTipView:_onTouch(pos)
	local anchorPos = recthelper.screenPosToAnchorPos(pos, self._bgTr)

	if math.abs(anchorPos.x) > recthelper.getWidth(self._bgTr) or math.abs(anchorPos.y) > recthelper.getHeight(self._bgTr) then
		self:closeThis()
	end
end

function ShareTipView:onUpdateParam()
	self:_refreshUI()
end

function ShareTipView:onOpen()
	self._viewOpen = true

	self:_refreshUI()
end

function ShareTipView:_refreshUI()
	self._texture = self.viewParam

	local image = gohelper.onceAddComponent(self._gorawImage, gohelper.Type_RawImage)

	image.texture = self._texture

	TaskDispatcher.cancelTask(self.closeThis, self)
	TaskDispatcher.runDelay(self.closeThis, self, 3)
end

function ShareTipView:onClose()
	self._viewOpen = false

	if not self._openShareEditor then
		UnityEngine.Object.Destroy(self._texture)
	end
end

function ShareTipView:onDestroyView()
	TaskDispatcher.cancelTask(self.closeThis, self)

	if self._touch then
		TouchEventMgrHepler.remove(self._touch)

		self._touch = nil
	end
end

return ShareTipView
