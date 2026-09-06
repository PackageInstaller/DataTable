-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/view/GuideDragToView.lua

module("logic.extensions.guide.view.GuideDragToView", package.seeall)

local GuideDragToView = class("GuideDragToView", GuideUIObjectBase)

function GuideDragToView:buildUI()
	self._finger = self:getGo("Finger")
	self._mask = self:getGo("Mask")

	self._finger:SetActive(false)
	self._mask:SetActive(false)

	self._isDoingDelayShow = nil
	self._hasDelayShowDone = nil
end

function GuideDragToView:onEnterFinished()
	GuideDragToView.super.onEnterFinished(self)
	self._finger:SetActive(false)

	self._isDoingDelayShow = nil
	self._hasDelayShowDone = nil

	self:_showGuide()
end

function GuideDragToView:onExitFinished()
	removetimer(self._onViewDelayShow, self)
	GuideDragToView.super.onExitFinished(self)

	if self._saveDragContainer and self._saveEndedCallback then
		self._saveDragContainer:RegisterDragEndedCallback(self._saveEndedCallback, self._saveEndedCallbackTarget)
	end

	self._isDoingDelayShow = nil
	self._saveEndedCallback = nil
	self._saveEndedCallbackTarget = nil
	self._saveDragContainer = nil
	self._originStartGo = nil
	self._hasDelayShowDone = nil
end

function GuideDragToView:_showGuide()
	local params = self._currGuide:getGuideUIParams()
	local startGoUI = params[1]
	local startGoName = params[2]
	local endGoUI = params[3]
	local endGoName = params[4]

	self._originStartGo = self._originStartGo or self:_getWidgetIngoreHandler(startGoUI, startGoName)

	local startGo = self:_getWidgetNeedHandler(startGoUI, startGoName)
	local endGo = self:_getWidgetNeedHandler(endGoUI, endGoName)

	if startGo and endGo and not self._isDoingDelayShow then
		local delayTime = 0

		if params[5] then
			delayTime = tonumber(params[5])
		end

		if delayTime > 0 and not self._hasDelayShowDone then
			self._mask:SetActive(true)

			self._isDoingDelayShow = true

			settimer(delayTime, self._onViewDelayShow, self, false)
		else
			self._mask:SetActive(false)

			local startX, startY, startZ = self:_getWidgetCenterPosition(startGo)
			local endX, endY, endZ = self:_getWidgetCenterPosition(endGo)

			Framework.TransformUtil.SetPos(self._finger.transform, endX, endY, endZ)

			endX, endY, endZ = Framework.TransformUtil.GetLocalPos(self._finger.transform, nil, nil, nil)

			Framework.TransformUtil.SetPos(self._finger.transform, startX, startY, startZ)

			startX, startY, startZ = Framework.TransformUtil.GetLocalPos(self._finger.transform, nil, nil, nil)

			local tweenPos = self._finger:GetComponent(UnityTweensType.TweenPosition)

			tweenPos.from = Vector3.New(startX, startY, startZ)
			tweenPos.to = Vector3.New(endX, endY, startZ)

			self:_handleDragEvent()
			self._finger:SetActive(true)
		end
	else
		self._finger:SetActive(false)
	end
end

function GuideDragToView:_onViewDelayShow()
	self._isDoingDelayShow = nil
	self._hasDelayShowDone = true

	self._mask:SetActive(false)
	removetimer(self._onViewDelayShow, self)
	self:_showGuide()
end

function GuideDragToView:_onHandleTableviewObjectFinish(tableView)
	self:_showGuide()
end

function GuideDragToView:_handleDragEvent()
	self._saveDragContainer = self._originStartGo:GetComponent("UIDragContainerForLua")

	if self._saveDragContainer then
		self._saveEndedCallback = self._saveDragContainer:GetDragEndedCallback()
		self._saveEndedCallbackTarget = self._saveDragContainer:GetDragEndedCallbackTarget()

		self._saveDragContainer:RegisterDragEndedCallback(self._onDragEnded, self)
	end
end

function GuideDragToView:_onDragEnded(sContainer, cell, endContainer)
	if not endContainer or endContainer == sContainerthen then
		if self._saveEndedCallback then
			return self._saveEndedCallback(self._saveEndedCallbackTarget, sContainer, cell, endContainer)
		end
	else
		if self._saveEndedCallback then
			-- block empty
		end

		return true
	end
end

return GuideDragToView
