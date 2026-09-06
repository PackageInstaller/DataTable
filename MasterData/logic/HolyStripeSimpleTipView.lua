-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeSimpleTipView.lua

module("logic.extensions.holystripe.view.HolyStripeSimpleTipView", package.seeall)

local HolyStripeSimpleTipView = class("HolyStripeSimpleTipView", ViewComponent)

function HolyStripeSimpleTipView:ctor()
	HolyStripeSimpleTipView.super.ctor(self)

	self._clearGo = {}
end

function HolyStripeSimpleTipView:buildUI()
	HolyStripeSimpleTipView.super.buildUI()

	self._nameText = self:getTxt("content/top/txtName")
	self._nameTextChange = self._nameText:GetComponent(ComponentType.UIChangeGroup)
	self._txtPos = self:getTxt("content/top/txtPos")
	self._itemGo = self:getGo("content/top/item")
	self._discardGo = self:getGo("content/top/tag")
	self._discardBtn = GameUtil.asBtn(self._discardGo)
	self._discardUIChange = goutil.findChildComponent(self.mainGO, "content/top/tag", "UIImageSpriteChange")
	self._suitview = self:getGo("content/info/suitDesc/Viewport/suitview")
	self._suitCell = self:getGo("content/info/suitDesc/Viewport/suitview/suititem")
	self._contentSizeImmediate = self:getGo("content"):GetComponent("ContentSizeImmediate")
	self._adjustPosition = goutil.findChildComponent(self.mainGO, "content", "UIAdjustPosition")
	self._customInput = UICustomInput.Get(self:getGo("content"))
end

function HolyStripeSimpleTipView:bindEvents()
	HolyStripeSimpleTipView.super.bindEvents(self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
	self._discardBtn:AddClickListener(self._onClickDiscard, self)
end

function HolyStripeSimpleTipView:unbindEvents()
	HolyStripeSimpleTipView.super.unbindEvents(self)
	self._customInput:RemoveListener()
	self._discardBtn:RemoveClickListener()
end

function HolyStripeSimpleTipView:onEnter()
	HolyStripeSimpleTipView.super.onEnter(self)
	self.addGEvent(self, HolyStripeController.PM_HolyStripeChangeReadyToDiscardRes, self._onDiscardChangeReadyRes, self)

	self._clearGo = {}

	local params = self:getOpenParam()
	local id = checknumber(params[1])
	local sizeDelta = params[3]
	local pos = params[2]
	local cfg = HolyStripeConfig.instance:getHolyStripeCfg(id)

	self._holyStripeMo = HolyStripeModel.instance:getHolyStripeMo(id)
	self._pendingDiscardTips = nil

	MaterialMgr.setCell(MatType.HolyStripe, cfg.id, self._itemGo)

	self._nameText.text = cfg.name

	self._nameTextChange:SetState(cfg.quality)

	self._txtPos.text = ""

	local suitCfg = HolyStripeConfig.instance:getSuitCfgBySuitType(cfg.suitType)

	goutil.setActive(self._suitCell, false)

	local suitItemGo, suitDocTxt, suitNumTxt

	for i = 1, #suitCfg do
		suitItemGo = goutil.cloneAndSetParent(self._suitCell, self._suitview.transform)

		table.insert(self._clearGo, suitItemGo)
		goutil.setActive(suitItemGo, true)

		suitDocTxt = goutil.findChildTextComponent(suitItemGo, "doc")
		goutil.findChildTextComponent(suitItemGo, "suitType").text = langPara("%s件：", suitCfg[i].num)
		suitDocTxt.text = langPara("%s", suitCfg[i].doc)
	end

	if pos then
		self._adjustPosition:AdjustScreenPosition(pos, sizeDelta[1], sizeDelta[2])
	end

	self:_refreshDiscardState()
end

function HolyStripeSimpleTipView:onExit()
	HolyStripeSimpleTipView.super.onExit(self)

	for i, v in ipairs(self._clearGo) do
		goutil.destroy(v)
	end

	MaterialMgr.resetAll(self._itemGo)

	self._clearGo = {}
	self._holyStripeMo = nil
	self._pendingDiscardTips = nil
end

function HolyStripeSimpleTipView:_onCustomInputCallback(hover)
	CommonTipsMgr.instance:doWillClose(self, hover)
end

function HolyStripeSimpleTipView:_refreshDiscardState()
	if not self._discardGo then
		return
	end

	self._holyStripeMo = self._holyStripeMo and HolyStripeModel.instance:getHolyStripeMo(self._holyStripeMo:getId()) or self._holyStripeMo

	if self._holyStripeMo then
		local hasMo = self._holyStripeMo:isBagMo()

		goutil.setActive(self._discardGo, hasMo)

		if hasMo and self._discardUIChange then
			if self._holyStripeMo:getIsReadyToDiscard() then
				self._discardUIChange:SetState(0)
			else
				self._discardUIChange:SetState(1)
			end
		end

		if self._pendingDiscardTips then
			FloatWordMgr.instance:setParent(ViewMgr.instance:getRoot(ViewRootType.TopMost))
			FloatWordMgr.instance:show(self._pendingDiscardTips)
			FloatWordMgr.instance:resetParent()

			self._pendingDiscardTips = nil
		end
	end
end

function HolyStripeSimpleTipView:_onDiscardChangeReadyRes()
	self:_refreshDiscardState()
end

function HolyStripeSimpleTipView:_onClickDiscard()
	if not self._holyStripeMo then
		return
	end

	if self._holyStripeMo:getIsLock() then
		FloatWordMgr.instance:setParent(ViewMgr.instance:getRoot(ViewRootType.TopMost))
		FloatWordMgr.instance:show(lang("请先解除锁定标记"))
		FloatWordMgr.instance:resetParent()

		return
	end

	local isDiscard = not self._holyStripeMo:getIsReadyToDiscard()

	self._pendingDiscardTips = isDiscard and lang("已标记弃置") or lang("已取消弃置")

	HolyStripeController.instance:sendPM_HolyStripeChangeReadyToDiscardReq(self._holyStripeMo, isDiscard)
end

return HolyStripeSimpleTipView
