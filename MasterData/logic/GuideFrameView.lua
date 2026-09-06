-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/view/GuideFrameView.lua

module("logic.extensions.guide.view.GuideFrameView", package.seeall)

local GuideFrameView = class("GuideFrameView", GuideUIObjectBase)

function GuideFrameView:buildUI()
	self._frame = self:getGo("Frame")

	self._frame:SetActive(false)

	self._frameBtn = self:getBtn("Frame")
	self._pointerClick = nil
	self._btnClickHandle = nil
	self._btnClickTarget = nil
end

function GuideFrameView:onEnterFinished()
	GuideFrameView.super.onEnterFinished(self)

	self._originStartGo = nil

	self._frame.transform:SetParent(self.mainGO.transform)

	self._effect = UIEffectManager.instance:playEffect(self, "fx_ui_renwu/fx_ui_renwukuang.prefab", self._frame:GetComponent("RectTransform"), 0, 0, true, nil, nil, self._onEffectLoaded, self)
	self._effect.hideEffWhileNotOnTop = nil

	self._effect:setVisible(false)
	self._frame:SetActive(false)
	self._frameBtn:AddClickListener(self._onClickTarget, self)
end

function GuideFrameView:onExitFinished()
	if self._effect then
		UIEffectManager.instance:stopEffect(self._effect)

		self._effect = nil
	end

	self._frameBtn:RemoveClickListener()
	self._frame.transform:SetParent(self.mainGO.transform)

	self._pointerClick = nil
	self._btnClickHandle = nil
	self._btnClickTarget = nil

	GuideFrameView.super.onExitFinished(self)
end

function GuideFrameView:_showGuide()
	self._originStartGo = self._originStartGo or self:_getGuideWidget()

	local startGo = self:_handleWidget(self._originStartGo)

	if startGo then
		self._frame:SetActive(true)
		self._effect:setVisible(true)
		self._effect:setScrollRectClipping(self._originStartGo:GetComponent(typeof(UnityEngine.UI.ScrollRect)))
		self._effect:setParent(startGo.transform)

		local refWidght = startGo
		local childNode = "bg"

		if childNode then
			refWidght = goutil.findChild(startGo, childNode)
			refWidght = refWidght or startGo
		end

		local sizeDelta = refWidght:GetComponent("RectTransform").rect
		local lx, ly, lz = Framework.TransformUtil.GetLocalPos(refWidght.transform, nil, nil, nil)

		ly = ly + 39

		local x, y, z = UIEffectManager.instance:getEffectPosition(self._effect, startGo:GetComponent("RectTransform"), 151, (-sizeDelta.height + ly) * 0.5)

		self._effect:setPos(x, y, z)
		self._effect:setScaleXYZ(1, sizeDelta.height / 84, 1)

		local frameRect = self._frame:GetComponent("RectTransform")
		local frameSize = frameRect.sizeDelta

		frameSize.x = sizeDelta.width
		frameSize.y = sizeDelta.height

		Framework.TransformUtil.SetPos(self._frame.transform, x, y, z)

		frameRect.sizeDelta = frameSize

		self._effect:setParent(startGo.transform.parent)
		self._frame.transform:SetParent(startGo.transform.parent)
		self._effect:setSortingOrder(101)
		self:_handleTargetEvent(refWidght)
	else
		self._frame:SetActive(false)
	end
end

function GuideFrameView:_onEffectLoaded()
	self:_showGuide()
end

function GuideFrameView:_handleTargetEvent(target)
	self._pointerClick = target:GetComponent("PointerClickHandler")

	local btnAdapter = target:GetComponent("Framework.ButtonAdapter")

	if btnAdapter then
		self._btnClickHandle = btnAdapter:GetLuaHandle()
		self._btnClickTarget = btnAdapter:GetLuaTarget()
	end
end

function GuideFrameView:_onHandleTableviewObjectFinish(tableView)
	self:_showGuide()
end

function GuideFrameView:_onClickTarget()
	local pointerClick = self._pointerClick
	local btnClickHandle = self._btnClickHandle
	local btnClickTarget = self._btnClickTarget

	GuideController.instance:finishGuide()

	if pointerClick then
		pointerClick:OnPointerClick(nil)
	end

	if btnClickHandle then
		self._btnClickHandle(btnClickTarget)
	end
end

return GuideFrameView
