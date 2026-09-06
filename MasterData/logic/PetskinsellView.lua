-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firstcharge/view/PetskinsellView.lua

module("logic.extensions.firstcharge.view.PetskinsellView", package.seeall)

local PetskinsellView = class("PetskinsellView", ViewComponent)

function PetskinsellView:ctor()
	PetskinsellView.super.ctor(self)
end

function PetskinsellView:buildUI()
	PetskinsellView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnBuy = self:getBtn("btnBuy")
	self._btnPreshow = self:getBtn("btnPreshow")
	self._items = {}

	for i = 1, 3 do
		local item = {}

		item.go = self:getGo("item" .. i)
		item.btn = GameUtil.asBtn(item.go)
		item.icon = goutil.findChild(item.go, "icon")
		item.matStr = nil
		item.txtNum = goutil.findChildTextComponent(item.go, "txtNum")
		self._items[i] = item
	end

	self._txtTime = self:getTxt("txtTime")
	self._txtPrize = self:getTxt("btnBuy/Text")
	self._btnSkill = self:getBtn("btnSkill")
	self._goodsId = FirstChargeModel.instance:getCurPetSkinGoodId()
	self._funcId = 214
end

function PetskinsellView:bindEvents()
	PetskinsellView.super.bindEvents(self)
	self._btnSkill:AddClickListener(self._onClickBtnSkill, self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnBuy:AddClickListener(self._onClickBtnBuy, self)
	self._btnPreshow:AddClickListener(self._onClickBtnPreshow, self)

	for i = 1, 3 do
		self._items[i].btn:AddClickListener(function()
			self:_onClickItem(i)
		end, self)
	end
end

function PetskinsellView:unbindEvents()
	PetskinsellView.super.unbindEvents(self)
	self._btnSkill:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnBuy:RemoveClickListener()
	self._btnPreshow:RemoveClickListener()

	for i = 1, 3 do
		self._items[i].btn:RemoveClickListener()
	end
end

function PetskinsellView:destroyUI()
	PetskinsellView.super.destroyUI(self)
end

function PetskinsellView:onEnter()
	PetskinsellView.super.onEnter(self)

	self._goodsCfg = PayShopConfig.instance:getPayShopGoodsCfgById(self._goodsId)

	GlobalDispatcher:addListener(GlobalNotify.NotifyPayShopItemBuySucRes, self.handlePayShopItemBuySucRes, self)
	settimer(1, self._preHourReset, self)

	local prizes = MaterialMgr.changeItemStrArr(self._goodsCfg.content)

	for i = 1, 3 do
		if not GameUtil.isEmptyString(prizes[i]) then
			goutil.setActive(self._items[i].go, true)

			self._items[i].matStr = prizes[i]

			MaterialMgr.clearIcon(self._items[i].icon)
			MaterialMgr.updateItemByStr(self._items[i].icon, prizes[i])

			local matType, matId, matNum = MaterialMgr.getMatParams(prizes[i])

			self._items[i].txtNum.text = matNum <= 1 and "" or "x" .. matNum
		else
			goutil.setActive(self._items[i].go, false)
		end
	end

	self._txtPrize.text = PayConfig.instance:getPayMoneyYuan(self._goodsCfg.originalGoodsId) .. "元"

	self:_preHourReset()
end

function PetskinsellView:onEnterFinished()
	PetskinsellView.super.onEnterFinished(self)
end

function PetskinsellView:onExit()
	PetskinsellView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.NotifyPayShopItemBuySucRes, self.handlePayShopItemBuySucRes, self)
	removetimer(self._preHourReset, self)

	for i = 1, 3 do
		MaterialMgr.clearIcon(self._items[i].icon)
	end
end

function PetskinsellView:onExitFinished()
	PetskinsellView.super.onExitFinished(self)
end

function PetskinsellView:_onClickBtnBuy()
	if self._hasBuy then
		TipsFacade.instance:openCommonTips("已购买")

		return
	end

	local data = {
		id = self._goodsId,
		times = self._hasBuyTimes
	}

	UIStateManager.instance:push(ViewName.PayShopMibaoBuyView, data)
end

function PetskinsellView:_onClickItem(id)
	if self._items[id].matStr and self._items[id].go then
		CommonTipsMgr.instance:openTipsByConfStr(self._items[id].go, self._items[id].matStr)
	end
end

function PetskinsellView:handlePayShopItemBuySucRes(status, msg)
	if status == 0 then
		self:close()
	end
end

function PetskinsellView:_preHourReset()
	local isOpen = FuncOpenModel.instance:getFuncIsOpen(self._funcId)

	if not isOpen then
		TipsFacade.instance:openCommonTips("当前活动已经结束")
		self:close()
	end

	self._hasBuyTimes = PayShopModel.instance:getMibaoBuyTimesById(self._goodsId)
	self._hasBuy = self._hasBuyTimes > 0

	if self._hasBuy then
		self._txtPrize.text = "已购买"
	end

	local cfg = FuncOpenConfig.instance:getFunctionOpenById(checknumber(self._funcId))
	local times = string.split(cfg.openTime, "#")
	local timeEnd = GameUtil.string2time(times[2])
	local left = timeEnd - ServerTime.now()

	if left > 0 then
		self._txtTime.text = GameUtil.FormatTimeSymbol(left)
	else
		TipsFacade.instance:openCommonTips("当前活动已经结束")
		self:close()
	end
end

function PetskinsellView:_onClickBtnPreshow()
	if not GameUtil.isEmptyString(self._items[1].matStr) then
		local matType, matId, matNum = MaterialMgr.getMatParams(self._items[1].matStr)
		local skinCfg = PetSkinConfig.instance:getPetSkinCfg(matId)

		if skinCfg then
			local raceId = skinCfg.raceId

			PetbookController.instance:previewBattle(raceId, matId)
		end
	end
end

function PetskinsellView:_onClickBtnSkill()
	local skinId = 1032401

	if skinId then
		local cfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

		if cfg then
			local raceId = cfg.raceId

			PetbookController.instance:previewBattle(raceId, skinId)
		end
	end
end

return PetskinsellView
