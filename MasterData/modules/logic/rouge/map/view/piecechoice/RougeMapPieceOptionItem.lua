-- chunkname: @modules/logic/rouge/map/view/piecechoice/RougeMapPieceOptionItem.lua

module("modules.logic.rouge.map.view.piecechoice.RougeMapPieceOptionItem", package.seeall)

local RougeMapPieceOptionItem = class("RougeMapPieceOptionItem", UserDataDispose)

function RougeMapPieceOptionItem:init(go)
	self:__onInit()

	self.go = go
	self.tr = go:GetComponent(gohelper.Type_RectTransform)

	self:_editableInitView()
end

function RougeMapPieceOptionItem:_editableInitView()
	self._refreshClick = gohelper.findChildClickWithDefaultAudio(self.go, "#go_refresh")
	self._exitClick = gohelper.findChildClickWithDefaultAudio(self.go, "#go_exit")

	self._refreshClick:AddClickListener(self.onClickRefreshBtn, self)
	self._exitClick:AddClickListener(self.onClickExitBtn, self)

	self.goNormal = gohelper.findChild(self.go, "#go_refresh/normal")
	self.goLock = gohelper.findChild(self.go, "#go_refresh/locked")
	self.txtNormalTime = gohelper.findChildText(self.go, "#go_refresh/normal/txt_refresh/#txt_times")
	self.txtLockTime = gohelper.findChildText(self.go, "#go_refresh/locked/txt_refresh/#txt_times")
	self.goRefresh = self._refreshClick.gameObject

	self:setRefreshActive()
end

function RougeMapPieceOptionItem:setRefreshActive()
	local active = RougeMapEffectHelper.checkHadEffect(RougeMapEnum.EffectType.UnlockRestRefresh)

	gohelper.setActive(self.goRefresh, active)
end

function RougeMapPieceOptionItem:onClickRefreshBtn()
	local active = RougeMapEffectHelper.checkHadEffect(RougeMapEnum.EffectType.UnlockRestRefresh)

	if not active then
		return
	end

	if self.isLock then
		return
	end

	self:clearCallback()

	self.callbackId = RougeRpc.instance:sendRougeRepairShopRandomRequest(self.onReceiveMsg, self)
end

function RougeMapPieceOptionItem:onReceiveMsg()
	self.callbackId = nil

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onRefreshPieceChoiceEvent)
end

function RougeMapPieceOptionItem:onClickExitBtn()
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onChoiceViewStatusChange, RougeMapEnum.PieceChoiceViewStatus.Choice)
end

function RougeMapPieceOptionItem:update(pos, pieceMo)
	self.pieceMo = pieceMo

	recthelper.setAnchor(self.tr, pos.x, pos.y)
	self:refreshExchangeUI()
end

function RougeMapPieceOptionItem:refreshExchangeUI()
	if self.pieceMo.triggerStr then
		if not self.pieceMo.triggerStr.repairRandomNum then
			local curRandomTime = 0
			local maxRandomTime = RougeMapConfig.instance:getRestStoreRefreshCount()

			self.isLock = maxRandomTime <= curRandomTime

			gohelper.setActive(self.goNormal, not self.isLock)
			gohelper.setActive(self.goLock, self.isLock)

			if self.isLock then
				self.txtLockTime.text = string.format("(<color=#d97373>0</color>/%s)", maxRandomTime)
			else
				local remainTime = maxRandomTime - curRandomTime

				self.txtNormalTime.text = string.format("(%s/%s)", remainTime, maxRandomTime)
			end
		end
	end
end

function RougeMapPieceOptionItem:show()
	gohelper.setActive(self.go, true)
end

function RougeMapPieceOptionItem:hide()
	gohelper.setActive(self.go, false)
end

function RougeMapPieceOptionItem:clearCallback()
	if self.callbackId then
		RougeRpc.instance:removeCallbackById(self.callbackId)

		self.callbackId = nil
	end
end

function RougeMapPieceOptionItem:destroy()
	self:clearCallback()
	self._refreshClick:RemoveClickListener()
	self._exitClick:RemoveClickListener()
	self:__onDispose()
end

return RougeMapPieceOptionItem
