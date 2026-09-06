-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/view/GuideTipsView.lua

module("logic.extensions.guide.view.GuideTipsView", package.seeall)

local GuideTipsView = class("GuideTipsView", GuideUIObjectBase)

function GuideTipsView:buildUI()
	self._closeButton = self:getBtn("EmptyClick")
	self._customInput = UICustomInput.Get(self.mainGO)
	self._nodes = {}
	self._texts = {}
	self._nodes[1] = self:getGo("NodeUp")
	self._nodes[2] = self:getGo("Node")
	self._nodes[3] = self:getGo("Node1")
	self._nodes[4] = self:getGo("Node2")
	self._nodes[5] = self:getGo("Node3")
	self._texts[1] = self:getGo("NodeUp/Text"):GetComponent("Text")
	self._texts[2] = self:getGo("Node/Text"):GetComponent("Text")
	self._texts[3] = self:getGo("Node1/Text"):GetComponent("Text")
	self._texts[4] = self:getGo("Node2/Text"):GetComponent("Text")
	self._texts[5] = self:getGo("Node3/Text"):GetComponent("Text")
	self._handleEvtOnAutoFinish = nil
	self._delayShowing = nil

	self:_hideAllNodes()
end

function GuideTipsView:_hideAllNodes()
	local cnt = #self._nodes

	for i = 1, cnt do
		self._nodes[i]:SetActive(false)
	end
end

function GuideTipsView:bindEvents()
	self._closeButton:AddClickListener(self._onClickCloseBtn, self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function GuideTipsView:onEnterFinished()
	Framework.TransformUtil.SetLocalScale(self._nodes[2].transform, 0, 0, 0)
	GuideTipsView.super.onEnterFinished(self)
	self:_showGuide()
end

function GuideTipsView:onExitFinished()
	removetimer(self._onTimeoutToShow, self)

	if TaskModel.instance.finishByTimeout and self._handleEvtOnAutoFinish then
		self._handleEvtOnAutoFinish = nil

		if self._saveCallback then
			self._saveCallback(self._saveTarget)
		end
	end

	GuideTipsView.super.onExitFinished(self)

	self._handleEvtOnAutoFinish = nil
	self._delayShowing = nil
end

function GuideTipsView:unbindEvents()
	self._customInput:RemoveListener()
	self._closeButton:RemoveClickListener()
end

function GuideTipsView:_showGuide()
	local params = self._currGuide:getGuideUIParams()

	if not self:_setDelayShowTime(params[3]) then
		self:_setViewText(tonumber(params[1]))
		self:_setEventHanelr(params[2])
		self:_setMaskEnabled(params[4])
	end
end

function GuideTipsView:_setViewText(idx)
	local cnt = #self._nodes
	local widget = self:_getGuideWidget()
	local ofs = self._currGuide:getWidgetOffset()

	for i = 1, cnt do
		if idx == i then
			local node = self._nodes[i]

			node:SetActive(true)

			self._texts[i].text = self._currGuide:getDialogue()

			if widget then
				Framework.TransformUtil.SetPos(node.transform, self:_getWidgetCenterPosition(widget))
			end

			local posX, posY, posZ = Framework.TransformUtil.GetLocalPos(node.transform, nil, nil, nil)

			if ofs then
				posX = posX + (ofs[1] or 0)
				posY = posY + (ofs[2] or 0)
			end

			Framework.TransformUtil.SetLocalPos(node.transform, posX, posY, posZ)
		else
			self._nodes[i]:SetActive(false)
		end
	end
end

function GuideTipsView:_setEventHanelr(evtType)
	if evtType and evtType ~= "0" then
		self:_handleGuideWIdgrt()

		if evtType == "1" then
			self._handleEvtOnAutoFinish = true
		end
	end
end

function GuideTipsView:_setMaskEnabled(maskType)
	if maskType and maskType ~= "0" then
		self._closeButton.gameObject:SetActive(false)

		self._customInput.enabled = true
	else
		self._closeButton.gameObject:SetActive(true)

		self._customInput.enabled = false
	end
end

function GuideTipsView:_setDelayShowTime(time)
	if time then
		local numTime = tonumber(time)

		if numTime > 0 then
			self._delayShowing = true

			self._closeButton.gameObject:SetActive(true)

			self._customInput.enabled = false

			self:_hideAllNodes()
			settimer(numTime, self._onTimeoutToShow, self, false)

			return true
		end
	end
end

function GuideTipsView:_onTimeoutToShow()
	removetimer(self._onTimeoutToShow, self)

	self._delayShowing = nil

	local params = self._currGuide:getGuideUIParams()

	self:_setViewText(tonumber(params[1]))
	self:_setEventHanelr(params[2])
	self:_setMaskEnabled(params[4])
end

function GuideTipsView:_onClickCloseBtn()
	if self._delayShowing or self._handleEvtOnAutoFinish then
		return
	end

	GuideController.instance:finishGuide()
end

function GuideTipsView:_onCustomInputCallback(hover)
	if self._delayShowing or self._handleEvtOnAutoFinish then
		return
	end

	GuideController.instance:finishGuide()
end

return GuideTipsView
