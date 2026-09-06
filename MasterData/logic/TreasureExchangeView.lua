-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sevendays/view/TreasureExchangeView.lua

module("logic.extensions.sevendays.view.TreasureExchangeView", package.seeall)

local TreasureExchangeView = class("TreasureExchangeView", TableViewComponent)

function TreasureExchangeView:ctor()
	TreasureExchangeView.super.ctor(self)
end

function TreasureExchangeView:onExitFinished()
	return
end

function TreasureExchangeView:onEnterFinished()
	return
end

function TreasureExchangeView:buildUI()
	TreasureExchangeView.super.buildUI(self)

	self._bgBlur = self:getGo("blurBg"):GetComponent(typeof(UnityEngine.UI.RawImage))
	self.viewBgGo = self:getGo("viewBgGo")

	local spriteInfoGo = self:getGo("spriteInfoGo")
	local spriteRawGo = goutil.findChild(spriteInfoGo, "spriteRawIma")

	self.petPhoto = PetPhotoShow.Get(spriteRawGo)

	local upInfoGo = self:getGo("upInfoTran")

	self.closeClickBtn = Framework.ButtonAdapter.GetFrom(upInfoGo, "closeClickBtn")
	self.diabiItemBtn = Framework.ButtonAdapter.GetFrom(upInfoGo, "diabiItem")
	self.supTimeTxt = goutil.findChildTextComponent(upInfoGo, "supTimeIma/supTimeTxt")
	self.daibiIconGo = goutil.findChild(upInfoGo, "diabiItem/daibiIconIma")
	self.daibiCountTxt = goutil.findChild(upInfoGo, "diabiItem/daibiCountTxt"):GetComponent("Text")
	self.daibiAddBtn = Framework.ButtonAdapter.GetFrom(upInfoGo, "diabiItem/daibiAddBtn")
	self.supTimeTxt.text = ""
end

function TreasureExchangeView:_setBlurBg()
	self._bgBlur:Release()
	self._bgBlur:Capture()
	StaticBluredHook.instance:start(self.mainGO)
	self._bgBlur:AddCaptureFinishListener(self._onCaptureScreenFinish, self)
end

function TreasureExchangeView:_onCaptureScreenFinish()
	StaticBluredHook.instance:stop()
end

function TreasureExchangeView:_removeBlurBg()
	StaticBluredHook.instance:stop()
	self._bgBlur:Release()
end

function TreasureExchangeView:bindEvents()
	TreasureExchangeView.super.bindEvents(self)
	self.closeClickBtn:AddClickListener(function()
		if SevenDaysModel.instance:GetFunctionActivityId() <= 0 then
			UIStateManager.instance:setRoot(ViewName.MainUI)
			UIStateManager.instance:clear(true)
		else
			self:close()
		end
	end, self)
	self.diabiItemBtn:AddClickListener(function()
		if self.goodsInfo == nil or checknumber(self.goodsInfo[1]) < 1 then
			return
		end

		CommonTipsMgr.instance:openMaterialTips(self.diabiItemBtn, self.goodsInfo[1], self.goodsInfo[2])
	end, self)
end

function TreasureExchangeView:unbindEvents()
	TreasureExchangeView.super.unbindEvents(self)
	self.closeClickBtn:RemoveClickListener()
	self.diabiItemBtn:RemoveClickListener()
end

function TreasureExchangeView:onExit()
	TreasureExchangeView.super.onExit(self)
	self.petPhoto:clear()
	self:_removeBlurBg()
	removetimer(self.CalculationSurplusTime, self)

	if self.pmEff then
		UIEffectManager.instance:stopEffect(self.pmEff)
	end

	self.pmEff = nil

	GlobalDispatcher:removeListener("UpdataExchangeBuyInfo", self.UpdataExchangeBuyInfo, self)
	ClockMgr.instance:removeListener(ClockMgr.TickDailyRefresh, self.TickDailyRefreshData, self)
end

function TreasureExchangeView:destroyUI()
	TreasureExchangeView.super.destroyUI(self)
	self.petPhoto:clear()
end

function TreasureExchangeView:onEnter()
	TreasureExchangeView.super.onEnter(self)

	local activityId, timer = SevenDaysModel.instance:CalculationWishingWellOpen(true)

	self.supTimer = timer

	if activityId <= 0 then
		print("sr----天外飞石     TreasureExchangeView:onEnter()    当前活动时间错误 = " .. activityId)

		self.supTimer = 0
		activityId = 7001
	end

	self:_setBlurBg()

	local consumeCfg = TreasureBoxConfig.instance:GetConsumeCfg(activityId)

	self.goodsInfo = {
		10,
		7101
	}

	if consumeCfg and not string.nilorempty(consumeCfg.prize) then
		local list = string.split(consumeCfg.prize, ":")

		if list and #list >= 2 then
			self.goodsInfo[1] = checknumber(list[1])
			self.goodsInfo[2] = checknumber(list[2])
		end
	end

	self:CalculationSurplusTime()
	self:ShowSpriteInfo()
	self:UpdataExchangeBuyInfo()
	self.petPhoto:showPetEffect(10345, true, 2.5)

	local effPath = "fx_ui_qirirenwu/fx_qirirenwu_pingmu.prefab"

	self.pmEff = UIEffectManager.instance:playEffect(self, effPath, self.viewBgGo, 0, 0, true, nil, nil, nil, self)

	self.pmEff:setParent(self.viewBgGo.transform)
	self.pmEff:setLocalPos(0, 0, 0)
	self.pmEff:setScale(1)
	GlobalDispatcher:addListener("UpdataExchangeBuyInfo", self.UpdataExchangeBuyInfo, self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self.TickDailyRefreshData, self)
end

function TreasureExchangeView:ShowSpriteInfo()
	settimer(1, self.CalculationSurplusTime, self, true)
	self.petPhoto:playShowAnim()
end

function TreasureExchangeView:CalculationSurplusTime()
	self.supTimer = self.supTimer - 1

	if self.supTimer < 0 then
		self.supTimeTxt.text = "当前活动结束"

		removetimer(self.CalculationSurplusTime, self)

		return
	end

	local days = 0

	if self.supTimer >= 86400 then
		days = math.floor(self.supTimer / 86400)
	end

	local hour = 0

	if self.supTimer - days * 86400 >= 3600 then
		hour = math.floor((self.supTimer - days * 86400) / 3600)
	end

	local min = 0

	if self.supTimer - days * 86400 - hour * 3600 >= 60 then
		min = math.floor((self.supTimer - days * 86400 - hour * 3600) / 60)
	end

	local sec = self.supTimer - days * 86400 - hour * 3600 - min * 60

	self.supTimeTxt.text = days > 0 and string.format("活动剩余时间：%s天%s小时%s分", days, hour, min) or string.format("活动剩余时间：%s小时%s分%s秒", hour, min, sec)
end

function TreasureExchangeView:TickDailyRefreshData()
	removetimer(self.CalculationSurplusTime, self)
	self:UpdataExchangeBuyInfo()
	settimer(1, self.CalculationSurplusTime, self, true)
end

function TreasureExchangeView:UpdataExchangeBuyInfo()
	if SevenDaysModel.instance:GetFunctionActivityId() <= 0 then
		return
	end

	MaterialMgr.setIcon(self.daibiIconGo, self.goodsInfo[1], self.goodsInfo[2])

	local haveCount = MaterialModel.instance:getMaterialsNumber(self.goodsInfo[1], self.goodsInfo[2])

	self.daibiCountTxt.text = tostring(haveCount)
	self._curViewDatas = SevenDaysModel.instance:GetAllExchangeGoodsList()

	self._tableview:ReloadData()
end

function TreasureExchangeView:_getPath()
	return {
		cellPath = "viewBgGo/buyItem",
		viewPath = "viewBgGo/buyGoodsSR"
	}
end

function TreasureExchangeView:_cellSize()
	return 218, 274
end

function TreasureExchangeView:_updateCell(view, cell, data)
	local goodsNameTxt = goutil.findChildTextComponent(cell, "goodsNameTxt")
	local limitTxt = goutil.findChildTextComponent(cell, "limitBgIma/limitTxt")
	local goodsTranGo = goutil.findChild(cell, "goodsTranGo")
	local buyOutGo = goutil.findChild(cell, "buyOutGo")
	local consumeImaGo = goutil.findChild(cell, "consumeGo/consumeIma")
	local consumeTxt = goutil.findChildTextComponent(cell, "consumeGo/consumeTxt")

	MaterialMgr.resetAll(goodsTranGo)

	local itemId = data.shopItemId
	local activityId = data.activityId
	local goodsType = checknumber(data.sellContent[1])
	local goodsId = checknumber(data.sellContent[2])
	local goodsCount = checknumber(data.sellContent[3])
	local cfg = MaterialMgr.getMatCfg(goodsType, goodsId)

	if cfg then
		local _, colorStr = PetEquipController.instance:GetQualityStrByNum(cfg.quality or 1)

		goodsNameTxt.text = string.format("<color=%s>%s</color>", colorStr, data.name)

		local isNo = false

		if data.sellPeriodLimit ~= "none" then
			isNo = checknumber(data.buyCount) >= data.sellLimitCount
		end

		local limitStr = self:GetLimitTypeStr(data.sellPeriodLimit)

		limitTxt.text = string.nilorempty(limitStr) and "" or isNo and string.format(limitStr, 0, data.sellLimitCount) or string.format(limitStr, data.sellLimitCount - checknumber(data.buyCount), data.sellLimitCount)

		local subLua = MaterialMgr.setCell(goodsType, goodsId, goodsTranGo)

		subLua.binder:setNum(goodsCount)
		buyOutGo:SetActive(isNo)

		local priceType = data.sellPrice[1] and checknumber(data.sellPrice[1]) or 10
		local priceId = data.sellPrice[2] and checknumber(data.sellPrice[2]) or 7101

		if not data.sellPrice[3] then
			local priceCount = "100"

			consumeTxt.text = priceCount

			MaterialMgr.setIcon(consumeImaGo, priceType, priceId)

			local len = StringUtil.GetUtf8Length(priceCount)

			Framework.TransformUtil.SetLocalPos(consumeImaGo.transform, -8 - (len - 1) * 10, 2, 0)
			GameUtil.asBtn(cell):AddClickListener(function()
				if SevenDaysModel.instance:CalculationWishingWellOpen() <= 0 then
					FloatWordMgr.instance:show("活动已结束，无法兑换！")

					return
				end

				if isNo then
					FloatWordMgr.instance:show("兑换已达上限！")

					return
				end

				local matNum = checknumber(priceCount)
				local itemStr = MaterialMgr.createSerName(priceType, priceId)
				local cfg = MaterialMgr.getMatCfg(priceType, priceId)
				local matStr1 = TipsFacade.instance:getContentMatStr(table.concat(data.sellContent, ":"), 80, -10)
				local matStr2 = TipsFacade.instance:getContentMatStr(itemStr, 50, -10, true)
				local content = string.format("兑换 %s 需要消耗<color=#d44c28>%s</color>%sx%s", matStr1, lang(cfg.name), matStr2, matNum)

				TipsFacade.instance:openPopupCostMatViewNew(priceType, priceId, matNum, content, function()
					ActivityshopController.instance:buyShopItem(SevenDaysModel.instance.trboxActivityType, activityId, itemId, 1)
				end)
			end, self)
		end
	end
end

function TreasureExchangeView:GetLimitTypeStr(str)
	if string.nilorempty(str) or str == "none" then
		return
	end

	if str == "daily" then
		return "每日限购 %s/%s"
	end

	if str == "allTime" then
		return "活动限购 %s/%s"
	end
end

return TreasureExchangeView
