-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/instruction/view/SimpletxttipsView.lua

module("logic.extensions.common.instruction.view.SimpletxttipsView", package.seeall)

local SimpletxttipsView = class("SimpletxttipsView", TipsViewBase)
local maxWidth = 380

function SimpletxttipsView:buildUI()
	SimpletxttipsView.super.buildUI(self)

	self._content = self:getGo("content")
	self._adjustPosition = self._content:GetComponent("UIAdjustPosition")
	self._customInput = UICustomInput.Get(self._content)
	self._txtDesc = self:getTxt("content/txtDesc")
	self._contentRect = self:getGo("content"):GetComponent("RectTransform")
	self._textRect = self:getGo("content/txtDesc"):GetComponent("RectTransform")
end

function SimpletxttipsView:destroyUI()
	SimpletxttipsView.super.destroyUI(self)
end

function SimpletxttipsView:bindEvents()
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function SimpletxttipsView:unbindEvents()
	self._customInput:RemoveListener()
end

function SimpletxttipsView:_onCustomInputCallback(hover)
	CommonTipsMgr.instance:doWillClose(self, hover)
end

function SimpletxttipsView:onExit()
	SimpletxttipsView.super.onExit(self)
	removetimer(self._onTimer, self)
end

function SimpletxttipsView:onEnter()
	SimpletxttipsView.super.onEnter(self)

	local params = self:getOpenParam() or {}
	local desc = self._viewPresentor._openParam[1]
	local pos = self._viewPresentor._openParam[2]

	if not self._viewPresentor._openParam[3] then
		self._txtDesc.text = desc

		local textWidth = Mathf.Min(self._txtDesc.preferredWidth, maxWidth)
		local textHeight = self._txtDesc.preferredHeight

		self._textRect.sizeDelta = Vector2.New(textWidth, textHeight)
		self._contentRect.sizeDelta = Vector2.New(textWidth + 40, textHeight + 45)

		if pos then
			GameUtil.SetActive(self.mainGO, false)

			self._tempPos = pos
			self._tempSizeDelta = self._viewPresentor._openParam[3]

			settimer(0.1, self._onTimer, self, false)
		else
			Framework.TransformUtil.SetLocalPos(self._content.transform, 0, 0, 0)
		end
	end
end

function SimpletxttipsView:_onTimer()
	local pos = self._tempPos
	local sizeDelta = self._tempSizeDelta

	GameUtil.SetActive(self.mainGO, true)
	Framework.TransformUtil.SetLocalScale(self.mainGO.transform, 1, 1, 1)
	self._adjustPosition:AdjustScreenPosition(pos, sizeDelta[1], sizeDelta[2])
end

return SimpletxttipsView
