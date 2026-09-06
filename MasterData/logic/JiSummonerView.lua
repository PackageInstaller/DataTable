-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jisummoner/view/JiSummonerView.lua

module("logic.extensions.jisummoner.view.JiSummonerView", package.seeall)

local JiSummonerView = class("JiSummonerView", ViewComponent)

function JiSummonerView:ctor()
	JiSummonerView.super.ctor(self)

	self._leftBtnsList = nil
	self._choiseIndex = nil
	self._currencyList = nil
	self._barGoodslist = nil
end

function JiSummonerView:bindEvents()
	JiSummonerView.super.bindEvents(self)
	self._closeBtn:AddClickListener(function()
		JiSummonerController.instance.viewOpenIndex = self._choiseIndex

		self:close()
	end, self)
	self._tipsBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "jisummoner")
	end, self)

	for i = 1, #self._leftBtnsList do
		if self._leftBtnsList[i] and self._leftBtnsList[i].itemGo then
			GameUtil.asBtn(self._leftBtnsList[i].itemGo):AddClickListener(function()
				self:_onClickLeftBtn(i, false, true)
			end, self)
		end
	end

	if self._currencyList[1] and self._currencyList[1].itemGo then
		GameUtil.asBtn(self._currencyList[1].itemGo):AddClickListener(function()
			if self._barGoodslist and not string.nilorempty(self._barGoodslist[1]) then
				MaterialMgr.openGetSourceByStr(self._barGoodslist[1])
			end
		end, self)
	end

	if self._currencyList[2] and self._currencyList[2].itemGo then
		GameUtil.asBtn(self._currencyList[2].itemGo):AddClickListener(function()
			if self._barGoodslist and not string.nilorempty(self._barGoodslist[2]) then
				MaterialMgr.openGetSourceByStr(self._barGoodslist[2])
			end
		end, self)
	end
end

function JiSummonerView:unbindEvents()
	JiSummonerView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipsBtn:RemoveClickListener()

	for _, item in pairs(self._leftBtnsList or {}) do
		if item and item.itemGo then
			GameUtil.asBtn(item.itemGo):RemoveClickListener()
		end
	end

	for _, item in pairs(self._currencyList or {}) do
		if item and item.itemGo then
			GameUtil.asBtn(item.itemGo):RemoveClickListener()
		end
	end
end

function JiSummonerView:onExit()
	JiSummonerView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataJiSummonerInfo, self._updataShowViewInfo, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnMaterialCountChange, self._updateMaterialCountShow, self)

	self._choiseIndex = nil
end

function JiSummonerView:destroyUI()
	JiSummonerView.super.destroyUI(self)

	self._leftBtnsList = nil

	local bgBig = self._viewBgGo:GetComponent("ImageBigBG")

	if bgBig then
		bgBig:ClearImage()
	end

	for _, item in pairs(self._currencyList or {}) do
		if item and item.iconGo then
			uGuiUtil.clearImage(item.iconGo)
		end
	end

	self._currencyList = nil
	self._barGoodslist = nil
	self._viewsInfo = nil
end

function JiSummonerView:buildUI()
	JiSummonerView.super.buildUI(self)

	self._viewBgGo = self:getGo("viewBgGo")
	self._subParentGo = self:getGo("subParentGo")
	self._closeBtn = self:getBtn("closeBtn")
	self._tipsBtn = self:getBtn("tipsBtn")
	self._leftBtnsList = {}

	for i = 1, 3 do
		local leftBtnGo = self:getGo("btnTabTran/btnTabGo_" .. i)

		self._leftBtnsList[i] = {
			itemGo = leftBtnGo,
			selectedGo = goutil.findChild(leftBtnGo, "selectedGo"),
			redPointGo = goutil.findChild(leftBtnGo, "redPointGo"),
			lockGo = goutil.findChild(leftBtnGo, "lockGo")
		}

		GameUtil.SetActive(self._leftBtnsList[i].selectedGo, false)
		GameUtil.SetActive(self._leftBtnsList[i].redPointGo, false)
		GameUtil.SetActive(self._leftBtnsList[i].lockGo, false)
	end

	self._timeGo = self:getGo("timeGo")
	self._timeTxt = self:getGo("timeGo/timeTxt"):GetComponent("Text")
	self._timeTxt.text = ""
	self._currencyList = {}

	local daibiItem = self:getGo("daibiItem")

	self._currencyList[1] = {
		itemGo = daibiItem,
		iconGo = goutil.findChild(daibiItem, "daibiIconIma"),
		countTxt = goutil.findChildTextComponent(daibiItem, "daibiCountTxt")
	}

	local diamondItem = self:getGo("diamondItem")

	self._currencyList[2] = {
		itemGo = diamondItem,
		iconGo = goutil.findChild(diamondItem, "diamondIma"),
		countTxt = goutil.findChildTextComponent(diamondItem, "diamondTxt")
	}

	GameUtil.SetActive(self._timeGo, false)
end

function JiSummonerView:onEnter()
	JiSummonerView.super.onEnter(self)

	local actId = JiSummonerConfig.instance:getOpenActivityId()

	if checknumber(actId) <= 0 then
		error("sr----  JiSummonerView:onEnter() y运营-极召唤师    活动时间过了，还能打开？请配置功能开启id！！")

		return
	end

	self._viewsInfo = JiSummonerController.instance._viewsInfo

	GlobalDispatcher:addListener(GlobalNotify.UpdataJiSummonerInfo, self._updataShowViewInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.OnMaterialCountChange, self._updateMaterialCountShow, self)

	local index = 1
	local param = self:getOpenParam()

	if checknumber(param) > 0 then
		index = param
	end

	if checknumber(JiSummonerController.instance.viewOpenIndex) > 0 then
		index = JiSummonerController.instance.viewOpenIndex
	end

	self._actCfg = JiSummonerConfig.instance:getJiSummonerCfg(actId)
	self._barGoodslist = {
		"4:138",
		"204:120015"
	}

	for i = 1, #self._currencyList do
		if self._currencyList[i] and self._currencyList[i].itemGo then
			if not string.nilorempty(self._barGoodslist[i]) then
				GameUtil.SetActive(self._currencyList[i].itemGo, true)

				local have = MaterialMgr.getMatCount(self._barGoodslist[i])

				self._currencyList[i].countTxt.text = tostring(have)

				MaterialMgr.updateItemByStr(self._currencyList[i].iconGo, self._barGoodslist[i])
			else
				GameUtil.SetActive(self._currencyList[i].itemGo, false)
			end
		end
	end

	self:_getJiTaskIsOpen()
	self:_onClickLeftBtn(index, true, true)
end

function JiSummonerView:_getJiTaskIsOpen()
	local times = string.split(self._actCfg.testShow, "#")

	GameUtil.SetActive(self._leftBtnsList[2].lockGo, false)

	if times and #times == 2 and not GameUtil.checkIsInTimePeriod(times[1], times[2]) then
		GameUtil.SetActive(self._leftBtnsList[2].lockGo, true)
	end
end

function JiSummonerView:_updataShowViewInfo()
	self._choiseIndex = self._choiseIndex or 1

	self:_getJiTaskIsOpen()
	self:_onClickLeftBtn(self._choiseIndex, true, false)
end

function JiSummonerView:_onClickLeftBtn(index, isForce, isOpenView)
	if self._leftBtnsList == nil or #self._leftBtnsList == 0 then
		return
	end

	if checknumber(index) <= 0 then
		index = checknumber(self._choiseIndex) <= 0 and 1 or checknumber(self._choiseIndex)
	end

	if checknumber(index) == 2 and self._leftBtnsList[2].lockGo.activeSelf then
		FloatWordMgr.instance:show(self._actCfg.timeShow)

		return
	end

	if self._choiseIndex == index and not isForce then
		return
	end

	for i = 1, #self._leftBtnsList do
		if self._leftBtnsList[i] and self._leftBtnsList[i].itemGo then
			local redId = self._viewsInfo[i].redId

			GameUtil.SetActive(self._leftBtnsList[i].redPointGo, JiSummonerController.instance:getLeftTableRed(redId))
			GameUtil.SetActive(self._leftBtnsList[i].selectedGo, false)
		end
	end

	self._choiseIndex = index

	GameUtil.SetActive(self._timeGo, false)

	if self._choiseIndex == 1 then
		if self._actCfg and not string.nilorempty(self._actCfg.timeShow) then
			GameUtil.SetActive(self._timeGo, true)

			self._timeTxt.text = self._actCfg.timeShow
		end
	elseif self._choiseIndex == 2 then
		local actCfg = DragonConfig.instance:getActivityCfg(112006)

		if actCfg then
			if not actCfg.poolGroupId then
				local groupId = 6
				local poolCfg = DragonConfig.instance:getDragonPoolCfg(groupId)

				if poolCfg and not string.nilorempty(poolCfg.timeDesc) then
					GameUtil.SetActive(self._timeGo, true)

					self._timeTxt.text = poolCfg.timeDesc
				end
			end
		end
	end

	local path = GameUrl.getBigbgFolderUrl("jisummoner", self._viewsInfo[self._choiseIndex].bgName)

	uGuiUtil.setSpriteToImage(self._viewBgGo, uGuiUtil.SpriteType.BigBg, path)
	GameUtil.SetActive(self._leftBtnsList[self._choiseIndex].selectedGo, true)

	JiSummonerController.instance.viewOpenIndex = self._choiseIndex

	self:_updateMaterialCountShow()

	if not isOpenView then
		return
	end

	self:showTabAt(self._subParentGo, self._viewsInfo[self._choiseIndex].viewName, self._actCfg)
end

function JiSummonerView:_updateMaterialCountShow()
	for i = 1, #self._currencyList do
		if self._currencyList[i] and self._currencyList[i].itemGo and not string.nilorempty(self._barGoodslist[i]) then
			local have = MaterialMgr.getMatCount(self._barGoodslist[i])

			self._currencyList[i].countTxt.text = tostring(have)
		end
	end
end

return JiSummonerView
