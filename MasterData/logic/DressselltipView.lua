-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dress/view/DressselltipView.lua

module("logic.extensions.dress.view.DressselltipView", package.seeall)

local DressselltipView = class("DressselltipView", ViewComponent)

function DressselltipView:ctor()
	DressselltipView.super.ctor(self)
end

function DressselltipView:buildUI()
	DressselltipView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._goBuy = self:getGo("btnBuy")
	self._btnBuy = self:getBtn("btnBuy")
	self._conCell = self:getGo("conCell")
	self._txtName = self:getTxt("txtName")
	self._txtTip = self:getTxt("txtTip")
	self._txtCost = self:getTxt("cost/txt")
	self._txtOwn = self:getTxt("own/txt")
	self._coinIconCost = self:getGo("cost/coinIcon"):GetComponent(ComponentType.UIImageSpriteChange)
	self._coinIconOwn = self:getGo("own/coinIcon"):GetComponent(ComponentType.UIImageSpriteChange)
	self._markTime = goutil.findChild(self.mainGO, "markTime")
	self._showTime = goutil.findChild(self._markTime, "card"):GetComponent(ComponentType.UIImageSpriteChange)
	self._txtCostDeduce = self:getTxt("deduce/costDeduce/txt")
	self._txtOwnDeduce = self:getTxt("deduce/ownDeduce/txt")
	self._coinIconCostDeduceGo = self:getGo("deduce/costDeduce/coinIcon")
	self._coinIconOwnDeduceGo = self:getGo("deduce/ownDeduce/coinIcon")
	self._deduceGo = self:getGo("deduce")
end

function DressselltipView:bindEvents()
	DressselltipView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnBuy:AddClickListener(self._onClickBtnBuy, self)
end

function DressselltipView:unbindEvents()
	DressselltipView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnBuy:RemoveClickListener()
end

function DressselltipView:destroyUI()
	DressselltipView.super.destroyUI(self)
end

function DressselltipView:onEnter()
	DressselltipView.super.onEnter(self)

	self._useDeduce = false
	self._deduceMatEnough = true
	self._deduceCount = 0

	self:updateViewByData()
end

function DressselltipView:onEnterFinished()
	DressselltipView.super.onEnterFinished(self)
end

function DressselltipView:onExit()
	DressselltipView.super.onExit(self)
	uGuiUtil.clearImage(self._conCell)
	MaterialMgr.resetAll(self._coinIconCostDeduceGo)
	MaterialMgr.resetAll(self._coinIconOwnDeduceGo)
end

function DressselltipView:onExitFinished()
	DressselltipView.super.onExitFinished(self)
end

function DressselltipView:updateViewByData()
	self._curData = self:getFirstParam()

	local name = self._curData.goodsCfg.name

	self._costMatStr = self._curData.goodsCfg.originalGoodsId

	local costNum = self._curData.costNum
	local ownNum = MaterialMgr.getMatCount(self._costMatStr)

	self._matName = MaterialMgr.getMatCfgByStr(self._costMatStr).name
	self._txtName.text = name
	self._txtCost.text = costNum
	self._txtOwn.text = ownNum
	self._txtTip.text = langPara("你确认花费<color='#eb4642'>%s%s</color>,\n购买%s吗？", costNum, self._matName, name)
	self._isMatEnough = MaterialMgr.getMatEnough(self._costMatStr)

	self._coinIconCost:SetState(self._curData.costType - 2)
	self._coinIconOwn:SetState(self._curData.costType - 2)
	uGuiUtil.setSpriteToImage(self._conCell, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(self._curData.goodsCfg.icon))
	goutil.setActive(self._markTime, self._curData:getIsTrialCard())

	if self._curData:getUseTime() == 15 then
		self._showTime:SetState(2)
	elseif self._curData:getUseTime() == 7 then
		self._showTime:SetState(1)
	else
		self._showTime:SetState(0)
	end

	self:_updateDeduce(self._isMatEnough, costNum, ownNum)
	GameUtil.SetGray(self._goBuy, not self._deduceMatEnough)
end

function DressselltipView:_onClickBtnBuy()
	if (not self._useDeduce or not self._deduceMatEnough) and not self._isMatEnough then
		FloatWordMgr.instance:show(langPara("%s不足", self._matName))
		MaterialMgr.openGetSourceByStr(self._costMatStr)
		self:close()

		return
	end

	PayShopController.instance:buyShopItem(self._curData.goodsCfg.id, 1, 0, self._deduceCount)
	self:close()
end

function DressselltipView:_updateDeduce(isMatEnough, costNum, ownNum)
	self._deduceMatEnough = true
	self._useDeduce = false
	self._deduceCount = 0

	goutil.setActive(self._deduceGo, false)

	if isMatEnough then
		return
	end

	local deduceCfg = self._curData:getDeduceCfg()

	if not deduceCfg then
		return
	end

	local needNum = costNum - ownNum
	local arr = string.split(deduceCfg.deduction, ":")
	local matType = checknumber(arr[1])
	local matId = checknumber(arr[2])
	local costDeduceNum = needNum * deduceCfg.deduceFactor
	local ownDeduceNum = MaterialFacade.instance:getMatNumber(matType, matId)
	local deduceMatName = MaterialMgr.getMaterialsName(matType, matId)

	self._txtCostDeduce.text = string.format("%s可补足", costDeduceNum)
	self._txtOwnDeduce.text = ownDeduceNum
	self._deduceCostMatStr = deduceCfg.deduction

	MaterialMgr.setIcon(self._coinIconOwnDeduceGo, matType, matId)
	MaterialMgr.setIcon(self._coinIconCostDeduceGo, matType, matId)

	self._deduceMatEnough = costDeduceNum <= ownDeduceNum
	self._deduceMatName = deduceMatName
	self._txtTip.text = langPara("你确认花费<color='#eb4642'>%s%s和%s%s</color>,\n购买%s吗？", ownNum, self._matName, costDeduceNum, deduceMatName, self._curData.goodsCfg.name)
	self._deduceCount = costDeduceNum
	self._useDeduce = true

	goutil.setActive(self._deduceGo, true)
end

return DressselltipView
