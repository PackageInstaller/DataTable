-- chunkname: @IQIGame\\UI\\BuyExchangePanelUI.lua

local BuyExchangePanelUI = Base:Extend("BuyExchangePanelUI", "IQIGame.Onigao.UI.BuyExchangePanelUI", {
	itemIds = {
		10003,
		10004
	},
	itemNum = {}
})

function BuyExchangePanelUI:OnInit()
	UGUIUtil.SetText(self.TextTitle, BuyExchangeUIApi:GetString("TextTitle"))
	UGUIUtil.SetText(self.TextBtnTitle, BuyExchangeUIApi:GetString("TextBtnTitle"))
	UGUIUtil.SetTextInChildren(self.BtnRewardType1, BuyExchangeUIApi:GetString("TextBtnExchange"))
	UGUIUtil.SetTextInChildren(self.BtnRewardType2, BuyExchangeUIApi:GetString("TextBtnExchange"))

	function self.delegateClickBtnClose()
		self:OnClickBtnClose()
	end

	function self.delegateClickBtnReward()
		self:OnClickBtnReward()
	end

	function self.delegateUpdateExchange()
		self:OnUpdateExchange()
	end

	function self.delegateExChangeItemSuccess(data)
		self:OnExChangeItemsSuccess(data)
	end

	function self.delegateBtnRewardType1()
		self:OnBtnRewardType1()
	end

	function self.delegateBtnRewardType2()
		self:OnBtnRewardType2()
	end

	function self.delegateUpdateItem()
		self:UpdateItem()
	end
end

function BuyExchangePanelUI:GetPreloadAssetPaths()
	return nil
end

function BuyExchangePanelUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function BuyExchangePanelUI:OnOpen(userData)
	self.cfgExchange = userData

	self.Effect:SetActive(false)
	self.EffectType1:SetActive(false)
	self.EffectType2:SetActive(false)
	self:UpDateView()
end

function BuyExchangePanelUI:OnClose(userData)
	if self.timer ~= nil then
		self.timer:Stop()

		self.timer = nil
	end
end

function BuyExchangePanelUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.delegateClickBtnClose)
	self.BtnClose1:GetComponent("Button").onClick:AddListener(self.delegateClickBtnClose)
	self.BtnReward:GetComponent("Button").onClick:AddListener(self.delegateClickBtnReward)
	self.BtnRewardType1:GetComponent("Button").onClick:AddListener(self.delegateBtnRewardType1)
	self.BtnRewardType2:GetComponent("Button").onClick:AddListener(self.delegateBtnRewardType2)
	EventDispatcher.AddEventListener(EventID.ExChangeItemSuccessEvent, self.delegateExChangeItemSuccess)
	EventDispatcher.AddEventListener(EventID.UpdateExChangeEvent, self.delegateUpdateExchange)
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.delegateUpdateItem)
end

function BuyExchangePanelUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateClickBtnClose)
	self.BtnClose1:GetComponent("Button").onClick:RemoveListener(self.delegateClickBtnClose)
	self.BtnReward:GetComponent("Button").onClick:RemoveListener(self.delegateClickBtnReward)
	self.BtnRewardType1:GetComponent("Button").onClick:RemoveListener(self.delegateBtnRewardType1)
	self.BtnRewardType2:GetComponent("Button").onClick:RemoveListener(self.delegateBtnRewardType2)
	EventDispatcher.RemoveEventListener(EventID.ExChangeItemSuccessEvent, self.delegateExChangeItemSuccess)
	EventDispatcher.RemoveEventListener(EventID.UpdateExChangeEvent, self.delegateUpdateExchange)
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.delegateUpdateItem)
end

function BuyExchangePanelUI:OnPause()
	return
end

function BuyExchangePanelUI:OnResume()
	return
end

function BuyExchangePanelUI:OnCover()
	return
end

function BuyExchangePanelUI:OnReveal()
	return
end

function BuyExchangePanelUI:OnRefocus(userData)
	return
end

function BuyExchangePanelUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function BuyExchangePanelUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function BuyExchangePanelUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function BuyExchangePanelUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function BuyExchangePanelUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function BuyExchangePanelUI:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.BuyExchangePanelUI)
end

function BuyExchangePanelUI:UpDateView()
	self.nextChange = nil

	if self.cfgExchange ~= nil then
		self.TextDes:GetComponent("Text").text = ""

		local leftCount, costItemCid, costItemNum, nextIndex = ChurchModule.GetExchangeInfo(self.cfgExchange)

		self.exchangeCount = leftCount
		self.TextTimes:GetComponent("Text").text = BuyExchangeUIApi:GetString("TextTimes", self.exchangeCount, self.cfgExchange.Limit)
		self.costId = costItemCid
		self.costNum = costItemNum

		if self.costNum == nil then
			self.costNum = 0
		end

		local haveNum = WarehouseModule.GetItemNumByCfgID(self.costId)

		self.copiesNum = haveNum >= self.costNum

		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[self.costId].Icon), self.ImgGood1:GetComponent("Image"))
		UGUIUtil.SetText(self.TextGood1, self.costNum)

		local getId = self.cfgExchange.GetItems[nextIndex][1]
		local getNum = self.cfgExchange.GetItems[nextIndex][2]

		if self.cfgExchange.Coefficient == 1 then
			getNum = getNum * PlayerModule.PlayerInfo.baseInfo.pLv
		end

		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[getId].Icon), self.ImgGood2:GetComponent("Image"))
		UGUIUtil.SetText(self.TextGood2, getNum)
	end

	self:UpdateExchangeView()
end

function BuyExchangePanelUI:OnClickBtnReward()
	local energy = WarehouseModule.GetItemNumByCfgID(Constant.ItemID.ENERGY)

	if energy > 500 then
		NoticeModule.ShowNotice(21045069)

		return
	end

	if self.cfgExchange.Limit > 0 and self.exchangeCount <= 0 then
		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, BuyExchangeUIApi:GetString("ErrorMsg1"))

		return
	end

	local haveNum = WarehouseModule.GetItemNumByCfgID(self.costId)

	self.copiesNum = haveNum >= self.costNum

	if self.copiesNum == false then
		if self.costId == Constant.ItemID.TREASURE then
			NoticeModule.MoneyDeficitTip(1, self.costNum)
		elseif self.costId == Constant.ItemID.ID_PAYPOINT_SHOW then
			NoticeModule.MoneyDeficitTip(2, self.costNum)
		else
			NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, BuyExchangeUIApi:GetString("ErrorMsg2", CfgItemTable[self.costId].Name))
		end

		return
	end

	ChurchModule.SendExchangeMsg(self.cfgExchange.Id, 1)
end

function BuyExchangePanelUI:OnUpdateExchange()
	self:UpDateView()
end

function BuyExchangePanelUI:OnExChangeItemsSuccess(data)
	self.Effect:SetActive(false)
	self.Effect:SetActive(true)
	self:UpDateView()

	local str = ""

	if data.showItems then
		for i, v in pairs(data.showItems) do
			str = str .. CfgItemTable[v.cid].Name .. " +" .. v.num .. " "
		end
	end

	if data.critMultiple ~= nil and data.critMultiple > 1 then
		str = BuyExchangeUIApi:GetString("TextDes", str, data.critMultiple)
	end

	if str ~= "" then
		self.TextDes:GetComponent("Text").text = str

		if self.timer ~= nil then
			self.timer:Stop()

			self.timer = nil
		end

		self.timer = Timer.New(function()
			self.TextDes:GetComponent("Text").text = ""
		end, 2)

		self.timer:Start()
	end
end

function BuyExchangePanelUI:UpdateExchangeView()
	self.itemNum = {}

	for i = 1, 2 do
		local costID = self.itemIds[i]
		local getId = CfgItemTable[costID].EffectTypeParam[1][1]
		local getNum = CfgItemTable[costID].EffectTypeParam[1][2]
		local path1 = UIGlobalApi.GetIconPath(CfgItemTable[costID].Icon)
		local path2 = UIGlobalApi.GetIconPath(CfgItemTable[getId].Icon)

		AssetUtil.LoadImage(self, path1, self["ImgGood1Type" .. i]:GetComponent("Image"))
		AssetUtil.LoadImage(self, path2, self["ImgGood2Type" .. i]:GetComponent("Image"))
		UGUIUtil.SetText(self["TextGood1Type" .. i], 1)
		UGUIUtil.SetText(self["TextGood2Type" .. i], getNum)

		local haveNum = WarehouseModule.GetItemNumByCfgID(costID)

		UGUIUtil.SetText(self["TextTimesType" .. i], BuyExchangeUIApi:GetString("TextHaveNum", haveNum))

		self.itemNum[costID] = haveNum
	end
end

function BuyExchangePanelUI:ShowEffect(tab)
	local isUpdate = false
	local addValue = 0

	for i, v in pairs(tab) do
		isUpdate = true

		if i == self.itemIds[1] then
			self.EffectType1:SetActive(false)
			self.EffectType1:SetActive(true)

			addValue = addValue + CfgItemTable[i].EffectTypeParam[1][2]
		end

		if i == self.itemIds[2] then
			self.EffectType2:SetActive(false)
			self.EffectType2:SetActive(true)

			addValue = addValue + CfgItemTable[i].EffectTypeParam[1][2]
		end
	end

	if isUpdate then
		self:UpdateExchangeView()

		if addValue > 0 then
			local str = BuyExchangeUIApi:GetString("GetAddValueStr", CfgItemTable[Constant.ItemID.ENERGY].Name, addValue)

			self.TextDes:GetComponent("Text").text = str

			if self.timer ~= nil then
				self.timer:Stop()

				self.timer = nil
			end

			self.timer = Timer.New(function()
				self.TextDes:GetComponent("Text").text = ""
			end, 2)

			self.timer:Start()
		end
	end
end

function BuyExchangePanelUI:UpdateItem()
	local tab = {}

	for i, v in pairs(self.itemNum) do
		local newNum = WarehouseModule.GetItemNumByCfgID(i)

		if newNum < v then
			tab[i] = v - newNum
		end
	end

	self:ShowEffect(tab)
end

function BuyExchangePanelUI:UseItemExchange(costID)
	local energy = WarehouseModule.GetItemNumByCfgID(Constant.ItemID.ENERGY)

	if energy > 500 then
		NoticeModule.ShowNotice(21045069)

		return
	end

	local haveNum = WarehouseModule.GetItemNumByCfgID(costID)

	if haveNum <= 0 then
		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, BuyExchangeUIApi:GetString("ErrorMsg2", CfgItemTable[costID].Name))

		return
	end

	local itemData = WarehouseModule.GetItemDataByCfgID(costID)

	ItemModule.UseItem(itemData, 1)
end

function BuyExchangePanelUI:OnBtnRewardType1()
	local costID = self.itemIds[1]

	self:UseItemExchange(costID)
end

function BuyExchangePanelUI:OnBtnRewardType2()
	local costID = self.itemIds[2]

	self:UseItemExchange(costID)
end

return BuyExchangePanelUI
