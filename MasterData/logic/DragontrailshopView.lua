-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragontrial/view/DragontrailshopView.lua

module("logic.extensions.dragontrial.view.DragontrailshopView", package.seeall)

local DragontrailshopView = class("DragontrailshopView", TableViewComponent)

function DragontrailshopView:buildUI()
	DragontrailshopView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._txtLeftTime = self:getTxt("time/txt")
	self._goldBarCon = self:getGo("goldBarCon")
	self._txtLeftTime.text = ""
	self._titleTxt = self:getTxt("txtTitle")
end

function DragontrailshopView:bindEvents()
	DragontrailshopView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function DragontrailshopView:unbindEvents()
	DragontrailshopView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function DragontrailshopView:onExit()
	DragontrailshopView.super.onExit(self)
	GlobalModel.instance:visibleSceneHUDs(true)
	removetimer(self.CalculationSurplusTime, self)

	self._currTabId = false
	self._currRaceId = false

	GlobalDispatcher:removeListener(GlobalNotify.UpdateActiveShopInfo, self._updateView, self)
end

function DragontrailshopView:onEnter()
	DragontrailshopView.super.onEnter(self)
	GlobalModel.instance:visibleSceneHUDs(false)

	local params = self:getOpenParam()

	self._activityType = GameEnum.ActivityType.DragonTrial
	self._activityId = DragontrialModel.instance:getCurrActivityId()

	if not self._activityId or self._activityId <= 0 then
		return
	end

	DragontrialModel.instance:clearExchangeShopRedPoint()

	self._activeCfg = ActivityDefineConfig.instance:getCfgById(self._activityType, self._activityId)

	if not self._activeCfg then
		printError("无活动配置", self._activityType, self._activityId)
	end

	self._actStartTime, self._actEndTime = ActivityDefineController.instance:getStartTimeAndEndTime(self._activityType, self._activityId)
	self._isDiscountTime = ActivityshopModel.instance:isActivityInDiscountTime(self._activityId)

	GlobalDispatcher:addListener(GlobalNotify.UpdateActiveShopInfo, self._updateView, self)
	ActivityshopController.instance:getAllShopItemInfo(self._activityType, self._activityId)
	self:ShowSpriteInfo()
	self:CalculationSurplusTime()
	self:_setTitle()
	self:_updateView()
	self:showGlodBar()
end

function DragontrailshopView:showGlodBar()
	local iconCfg = ActivityshopConfig.instance:getCostIcon(self._activityType, self._activityId)
	local btn_list = {}

	if iconCfg then
		local accounts = string.split(iconCfg.icon, "#")

		for _, v in ipairs(accounts) do
			table.insert(btn_list, {
				showAdd = true,
				id = v
			})
		end
	elseif self._curViewDatas and self._curViewDatas[1] then
		table.insert(btn_list, {
			showAdd = true,
			id = self._curViewDatas[1].sellPrice
		})
	end

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list)
end

function DragontrailshopView:ShowSpriteInfo()
	settimer(1, self.CalculationSurplusTime, self, true)
end

function DragontrailshopView:CalculationSurplusTime()
	local time = self._actEndTime

	self.supTimer = math.max(0, time - ServerTime.now())
	self.supTimer = self.supTimer - 1

	if self.supTimer < 0 then
		self._txtLeftTime.text = "当前活动结束"

		removetimer(self.CalculationSurplusTime, self)

		return
	end

	local days, hour, min, sec = GameUtil.getTimeDDHHMMSS(self.supTimer)

	self._txtLeftTime.text = self.supTimer > 86400 and string.format("活动剩余时间：%s天%s小时%s分", days, hour, min) or string.format("活动剩余时间：%s小时%s分%s秒", hour, min, sec)
end

function DragontrailshopView:_updateView()
	local dataList = ActivityshopConfig.instance:getActivityShopCfg(self._activityType, self._activityId)
	local list1 = {}
	local list2 = {}
	local list3 = {}
	local sellOut = false

	for i, v in ipairs(dataList) do
		sellOut = false

		if v.sellPeriodLimit ~= "none" then
			local buyTime = ActivityshopModel.instance:getActiveShopBuyTimes(self._activityType, self._activityId, v.shopItemId)

			if buyTime >= v.sellLimitCount then
				sellOut = true

				table.insert(list2, v)
			end
		end

		if not sellOut then
			if PayShopController.instance:checkTimeStr(v.sellTime) then
				table.insert(list1, v)
			else
				table.insert(list3, v)
			end
		end
	end

	for i, v in ipairs(list3) do
		table.insert(list1, v)
	end

	for i, v in ipairs(list2) do
		table.insert(list1, v)
	end

	self._curViewDatas = list1

	self:reloadData()
end

function DragontrailshopView:_getPath()
	return {
		cellPath = "cell",
		viewPath = "tableview"
	}
end

function DragontrailshopView:_clearTableview(cell)
	local goodsTranGo = goutil.findChild(cell, "goodsTranGo")
	local consumeImaGo = goutil.findChild(cell, "price/txtPrice/coin")

	MaterialMgr.resetAll(goodsTranGo)
	MaterialMgr.resetAll(consumeImaGo)
end

function DragontrailshopView:_updateCell(view, cell, data)
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local limitTxt = goutil.findChildTextComponent(cell, "txtLimit")
	local goodsTranGo = goutil.findChild(cell, "item")
	local buyOutGo = goutil.findChild(cell, "sellOut")
	local buyLimit = goutil.findChild(cell, "buyLimit")
	local consumeImaGo = goutil.findChild(cell, "price/txtPrice/coin")
	local txtPrice = goutil.findChildTextComponent(cell, "price/txtPrice")
	local txtDiscount = goutil.findChildTextComponent(cell, "price/txtDiscount")
	local goRate = goutil.findChild(cell.gameObject, "rate")
	local txtRate = goutil.findChildTextComponent(cell.gameObject, "rate/txtRate")

	MaterialMgr.resetAll(goodsTranGo)

	local itemId = data.shopItemId
	local activityId = data.activityId
	local matSplitList = string.split(data.sellContent, ":")
	local goodsType = checknumber(matSplitList[1])
	local goodsId = checknumber(matSplitList[2])
	local cfg = MaterialMgr.getMatCfg(goodsType, goodsId)
	local colorStr = MaterialMgr.getGoodsColor(goodsType, goodsId)

	txtName.text = string.format("<color=%s>%s</color>", colorStr, data.name)

	if self._isDiscountTime then
		local showDisc = not string.nilorempty(data.discountPrice)

		goutil.setActive(txtDiscount.gameObject, showDisc)

		local sellOut = false
		local buyTime = ActivityshopModel.instance:getActiveShopBuyTimes(self._activityType, self._activityId, itemId)

		if data.sellPeriodLimit ~= "none" then
			sellOut = buyTime >= data.sellLimitCount
		end

		self:_setLimitTxt(itemId, limitTxt)

		local content = data.sellContent

		if string.find(data.sellContent, "^" .. MatType.Cloth .. ":") then
			local arr = string.split(data.sellContent, "#")

			content = arr[RoleModel.instance:getGender() + 1]
		end

		local subLua = MaterialMgr.setCellByCfg(content, goodsTranGo)

		buyOutGo:SetActive(sellOut)
		buyLimit:SetActive(false)

		if not sellOut and not string.nilorempty(data.sellTime) and not PayShopController.instance:checkTimeStr(data.sellTime) then
			-- block empty
		end

		local sellPriceSplit = string.split(data.sellPrice, ":")
		local priceType = sellPriceSplit[1] and checknumber(sellPriceSplit[1]) or 104
		local priceId = sellPriceSplit[2] and checknumber(sellPriceSplit[2]) or 1

		if not sellPriceSplit[3] then
			local priceCount = 100

			goutil.setActive(goRate, showDisc)

			txtPrice.text = MaterialFacade.instance:getGoodCost(priceType, priceId, priceCount)

			if showDisc then
				txtRate.text = string.format("%s折", data.discountNum / 10)
				txtDiscount.text = MaterialFacade.instance:getGoodCostByStr(data.discountPrice)
			end

			MaterialMgr.setIcon(consumeImaGo, priceType, priceId)
			GameUtil.asBtn(cell):AddClickListener(function()
				if isNo then
					FloatWordMgr.instance:show("兑换已达上限！")

					return
				end

				if sellOut then
					FloatWordMgr.instance:show("已售罄")

					return
				end

				if string.nilorempty(data.sellTime) or not PayShopController.instance:checkTimeStr(data.sellTime) then
					if not string.nilorempty(data.notSellTimeTips) then
						TipsFacade.instance:openCommonTips(data.notSellTimeTips)
					end

					return
				end

				local haveNum = MaterialModel.instance:getMaterialsNumber(priceType, priceId) or 0

				if priceType == MatType.Diamond_Consume then
					priceType = MatType.Diamond
					priceId = MatType.Diamond_Binding
				end

				if ((priceType == MatType.Diamond or nil) and RoleModel.instance:getPayDiamond() + RoleModel.instance:getPresentDiamond()) < checknumber(priceCount) then
					local cfg = MaterialMgr.getMatCfg(priceType, priceId)

					if cfg then
						FloatWordMgr.instance:show(string.format("所需%s不足！", cfg.name))
					else
						FloatWordMgr.instance:show("所需货币不足！")
					end
				else
					UIStateManager.instance:push(ViewName.ActivityshopexchangebuyView, self._activityType, activityId, itemId)
				end
			end, self)
		end
	end
end

function DragontrailshopView:_getLimitTypeStr(str)
	if string.nilorempty(str) or str == "none" then
		return ""
	end

	if str == "daily" then
		return "每日限购 %s/%s"
	end

	if str == "allTime" then
		return "活动限购 %s/%s"
	end

	if str == "weekly" then
		return "每周限购 %s/%s"
	end
end

function DragontrailshopView:_setTitle()
	self._titleTxt.text = ActivityshopConfig.instance:getActShopTitleName(self._activityType, self._activityId)
end

function DragontrailshopView:_setLimitTxt(itemId, limitTxt)
	local data = ActivityshopConfig.instance:getActivityShopCfgByItemId(self._activityType, self._activityId, itemId)

	if PayShopController.instance:checkTimeStr(data.sellTime) then
		local buyTime = ActivityshopModel.instance:getActiveShopBuyTimes(self._activityType, self._activityId, itemId)
		local limitStr = self:_getLimitTypeStr(data.sellPeriodLimit)
		local finalStr = ""

		if not string.nilorempty(limitStr) then
			finalStr = (data.sellPeriodLimit ~= "none" or nil) and buyTime >= data.sellLimitCount and finalStr .. "\n" .. string.format(limitStr, 0, data.sellLimitCount) or finalStr .. "\n" .. string.format(limitStr, data.sellLimitCount - buyTime, data.sellLimitCount)
		end

		if data.activityLimitCount > 0 then
			local buyTime = ActivityshopModel.instance:getActiveShopBuyTimesInActivity(self._activityType, self._activityId, itemId)

			finalStr = finalStr .. "\n" .. string.format("活动限兑：%s/%s", data.activityLimitCount - buyTime, data.activityLimitCount)
		end

		limitTxt.text = string.trim(finalStr)
	elseif data.sellTime == "全天" then
		limitTxt.text = ""
	else
		local arr = string.split(data.sellTime, "|")
		local type = arr[1]
		local timeStr = arr[2]

		if type == "时段" then
			local tem = string.split(timeStr, ",")
			local timeStart = GameUtil.string2time(tem[1])
			local time = timeStart - ServerTime.nowServerLook()

			limitTxt.text = time > 0 and string.format("%s天后开始售卖", math.ceil(time / 86400)) or "未开始售卖"
		else
			limitTxt.text = "未开始售卖"
		end
	end
end

return DragontrailshopView
