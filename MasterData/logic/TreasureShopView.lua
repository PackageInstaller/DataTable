-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sevendays/view/TreasureShopView.lua

module("logic.extensions.sevendays.view.TreasureShopView", package.seeall)

local TreasureShopView = class("TreasureShopView", TableViewComponent)

function TreasureShopView:ctor()
	TreasureShopView.super.ctor(self)
end

function TreasureShopView:onExitFinished()
	return
end

function TreasureShopView:onEnterFinished()
	return
end

function TreasureShopView:buildUI()
	TreasureShopView.super.buildUI(self)

	self._bgBlur = self:getGo("blurBg"):GetComponent(typeof(UnityEngine.UI.RawImage))
	self.viewBgGo = self:getGo("viewBgGo")

	local upInfoGo = self:getGo("upInfoTran")

	self.closeClickBtn = Framework.ButtonAdapter.GetFrom(upInfoGo, "closeClickBtn")
	self.supTimeTxt = goutil.findChildTextComponent(upInfoGo, "supTimeIma/supTimeTxt")
	self.daibiIconIma = goutil.findChild(upInfoGo, "diabiItem/daibiIconIma"):GetComponent("Image")
	self.daibiCountTxt = goutil.findChild(upInfoGo, "diabiItem/daibiCountTxt"):GetComponent("Text")
	self.daibiAddBtn = Framework.ButtonAdapter.GetFrom(upInfoGo, "diabiItem/daibiAddBtn")
	self.supTimeTxt.text = ""

	local spriteInfoGo = self:getGo("spriteInfoGo")
	local spriteRawGo = goutil.findChild(spriteInfoGo, "spriteRawIma")

	self.petPhoto = PetPhotoShow.Get(spriteRawGo)
end

function TreasureShopView:bindEvents()
	TreasureShopView.super.bindEvents(self)
	self.closeClickBtn:AddClickListener(function()
		if SevenDaysModel.instance:GetFunctionActivityId() <= 0 then
			UIStateManager.instance:setRoot(ViewName.MainUI)
			UIStateManager.instance:clear(true)
		else
			self:close()
		end
	end, self)
	self.daibiAddBtn:AddClickListener(function()
		local cfg = FuncOpenConfig.instance:getFunctionOpenById(95)

		if not FuncOpenModel.instance:getFuncIsOpen(cfg.funcId) then
			FloatWordMgr.instance:show(cfg.lockedTips)

			return
		end

		PayShopController.instance:openView(GameEnum.PayShopEasyJump.Recharge)
	end, self)
end

function TreasureShopView:unbindEvents()
	TreasureShopView.super.unbindEvents(self)
	self.closeClickBtn:RemoveClickListener()
	self.daibiAddBtn:RemoveClickListener()
end

function TreasureShopView:_setBlurBg()
	self._bgBlur:Release()
	self._bgBlur:Capture()
	StaticBluredHook.instance:start(self.mainGO)
	self._bgBlur:AddCaptureFinishListener(self._onCaptureScreenFinish, self)
end

function TreasureShopView:_onCaptureScreenFinish()
	StaticBluredHook.instance:stop()
end

function TreasureShopView:_removeBlurBg()
	StaticBluredHook.instance:stop()
	self._bgBlur:Release()
end

function TreasureShopView:onExit()
	TreasureShopView.super.onExit(self)
	self.petPhoto:clear()
	self:_removeBlurBg()
	removetimer(self.CalculationSurplusTime, self)

	if self.pmEff then
		UIEffectManager.instance:stopEffect(self.pmEff)
	end

	self.pmEff = nil

	GlobalDispatcher:removeListener("UpdataTreBoxBuyInfo", self.UpdataTreBoxBuyInfo, self)
	ClockMgr.instance:removeListener(ClockMgr.TickDailyRefresh, self.TickDailyRefreshData, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnMaterialCountChange, self.OnCurrencyCountChange, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnViewClose, self._onViewClose, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnViewOpenDone, self._onViewOpenDone, self)
end

function TreasureShopView:destroyUI()
	TreasureShopView.super.destroyUI(self)
	self.petPhoto:clear()
end

function TreasureShopView:onEnter()
	TreasureShopView.super.onEnter(self)

	local activityId, timer = SevenDaysModel.instance:CalculationWishingWellOpen(true)

	self.supTimer = timer

	if activityId <= 0 then
		print("sr----天外飞石     TreasureShopView:onEnter()    当前活动时间错误 = " .. activityId)

		self.supTimer = 0
		activityId = 7001
	end

	self:_setBlurBg()
	self:CalculationSurplusTime()
	self:ShowSpriteInfo()
	self:UpdataTreBoxBuyInfo()
	self.petPhoto:showPetEffect(10167, true, 2.5)

	local effPath = "fx_ui_qirirenwu/fx_qirirenwu_pingmu.prefab"

	self.pmEff = UIEffectManager.instance:playEffect(self, effPath, self.viewBgGo, 0, 0, true, nil, nil, nil, self)

	self.pmEff:setParent(self.viewBgGo.transform)
	self.pmEff:setLocalPos(0, 0, 0)
	self.pmEff:setScale(1)
	GlobalDispatcher:addListener("UpdataTreBoxBuyInfo", self.UpdataTreBoxBuyInfo, self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self.TickDailyRefreshData, self)
	GlobalDispatcher:addListener(GlobalNotify.OnMaterialCountChange, self.OnCurrencyCountChange, self)
	GlobalDispatcher:addListener(GlobalNotify.OnViewClose, self._onViewClose, self)
	GlobalDispatcher:addListener(GlobalNotify.OnViewOpenDone, self._onViewOpenDone, self)
end

function TreasureShopView:_onViewClose(view)
	return
end

function TreasureShopView:_onViewOpenDone(view)
	return
end

function TreasureShopView:ShowSpriteInfo()
	settimer(1, self.CalculationSurplusTime, self, true)
	self.petPhoto:playShowAnim()
end

function TreasureShopView:OnCurrencyCountChange()
	if self.daibiCountTxt == nil or RoleModel.instance == nil then
		return
	end

	local num = RoleModel.instance:getPayDiamond() + RoleModel.instance:getPresentDiamond()

	self.daibiCountTxt.text = tostring(num)
end

function TreasureShopView:CalculationSurplusTime()
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

function TreasureShopView:TickDailyRefreshData()
	removetimer(self.CalculationSurplusTime, self)
	self:UpdataTreBoxBuyInfo()
	settimer(1, self.CalculationSurplusTime, self, true)
end

function TreasureShopView:UpdataTreBoxBuyInfo()
	if SevenDaysModel.instance:GetFunctionActivityId() <= 0 then
		return
	end

	self:OnCurrencyCountChange()

	self._curViewDatas = SevenDaysModel.instance:GetAllShopGoodsList()

	self._tableview:ReloadData()
end

function TreasureShopView:_getPath()
	return {
		cellPath = "viewBgGo/buyItem",
		viewPath = "viewBgGo/buyGoodsSR"
	}
end

function TreasureShopView:_cellSize()
	return 220, 260
end

function TreasureShopView:_updateCell(view, cell, data)
	local goodsIconGo = goutil.findChild(cell, "goodsIconIma")
	local goodsClickGo = goutil.findChild(cell, "goodsClickGo")
	local buyOutGo = goutil.findChild(cell, "buyOutGo")
	local limitTxt = goutil.findChildTextComponent(cell, "limitBgIma/limitTxt")
	local consumeImaGo = goutil.findChild(cell, "consumeGo/consumeIma")
	local consumeTxt = goutil.findChildTextComponent(cell, "consumeGo/consumeTxt")
	local goodsNameTxt = goutil.findChildTextComponent(cell, "goodsNameTxt")
	local goodsGo_1 = goutil.findChild(cell, "goodsGo_1")
	local goodsGo_2 = goutil.findChild(cell, "goodsGo_2")
	local goodsGo_3 = goutil.findChild(cell, "goodsGo_3")
	local redpointGo = goutil.findChild(cell, "redpointGo")

	MaterialMgr.resetAll(goodsGo_1)
	MaterialMgr.resetAll(goodsGo_2)
	MaterialMgr.resetAll(goodsGo_3)

	local itemId = data.itemId

	uGuiUtil.setSpriteToImage(goodsIconGo, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(data.itemIcon))

	goodsNameTxt.text = data.itemName

	local isNo = data.limitCount > 0 and data.limitCount <= data.buyCount

	buyOutGo:SetActive(isNo)

	local isFree, isDiamd, isRmb = false, false, false

	if not string.nilorempty(data.rmbId) then
		isRmb = true
	elseif string.nilorempty(data.sellPrice) then
		isFree = true
	else
		isDiamd = true
	end

	limitTxt.text = data.limitCount < 1 and "" or isNo and string.format("每日限购%s/%s", 0, data.limitCount) or string.format("每日限购%s/%s", data.limitCount - checknumber(data.buyCount), data.limitCount)

	local priceType, priceId, priceCount = 0, 0, 0

	if isFree then
		consumeImaGo:SetActive(false)

		consumeTxt.text = "免费"

		redpointGo:SetActive(not isNo)
	else
		redpointGo:SetActive(false)
		consumeImaGo:SetActive(isDiamd)

		if isDiamd then
			local list = string.split(data.sellPrice, ":")

			priceType = list[1] and checknumber(list[1]) or 105
			priceId = list[2] and checknumber(list[2]) or 100
			priceCount = list[3] and checknumber(list[3]) or 600

			if priceType == MatType.Diamond_Consume then
				priceCount = GoodsConfig.instance:getCfgPrice(priceId) * priceCount
			end

			consumeTxt.text = tostring(priceCount)

			MaterialMgr.setIcon(consumeImaGo, priceType, priceId)

			local len = StringUtil.GetUtf8Length(tostring(priceCount))

			Framework.TransformUtil.SetLocalPos(consumeImaGo.transform, -25 - (len - 1) * 8, 2, 0)
		else
			local payCfg = PayConfig.instance:getPayGoodsCfg(data.rmbId)

			if payCfg then
				if not payCfg.payMoney then
					local count = 600

					consumeTxt.text = "¥ " .. count * PayModel.RMB_UNIT
				end
			end
		end
	end

	if data.sellContent then
		if not #data.sellContent then
			local subCount = 0

			subCount = subCount > 3 and 3 or subCount

			local posX = 0

			if subCount > 2 then
				posX = -60
			elseif subCount == 2 then
				posX = -35
			end

			for i = 1, subCount do
				local list = string.split(data.sellContent[i], ":")
				local goodsType = checknumber(list[1])
				local goodsId = checknumber(list[2])
				local subLua

				if i == 1 then
					subLua = MaterialMgr.setCell(goodsType, goodsId, goodsGo_1)

					Framework.TransformUtil.SetLocalPos(goodsGo_1.transform, posX, -32, 0)
				elseif i == 2 then
					subLua = MaterialMgr.setCell(goodsType, goodsId, goodsGo_2)

					if subCount == 2 then
						if not -posX then
							local x = 0

							Framework.TransformUtil.SetLocalPos(goodsGo_2.transform, x, -32, 0)
						end
					end
				elseif i == 3 then
					subLua = MaterialMgr.setCell(goodsType, goodsId, goodsGo_3)
				end

				subLua.binder:setNum(checknumber(list[3]))
				GameUtil.setLocalScale(subLua.view, 1, 1, 1)
				Framework.TransformUtil.SetLocalPos(subLua.view.transform, 0, 0, 0)
			end

			GameUtil.asBtn(goodsClickGo):AddClickListener(function()
				if SevenDaysModel.instance:GetFunctionActivityId() <= 0 then
					FloatWordMgr.instance:show("活动已结束，无法购买礼包！")

					return
				end

				ViewMgr.instance:open(ViewName.TreasureBuy, 1, itemId)
			end, self)
		end
	end
end

return TreasureShopView
