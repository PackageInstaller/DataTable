-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Welfare\\MonthCardCell.lua

local ResRandClient = require("ClientData/ResRandClient")
local ResCardClient = require("ClientData/ResCardClient")
local ResRoleHeadPendant = require("ClientData/ResRoleHeadPendant")
local StorePrivilegeCell = require("UI/Welfare/StorePrivilegeCell")
local ResMallMisc = require("ClientData/ResMallMisc")
local MonthCardCell = Class("MonthCardCell", UIControls.Child)
local BEGINNER_MONTH_CARD_ID = 6

function MonthCardCell:ctor()
	self.imgBG = UIControls.RawImage(self, "")
	self.imgIcon = UIControls.Image(self, "Icon")
	self.imgName = UIControls.Image(self, "ImgName")
	self.efx = UIControls.LazyEffectPlayer(self, "Efx")
	self.dayAwardPanel = UIControls.Panel(self, "EverydayAwardPanel")
	self.btnBuy = UIControls.Button(self, "BtnBuy")

	self.btnBuy:addEventClick(self.onBtnClick)

	self.iconCurrency = UIControls.Image(self, "BtnBuy/IconCurrency")
	self.txtPrice = UIControls.Label(self, "BtnBuy/TextPrice")
	self.imgLineS = UIControls.Image(self, "ImgLineS")
	self.imgLineL = UIControls.Image(self, "ImgLineL")
	self.timeLimit = UIControls.Label(self, "TextLimit")
	self.limitPanel = UIControls.Panel(self, "TextLimit/LimitPanel")
	self.txtLimit = UIControls.Label(self, "TextLimit/LimitPanel/TextTime")
	self.imgLimitRedBg = UIControls.Image(self, "TextLimit/LimitPanel/BgTime")
	self.limitPanel2 = UIControls.Panel(self, "LimitPanel")
	self.txtTime = UIControls.Label(self, "LimitPanel/TextTime")
	self.discountPanel = UIControls.Panel(self, "DiscountPanel")
	self.textDiscountPrice = UIControls.Label(self, "DiscountPanel/TextPrice")
	self.textDiscountPriceNow = UIControls.Label(self, "DiscountPanel/TextPriceNow")
	self.textDiscount = UIControls.Label(self, "DiscountPanel/ImgDiscount/TextDiscount")
	self._timerUpdate = Timer.New(Slot(self.timer, self), 0.5, -1)
	self.nextDayTime = ClientUtils.getServerTimeNextDay()
	self.items = {}
	self.privileges = {}
	self.panelSpecialCard = UIControls.Panel(self, "ImgSpe")
	self.panelSpecialCardTime = UIControls.Panel(self, "ImgBuyLimit")
	self.textSpecialCardTime = UIControls.Label(self, "ImgBuyLimit/TextTime")

	if ChannelUtil.isDMMGame() then
		if UIControls.checkControlFunc(self, "DiscountPanel/TextPt") then
			self.priceDmmPanel = UIControls.Panel(self, "DiscountPanel/TextPt")

			self.priceDmmPanel:setVisible(true)
		end

		if UIControls.checkControlFunc(self, "BtnBuy/TextPt") then
			self.priceDmmPanel2 = UIControls.Panel(self, "BtnBuy/TextPt")

			self.priceDmmPanel2:setVisible(true)
		end
	end

	if UIControls.checkControlFunc(self, "PrivilegePanel/ItemPanel/Icon") then
		self.imgItemIcon = UIControls.Image(self, "PrivilegePanel/ItemPanel/Icon")
		self.txtItemTitle = UIControls.Label(self, "PrivilegePanel/ItemPanel/TextTitle")
		self.itemAttrList = {}

		for i = 1, 2 do
			local path = "PrivilegePanel/ItemPanel/TextAttr" .. i

			self.itemAttrList[i] = UIControls.Label(self, path)
			self.itemAttrList[i].txtNum = UIControls.Label(self, path .. "/TextNum")
			self.itemAttrList[i].icon = UIControls.Image(self, path .. "/Icon")
		end
	end

	if UIControls.checkControlFunc(self, "FirstBuyAwardPanel") then
		self.firstBuyAwardPanel = UIControls.Panel(self, "FirstBuyAwardPanel")
		self.imgFirstBuyAwardBonus = UIControls.Panel(self, "FirstBuyAwardPanel/ImgBonus")
		self.btnfirstBuyAwardGet = UIControls.Button(self, "FirstBuyAwardPanel/BtnGet")

		self.btnfirstBuyAwardGet:addEventClick(self.onBtnFirstBuyAwardGetClick)
	end

	if UIControls.checkControlFunc(self, "LimitPanel") then
		self.panelLimit = UIControls.Panel(self, "LimitPanel")
	end

	if UIControls.checkControlFunc(self, "SubscribePanel") then
		self.panelSubscribe = UIControls.Panel(self, "SubscribePanel")
	end
end

function MonthCardCell:setData(id, data, svrData)
	local srvTime = ClientUtils.getServerTime()
	local resData = ResCardClient[id]

	self.data = data
	self.svrData = svrData or {}
	self.resData = resData
	self.cellId = id

	if resData.award then
		self.day_award = ResRandClient[resData.award]
	end

	self.period = resData.continue_day
	self.lastTime = self.svrData.endtime and self.svrData.endtime - srvTime or 0

	if self.lastTime > 0 and self.resData and self.resData.is_privilege and self.resData.is_privilege == 1 then
		self.btnBuy:setVisible(false)
	else
		self.btnBuy:setVisible(true)
	end

	self:tryReportBuriedPointBuySucc(self.lastTime)

	if resData.bg_icon then
		self.imgBG:setImage(resData.bg_path .. "/" .. resData.bg_icon)
	end

	if resData.name_icon then
		self.imgName:setImage(resData.name_path, resData.name_icon)
	end

	if resData.icon_icon then
		self.imgIcon:setImage(resData.icon_path, resData.icon_icon)
	end

	if resData.efx_name then
		local name = string.format("Effects/UI/%s.prefab", "efx_ui_Life_time_card")

		self.efx:playEffectByPath(name)
	end

	self.txtPrice:setText(data.priceText)

	local buyAwardData = ResRandClient[data.randId]
	local privilegeNum = 0

	for idx, award in ipairs(buyAwardData.show_nums) do
		local obj = BaseObject.GetObject(buyAwardData.show_ids[idx], buyAwardData.show_nums[idx])

		if obj then
			if obj.subType then
				if obj.subType == Const.ITEM_STYPE_PRIVILEGE then
					privilegeNum = privilegeNum + 1

					if UIControls.checkControlFunc(self, "PrivilegePanel/ListPrivilige") then
						if not self.privileges[privilegeNum] then
							self.privileges[privilegeNum] = StorePrivilegeCell(self, "PrivilegePanel/ListPrivilige/Content", "System/Store/StorePrivilegeCell")

							self.privileges[privilegeNum]:setVisible(true)
						end

						self.privileges[privilegeNum]:setObj(obj)
					end
				elseif obj.subType == Const.ITEM_STYPE_TIMEAPPEND then
					if obj.resData and obj.resData.extend_args1 and ResRoleHeadPendant[obj.resData.extend_args1] then
						local HPResData = ResRoleHeadPendant[obj.resData.extend_args1]
						local relaObj = BaseObject.GetObject(obj.resData.extend_args1)

						if relaObj then
							local iconData = relaObj:getIconPath()

							if iconData then
								self.imgItemIcon:setVisible(true)
								self.imgItemIcon:setImage(iconData[1], iconData[2])
							end
						end

						if HPResData.name and self.txtItemTitle then
							self.txtItemTitle:setText(HPResData.name)
						end

						if HPResData.attrs then
							for i = 1, #HPResData.attrs do
								local iconData = ClientUtils.getRolePropIconByType(HPResData.attrs)

								if self.itemAttrList and self.itemAttrList[i] then
									if iconData then
										self.itemAttrList[i].icon:setImage(iconData[1], iconData[2])
									end

									if HPResData.attrs[i].value then
										self.itemAttrList[i].txtNum:setText(HPResData.attrs[i].value)
									end
								end
							end
						elseif self.itemAttrList then
							self.itemAttrList[1]:setVisible(false)
							self.itemAttrList[2]:setVisible(false)
						end
					end
				else
					local moneyInfo = ClientUtils.getMoneyIcon(buyAwardData.show_ids[idx])

					if moneyInfo then
						local awardItem = UIControls.Panel(self, "BuyAwardPanel/Award" .. idx)
						local txtBuyAward = UIControls.Label(self, "BuyAwardPanel/Award" .. idx .. "/TextNum")
						local imgBuyAward = UIControls.Image(self, "BuyAwardPanel/Award" .. idx .. "/Icon")

						txtBuyAward:setText(buyAwardData.show_nums[idx])
						imgBuyAward:setImage(moneyInfo[1], moneyInfo[2])
						awardItem:setVisible(true)
					end
				end
			else
				local moneyInfo = ClientUtils.getMoneyIcon(buyAwardData.show_ids[idx])

				if moneyInfo then
					local awardItem = UIControls.Panel(self, "BuyAwardPanel/Award" .. idx)
					local txtBuyAward = UIControls.Label(self, "BuyAwardPanel/Award" .. idx .. "/TextNum")
					local imgBuyAward = UIControls.Image(self, "BuyAwardPanel/Award" .. idx .. "/Icon")

					txtBuyAward:setText(buyAwardData.show_nums[idx])
					imgBuyAward:setImage(moneyInfo[1], moneyInfo[2])
					awardItem:setVisible(true)
				end
			end
		end
	end

	for i = privilegeNum + 1, #self.privileges do
		self.privileges[i]:setVisible(false)
	end

	if self.day_award then
		for i, id in ipairs(self.day_award.show_ids) do
			if not self.items[i] then
				local obj = BaseObject.GetObject(id, self.day_award.show_nums[i])
				local item = UIControls.getGridAwardContainer(self, "EverydayAwardPanel/AwardPanel")

				item.mDisableWays = true

				item:setObj(obj)
				item:setVisible(true)

				self.items[i] = item
			end
		end
	else
		self.dayAwardPanel:setVisible(false)
	end

	self.showDiscount = false

	if data.rateType == 1 then
		self.showDiscount = true

		self.discountPanel:setVisible(true)
		self.textDiscountPrice:setText(data.originalPrice)
		self.textDiscountPriceNow:setText(data.priceText)

		local rate = data.rate10

		if Const.SHOP_DISCOUNT_MODE == 1 and tonumber(data.rate10) then
			rate = 100 - tonumber(data.rate10) * 10
		end

		self.textDiscount:setText(rate)
		self.iconCurrency:setVisible(false)

		if self.priceDmmPanel2 then
			self.priceDmmPanel2:setVisible(false)
		end

		self.txtPrice:setVisible(false)
	elseif data.rateType == 2 then
		self.showDiscount = true

		self.discountPanel:setVisible(true)
		self.textDiscountPrice:setText(data.originalPrice)
		self.textDiscountPriceNow:setText(data.priceText)
		self.textDiscount:setText(data.rate10 .. "%")
		self.iconCurrency:setVisible(false)

		if self.priceDmmPanel2 then
			self.priceDmmPanel2:setVisible(false)
		end

		self.txtPrice:setVisible(false)
	else
		self.discountPanel:setVisible(false)

		if data.buyTimesLeft == 0 then
			self.iconCurrency:setVisible(false)

			if self.priceDmmPanel2 then
				self.priceDmmPanel2:setVisible(false)
			end

			self.txtPrice:setVisible(false)
		else
			self.iconCurrency:setVisible(true)

			if self.priceDmmPanel2 then
				self.priceDmmPanel2:setVisible(true)
			end

			self.txtPrice:setVisible(true)
		end
	end

	if self.period > 0 then
		self.limitPanel2:setVisible(false)
		self.timeLimit:setText(string.format(Lang.get(30795), self.period))
		self.imgLineL:setVisible(false)
		self.imgLineS:setVisible(true)

		if self.lastTime / 86400 > 1 then
			self.txtLimit:setText(string.format(Lang.get(30022), math.floor(self.lastTime / 86400)))
			self.limitPanel:setVisible(true)
		elseif self.lastTime > 0 then
			self.nextDayTime = ClientUtils.getServerTimeNextDay()

			self._timerUpdate:Start()
			self.limitPanel:setVisible(true)
		else
			self.imgLineL:setVisible(true)
			self.imgLineS:setVisible(false)
			self.limitPanel:setVisible(false)
		end

		local noticeDay = self.resData.notice_day

		if noticeDay then
			if self.lastTime <= noticeDay * 86400 then
				self.imgLimitRedBg:setVisible(true)
			else
				self.imgLimitRedBg:setVisible(false)
			end
		end
	else
		self.limitPanel:setVisible(false)
		self.timeLimit:setText(Lang.get(30796))

		if self.svrData and self.svrData.count and self.svrData.count > 0 then
			self.iconCurrency:setVisible(false)

			if self.priceDmmPanel2 then
				self.priceDmmPanel2:setVisible(false)
			end

			self.txtPrice:setVisible(false)
			self.limitPanel2:setVisible(true)
			self.txtTime:setText(string.format(Lang.get(30797), self.svrData.count))
		else
			self.iconCurrency:setVisible(true)

			if self.priceDmmPanel2 then
				self.priceDmmPanel2:setVisible(true)
			end

			self.txtPrice:setVisible(true)
			self.limitPanel2:setVisible(false)
		end
	end

	self:refreshSpecialCell()
end

function MonthCardCell:refreshData(data, svrData)
	local srvTime = ClientUtils.getServerTime()
	local resData = ResCardClient[self.cellId]

	self.data = data
	self.svrData = svrData or {}
	self.resData = resData
	self.lastTime = self.svrData.endtime and svrData.endtime - srvTime or 0

	if self.showDiscount or self.data.buyTimesLeft == 0 then
		self.iconCurrency:setVisible(false)

		if self.priceDmmPanel2 then
			self.priceDmmPanel2:setVisible(false)
		end

		self.txtPrice:setVisible(false)
	else
		self.iconCurrency:setVisible(true)

		if self.priceDmmPanel2 then
			self.priceDmmPanel2:setVisible(true)
		end

		self.txtPrice:setVisible(true)
	end

	if self.period > 0 then
		self.limitPanel2:setVisible(false)
		self.imgLineL:setVisible(false)
		self.imgLineS:setVisible(true)

		if self.lastTime / 86400 > 1 then
			self.txtLimit:setText(string.format(Lang.get(30022), math.floor(self.lastTime / 86400)))
			self.limitPanel:setVisible(true)
		elseif self.lastTime > 0 then
			self.nextDayTime = ClientUtils.getServerTimeNextDay()

			self._timerUpdate:Start()
			self.limitPanel:setVisible(true)
		else
			self.imgLineL:setVisible(true)
			self.imgLineS:setVisible(false)
			self.limitPanel:setVisible(false)
		end
	else
		self.limitPanel:setVisible(false)

		if self.svrData and self.svrData.count and self.svrData.count > 0 then
			self.iconCurrency:setVisible(false)

			if self.priceDmmPanel2 then
				self.priceDmmPanel2:setVisible(false)
			end

			self.txtPrice:setVisible(false)
			self.limitPanel2:setVisible(true)
			self.txtTime:setText(string.format(Lang.get(30797), self.svrData.count))
		else
			self.iconCurrency:setVisible(true)

			if self.priceDmmPanel2 then
				self.priceDmmPanel2:setVisible(true)
			end

			self.txtPrice:setVisible(true)
			self.limitPanel2:setVisible(false)
		end
	end

	self:refreshSpecialCell()
end

function MonthCardCell:onBtnFirstBuyAwardGetClick()
	RPC.subscribeGetAward()
end

function MonthCardCell:refreshSpecialCell()
	if self.cellId == BEGINNER_MONTH_CARD_ID then
		local rTick = self.data:getProductRemainTime()

		if rTick then
			self.panelSpecialCard:setVisible(true)
			self.panelSpecialCardTime:setVisible(true)
			ClientTimerManager.AddSecondFormatTickUI(self.textSpecialCardTime, rTick, false, Lang.get(48674))
		else
			self.panelSpecialCard:setVisible(false)
			self.panelSpecialCardTime:setVisible(false)
		end
	elseif self.resData and self.resData.is_privilege and self.resData.is_privilege == 1 then
		if self.svrData and self.svrData.firstBuyAwardGet ~= Const.FIRST_SUBSCRIBE_AWARD_GOT then
			self.firstBuyAwardPanel:setVisible(true)

			if self.svrData.endtime and self.svrData.endtime ~= 0 then
				self.btnfirstBuyAwardGet:setVisible(true)
				self.imgFirstBuyAwardBonus:setVisible(false)
			else
				self.btnfirstBuyAwardGet:setVisible(false)
				self.imgFirstBuyAwardBonus:setVisible(true)
			end

			local awardId = ResMallMisc[1].subscribe_award

			if awardId and ResRandClient[awardId] and not self.firstBuyAwardCells then
				self.firstBuyAwardCells = {}

				for i, id in ipairs(ResRandClient[awardId].show_ids) do
					if not self.items[i] then
						local obj = BaseObject.GetObject(id, ResRandClient[awardId].show_nums[i])
						local item = UIControls.getGridAwardContainer(self, "FirstBuyAwardPanel/AwardPanel")

						item.mDisableWays = true

						item:setObj(obj)
						item:setVisible(true)

						self.firstBuyAwardCells[i] = item
					end
				end
			end
		else
			self.firstBuyAwardPanel:setVisible(false)
		end
	else
		self.panelSpecialCard:setVisible(false)
		self.panelSpecialCardTime:setVisible(false)
	end
end

function MonthCardCell:timer()
	if self.resData and self.resData.is_privilege and self.resData.is_privilege == 1 then
		if self.svrData and self.svrData.endtime then
			local time = self.svrData.endtime - ClientUtils.getServerTime()

			if time and time > 0 then
				self.txtLimit:setText(utils.calcTimeTxt(time))
			else
				local clientData, svrData = CurAvatar:getPrivilegeMonthCardData()

				self:refreshData(clientData, svrData)
			end
		end
	else
		local time = self.nextDayTime - ClientUtils.getServerTime()

		if time > 0 then
			self.txtLimit:setText(utils.calcTimeTxt(time))
		end
	end
end

function MonthCardCell:onBtnClick()
	CurAvatar:setUserDataMallNew(self.mParent.panelConfigData.id)

	if not (self.data.buyTimesLeft > 0) then
		local noticeId = self.resData.sold_out_notice

		if noticeId then
			MsgManager.clientNotice(noticeId)
		end
	elseif self.lastTime > 0 then
		local confirmId = self.resData.buy_notice

		if confirmId then
			UIManager.showConfirmWithId(confirmId, Slot(self.doBuy, self))
		end
	elseif self.resData and self.resData.is_privilege and self.resData.is_privilege == 1 then
		if not ClientUtils.checkHaveAbilityMonthCard() then
			local ResClientNotice = require("ClientData/ResClientNotice")

			if ResClientNotice[770] then
				MsgManager.notice(ResClientNotice[770].notice)
			end

			return
		end

		if RegionUtils.isJP() then
			local ui = UIManager.getUI("privilegeMonthCardConfirmBoxJP", true)

			if ui then
				ui.confirmCallBack = Slot(self.doBuy, self)
			end
		else
			self:doBuy()
		end
	else
		self:doBuy()
	end
end

function MonthCardCell:doBuy()
	if self.mEventClick then
		self.mEventClick(self.data)
	end
end

function MonthCardCell:tryReportBuriedPointBuySucc(lastTime)
	if self.lastTimeForReport and lastTime > self.lastTimeForReport then
		SDKAgent.reportBuriedPoint("af_Month_Card", "Fire_Month_Card")
	end

	self.lastTimeForReport = lastTime
end

function MonthCardCell:destroy()
	if self._timerUpdate then
		self._timerUpdate:Stop()
	end
end

return MonthCardCell
