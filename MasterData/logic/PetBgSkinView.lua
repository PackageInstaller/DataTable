-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bgskin/view/PetBgSkinView.lua

module("logic.extensions.bgskin.view.PetBgSkinView", package.seeall)

local PetBgSkinView = class("PetBgSkinView", ViewComponent)

function PetBgSkinView:buildUI()
	PetBgSkinView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._skinIconGo = self:getGo("skinIcon")
	self._leftCell = self:getGo("leftCell")

	self._leftCell:SetActive(false)

	self._leftSelectsGo = self:getGo("leftSelects")
	self._items = {}

	for i = 1, 3 do
		local element = {}
		local go = self:getGo("item" .. i)

		element.go = go
		element.btn = Framework.ButtonAdapter.Get(go)
		element.icon = goutil.findChild(go, "icon")
		element.txtNum = goutil.findChildTextComponent(go, "txtNum")
		self._items[i] = element
	end

	self._btnBuy = self:getBtn("btnBuy")
	self._txtPrize = self:getTxt("btnBuy/Text")
	self._txtTime = self:getTxt("txtTime")
end

function PetBgSkinView:bindEvents()
	PetBgSkinView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnBuy:AddClickListener(self._onClickBuy, self)
end

function PetBgSkinView:unbindEvents()
	PetBgSkinView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnBuy:RemoveClickListener()
end

function PetBgSkinView:onEnter()
	PetBgSkinView.super.onEnter(self)
	GlobalDispatcher:addListener(ClockMgr.TickDailyRefresh, self._onFiveClockRefresh, self)
	GlobalDispatcher:addListener(GlobalNotify.NotifyPayShopItemBuySucRes, self.handlePayShopItemBuySucRes, self)

	self._curSelectCfg = nil
	self._funcId = 0

	self:_updateView()
	settimer(1, self._onSecond, self)
end

function PetBgSkinView:onExit()
	PetBgSkinView.super.onExit(self)
	GlobalDispatcher:removeListener(ClockMgr.TickDailyRefresh, self._onFiveClockRefresh, self)
	GlobalDispatcher:removeListener(GlobalNotify.NotifyPayShopItemBuySucRes, self.handlePayShopItemBuySucRes, self)
	removetimer(self._onSecond, self)
end

function PetBgSkinView:onExitFinished()
	for i = 1, 3 do
		MaterialMgr.clearIcon(self._items[i].icon)
	end

	self:_clearLeftBtns()
	self:_clearSkinIcon()
	self:_clearEffect()
end

function PetBgSkinView:_onClickClose()
	self:close()
end

function PetBgSkinView:_onClickBuy()
	if self._hasBuy then
		self._txtPrize.text = "已购买"

		FloatWordMgr.instance:show("已售罄")

		return
	end

	if self._curSelectCfg then
		if not self._curSelectCfg.shopId then
			local id = 0

			if not self._hasBuyTimes then
				printInfo("test 购买id", id)

				local data = {
					id = id,
					times = self._hasBuyTimes
				}

				UIStateManager.instance:push(ViewName.PayShopMibaoBuyView, data)
			end
		end
	end
end

function PetBgSkinView:_updateView()
	self._availableCfgs = self:_getAvailableSkinCfgs()

	if #self._availableCfgs > 0 then
		self:_updateInfo(1, self._availableCfgs[1])
	else
		self:_showClosePopupView()
	end
end

function PetBgSkinView:_getAvailableSkinCfgs()
	local cfgs = PetSkinConfig.instance:getBgSkinCfgs()

	if cfgs then
		local resultList = {}

		for i, v in ipairs(cfgs) do
			local timeStrs = string.split(v.time, "#")

			if timeStrs and timeStrs[1] and timeStrs[2] and GameUtil.checkIsInTimePeriod(timeStrs[1], timeStrs[2]) then
				table.insert(resultList, v)
			end
		end

		return resultList
	else
		return {}
	end
end

function PetBgSkinView:_showClosePopupView()
	removetimer(self._onSecond, self)

	local content = "当前不在活动时间内哦"
	local btnText = "知道了"

	local function func()
		self:_onClickClose()
	end

	TipsFacade.instance:openTipWindow(lang("tip"), content, func, btnText)
end

function PetBgSkinView:_updateInfo(selectIndex, cfg)
	self:_updateLeftSelectBtns(selectIndex)
	self:_updateBuyInfo(cfg)
end

function PetBgSkinView:_updateLeftSelectBtns(selectIndex)
	self:_clearLeftBtns()

	local count = #self._availableCfgs

	self._leftBtnItems = {}

	for i = 1, count do
		local go = goutil.cloneAndSetParent(self._leftCell, self._leftSelectsGo.transform, "btn" .. i)

		go:SetActive(true)

		local element = {}

		element.go = go
		element.selectGo = goutil.findChild(go, "imgSelected")

		element.selectGo:SetActive(i == selectIndex)

		element.txtName = goutil.findChildTextComponent(go, "txtName")
		element.txtName.text = ""
		element.btn = Framework.ButtonAdapter.Get(go)

		element.btn:AddClickListener(function()
			if self._curSelectCfg and self._availableCfgs then
				if self._curSelectCfg.id == self._availableCfgs[i] then
					return
				end

				self:_updateBtnSelect(i)
				self:_updateBuyInfo(self._availableCfgs[i])
			end
		end)
		uGuiUtil.setSpriteToImage(go, uGuiUtil.SpriteType.BigBg, string.format("ui/bigbg/bgskin/%s.png", self._availableCfgs[i].tabImg))

		self._leftBtnItems[i] = element
	end
end

function PetBgSkinView:_updateBtnSelect(index)
	local count = #self._availableCfgs

	for i = 1, count do
		self._leftBtnItems[i].selectGo:SetActive(i == index)
	end
end

function PetBgSkinView:_clearLeftBtns()
	if self._leftBtnItems then
		for i, v in ipairs(self._leftBtnItems) do
			Framework.ImageBigBG.Get(v.go):ClearImage()
		end

		goutil.clearChildren(self._leftSelectsGo)

		self._leftBtnItems = nil
	end
end

function PetBgSkinView:_updateBuyInfo(cfg)
	self:_updateSkinIcon(cfg.bgImg)

	self._curSelectCfg = cfg

	local goodsCfg = PayShopConfig.instance:getPayShopGoodsCfgById(cfg.shopId)

	if goodsCfg then
		self._curGoodsCfg = goodsCfg

		local prizes = MaterialMgr.changeItemStrArr(goodsCfg.content)

		for i = 1, 3 do
			GameUtil.rmClickHandler(self._items[i].icon)
			MaterialMgr.clearIcon(self._items[i].icon)

			if not GameUtil.isEmptyString(prizes[i]) then
				goutil.setActive(self._items[i].go, true)

				self._items[i].matStr = prizes[i]

				MaterialMgr.updateItemByStr(self._items[i].icon, prizes[i])
				GameUtil.addClickHandler(self._items[i].icon, function()
					if self._items and self._items[i] and not goutil.isNil(self._items[i].go) then
						CommonTipsMgr.instance:openTipsByConfStr(self._items[i].go, prizes[i])
					end
				end)

				local matType, matId, matNum = MaterialMgr.getMatParams(prizes[i])

				self._items[i].txtNum.text = matNum <= 1 and "" or "x" .. matNum
			else
				goutil.setActive(self._items[i].go, false)
			end
		end

		self._txtPrize.text = PayConfig.instance:getPayMoneyYuan(goodsCfg.originalGoodsId) .. "元"

		self:_updateBtnBuyInfo()
		self:_updateTimeTxt()
	end
end

function PetBgSkinView:_onFiveClockRefresh()
	self:_updateView()
end

function PetBgSkinView:handlePayShopItemBuySucRes(status, msg)
	if status == 0 then
		self:_updateBtnBuyInfo()
	end
end

function PetBgSkinView:_onSecond()
	self:_updateTimeTxt()
end

function PetBgSkinView:_updateBtnBuyInfo()
	self:_clearEffect()

	if self._curSelectCfg then
		self:_showEffect(self._curSelectCfg)

		local times = PayShopModel.instance:getMibaoBuyTimesById(self._curSelectCfg.shopId)

		self._hasBuyTimes = times

		local goodsCfg = PayShopConfig.instance:getPayShopGoodsCfgById(self._curSelectCfg.shopId)
		local isSellOut = goodsCfg.limitType ~= "none" and goodsCfg.limitTimes > 0 and times and times >= goodsCfg.limitTimes

		self._hasBuy = isSellOut

		GameUtil.SetGray(self.btnBuy, isSellOut)

		if isSellOut then
			self._txtPrize.text = "已购买"
		end
	end
end

function PetBgSkinView:_showEffect(cfg)
	self:_clearEffect()

	if cfg and not string.nilorempty(cfg.effConfig) then
		local effPath = cfg.effConfig
		local eff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, false, nil, function(target, eff)
			return
		end)

		eff:setParent(self.mainGO.transform)
		eff:setLocalPos(0, 0, 0)
		eff:setScale(1)

		self.eff = eff
	end
end

function PetBgSkinView:_clearEffect()
	if self.eff then
		UIEffectManager.instance:stopEffect(self.eff)
	end

	self.eff = nil
end

function PetBgSkinView:_updateTimeTxt()
	if self._curSelectCfg then
		local timeStrs = string.split(self._curSelectCfg.time, "#")

		if timeStrs and timeStrs[1] and timeStrs[2] then
			local startTime = GameUtil.string2time(timeStrs[1])
			local endTime = GameUtil.string2time(timeStrs[2])
			local leftTime = endTime - ServerTime.now()

			leftTime = leftTime > 0 and leftTime or 0
			self._txtTime.text = GameUtil.FormatTimeSymbol(leftTime)
		end
	end
end

function PetBgSkinView:_updateSkinIcon(name)
	uGuiUtil.setSpriteToImage(self._skinIconGo, uGuiUtil.SpriteType.BigBg, string.format("ui/bigbg/bgskin/%s.png", name))
end

function PetBgSkinView:_clearSkinIcon()
	Framework.ImageBigBG.Get(self._skinIconGo):ClearImage()
end

return PetBgSkinView
