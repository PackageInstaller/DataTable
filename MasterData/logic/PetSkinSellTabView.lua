-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firstcharge/view/petskinsell/PetSkinSellTabView.lua

module("logic.extensions.firstcharge.view.petskinsell.PetSkinSellTabView", package.seeall)

local PetSkinSellTabView = class("PetSkinSellTabView", ViewComponent)

function PetSkinSellTabView:buildUI()
	PetSkinSellTabView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._bgImg = self:getImg("bgImg")
	self._sloganImg = self:getImg("sloganImg")
	self._limitImg = self:getImg("limitImg")
	self._roleGo = self:getGo("role")
	self._petPhoto = PetPhotoShow.Get(self._roleGo)
	self._btnSkill = self:getBtn("btnSkill")
	self._bgImgRectTrans = self._bgImg:GetComponent(goutil.Type_RectTransform)
	self._sloganImgRectTrans = self._sloganImg:GetComponent(goutil.Type_RectTransform)
	self._btnSkillRectTrans = self._btnSkill:GetComponent(goutil.Type_RectTransform)
	self._roleRectTrans = self._roleGo:GetComponent(goutil.Type_RectTransform)

	local labelviewGo = goutil.findChild(self.mainGO, "labelview")
	local labelcellGo = goutil.findChild(self.mainGO, "labelcell")
	local updateCell = GameUtil.handler(self._updateLabelCell, self)
	local clearCell = GameUtil.handler(self._clearLabelCell, self)

	self.labelScrollList = ScrollerList.create(labelviewGo, labelcellGo, updateCell, clearCell)

	GameUtil.SetActive(labelcellGo, false)

	self._leftBtnItems = {}
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
	self._txtTime2 = self:getTxt("txtTime2")
	self._txtSkinDesc = self:getTxt("skinDesc")
end

function PetSkinSellTabView:bindEvents()
	PetSkinSellTabView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnBuy:AddClickListener(self._onClickBuy, self)
	self._btnSkill:AddClickListener(self._onClickSkill, self)
end

function PetSkinSellTabView:unbindEvents()
	PetSkinSellTabView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnBuy:RemoveClickListener()
	self._btnSkill:RemoveClickListener()
end

function PetSkinSellTabView:onEnter()
	PetSkinSellTabView.super.onEnter(self)
	GlobalDispatcher:addListener(ClockMgr.TickDailyRefresh, self._onFiveClockRefresh, self)
	GlobalDispatcher:addListener(GlobalNotify.NotifyPayShopItemBuySucRes, self.handlePayShopItemBuySucRes, self)

	self._curSelectCfg = nil
	self._curSelectIndex = self._curSelectIndex or 1

	local id = checknumber(self:getFirstParam())

	if id and id > 0 then
		local list = self:_getAvailableSkinCfgs()

		for i, v in ipairs(list) do
			if v.id == id then
				self._curSelectIndex = i

				break
			end
		end
	end

	self:_updateView()
	settimer(1, self._onSecond, self)
end

function PetSkinSellTabView:onExit()
	PetSkinSellTabView.super.onExit(self)
	GlobalDispatcher:removeListener(ClockMgr.TickDailyRefresh, self._onFiveClockRefresh, self)
	GlobalDispatcher:removeListener(GlobalNotify.NotifyPayShopItemBuySucRes, self.handlePayShopItemBuySucRes, self)
	removetimer(self._onSecond, self)
end

function PetSkinSellTabView:onExitFinished()
	self:_removeRole()

	for i = 1, 3 do
		MaterialMgr.clearIcon(self._items[i].icon)
	end

	self:_clearImage()
	self:_clearLeftBtns()
end

function PetSkinSellTabView:_onClickClose()
	self:close()
end

function PetSkinSellTabView:_onClickBuy()
	if self._curSelectCfg == nil then
		return
	end

	if self._hasBuy then
		self._txtPrize.text = "已购买"

		FloatWordMgr.instance:show("已售罄")

		return
	end

	if self._curSelectCfg.shopType == 1 then
		if self._curSelectCfg then
			if not self._curSelectCfg.shopId then
				local id = 0

				if not self._hasBuyTimes then
					local data = {
						id = id,
						times = self._hasBuyTimes
					}

					UIStateManager.instance:push(ViewName.PayShopMibaoBuyView, data)
				end
			end
		end
	elseif self._curSelectCfg.shopType == 2 then
		local goodsCfg = ActivityPopupConfig.instance:getLyXxCfg(self._curSelectCfg.shopId)
		local price = ""
		local strArr = string.split(goodsCfg.discountCost, ":")

		price = MaterialMgr.getModel(strArr[1], strArr[2]) and goodsCfg.discountPrice or goodsCfg.normalPrice

		local subGoodsType = GameEnum.PaySubGoodsType.LONG_YAN_XI_XI_SKIN
		local subGoodsId = self._curSelectCfg.shopId

		PayController.instance:pay(price, subGoodsType, subGoodsId)

		local status, msg = 0

		self:handlePayShopItemBuySucRes(status, msg)
	end
end

function PetSkinSellTabView:_onClickSkill()
	if self._curSelectCfg == nil then
		return
	end

	local skinId = self:_getSkinId(self._curSelectCfg.shopId)
	local cfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

	if cfg then
		PetbookController.instance:previewBattle(cfg.raceId, skinId)
	end
end

function PetSkinSellTabView:_updateView()
	self._availableCfgs = self:_getAvailableSkinCfgs()

	if #self._availableCfgs > 0 then
		if self._availableCfgs[self._curSelectIndex] == nil then
			self._curSelectIndex = 1
		end

		self._curSelectCfg = self._availableCfgs[self._curSelectIndex]

		self:_onUpdateLabelScroller()
		self:_updateBuyInfo(self._curSelectCfg)
	else
		self:_showClosePopupView()
	end
end

function PetSkinSellTabView:_getAvailableSkinCfgs()
	local cfgs = PetSkinConfig.instance:getPetSkinSellCfgs()

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

function PetSkinSellTabView:_showClosePopupView()
	removetimer(self._onSecond, self)

	local content = "当前不在活动时间内哦"
	local btnText = "知道了"

	local function func()
		self:_onClickClose()
	end

	TipsFacade.instance:openTipWindow(lang("tip"), content, func, btnText)
end

function PetSkinSellTabView:_onUpdateLabelScroller()
	local dataList = {}

	for index, data in ipairs(self._availableCfgs) do
		data.index = index

		table.insert(dataList, data)
	end

	self.labelScrollList:reloadData(dataList)
	self.labelScrollList:refresh()
end

function PetSkinSellTabView:_updateLabelCell(_, cellModel, data, _)
	local element = {}
	local go = cellModel

	element.go = cellModel
	element.selectGo = goutil.findChild(go, "imgSelected")

	element.selectGo:SetActive(data.index == self._curSelectIndex)

	element.txtName = goutil.findChildTextComponent(go, "txtName")
	element.txtName.text = ""
	element.index = data.index
	element.btn = go

	GameUtil.addClickHandler(element.btn, function()
		if self._curSelectCfg and self._availableCfgs then
			if self._curSelectCfg.id == self._availableCfgs[data.index] then
				return
			end

			self._curSelectIndex = data.index
			self._curSelectCfg = self._availableCfgs[data.index]

			self:_updateBtnSelect()
			self:_updateBuyInfo(self._availableCfgs[data.index])
		end
	end)

	local path = string.format("ui/bigbg/bgskin/%s.png", self._availableCfgs[data.index].tabImg)

	uGuiUtil.setSpriteToImage(go, uGuiUtil.SpriteType.BigBg, path)

	self._leftBtnItems[data.index] = element
end

function PetSkinSellTabView:_clearLabelCell(cellGo)
	return
end

function PetSkinSellTabView:_updateBtnSelect()
	for _, v in ipairs(self._leftBtnItems) do
		GameUtil.SetActive(v.selectGo, v.index == self._curSelectIndex)
	end
end

function PetSkinSellTabView:_clearLeftBtns()
	if self._leftBtnItems then
		for _, v in pairs(self._leftBtnItems) do
			uGuiUtil.clearImage(v.go)
			GameUtil.rmClickHandler(v.btn)
		end

		self._leftBtnItems = {}
	end
end

function PetSkinSellTabView:_updateSkinDesc(desc)
	self._txtSkinDesc.text = desc
end

function PetSkinSellTabView:_updateBuyInfo(cfg)
	if cfg == nil then
		return
	end

	self._curSelectCfg = cfg

	self:_updateImage(cfg)
	self:_updateImgRect(cfg)
	self:_loadRole(cfg.shopId)
	self:_updateSkinDesc(cfg.desc)

	local goodsCfg

	if self._curSelectCfg.shopType == 1 then
		goodsCfg = PayShopConfig.instance:getPayShopGoodsCfgById(cfg.shopId)
	elseif self._curSelectCfg.shopType == 2 then
		goodsCfg = ActivityPopupConfig.instance:getLyXxCfg(cfg.shopId)
	end

	if goodsCfg == nil then
		return
	end

	local prizes = ""

	if self._curSelectCfg.shopType == 1 then
		prizes = MaterialMgr.changeItemStrArr(goodsCfg.content)
	elseif self._curSelectCfg.shopType == 2 then
		local skinStr = "17:" .. goodsCfg.skinId .. ":-1:1"
		local content = skinStr .. "#" .. goodsCfg.extraPrize

		prizes = MaterialMgr.changeItemStrArr(content)
	end

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

	local value = 0

	if self._curSelectCfg.shopType == 1 then
		value = PayConfig.instance:getPayMoneyYuan(goodsCfg.originalGoodsId)
	elseif self._curSelectCfg.shopType == 2 then
		local price = ""

		if not string.nilorempty(goodsCfg.discountCost) then
			local strArr = string.split(goodsCfg.discountCost, ":")

			price = MaterialMgr.getModel(strArr[1], strArr[2]) and goodsCfg.discountPrice or goodsCfg.normalPrice
		else
			price = goodsCfg.normalPrice
		end

		value = PayConfig.instance:getPayMoneyYuan(price)
	end

	self._txtPrize.text = value .. "元"

	self:_updateBtnBuyInfo()
	self:_updateTimeTxt()
end

function PetSkinSellTabView:_onFiveClockRefresh()
	self:_updateView()
end

function PetSkinSellTabView:handlePayShopItemBuySucRes(status, msg)
	if status == 0 then
		self:_updateBtnBuyInfo()
	end
end

function PetSkinSellTabView:_onSecond()
	self:_updateTimeTxt()
end

function PetSkinSellTabView:_updateBtnBuyInfo()
	if self._curSelectCfg == nil then
		return
	end

	if self._curSelectCfg.shopType == 1 then
		local times = PayShopModel.instance:getMibaoBuyTimesById(self._curSelectCfg.shopId)

		self._hasBuyTimes = times

		local goodsCfg = PayShopConfig.instance:getPayShopGoodsCfgById(self._curSelectCfg.shopId)

		self._hasBuy = goodsCfg.limitType ~= "none" and goodsCfg.limitTimes > 0 and times and times >= goodsCfg.limitTimes
	elseif self._curSelectCfg.shopType == 2 then
		self._hasBuyTimes = 999999

		local skinId = self:_getSkinId(self._curSelectCfg.shopId)

		self._hasBuy = PetskinController.instance:checkHasForeverSkinBySkinId(skinId)
	end

	GameUtil.SetGray(self._btnBuy.gameObject, self._hasBuy)

	if self._hasBuy then
		self._txtPrize.text = "已购买"
	end
end

function PetSkinSellTabView:_updateTimeTxt()
	if self._curSelectCfg == nil then
		return
	end

	local timeStrs = string.split(self._curSelectCfg.time, "#")

	if timeStrs and timeStrs[1] and timeStrs[2] then
		local startTime = GameUtil.string2time(timeStrs[1])
		local endTime = GameUtil.string2time(timeStrs[2])
		local startDate = GameUtil.time2date(startTime)
		local endDate = GameUtil.time2date(endTime)
		local leftTime = endTime - ServerTime.now()

		leftTime = leftTime > 0 and leftTime or 0
		self._txtTime.text = GameUtil.FormatTimeSymbol(leftTime)
		self._txtTime2.text = string.format("%02d月%02d日 ~ %02d月%02d日", startDate.month, startDate.day, endDate.month, endDate.day)
	end
end

function PetSkinSellTabView:_updateImage(cfg)
	uGuiUtil.setSpriteToImage(self._bgImg.gameObject, uGuiUtil.SpriteType.BigBg, string.format("ui/bigbg/bgskin/%s.png", cfg.bgImg), function()
		if not goutil.isNil(self._bgImg) then
			self._bgImg:SetNativeSize()
		end
	end)
	uGuiUtil.setSpriteToImage(self._sloganImg.gameObject, uGuiUtil.SpriteType.BigBg, string.format("ui/bigbg/bgskin/%s.png", cfg.sloganImg), function()
		if not goutil.isNil(self._sloganImg) then
			self._sloganImg:SetNativeSize()
		end
	end)
	uGuiUtil.setSpriteToImage(self._limitImg.gameObject, uGuiUtil.SpriteType.BigBg, string.format("ui/bigbg/bgskin/%s.png", cfg.limitImg), function()
		if not goutil.isNil(self._limitImg) then
			self._limitImg:SetNativeSize()
		end
	end)
end

function PetSkinSellTabView:_clearImage()
	Framework.ImageBigBG.Get(self._bgImg.gameObject):ClearImage()
	Framework.ImageBigBG.Get(self._sloganImg.gameObject):ClearImage()
	Framework.ImageBigBG.Get(self._limitImg.gameObject):ClearImage()
end

function PetSkinSellTabView:_updateImgRect(cfg)
	Framework.TransformUtil.SetAnchoredPos(self._bgImgRectTrans, cfg.bgPos[1], cfg.bgPos[2])
	Framework.TransformUtil.SetAnchoredPos(self._sloganImgRectTrans, cfg.sloganPos[1], cfg.sloganPos[2])
	Framework.TransformUtil.SetAnchoredPos(self._btnSkillRectTrans, cfg.skillIconPos[1], cfg.skillIconPos[2])
	Framework.TransformUtil.SetAnchoredPos(self._roleRectTrans, cfg.rolePos[1], cfg.rolePos[2])
	Framework.TransformUtil.SetLocalScale(self._roleRectTrans, cfg.roleScale[1], cfg.roleScale[2], cfg.roleScale[3])

	self._roleRectTrans.sizeDelta = Vector2.New(cfg.roleRect[1], cfg.roleRect[2])
end

function PetSkinSellTabView:_getSkinId(shopId)
	local skinId = 0

	if self._curSelectCfg.shopType == 1 then
		local cfg = PayShopConfig.instance:getPayShopGoodsCfgById(shopId)

		if not cfg then
			return 0
		end

		local arr = string.split(cfg.content, "#")
		local itemArr = string.split(arr[1], ":")

		skinId = itemArr[2] or 0
	elseif self._curSelectCfg.shopType == 2 then
		local cfg = ActivityPopupConfig.instance:getLyXxCfg(shopId)

		skinId = cfg and cfg.skinId or 0
	end

	return checknumber(skinId)
end

function PetSkinSellTabView:_loadRole(shopId)
	local skinId = self:_getSkinId(shopId)

	self._petPhoto:showPetEffect(skinId, true, 5)
end

function PetSkinSellTabView:_removeRole()
	if self._petPhoto then
		self._petPhoto:clear()
	end
end

return PetSkinSellTabView
