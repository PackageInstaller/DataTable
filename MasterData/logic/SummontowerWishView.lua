-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summontower/view/SummontowerWishView.lua

module("logic.extensions.summontower.view.SummontowerWishView", package.seeall)

local SummontowerWishView = class("SummontowerWishView", ViewComponent)

function SummontowerWishView:buildUI()
	SummontowerWishView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnSure = self:getBtn("btnSure")
	self._wishing = {}

	for k, v in pairs(SummontowerModel.WishType) do
		self._wishing[v] = {}

		local go = self:getGo("wish_" .. v)

		self._wishing[v].go = go
		self._wishing[v].selectNode = goutil.findChild(go, "select")
		self._wishing[v].selectImage = goutil.findChild(go, "select/img")
		self._wishing[v].selectBtn = Framework.ButtonAdapter.GetFrom(go, "btn")
	end
end

function SummontowerWishView:bindEvents()
	SummontowerWishView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnSure:AddClickListener(self._onClickSure, self)

	for k, v in pairs(self._wishing) do
		v.selectBtn:AddClickListener(function()
			self:_selectWish(k)
		end)
	end
end

function SummontowerWishView:unbindEvents()
	SummontowerWishView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnSure:RemoveClickListener()

	for k, v in pairs(self._wishing) do
		v.selectBtn:RemoveClickListener()
	end
end

function SummontowerWishView:onEnter()
	SummontowerWishView.super.onEnter(self)
	self:_selectWish()
end

function SummontowerWishView:onExit()
	SummontowerWishView.super.onExit(self)

	self._wishType = nil
end

function SummontowerWishView:_onClickClose()
	self:close()
end

function SummontowerWishView:_selectWish(withType)
	self._wishType = withType

	local canWish = SummontowerMapModel.instance:canMake1Wish()

	for k, v in pairs(self._wishing) do
		v.selectNode:SetActive(canWish)
		v.selectImage:SetActive(self._wishType == k)
	end

	self._btnSure.gameObject:SetActive(self._wishType ~= nil and canWish)
end

function SummontowerWishView:_onClickSure()
	if not self._wishType then
		FloatWordMgr.instance:show(lang("txt_summontower_selwish"))

		return
	end

	local wishType = self._wishType
	local gridData = SummontowerMapModel.instance:getWishGridData()

	if self._wishType == SummontowerModel.WishType.Pet then
		self:close()
		SummontowerController.instance:wish1Pet(gridData.gridId, wishType)
	elseif self._wishType == SummontowerModel.WishType.SummonMaster then
		self:close()
		UIStateManager.instance:push(ViewName.SummontowerChooseView, wishType, gridData)
	end
end

return SummontowerWishView
