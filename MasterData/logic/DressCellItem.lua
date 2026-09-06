-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dress/view/DressCellItem.lua

module("logic.extensions.dress.view.DressCellItem", package.seeall)

local DressCellItem = class("DressCellItem")

function DressCellItem:ctor(go)
	self.mainGO = go

	self:buildUI()
	self:OnEnter()
end

function DressCellItem:OnDestroy()
	self:OnExit()
end

function DressCellItem:buildUI()
	self._icon = goutil.findChild(self.mainGO, "icon")
	self._redpoint = goutil.findChild(self.mainGO, "redpoint")
	self._markSold = goutil.findChild(self.mainGO, "markSold")
	self._markTime = goutil.findChild(self.mainGO, "markTime")
	self._showTime = goutil.findChild(self._markTime, "card"):GetComponent(ComponentType.UIImageSpriteChange)
	self._markSoldAll = goutil.findChild(self.mainGO, "markSoldAll")
	self._markSelect = goutil.findChild(self.mainGO, "markSelect")
	self._markDressing = goutil.findChild(self.mainGO, "markDressing")
	self._txtName = goutil.findChildTextComponent(self.mainGO, "txtName")
	self._txtprize = goutil.findChildTextComponent(self.mainGO, "btnBuy/txtPrize")
	self._symMoney = goutil.findChild(self.mainGO, "btnBuy/txtPrize/symMoney")
	self._symCoin = goutil.findChild(self.mainGO, "btnBuy/txtPrize/symCoin")
	self._iconCoin = self._symCoin:GetComponent(ComponentType.UIImageSpriteChange)
	self._btnSelect = GameUtil.asBtn(goutil.findChild(self.mainGO, "btnSelect"))
	self._btnBuy = GameUtil.asBtn(goutil.findChild(self.mainGO, "btnBuy"))
	self._showTag = goutil.findChildComponent(self.mainGO, "tag", "UIImageSpriteChange")
end

function DressCellItem:OnEnter()
	self._btnBuy:AddClickListener(self._onClickBtnBuy, self)
	self._btnSelect:AddClickListener(self._onClickBtnDress, self)
end

function DressCellItem:OnExit()
	self._btnBuy:RemoveClickListener()
	self._btnSelect:RemoveClickListener()

	self._curData = nil

	uGuiUtil.clearImage(self._icon)
end

function DressCellItem:setData(refTarget, data)
	self._refTarget = refTarget

	if self._curData ~= data then
		self._curData = data

		self:_updateCellData()
	end

	self:_updateCellState()
end

function DressCellItem:_updateCellData()
	uGuiUtil.clearImage(self._icon)

	self._txtName.text = self._curData.goodsCfg.name
	self._txtprize.text = self._curData.costNum

	if self._curData.costType == 1 then
		goutil.setActive(self._symMoney, true)
		goutil.setActive(self._symCoin, false)
	else
		goutil.setActive(self._symMoney, false)
		goutil.setActive(self._symCoin, true)
		self._iconCoin:SetState(self._curData.costType - 2)
	end

	uGuiUtil.setSpriteToImage(self._icon, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(self._curData.goodsCfg.icon))
	goutil.setActive(self._markTime, self._curData:getIsTrialCard())

	if self._curData:getUseTime() == 15 then
		self._showTime:SetState(2)
	elseif self._curData:getUseTime() == 7 then
		self._showTime:SetState(1)
	else
		self._showTime:SetState(0)
	end

	local tag = self._curData.tag
	local index = table.keyof(DressConfig.ShopShowTags, tag)

	if index then
		goutil.setActive(self._showTag.gameObject, true)
		self._showTag:SetState(index)
	else
		goutil.setActive(self._showTag.gameObject, false)
	end
end

function DressCellItem:_updateCellState()
	if self._refTarget then
		goutil.setActive(self._markSelect, self._curData == self._refTarget.curSelectData)
		goutil.setActive(self._markDressing, table.keyof(self._refTarget._selectDatas or {}, self._curData))
		goutil.setActive(self._markSold, self._curData:getIsFoverOwn())
		goutil.setActive(self._markSoldAll, not self._curData:getIsAbleToBuy() and not self._curData:getIsFoverOwn())
	end
end

function DressCellItem:_onClickBtnDress()
	self._refTarget:selectDress(self._curData)
end

function DressCellItem:_onClickBtnBuy()
	self._refTarget:tryToBuyDress(self._curData)
end

return DressCellItem
