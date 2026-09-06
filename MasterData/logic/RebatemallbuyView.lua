-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doubleeleven/view/RebatemallbuyView.lua

module("logic.extensions.doubleeleven.view.RebatemallbuyView", package.seeall)

local RebatemallbuyView = class("RebatemallbuyView", ViewComponent)

function RebatemallbuyView:ctor()
	RebatemallbuyView.super.ctor(self)
end

function RebatemallbuyView:unbindEvents()
	RebatemallbuyView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnBuy)
end

function RebatemallbuyView:bindEvents()
	RebatemallbuyView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnBuy, self._onClickBuy, self)
end

function RebatemallbuyView:buildUI()
	RebatemallbuyView.super.buildUI(self)

	self._costIcon = self:getGo("cost/coinIcon")
	self._deduceGo = self:getGo("cost/txtCost/deduce")
	self._deduceIcon = self:getGo("cost/txtCost/deduce/coinIcon")
	self._ownCostIcon = self:getGo("own/coinIcon")
	self._ownDeduceGo = self:getGo("own/txtCost/deduce")
	self._ownDeduceIcon = self:getGo("own/txtCost/deduce/coinIcon")
	self._itemIcon = self:getGo("item/icon")
	self._txtTip = self:getTxt("txtTip")
	self._txtCost = self:getTxt("cost/txtCost")
	self._txtDeduceCost = self:getTxt("cost/txtCost/deduce/txtCost")
	self._txtOwnCost = self:getTxt("own/txtCost")
	self._txtOwnDeduceCost = self:getTxt("own/txtCost/deduce/txtCost")
	self._btnClose = self:getBtn("btnClose")
	self._btnBuy = self:getBtn("btnBuy")
end

function RebatemallbuyView:onExit()
	RebatemallbuyView.super.onExit(self)
end

function RebatemallbuyView:onEnter()
	RebatemallbuyView.super.onEnter(self)

	self._params = self:getFirstParam()
	self._deduceCount = 0
	self._canBuy = true
	self._activityId = RebateMallController.instance:getActId()

	local itemName = MaterialMgr.getMaterialsNameByCfg(self._params.content)
	local costName = MaterialMgr.getMaterialsNameByCfg(self._params.cost)
	local cfg = DoubleElevenConfig.instance:getRebateMallActCfgs(self._activityId)
	local matType, matId, matNum = MaterialMgr.getMatParams(self._params.content)

	MaterialMgr.setIcon(self._itemIcon, matType, matId)

	local formMatType, formMatId, formMatNum = MaterialMgr.getMatParams(cfg.deduceFrom)
	local toMatType, toMatId, toMatNum = MaterialMgr.getMatParams(cfg.deduceTo)
	local itemMatType, itemMatId, itemMatNum = MaterialMgr.getMatParams(self._params.cost)
	local deduceRate = formMatNum / toMatNum
	local hasCostMatNum = MaterialMgr.getMatCount(self._params.cost)
	local hasDeduceMatNum = MaterialMgr.getMatCount(cfg.deduceFrom)
	local canBuyMaxNum = self._params.limitTimes - RebateMallController.instance:itemBuyTimes(self._params.id)

	if canBuyMaxNum > 0 then
		local isNeedDeduce = hasCostMatNum < itemMatNum

		GameUtil.SetActive(self._deduceGo, isNeedDeduce)
		GameUtil.SetActive(self._ownDeduceGo, isNeedDeduce)

		if isNeedDeduce then
			local needDeduceNum = itemMatNum - hasCostMatNum
			local deduceNum = needDeduceNum * deduceRate
			local isCanDeduce = deduceNum <= hasDeduceMatNum

			self._txtDeduceCost.text = deduceNum
			self._txtOwnDeduceCost.text = hasDeduceMatNum

			MaterialMgr.setIcon(self._deduceIcon, formMatType, formMatId)
			MaterialMgr.setIcon(self._ownDeduceIcon, formMatType, formMatId)

			if not isCanDeduce then
				self._canBuy = false
				self._txtTip.text = "您的储值不够，无法进行购买哦~"

				uGuiUtil.setImageGrayStateRecursive(self._btnBuy, true)
				MaterialMgr.setIcon(self._costIcon, toMatType, toMatId)
				MaterialMgr.setIcon(self._ownCostIcon, toMatType, toMatId)

				self._txtCost.text = itemMatNum
				self._txtOwnCost.text = hasCostMatNum
			else
				local deduceName = MaterialMgr.getMaterialsNameByCfg(cfg.deduceFrom)

				uGuiUtil.setImageGrayStateRecursive(self._btnBuy, false)
				MaterialMgr.setIcon(self._costIcon, toMatType, toMatId)
				MaterialMgr.setIcon(self._ownCostIcon, toMatType, toMatId)

				self._txtCost.text = hasCostMatNum
				self._txtOwnCost.text = hasCostMatNum
				self._txtTip.text = string.format("您确定花费<color='#eb4642'>%d%s</color>,<color='#eb4642'>%d%s</color>兑换%s吗？", hasCostMatNum, costName, deduceNum, deduceName, itemName)
				self._deduceCount = deduceNum
			end
		else
			MaterialMgr.setIcon(self._costIcon, toMatType, toMatId)
			MaterialMgr.setIcon(self._ownCostIcon, toMatType, toMatId)

			self._txtCost.text = itemMatNum
			self._txtOwnCost.text = hasCostMatNum
			self._txtTip.text = string.format("您确定花费<color='#eb4642'>%d%s</color>兑换%s吗？", itemMatNum, costName, itemName)
			self._deduceCount = 0
		end
	end
end

function RebatemallbuyView:_onClickBuy()
	if not self._canBuy then
		FloatWordMgr.instance:show("您的储值不够，无法进行购买哦~")

		return
	end

	RebateMallController.instance:sendPM_RebateMallBuyReq(self._activityId, self._params.id, self._deduceCount)
	self:close()
end

return RebatemallbuyView
