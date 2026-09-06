-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/LotteryGroupView.lua

module("logic.extensions.lottery.view.LotteryGroupView", package.seeall)

local LotteryGroupView = class("LotteryGroupView", ViewComponent)

function LotteryGroupView:ctor()
	LotteryGroupView.super.ctor(self)

	self._poolItemList = nil
end

function LotteryGroupView:bindEvents()
	self._cancelBtn:AddClickListener(self.close, self)
	self._sureBtn:AddClickListener(self._onClickSureBtn, self)
end

function LotteryGroupView:unbindEvents()
	self._cancelBtn:RemoveClickListener()
	self._sureBtn:RemoveClickListener()
end

function LotteryGroupView:onExit()
	LotteryGroupView.super.onExit(self)
	GlobalDispatcher:removeListener("UpdataUnlockGroup", self._updataAllPoolInfo, self)
	removetimer(self._calculationSurplusTime, self)
end

function LotteryGroupView:destroyUI()
	LotteryGroupView.super.destroyUI(self)
	MaterialMgr.clearIcon(self._buyIma)

	self._poolItemList = nil
end

function LotteryGroupView:buildUI()
	LotteryGroupView.super.buildUI(self)

	local poolItemTran = self:getGo("poolItemTran").transform

	self._descTxt = self:getGo("viewDescTxt"):GetComponent("Text")
	self._timerTxt = self:getGo("timerTxt"):GetComponent("Text")
	self._sureBtn = self:getBtn("sureBtn")
	self._sureTxt = self:getGo("sureBtn/sureTxt"):GetComponent("Text")
	self._buyIma = self:getGo("sureBtn/buyIma"):GetComponent("Image")
	self._buyTxt = self:getGo("sureBtn/buyIma/buyTxt"):GetComponent("Text")
	self._cancelBtn = self:getBtn("cancelBtn")
	self._poolItemList = {}

	for i = 1, poolItemTran.childCount do
		local go = poolItemTran:GetChild(i - 1).gameObject
		local names = string.split(go.name, "_")

		self._poolItemList[tonumber(names[2])] = {
			itemGo = go,
			itemIma = go:GetComponent("UIImageSpriteChange"),
			choiseGo = goutil.findChild(go, "choiseGo"),
			lockGo = goutil.findChild(go, "lockGo")
		}
	end

	self._descTxt.text = ""
	self._timerTxt.text = ""
	self._sureTxt.text = ""
	self._buyTxt.text = ""

	GameUtil.SetActive(self._buyIma, false)
end

function LotteryGroupView:onEnter()
	LotteryGroupView.super.onEnter(self)
	GlobalDispatcher:addListener("UpdataUnlockGroup", self._updataAllPoolInfo, self)

	self._groupInfo = self:getFirstParam()

	if self._groupInfo == nil or self._groupInfo.groupId == nil or self._groupInfo.poolId == nil or self._groupInfo.idList == nil then
		printError("sr---抽卡 LotteryGroupView:onEnter()  传入的参数为空！")
	end

	self._choiIndex = table.indexof(self._groupInfo.idList, self._groupInfo.poolId) or 1

	self:_updataAllPoolInfo(self._groupInfo.groupId)
end

function LotteryGroupView:_showActivityTimer()
	if self._endTime <= 0 or self._endTime <= ServerTime.now() then
		self._timerTxt.text = lang("text_lottery_desc_15")

		return
	end

	if self._endTime > ServerTime.now() then
		self:_calculationSurplusTime()
		settimer(1, self._calculationSurplusTime, self, true)
	end
end

function LotteryGroupView:_calculationSurplusTime()
	local supTime = self._endTime - ServerTime.now()

	if supTime <= 0 then
		removetimer(self._calculationSurplusTime, self)

		self._timerTxt.text = lang("text_lottery_switch")

		return
	end

	local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(supTime)

	self._timerTxt.text = day > 0 and langPara("text_suo_timer_1", day, hour, min) or langPara("text_suo_timer_2", hour, min, sec)
end

function LotteryGroupView:_updataAllPoolInfo(id)
	if checknumber(id) ~= self._groupInfo.groupId then
		return
	end

	removetimer(self._calculationSurplusTime, self)

	self._isUnlock = LotteryModel.instance:IsPoolGroupUnlock(self._groupInfo.groupId)

	if self._isUnlock then
		self._descTxt.text = lang("text_lottery_desc_16")
		self._sureTxt.text = lang("text_lottery_choise")
		self._buyTxt.text = ""

		GameUtil.SetActive(self._buyIma, false)
		GameUtil.SetActive(self._timerTxt, false)
	else
		self._descTxt.text = lang("text_lottery_desc_18")
		self._sureTxt.text = ""

		local cfg = LotteryConfig.instance:GetPoolGroupCfg(self._groupInfo.groupId)
		local cost = "105:1:300"

		if cfg == nil or string.nilorempty(cfg.unlockCost) then
			printError("sr---抽卡   LotteryGroupView:_updataAllPoolInfo()   获取消耗为空 = " .. self._groupInfo.groupId)
		else
			cost = cfg.unlockCost
		end

		GameUtil.SetActive(self._buyIma, true)

		local list = string.split(cost, ":")
		local count = checknumber(list[3])

		if checknumber(list[1]) == MatType.Diamond_Consume then
			local price = GoodsConfig.instance:getCfgPrice(checknumber(list[2]))

			if checknumber(price) > 0 then
				count = count * checknumber(price)
			end
		end

		self._buyTxt.text = langPara("text_lottery_desc_19", count)

		MaterialMgr.setIcon(self._buyIma, tonumber(list[1]), tonumber(list[2]))

		self._endTime = GameUtil.string2time(cfg.endTime)

		if self._endTime > ServerTime.now() then
			self._endTime = self._endTime + 5
		end

		GameUtil.SetActive(self._timerTxt, true)
		self:_showActivityTimer()
	end

	for i = 1, #self._poolItemList do
		if self._poolItemList[i] then
			GameUtil.asBtn(self._poolItemList[i].itemGo):RemoveClickListener()

			local poolId = self._groupInfo.idList[i]
			local cfg = LotteryConfig.instance:GetPoolCfg(poolId)

			if cfg and checknumber(cfg.tabSort) > 0 then
				local isLock = false

				self._poolItemList[i].itemGo:SetActive(true)

				if i == self._choiIndex then
					self._poolItemList[i].choiseGo:SetActive(true)
					self._poolItemList[i].lockGo:SetActive(false)
				else
					self._poolItemList[i].choiseGo:SetActive(false)
					self._poolItemList[i].lockGo:SetActive(not self._isUnlock)

					isLock = not self._isUnlock
				end

				self._poolItemList[i].itemIma:SetState(cfg.tabIconNum - 1)
				GameUtil.asBtn(self._poolItemList[i].itemGo):AddClickListener(function()
					self:_onClickPoolItemBtn(i, isLock)
				end, self)
			else
				self._poolItemList[i].itemGo:SetActive(false)
			end
		end
	end
end

function LotteryGroupView:_onClickPoolItemBtn(index, isLock)
	if isLock then
		FloatWordMgr.instance:show(lang("text_lottery_desc_30"))

		return
	end

	if not self._isUnlock then
		return
	end

	if self._poolItemList[self._choiIndex] then
		self._poolItemList[self._choiIndex].choiseGo:SetActive(false)
	end

	if self._poolItemList[index] then
		self._poolItemList[index].choiseGo:SetActive(true)
	end

	self._choiIndex = index
end

function LotteryGroupView:_onClickSureBtn()
	if self._isUnlock then
		if self._groupInfo.idList and self._groupInfo.idList[self._choiIndex] then
			LotteryModel.instance:SetPoolGroupPoolId(self._groupInfo.groupId, self._groupInfo.idList[self._choiIndex])
		end

		self:close()
	else
		local cfg = LotteryConfig.instance:GetPoolGroupCfg(self._groupInfo.groupId)

		if cfg == nil or string.nilorempty(cfg.unlockCost) then
			return
		end

		local function callback()
			LotteryController.instance:CSRequestUnlockGroup(self._groupInfo.groupId)
		end

		local list = string.split(cfg.unlockCost, ":")
		local matName = MaterialMgr.getMaterialsName(tonumber(list[1]), tonumber(list[2]))
		local count = checknumber(list[3])

		if checknumber(list[1]) == MatType.Diamond_Consume then
			local price = GoodsConfig.instance:getCfgPrice(checknumber(list[2]))

			if checknumber(price) > 0 then
				count = count * checknumber(price)
			end
		end

		local content = langPara("text_lottery_desc_21", count, matName)

		if tonumber(list[1]) == MatType.Diamond or tonumber(list[1]) == MatType.Diamond_Consume then
			TipsFacade.instance:openPopupCostDiamondView(count, content, callback)
		elseif tonumber(list[1]) == MatType.Coin then
			TipsFacade.instance:openPopupCostCoinView(count, content, callback)
		else
			TipsFacade.instance:openPopupWindow(lang("text_lottery_buy_tips"), content, callback, nil, lang("text_lottery_buy"), lang("mail_cancel"), UnityEngine.TextAnchor.MiddleCenter)
		end
	end
end

return LotteryGroupView
