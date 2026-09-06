-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doubleeleven/view/SeckillZoneView.lua

module("logic.extensions.doubleeleven.view.SeckillZoneView", package.seeall)

local SeckillZoneView = class("SeckillZoneView", TableViewComponent)

function SeckillZoneView:ctor()
	SeckillZoneView.super.ctor(self)

	self._tabItemList = nil
end

function SeckillZoneView:bindEvents()
	SeckillZoneView.super.bindEvents(self)
end

function SeckillZoneView:unbindEvents()
	SeckillZoneView.super.unbindEvents(self)
end

function SeckillZoneView:onExit()
	SeckillZoneView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.DE_UpdataSeckillZoneInfo, self.reloadData, self)
	removetimer(self._calculationSurplusTime, self)

	if self._pmEff then
		UIEffectManager.instance:stopEffect(self._pmEff)
	end

	self._pmEff = nil
	self._curViewDatas = nil
end

function SeckillZoneView:destroyUI()
	SeckillZoneView.super.destroyUI(self)

	self._tabItemList = nil
end

function SeckillZoneView:buildUI()
	SeckillZoneView.super.buildUI(self)

	self._descTxt = self:getTxt("descTxt")
	self._timeTxt = self:getTxt("timeTxt")
	self._timeBgGo = self:getGo("timeBgGo")
	self._timeBtnGo = self:getGo("timeBtnGo")
	self._tabItemList = {}

	local timeBtnsTran = self:getGo("timeBtnsTran").transform

	for i = 1, timeBtnsTran.childCount do
		local go = timeBtnsTran:GetChild(i - 1).gameObject

		self._tabItemList[i] = {
			itemGo = go,
			itemTxt = goutil.findChildTextComponent(go, "timeBtnTxt"),
			selectGo = goutil.findChild(go, "selectGo")
		}
	end

	self._descTxt.text = ""
	self._timeTxt.text = ""

	GameUtil.SetActive(self._timeBgGo, false)
	GameUtil.SetActive(self._timeBtnGo, false)
end

function SeckillZoneView:onEnter()
	SeckillZoneView.super.onEnter(self)
	removetimer(self._calculationSurplusTime, self)
	GlobalDispatcher:addListener(GlobalNotify.DE_UpdataSeckillZoneInfo, self.reloadData, self)

	self._descTxt.text = lang("text_doubleeleven_desc_1")

	self:_updataTabItemShow()

	local effPath = "fx_ui_qirirenwu/fx_qirirenwu_pingmu.prefab"

	self._pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self._pmEff:setParent(self.mainGO.transform)
	self._pmEff:setLocalPos(0, 0, 0)
	self._pmEff:setScale(1)
end

function SeckillZoneView:_updataTabItemShow()
	self._actId = DoubleElevenConfig.instance:getSeckillZoneActivityId()
	self._tabInfos = DoubleElevenModel.instance:getSeckillZoneTabList()
	self._curIndex = 1

	if self._tabInfos and #self._tabInfos > 0 then
		self._curIndex = #self._tabInfos

		for i = 1, #self._tabInfos do
			if self._tabInfos[i] and (self._tabInfos[i].stage == GameUtil.inTimePeriod or self._tabInfos[i].stage == GameUtil.beforeTimePeriod) then
				self._curIndex = i

				break
			end
		end
	end

	for i = 1, #self._tabItemList do
		GameUtil.asBtn(self._tabItemList[i].itemGo):RemoveClickListener()

		if self._tabInfos and self._tabInfos[i] then
			GameUtil.SetActive(self._tabItemList[i].itemGo, true)

			self._tabItemList[i].itemTxt.text = self._tabInfos[i].tabName

			GameUtil.SetActive(self._tabItemList[i].selectGo, i == self._curIndex)
			uGuiUtil.setTextGrayState(self._tabItemList[i].itemTxt.gameObject, self._tabInfos[i].stage == GameUtil.afterTimePeriod)

			local index = i

			GameUtil.asBtn(self._tabItemList[i].itemGo):AddClickListener(function()
				self:_onClickTabItemBtn(index)
			end, self)
		else
			GameUtil.SetActive(self._tabItemList[i].itemGo, false)
		end
	end

	self:_onClickTabItemBtn(self._curIndex, true)
end

function SeckillZoneView:_onClickTabItemBtn(index, isForce)
	if self._curIndex == index and not isForce then
		return
	end

	if self._tabInfos == nil or self._tabInfos[index] == nil then
		self._tableview:ReloadData()

		return
	end

	self._curViewDatas = {}

	if self._tabItemList[self._curIndex] and self._tabItemList[self._curIndex].selectGo then
		GameUtil.SetActive(self._tabItemList[self._curIndex].selectGo, false)
	end

	if self._tabItemList[index] and self._tabItemList[index].selectGo then
		GameUtil.SetActive(self._tabItemList[index].selectGo, true)
	end

	self._curIndex = index

	local planId = self._tabInfos[self._curIndex].secondSalePlanId

	self._curViewDatas = DoubleElevenConfig.instance:getSeckillZonePlanCfgs(planId)

	self._tableview:ReloadData()
	self:_showActivityTimer()
	DoubleElevenController.instance:csGetSecondSaleInfoReq(self._actId, planId)
end

function SeckillZoneView:_showActivityTimer()
	removetimer(self._calculationSurplusTime, self)

	if self._tabInfos == nil or self._tabInfos[self._curIndex] == nil then
		return
	end

	GameUtil.SetActive(self._timeBgGo, true)

	local info = self._tabInfos[self._curIndex]

	if info.stage == GameUtil.afterTimePeriod then
		self._timeTxt.text = lang("text_doubleeleven_desc_2")

		return
	end

	self._timeDesc = ""
	self._supTime = 0

	local nowTime = ServerTime.nowDateServerLook()
	local now = nowTime.hour * 3600 + nowTime.min * 60 + nowTime.sec

	if info.stage == GameUtil.inTimePeriod then
		self._timeDesc = "text_doubleeleven_desc_3"

		local strs = string.split(info.strEnd, ":")

		self._supTime = checknumber(strs[1]) * 3600 + checknumber(strs[2]) * 60 + checknumber(strs[3]) - now + 2
	elseif info.stage == GameUtil.beforeTimePeriod then
		self._timeDesc = "text_doubleeleven_desc_4"

		local strs = string.split(info.strStart, ":")

		self._supTime = checknumber(strs[1]) * 3600 + checknumber(strs[2]) * 60 + checknumber(strs[3]) - now + 2
	end

	if self._supTime <= 0 or string.nilorempty(self._timeDesc) then
		self._timerTxt.text = "活动结束"

		return
	end

	self:_calculationSurplusTime()
	settimer(1, self._calculationSurplusTime, self, true)
end

function SeckillZoneView:_calculationSurplusTime()
	self._supTime = self._supTime - 1

	if self._supTime <= 0 then
		removetimer(self._calculationSurplusTime, self)

		self._timeTxt.text = ""

		GameUtil.SetActive(self._timeBgGo, false)
		self:_updataTabItemShow()

		return
	end

	local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(self._supTime)

	self._timeTxt.text = langPara(self._timeDesc, hour, min, sec)
end

function SeckillZoneView:_getPath()
	return {
		cellPath = "cellItem",
		viewPath = "itemListSR"
	}
end

function SeckillZoneView:_cellSize()
	return 176, 252
end

function SeckillZoneView:_updateCell(view, cell, data)
	local goodsPos = goutil.findChild(cell, "goodsPos")
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")
	local zhekouGo = goutil.findChild(cell, "zhekouGo")
	local zhekouTxt = goutil.findChildTextComponent(zhekouGo, "zhekouTxt")
	local clickGo = goutil.findChild(cell, "clickGo")
	local qfLimitTxt = goutil.findChildTextComponent(cell, "qfLimitTxt")
	local grLimitTxt = goutil.findChildTextComponent(cell, "grLimitTxt")
	local countTxt = goutil.findChildTextComponent(cell, "countTxt")
	local iconGo = goutil.findChild(cell, "countTxt/iconGo")
	local selloutGo = goutil.findChild(cell, "selloutGo")

	GameUtil.asBtn(clickGo):RemoveClickListener()
	MaterialMgr.resetAll(goodsPos)
	MaterialMgr.resetAll(iconGo)

	local info = DoubleElevenModel.instance:getSeckillZoneBuyCount(self._tabInfos[self._curIndex].secondSalePlanId, data.itemId)
	local qfUse = info and checknumber(info.spaceBuyTimes) or 0
	local grUse = info and checknumber(info.personBuyTimes) or 0

	MaterialMgr.setCellByCfg(data.content, goodsPos)

	local name = MaterialMgr.getMaterialsNameByCfg(data.content)

	nameTxt.text = name

	if string.nilorempty(data.discount) then
		zhekouTxt.text = ""

		GameUtil.SetActive(zhekouGo, false)
	else
		GameUtil.SetActive(zhekouGo, true)

		zhekouTxt.text = data.discount
	end

	local isSellOut = false

	if data.spaceCountLimit >= 99999 then
		qfLimitTxt.text = "不限购"
	else
		qfLimitTxt.text = langPara("text_doubleeleven_desc_5", math.max(0, data.spaceCountLimit - qfUse), data.spaceCountLimit)
		isSellOut = qfUse >= data.spaceCountLimit
	end

	grLimitTxt.text = langPara("text_doubleeleven_desc_6", math.max(0, data.personCountLimit - grUse), data.personCountLimit)

	if string.nilorempty(data.salePrice) then
		countTxt.text = "免费"

		GameUtil.SetActive(iconGo, false)
	else
		GameUtil.SetActive(iconGo, true)

		local matType, matId, matNum = MaterialMgr.getMatParams(data.salePrice)

		countTxt.text = matNum .. MaterialMgr.getMaterialsName(matType, matId)

		MaterialMgr.setIcon(iconGo, matType, matId)
	end

	local isGrLomit = grUse >= data.personCountLimit

	GameUtil.SetActive(selloutGo, isSellOut)

	if isGrLomit or self._tabInfos[self._curIndex].stage == GameUtil.afterTimePeriod then
		uGuiUtil.setTextGrayState(qfLimitTxt.gameObject, true)
		uGuiUtil.setTextGrayState(grLimitTxt.gameObject, true)
		uGuiUtil.setTextGrayState(countTxt.gameObject, true)
		uGuiUtil.setImageGrayState(clickGo, true)
	else
		uGuiUtil.setTextGrayState(qfLimitTxt.gameObject, false)
		uGuiUtil.setTextGrayState(grLimitTxt.gameObject, false)
		uGuiUtil.setTextGrayState(countTxt.gameObject, false)
		uGuiUtil.setImageGrayState(clickGo, false)
	end

	GameUtil.asBtn(clickGo):AddClickListener(function()
		if isSellOut then
			FloatWordMgr.instance:show(lang("text_doubleeleven_desc_7"))

			return
		end

		if isGrLomit then
			FloatWordMgr.instance:show(lang("text_doubleeleven_desc_8"))

			return
		end

		if self._tabInfos[self._curIndex].stage == GameUtil.afterTimePeriod then
			FloatWordMgr.instance:show(lang("text_doubleeleven_desc_12"))

			return
		end

		if self._tabInfos[self._curIndex].stage == GameUtil.beforeTimePeriod then
			FloatWordMgr.instance:show(lang("text_doubleeleven_desc_13"))

			return
		end

		if string.nilorempty(data.salePrice) then
			DoubleElevenController.instance:csGetSecondSaleBuyReq(self._actId, self._tabInfos[self._curIndex].secondSalePlanId, data.itemId)
		else
			local matType, matId, matNum = MaterialMgr.getMatParams(data.salePrice)
			local matStr = matNum .. MaterialMgr.getMaterialsName(matType, matId)
			local content = string.format("确定花费%s购买%s礼包吗？", matStr, name)

			TipsFacade.instance:openPopupCostMatViewNew(matType, matId, matNum, content, function()
				DoubleElevenController.instance:csGetSecondSaleBuyReq(self._actId, self._tabInfos[self._curIndex].secondSalePlanId, data.itemId)
			end)
		end
	end, self)
end

return SeckillZoneView
