-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/paytempt/view/PaytemptView.lua

module("logic.extensions.paytempt.view.PaytemptView", package.seeall)

local PaytemptView = class("PaytemptView", ViewComponent)

function PaytemptView:ctor()
	PaytemptView.super.ctor(self)
end

function PaytemptView:buildUI()
	PaytemptView.super.buildUI(self)

	self.cell = self:getGo("itemcell")
	self.itemCon = self:getGo("itemCon")
	self.img = self:getGo("img")
	self.btnClose = self:getGo("btnClose")
	self.btnMoney = self:getGo("btnMoney")
	self.txtMoney = self:getTxt("btnMoney/txtMoney")
	self.txtChargeTip = self:getTxt("txtChargeTip")
	self.imgNum = goutil.findChildComponent(self.mainGO, "title/type1/imgNum", typeof(UIImgNumeralText))
	self.type1Go = self:getGo("title/type1")
	self.type2Go = self:getGo("title/type2")
	self.sloganCon = self:getGo("title/type2/sloganCon")
	self.txtTime = self:getTxt("title/txtTime")
	self.btnR = self:getGo("btnR")
	self.btnL = self:getGo("btnL")
	self._pagCon = self:getGo("pagCon")
	self._pagConCell = self:getGo("dot")

	GameUtil.SetActive(self.cell, false)
	GameUtil.SetActive(self._pagConCell, false)
end

function PaytemptView:bindEvents()
	PaytemptView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.onClose, self)
	GameUtil.addClickHandler(self.btnMoney, self.onBuy, self)
	GameUtil.addClickHandler(self.btnR, self.onBtnR, self)
	GameUtil.addClickHandler(self.btnL, self.onBtnL, self)
end

function PaytemptView:unbindEvents()
	PaytemptView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnMoney)
	GameUtil.rmClickHandler(self.btnR)
	GameUtil.rmClickHandler(self.btnL)
end

function PaytemptView:destroyUI()
	PaytemptView.super.destroyUI(self)
end

function PaytemptView:onClose()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.CLICK_JINGZHUN_CLOSE)
	self:close()
end

function PaytemptView:onEnter()
	PaytemptView.super.onEnter(self)

	self._pagConCellList = {}

	SurveyController.instance:reportBehavior(SurveyBehaviorID.CLICK_JINGZHUN_OPEN)
	PaytemptController.instance:registerNotify(PaytemptController.PAYTEMPT_GOODS_UPDATE, self.showNextOrClose, self)

	local actId = FirstChargeModel.instance:getCurActivityId()

	FirstChargeController.instance:sendGetInfoReq(actId, self._updateChargeTip, self)
	self:showNextOrClose()
	self:onTimer()
	settimer(1, self.onTimer, self)
	GlobalDispatcher:addListener(PayAgent.NotifyPayResultRes, self.handleNotifyPayResultRes, self)
end

function PaytemptView:onEnterFinished()
	PaytemptView.super.onEnterFinished(self)
end

function PaytemptView:onExit()
	PaytemptController.instance:unregisterNotify(PaytemptController.PAYTEMPT_GOODS_UPDATE, self.showNextOrClose, self)
	PaytemptView.super.onExit(self)
	removetimer(self.onTimer, self)
	self:clearItems()
	self:_clearPagConCellList()
	GlobalDispatcher:removeListener(PayAgent.NotifyPayResultRes, self.handleNotifyPayResultRes, self)
end

function PaytemptView:onExitFinished()
	PaytemptView.super.onExitFinished(self)
	uGuiUtil.clearImage(self.img.gameObject)
end

function PaytemptView:showItems(itemsStr)
	self:clearItems()

	local arr = string.split(itemsStr, "#")

	for i, v in ipairs(arr) do
		local cell = goutil.clone(self.cell, "cell" .. i)

		GameUtil.SetActive(cell, true)

		local con = goutil.findChild(cell, "con")

		MaterialMgr.setCellByCfg(v, con)
		goutil.addChildToParent(cell, self.itemCon)
	end
end

function PaytemptView:clearItems()
	local trs = self.itemCon.transform

	if trs ~= nil and trs.childCount > 0 then
		local count = trs.childCount

		for i = count, 1, -1 do
			local child = trs:GetChild(i - 1)
			local con = goutil.findChild(child, "con")

			MaterialMgr.resetAll(con)
			UnityEngine.GameObject.Destroy(child.gameObject)
		end

		trs:DetachChildren()
	end
end

function PaytemptView:refreshUI(isTimer)
	self.info = nil

	GameUtil.SetActive(self.btnL, false)
	GameUtil.SetActive(self.btnR, false)
	GameUtil.SetActive(self._pagCon, false)
	GameUtil.SetActive(self.type1Go, false)
	GameUtil.SetActive(self.type2Go, false)
	self:clearItems()

	if self.dataList then
		GameUtil.SetActive(self.btnL, self.currIndex > 1)
		GameUtil.SetActive(self.btnR, self.currIndex < #self.dataList)
		GameUtil.SetActive(self._pagCon, #self.dataList > 1)

		self.info = self.dataList[self.currIndex]

		if self.info then
			local cfg

			if self.info.type == PaytemptModel.TYPE_CLIENT then
				cfg = PaytemptConfig.instance:getClientCfgById(self.info.id)

				if cfg then
					if checknumber(cfg.slogantype) == 0 then
						GameUtil.SetActive(self.type1Go, true)
						self.imgNum:SetText(cfg.rebate)
					else
						GameUtil.SetActive(self.type2Go, true)
						goutil.clearChildren(self.sloganCon)

						local arr = string.split(cfg.sloganImg, "#")

						for i, v in ipairs(arr or {}) do
							local go = goutil.create("img_" .. i, true)

							goutil.addChildToParent(go, self.sloganCon)
							uGuiUtil.setSpriteToImage(go.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgPngUrl("gift/slogan/" .. v), function()
								go.gameObject:GetComponent("Image"):SetNativeSize()
							end)
						end
					end

					uGuiUtil.setSpriteToImage(self.img.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("gift", cfg.bigBgImg), function()
						self.img.gameObject:GetComponent("Image"):SetNativeSize()
					end)

					local mibaoCfg = PayShopConfig.instance:getPayShopGoodsCfgById(cfg.shopId)

					self:showItems(mibaoCfg.content)

					local payCfg = PayConfig.instance:getPayGoodsCfg(mibaoCfg.goodsId)

					if payCfg then
						local cost = payCfg.payMoney / 100

						self.txtMoney.text = "￥" .. cost
					end
				end
			else
				cfg = PaytemptConfig.instance:getCfgById(self.info.id)

				if cfg then
					if checknumber(cfg.slogantype) == 0 then
						GameUtil.SetActive(self.type1Go, true)
						self.imgNum:SetText(cfg.rebate)
					else
						GameUtil.SetActive(self.type2Go, true)
						goutil.clearChildren(self.sloganCon)

						local arr = string.split(cfg.sloganImg, "#")

						for i, v in ipairs(arr or {}) do
							local go = goutil.create("img_" .. i, true)

							goutil.addChildToParent(go, self.sloganCon)
							uGuiUtil.setSpriteToImage(go.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgPngUrl("gift/slogan/" .. v), function()
								go.gameObject:GetComponent("Image"):SetNativeSize()
							end)
						end
					end

					uGuiUtil.setSpriteToImage(self.img.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgPngUrl("gift/board_tclb_" .. checknumber(cfg.imgIdx)), function()
						self.img.gameObject:GetComponent("Image"):SetNativeSize()
					end)

					local payCfg = PayConfig.instance:getPayGoodsCfg(cfg.goodsId)

					if payCfg then
						local cost = payCfg.payMoney / 100

						self.txtMoney.text = "￥" .. cost
					end

					self:showItems(cfg.giftContent)
				end
			end
		else
			self:closeView(isTimer)
		end

		self:_refreshPagCon()
	else
		self:closeView(isTimer)
	end
end

function PaytemptView:closeView(isTimer)
	if isTimer then
		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("当前活动时间已经结束，请下次再来吧"), function()
			self:close()
		end)
	else
		self:close()
	end
end

function PaytemptView:onTimer()
	if self.info then
		local now = ServerTime.now()
		local left = checknumber(self.info.endTimeMillis) / 1000 - now

		if left > 0 then
			self.txtTime.text = GameUtil.FormatTimeSymbol(left)
		else
			TipsFacade.instance:openCommonTips("当前活动已经结束")
			self:showNextOrClose(true)
		end
	else
		self.txtTime.text = "--:--:--"
	end
end

function PaytemptView:showNextOrClose(isTimer)
	self.dataList = PaytemptModel.instance:getCurrShowList()
	self.currIndex = 1

	self:refreshUI(isTimer)
end

function PaytemptView:onBtnR()
	self.currIndex = self.currIndex + 1
	self.currIndex = math.min(#self.dataList, self.currIndex)

	self:refreshUI()
end

function PaytemptView:onBtnL()
	self.currIndex = self.currIndex - 1
	self.currIndex = math.max(1, self.currIndex)

	self:refreshUI()
end

function PaytemptView:onBuy()
	if self.info then
		if self.info.type == PaytemptModel.TYPE_CLIENT then
			local cfg = PaytemptConfig.instance:getClientCfgById(self.info.id)
			local mibaoCfg = PayShopConfig.instance:getPayShopGoodsCfgById(cfg.shopId)

			PayController.instance:pay(mibaoCfg.goodsId, GameEnum.PaySubGoodsType.PAY_SHOP, cfg.shopId)
		else
			local cfg = PaytemptConfig.instance:getCfgById(self.info.id)

			PayController.instance:pay(cfg.goodsId, GameEnum.PaySubGoodsType.PAY_TEMPT, self.info.id)
		end
	end
end

function PaytemptView:_updateChargeTip()
	local actId = FirstChargeModel.instance:getCurActivityId()
	local firstChargeCfgs = FirstChargeModel.instance:getCurActCfgs(actId)
	local curmoney = FirstChargeModel.instance:getChargeMoney(actId)
	local totalIndex = #firstChargeCfgs

	if curmoney >= firstChargeCfgs[totalIndex].consumeMoney then
		self.txtChargeTip.text = ""
	elseif curmoney <= 0 then
		self.txtChargeTip.text = "充值6元，即可领取首充奖励"
	else
		for _, v in ipairs(firstChargeCfgs) do
			if curmoney < v.consumeMoney then
				self.txtChargeTip.text = string.format("再充值%s元，即可领取更多首充奖励", (v.consumeMoney - curmoney) / 100)

				return
			end
		end
	end
end

function PaytemptView:handleNotifyPayResultRes(status, msg)
	if status == 0 then
		local actId = FirstChargeModel.instance:getCurActivityId()

		FirstChargeController.instance:sendGetInfoReq(actId, self._updateChargeTip, self)
	end
end

function PaytemptView:_clearPagConCellList()
	for k, v in pairs(self._pagConCellList) do
		if v then
			GameUtil.asBtn(v.go):RemoveClickListener()
			goutil.destroy(v.go)
		end
	end

	self._pagConCellList = {}
end

function PaytemptView:_refreshPagCon()
	self:_clearPagConCellList()

	for i = 1, #self.dataList do
		local list = {}

		list.go = goutil.cloneAndSetParent(self._pagConCell, self._pagCon.transform)
		list.select = goutil.findChild(list.go, "select")
		list.txt = goutil.findChildTextComponent(list.go, "txt")
		list.idx = i
		list.txt.text = i

		GameUtil.asBtn(list.go):RemoveClickListener()
		GameUtil.asBtn(list.go):AddClickListener(function()
			self.currIndex = list.idx

			self:refreshUI()

			for k, v in pairs(self._pagConCellList) do
				goutil.setActive(v.select, self.currIndex == v.idx)
			end
		end)
		goutil.setActive(list.select, self.currIndex == list.idx)
		goutil.setActive(list.go, true)

		self._pagConCellList[i] = list
	end
end

return PaytemptView
