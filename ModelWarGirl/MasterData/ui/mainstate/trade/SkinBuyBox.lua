-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Trade\\SkinBuyBox.lua

local ResColor = require("ClientData/ResColor")
local EventConst = require("EventConst")
local HeroAttrPanel = require("UI/Hero/HeroAttrPanel")
local HeroTagChild = require("UI/Hero/HeroTagChild")
local ResSkinTag = require("ClientData/ResSkinTag")
local ResClientNotice = require("ClientData/ResClientNotice")
local ResItem = require("ClientData/ResItem")
local strClassName = "SkinBuyBox"
local SkinBuyBox = Class(strClassName, UIControls.Window)

function SkinBuyBox:ctor()
	self.attrList = {}
	self.tagList = {}
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBoxClose)

	self.btnBuy = UIControls.Button(self, "BgPanel/BtnBuy")

	self.btnBuy:addEventClick(self.onClickBuy)

	self.txtPrice = UIControls.ShortNumLabel(self, "BgPanel/BtnBuy/TxtPrice")
	self.imgMoney = UIControls.Image(self, "BgPanel/BtnBuy/Icon")
	self.txtName = UIControls.Label(self, "BgPanel/TxtName")
	self.imgSkin = UIControls.Role(self, "BgPanel/SkinDraw")
	self.actInfoPanel = UIControls.Panel(self, "BgPanel/ActInfoPanel")
	self.timeOver = false
	self._slot4NewDay = Slot(self.onNewDay, self)
	self.toggleCoupon = UIControls.Toggle(self, "BgPanel/BtnCoupon")

	self.toggleCoupon:addEventValueChanged(self.onCouponChanged)

	self.iconToggle = UIControls.Image(self, "BgPanel/BtnCoupon/Icon")
	self.textCouponPriceOld = UIControls.Label(self, "BgPanel/BtnCouponBuy/TxtPriceOld")
	self.textCouponPriceNew = UIControls.Label(self, "BgPanel/BtnCouponBuy/TxtPriceNew")
	self.textCouponPrice = UIControls.Label(self, "BgPanel/BtnCouponBuy/TxtPrice")
	self.btnCouponBuy = UIControls.Button(self, "BgPanel/BtnCouponBuy")
	self.imgCouponBuy = UIControls.Image(self, "BgPanel/BtnCouponBuy/Icon")

	self.btnCouponBuy:addEventClick(self.onClickBuy)
end

function SkinBuyBox:onOpen()
	SkinBuyBox.super.onOpen(self)
	EventCenter.addEventListener(EventConst.NEW_DAY, self._slot4NewDay)
end

function SkinBuyBox:onCouponChanged()
	self:refreshCouponPart()
end

function SkinBuyBox:refreshCouponPart(fromInit)
	self.selectCoupon = nil
	self.couponHigher = false
	self.needMoney = self._totalMoney

	local countInfo = self._curItem.data.discount_items

	if not countInfo or not countInfo[1] or not (countInfo[1] > 0) then
		self.toggleCoupon:setVisible(false)

		return
	end

	if CurAvatar:getItemNumById(countInfo[1]) <= 0 then
		self.toggleCoupon:setVisible(false)

		return
	end

	local itemData = ResItem[countInfo[1]] or {}
	local moneyInfo = self._curItem.data.use[1]
	local moneyId = moneyInfo.ID

	if not itemData or itemData.extend_args2 ~= moneyId then
		self.toggleCoupon:setVisible(false)

		return
	end

	if fromInit then
		self.toggleCoupon:setVisible(true)
		self.toggleCoupon:setOn(false)
		self.btnBuy:setVisible(false)
		self.btnCouponBuy:setVisible(true)

		local curValue = ClientUtils.getMoney(moneyId)

		self.textCouponPrice:setText(self._totalMoney)

		if curValue < self._totalMoney then
			self.textCouponPrice:setFontColor(ResColor.RED)
		end
	end

	local isOn = self.toggleCoupon:isOn()
	local couponIcon = ClientUtils.getMoneyIcon(countInfo[1])

	if couponIcon then
		self.iconToggle:setImage(couponIcon[1], couponIcon[2])
	end

	local curValue = ClientUtils.getMoney(moneyInfo.ID)

	if isOn then
		self.selectCoupon = countInfo[1]

		self.textCouponPrice:setVisible(false)
		self.textCouponPriceOld:setVisible(true)
		self.textCouponPriceNew:setVisible(true)
		self.textCouponPriceOld:setText(self._totalMoney)

		local newPrice = math.max(0, self._totalMoney - itemData.extend_args1)

		self.needMoney = newPrice
		self.couponHigher = self._totalMoney < itemData.extend_args1

		self.textCouponPriceNew:setText(newPrice)

		if curValue < self.needMoney then
			self.textCouponPriceNew:setFontColor(ResColor.RED)
			self.textCouponPriceOld:setFontColor(ResColor.RED)
		else
			self.textCouponPriceNew:setFontColor(ResColor.BLACK)
			self.textCouponPriceOld:setFontColor(ResColor.BLACK)
		end
	else
		self.textCouponPrice:setVisible(true)
		self.textCouponPriceOld:setVisible(false)
		self.textCouponPriceNew:setVisible(false)
	end
end

function SkinBuyBox:onNewDay()
	if self.timeOver ~= nil then
		self.timeOver = true
	end
end

function SkinBuyBox:showShopItem(item, orderUI, buyCB, cellClass, cellPrefab)
	self.buyCB = buyCB
	self._curItem = item

	if orderUI and orderUI.mWindow then
		self:setOrder(orderUI.mWindow:getOrder() + 5)
	end

	self:setVisible(true)

	local moneyInfo = self._curItem.data.use[1]

	self._totalMoney = moneyInfo.discount

	local moneyPath = ClientUtils.getMoneyIcon(moneyInfo.ID)

	if moneyPath then
		self.imgMoney:setImage(moneyPath[1], moneyPath[2])
		self.imgCouponBuy:setImage(moneyPath[1], moneyPath[2])
	end

	local curValue = ClientUtils.getMoney(moneyInfo.ID)

	self.txtPrice:setNum(self._totalMoney)

	if curValue < self._totalMoney then
		self.txtPrice:setFontColor(ResColor.RED)
	end

	local obj = item.object
	local skin2dId = obj.clientData.port_id

	self.txtName:setText(obj.name)
	self.imgSkin:showRole(skin2dId, UIConst.ROLEIMAGE_SHOWTYPE_BUY_SKIN)
	self:setAttrAndTag(obj)
	self:refreshCouponPart(true)
end

function SkinBuyBox:setAttrAndTag(item)
	local curSkinData = item.clientData

	self.txtName:setText(curSkinData.name)

	for i = 1, 2 do
		if not self.attrList[i] then
			self.attrList[i] = HeroAttrPanel(self, "BgPanel/AttrLessPanel/Attr" .. i)
		end

		local attr = curSkinData.prop and curSkinData.prop[i] or nil

		if attr then
			local name, valueStr = ClientUtils.getRolePropZhNameByType(attr.type, attr.value)
			local attriconInfo = ClientUtils.getRolePropIconByType(attr.type)

			self.attrList[i]:setVisible(true)
			self.attrList[i]:setData(name, valueStr)
			self.attrList[i].imgIcon:setImage(attriconInfo[1], attriconInfo[2])
		else
			self.attrList[i]:setVisible(false)
		end

		if curSkinData.tag_id then
			if #curSkinData.tag_id > #self.tagList then
				for i = #self.tagList + 1, #curSkinData.tag_id do
					local tag = HeroTagChild(self, "BgPanel/MarkPanel", "System/Hero/MarkCell", 0, 0, true)

					self.tagList[i] = tag
				end
			end

			for i = 1, #self.tagList do
				if curSkinData.tag_id[i] then
					self.tagList[i]:setVisible(true)

					local info = ResSkinTag[curSkinData.tag_id[i]]

					self.tagList[i]:setData(info)
				else
					self.tagList[i]:setVisible(false)
				end
			end
		end
	end
end

function SkinBuyBox:_doBuy()
	if self.selectCoupon and self.couponHigher then
		local func = Functor(CurAvatar.checkItemsFull, CurAvatar, {
			self._curItem.object
		}, Slot(self.itemBuyCb, self), {
			1
		})

		UIManager.showConfirmWithId(1092, func)
	else
		CurAvatar:checkItemsFull({
			self._curItem.object
		}, Slot(self.itemBuyCb, self), {
			1
		})
	end
end

function SkinBuyBox:onBoxClose(sender)
	self:setVisible(false)
	EventCenter.removeEventListener(EventConst.NEW_DAY, self._slot4NewDay)
end

function SkinBuyBox:itemBuyCb()
	if self.buyCB then
		self.buyCB(self._curItem.id, 1)
	elseif self.selectCoupon then
		RPC.shopExchange(self._curItem.shopID, self._curItem.id, 1, 0, nil, nil, {
			self.selectCoupon
		})
	else
		RPC.shopExchange(self._curItem.shopID, self._curItem.id, 1, 0)
	end

	self:setVisible(false)
	EventCenter.removeEventListener(EventConst.NEW_DAY, self._slot4NewDay)
end

function SkinBuyBox:onClickBuy(sender)
	ClientUtils.tryBuySkinObj(self._curItem.object, Slot(self.onItemBuy, self))
end

function SkinBuyBox:onItemBuy()
	if self.timeOver == true then
		MsgManager.notice(Lang.get(30540))
		self:setVisible(false)
		EventCenter.removeEventListener(EventConst.NEW_DAY, self._slot4NewDay)

		return
	end

	local moneyInfo = self._curItem.data.use[1]

	if self.goRechargeCallBack then
		ClientUtils.checkMoneyChange(moneyInfo.ID, self.needMoney, self._doBuy, self, true, self.goRechargeCallBack)
	else
		ClientUtils.checkMoneyChange(moneyInfo.ID, self.needMoney, self._doBuy, self, true)
	end
end

function SkinBuyBox:setGoRechargeCallBack(cb)
	self.goRechargeCallBack = cb
end

return SkinBuyBox
