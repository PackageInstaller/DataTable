-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcopen/view/FuncOpenFlyView.lua

module("logic.extensions.funcopen.view.FuncOpenFlyView", package.seeall)

local FuncOpenFlyView = class("FuncOpenFlyView", ViewComponent)

function FuncOpenFlyView:ctor()
	self._icon = {
		icon_jljt = 3,
		icon_xiaoxiaole = 5,
		icon_yzzt = 4,
		icon_qrqd = 0,
		icon_zxjl = 1,
		icon_mrs = 2
	}
end

function FuncOpenFlyView:buildUI()
	self._ImgFun = self:getGo("ImgFun")
	self._ImageBg = self:getGo("Image")
	self._scale = self._ImgFun:GetComponent(UnityTweensType.TweenScale)
	self._posAction = self._ImgFun:GetComponent(UnityTweensType.TweenPosition)
	self._spriteChange = self:getGo("ImgFun"):GetComponent("UIImageSpriteChange")
end

function FuncOpenFlyView:bindEvents()
	self._posAction:AddListener(self._onFlyFinishCallBack, self)
end

function FuncOpenFlyView:unbindEvents()
	return
end

function FuncOpenFlyView:onEnter()
	self._widget = self:getFirstParam()

	local _params = self._viewPresentor:getOpenParam()

	self._callBack = _params[2]
	self._funId = _params[3] or 1
	self._cfg = FuncOpenConfig.instance:getFunctionOpenById(tonumber(self._funcId))

	if self._cfg then
		self._spriteChange:SetState(self._funId - 1)
	end

	self._spriteChange:SetState(self._funId - 1)

	if MainUIFacade.instance:GetActivity() then
		GlobalDispatcher:dispatch(GlobalNotify.HideActivity)
	end

	GlobalDispatcher:dispatch(GlobalNotify.SetActivityArrowPos)
	settimer(0.1, self._onAction, self, false)
end

function FuncOpenFlyView:_onAction(...)
	if self._widget then
		self._saveParent = self._widget.transform.parent
		self._saveSiblingIndex = self._widget.transform:GetSiblingIndex()

		self._widget.transform:SetParent(self.mainGO.transform)
	else
		return nil
	end

	self._eff = UIEffectManager.instance:playEffect(self, "fx_ui_xinshouzhiyin/fx_xinshouzhiyin_003/fx_feiru_xingxing.prefab", self._ImgFun, 0, 0, true, nil, nil, nil, self)

	settimer(0, self._update, self)

	if self._widget then
		local endPos = GameUtil.getLocalPos(self._widget)
		local rect = self._widget:GetComponent("RectTransform")

		self._posAction.to = Vector3.New(endPos.x + 45, endPos.y + 45, 0)
	end

	self._scale:Begin()
	self._posAction:Begin()
end

function FuncOpenFlyView:_onFlyFinishCallBack()
	UIEffectManager.instance:stopEffect(self._eff)

	self._eff = nil

	self._ImageBg.gameObject:SetActive(false)

	self._bloomEff = UIEffectManager.instance:playEffect(self, "fx_ui_xinshouzhiyin/fx_xinshouzhiyin_003/fx_feiru_xingxing_bao.prefab", self._ImgFun, 0, 0, true, nil, nil, nil, self)

	settimer(0.8, self._onBloomEffect, self)
	settimer(0.1, self._onShowWidget, self)
end

function FuncOpenFlyView:_onShowWidget()
	removetimer(self._onShowWidget, self)
	GameUtil.setLocalScale(self._widget.transform, 1, 1, 1)

	local trs = self._widget.transform
	local count = trs.childCount

	for i = count, 1, -1 do
		local child = trs:GetChild(i - 1)

		child.gameObject:SetActive(true)
	end
end

function FuncOpenFlyView:_onBloomEffect()
	removetimer(self._onBloomEffect, self)
	UIEffectManager.instance:stopEffect(self._bloomEff)

	if self._widget then
		self._widget.transform:SetParent(self._saveParent)
		self._widget.transform:SetSiblingIndex(self._saveSiblingIndex)
	end

	self._saveParent = nil
	self._widget = nil
	self._saveSiblingIndex = nil

	if self._callBack then
		self._callBack()
	end
end

function FuncOpenFlyView:_update()
	if not self._eff then
		return nil
	end

	UIEffectManager.instance:updateEffectPosition(self._eff)
end

function FuncOpenFlyView:onExit()
	self._ImageBg.gameObject:SetActive(true)
	removetimer(self._update, self)
end

return FuncOpenFlyView
