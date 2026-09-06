-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZooSpeedCardUsedView.lua

module("logic.extensions.itembag.view.ZooSpeedCardUsedView", package.seeall)

local ZooSpeedCardUsedView = class("ZooSpeedCardUsedView", ViewComponent)

function ZooSpeedCardUsedView:buildUI()
	ZooSpeedCardUsedView.super.buildUI(self)

	self._itemsLayout = self:getGo("itemsLayout"):GetComponent(ComponentType.UILayoutSingleLine)
	self._btnClose = self:getBtn("btnClose")
	self._btnSure = self:getBtn("btnSure")

	local txtTitle = self:getTxt("txtTitle")

	txtTitle.text = lang("petzoo_speedcard_title")
end

function ZooSpeedCardUsedView:bindEvents()
	ZooSpeedCardUsedView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnSure:AddClickListener(self._onClickSure, self)
end

function ZooSpeedCardUsedView:unbindEvents()
	ZooSpeedCardUsedView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnSure:RemoveClickListener()
end

function ZooSpeedCardUsedView:onEnter()
	ZooSpeedCardUsedView.super.onEnter(self)

	self._slotId = self:getFirstParam()
	self._selectCardId = 0

	self:_setUpItems()
	GlobalDispatcher:addListener(GlobalNotify.OnZooHatchUseSpeedUpCard, self._onUseSpeedCard, self)
end

function ZooSpeedCardUsedView:onExit()
	ZooSpeedCardUsedView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.OnZooHatchUseSpeedUpCard, self._onUseSpeedCard, self)

	self._selectCardId = nil
	self._slotId = nil
end

function ZooSpeedCardUsedView:onExitFinished()
	ZooSpeedCardUsedView.super.onExitFinished(self)
	self:_clearItems()
end

function ZooSpeedCardUsedView:_setUpItems()
	local items = ZooConfig.instance:getAllSpeedUpCards()
	local transform = self._itemsLayout.transform
	local cnt = transform.childCount
	local itemCnt = #items

	while cnt < itemCnt do
		UGUIToolHelper.AddChild(transform.gameObject, transform:GetChild(0).gameObject)

		cnt = cnt + 1
	end

	for i = 1, itemCnt do
		local go = transform:GetChild(i - 1).gameObject

		go:SetActive(true)

		local data = items[i]
		local btn = Framework.ButtonAdapter.Get(go)
		local imgSelect = goutil.findChild(go, "imgSelect")
		local txtName = goutil.findChildTextComponent(go, "txtName")
		local txtDesc = goutil.findChildTextComponent(go, "txtDesc")
		local txtHaveCount = goutil.findChildTextComponent(go, "txtHaveCount")
		local item = goutil.findChild(go, "item")
		local cfg = MaterialMgr.getMatCfg(MatType.Item, data.id)

		GameUtil.SetActive(imgSelect, self._selectCardId == data.id)
		MaterialMgr.setCell(MatType.Item, data.id, item)

		txtName.text = MaterialMgr.getMaterialsName(MatType.Item, data.id)
		txtDesc.text = cfg.desc
		txtHaveCount.text = langPara("item_have", MaterialModel.instance:getMaterialsNumber(MatType.Item, data.id))

		btn:RemoveClickListener()
		btn:AddClickListener(function()
			self._selectCardId = data.id

			self:_setUpItems()
		end)
	end

	for i = itemCnt + 1, cnt do
		local go = transform:GetChild(i - 1).gameObject

		go:SetActive(false)
	end

	self._itemsLayout:Layout()
end

function ZooSpeedCardUsedView:_clearItems()
	local transform = self._itemsLayout.transform

	for i = 1, transform.childCount do
		local go = transform:GetChild(i - 1).gameObject
		local con = goutil.findChild(go, "item")
		local btn = Framework.ButtonAdapter.Get(go)

		MaterialMgr.resetAll(con)
		btn:RemoveClickListener()
	end
end

function ZooSpeedCardUsedView:_onClickSure()
	if checknumber(self._selectCardId) ~= 0 then
		if MaterialModel.instance:getMaterialsNumber(MatType.Item, self._selectCardId) == 0 then
			FloatWordMgr.instance:show(lang("petzoo_speedcard_nocard"))

			return
		end

		ZooController.instance:sendPM_ZooHatchUseSpeedUpCardReq(self._slotId, self._selectCardId)
	else
		FloatWordMgr.instance:show(lang("petzoo_speedcard_selecttips"))
	end
end

function ZooSpeedCardUsedView:_onUseSpeedCard()
	self:close()
end

return ZooSpeedCardUsedView
