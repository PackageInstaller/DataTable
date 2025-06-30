-- chunkname: @IQIGame\\UI\\Cooking\\CookNowView.lua

local CookNowView = {}

function CookNowView.New(view, parentView)
	local obj = Clone(CookNowView)

	obj:Init(view, parentView)

	return obj
end

function CookNowView:Init(view, parentView)
	self.View = view
	self.parentView = parentView

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetText(self.TextBtnCleanCD, HomeLandCookingUIApi:GetString("TextBtnCleanCD"))
	UGUIUtil.SetText(self.TextBtnGetAll, HomeLandCookingUIApi:GetString("TextBtnGetAll"))
	UGUIUtil.SetText(self.TextGetAllTitle, HomeLandCookingUIApi:GetString("TextGetAllTitle"))

	self.btnCleanCD = self.BtnCleanCD:GetComponent("Button")

	function self.delegateBtnCleanCd()
		self:OnBtnCleanCd()
	end

	function self.delegateCompleteCook()
		self:OnCompleteCook()
	end

	function self.delegateBtnGetAll()
		self:OnBtnGetAll()
	end

	self.timerCD = Timer.New(function()
		self:ShowCookingCD()
	end, 1, -1)

	self:AddEventListener()
end

function CookNowView:AddEventListener()
	self.btnCleanCD.onClick:AddListener(self.delegateBtnCleanCd)
	self.BtnGetAll:GetComponent("Button").onClick:AddListener(self.delegateBtnGetAll)
end

function CookNowView:RemoveEventListener()
	self.btnCleanCD.onClick:RemoveListener(self.delegateBtnCleanCd)
	self.BtnGetAll:GetComponent("Button").onClick:RemoveListener(self.delegateBtnGetAll)
end

function CookNowView:OnBtnCleanCd()
	local cd = self.parentView.queueData.finishTime - PlayerModule.GetServerTime()

	if cd > 0 then
		local value = CfgDiscreteDataTable[6520009].Data[1]
		local spend = math.ceil(cd / value)

		NoticeModule.ShowNoticeBuyConfirm(21042004, self.delegateCompleteCook, nil, self, {
			2
		}, {
			spend
		}, self.getItemStr)
	end
end

function CookNowView:OnCompleteCook()
	local cd = self.parentView.queueData.finishTime - PlayerModule.GetServerTime()

	if cd > 0 then
		local value = CfgDiscreteDataTable[6520009].Data[1]
		local spend = math.ceil(cd / value)
		local have = WarehouseModule.GetItemNumByCfgID(Constant.ItemID.TREASURE)

		if have < spend then
			NoticeModule.MoneyDeficitTip(1, spend - have)
		else
			HomeLandLuaModule.CompleteCook(self.parentView.cfgBuildingID, self.parentView.queueData.id, cd + 1)
		end
	end
end

function CookNowView:ShowCookingCD()
	if self.parentView.queueData then
		local cd = self.parentView.queueData.finishTime - PlayerModule.GetServerTime()

		if cd >= 0 then
			UGUIUtil.SetText(self.TextNow2, HomeLandCookingUIApi:GetString("TextNow2", GetFormatTime(cd)))
		end

		self:UpdateGetAll()
	end
end

function CookNowView:Open()
	self.View:SetActive(true)
	self.timerCD:Stop()

	local menuData = CookingModule.GetMenuDataByID(self.parentView.queueData.cid)

	if menuData and menuData.unlock then
		local cd = self.parentView.queueData.finishTime - PlayerModule.GetServerTime()

		if cd > 0 then
			self.timerCD:Start()
			UGUIUtil.SetText(self.TextNow2, HomeLandCookingUIApi:GetString("TextNow2", GetFormatTime(cd)))
		end

		self:UpdateGetAll()
	else
		UGUIUtil.SetText(self.TextNow2, HomeLandCookingUIApi:GetString("TextUnlockTime"))
	end
end

function CookNowView:UpdateGetAll()
	local count = self.parentView.queueData:CanGetNum()

	self.GetPanel:SetActive(count > 0)

	if self.parentView.queueData.cid ~= nil and self.parentView.queueData.cid ~= "" then
		local itemID = CfgCookCombinationTable[self.parentView.queueData.cid].ItemId[1]
		local itemData = CfgItemTable[itemID]

		UGUIUtil.SetText(self.TextGetAllName, HomeLandCookingUIApi:GetString("TextMakingName", itemData.Name, count))
	end
end

function CookNowView:OnBtnGetAll()
	local count = self.parentView.queueData:CanGetNum()

	if count > 0 then
		HomeLandLuaModule.RewardCook(self.parentView.cfgBuildingID, self.parentView.queueData.id)
	end
end

function CookNowView:Close()
	self.View:SetActive(false)
	self.timerCD:Stop()
end

function CookNowView:Dispose()
	self:RemoveEventListener()

	if self.timerCD then
		self.timerCD:Stop()
	end

	self.timerCD = nil

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return CookNowView
