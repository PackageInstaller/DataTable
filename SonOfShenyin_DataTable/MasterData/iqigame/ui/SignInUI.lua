-- chunkname: @IQIGame\\UI\\SignInUI.lua

local SignInUI = {
	slotPool = {},
	OtherTable = {},
	CommonTable = {}
}

SignInUI = Base:Extend("SignInUI", "IQIGame.Onigao.UI.SignInUI", SignInUI)

local SignInItem = require("IQIGame.UI.SignIn.SignInItem")

function SignInUI:OnInit()
	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateCloseBtn()
		self:OnCloseBtnClick()
	end

	function self.DelegateSignInNotify()
		self:SignInSucessNotify()
	end

	function self.DelegateBuyMonthCardNotify()
		self:BuyMonthCardNotify()
	end

	function self.DelegateBuyMonthCard()
		self:BuyMonthCard()
	end

	self.slotPool[1] = SignInItem.New(self.goSlot, function(day)
		self:SignItemSelect(day)
	end)

	LuaCodeInterface.BindOutlet(self.Other, self.OtherTable)
	LuaCodeInterface.BindOutlet(self.Common, self.CommonTable)

	self.cfgDatas = SignInModule.SignCfgData

	SignInModule.GetMonthHasDay()
	UGUIUtil.SetText(self.infoText, SignInUIApi:GetContinueText())
	self:InitMsic()
end

function SignInUI:GetPreloadAssetPaths()
	return nil
end

function SignInUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function SignInUI:IsManualShowOnOpen(userData)
	return false
end

function SignInUI:GetBGM(userData)
	return nil
end

function SignInUI:OnOpen(userData)
	self:Refresh()
	self:StartSign()
	self:RefreshMonthCard()
end

function SignInUI:OnClose(userData)
	return
end

function SignInUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateCloseBtn)
	self.buttonReturn:GetComponent("Button").onClick:AddListener(self.DelegateCloseBtn)
	EventDispatcher.AddEventListener(EventID.SignInNotify, self.DelegateSignInNotify)
	EventDispatcher.AddEventListener(EventID.BuyMonthCardNotify, self.DelegateBuyMonthCardNotify)
end

function SignInUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateCloseBtn)
	self.buttonReturn:GetComponent("Button").onClick:RemoveListener(self.DelegateCloseBtn)
	EventDispatcher.RemoveEventListener(EventID.SignInNotify, self.DelegateSignInNotify)
	EventDispatcher.RemoveEventListener(EventID.BuyMonthCardNotify, self.DelegateBuyMonthCardNotify)
end

function SignInUI:OnPause()
	return
end

function SignInUI:OnResume()
	return
end

function SignInUI:OnCover()
	return
end

function SignInUI:OnReveal()
	return
end

function SignInUI:OnRefocus(userData)
	return
end

function SignInUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function SignInUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function SignInUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function SignInUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function SignInUI:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.Other, self.OtherTable)
	LuaCodeInterface.ClearOutlet(self.Common, self.CommonTable)

	for i, v in pairs(self.slotPool) do
		v:Dispose()
	end
end

function SignInUI:Refresh()
	for i = 1, #self.cfgDatas do
		local cell = self:GetSlot(i)

		cell:SetData(i, self.cfgDatas[i], i <= SignInModule.MonthSignDay)
	end

	for i, v in ipairs(self.slotPool) do
		v:SetVisible(i <= tonumber(SignInModule.CurMonthDay))
	end

	local signDay = SignInModule.MonthSignDay <= 0 and 1 or SignInModule.MonthSignDay

	signDay = signDay >= tonumber(SignInModule.CurMonthDay) and tonumber(SignInModule.CurMonthDay) or signDay

	self:SignItemSelect(signDay)
end

function SignInUI:GetSlot(index)
	local ret = self.slotPool[index]

	if ret == nil then
		local go = UnityEngine.Object.Instantiate(self.goSlot)

		go.transform:SetParent(self.SlotGrid.transform, false)

		ret = SignInItem.New(go, function(day)
			self:SignItemSelect(day)
		end)
		self.slotPool[index] = ret
	end

	return ret
end

function SignInUI:StartSign()
	if not SignInModule.CurDateState then
		local timer = FrameTimer.New(function()
			SignInModule.Sign()
		end, 2)

		timer:Start()
	end
end

function SignInUI:InitMsic()
	if SignInModule.MonthSignDay == tonumber(SignInModule.CurMonthDay) then
		self:RefreshCommon(SignInModule.CurDateState, SignInModule.MonthSignDay)
	else
		self:RefreshCommon(SignInModule.CurDateState, SignInModule.MonthSignDay + 1)
	end

	self:InitMonthCatdBase()
	self:RefreshOther()
end

function SignInUI:RefreshOther()
	local CNMonth, ENMonth = SignInUIApi:GetMonthStr(SignInModule.CurMonth)

	UGUIUtil.SetText(self.OtherTable.MonthDayText, CNMonth)
	UGUIUtil.SetText(self.OtherTable.MonthDayEnText, ENMonth)
end

function SignInUI:RefreshCommon(curState, day)
	self.CommonTable.IsSignImg:SetActive(curState)
	UGUIUtil.SetText(self.CommonTable.ItemCount, self.cfgDatas[day].SignItemId[2])
	UGUIUtil.SetText(self.CommonTable.ItemName, CfgItemTable[self.cfgDatas[day].SignItemId[1]].Name)
	self:LoadImg(UIGlobalApi.GetIconPath(CfgItemTable[self.cfgDatas[day].SignItemId[1]].Icon), self.CommonTable.SlotImg)
end

function SignInUI:InitMonthCatdBase()
	return
end

function SignInUI:RefreshMonthCard()
	return
end

function SignInUI:SignItemSelect(day)
	for i = 1, #self.slotPool do
		self.slotPool[i]:UnSelect()
	end

	self.slotPool[day]:Select()
	self:RefreshCommon(day <= SignInModule.MonthSignDay, day)
end

function SignInUI:BuyMonthCardNotify()
	self:RefreshMonthCard()
end

function SignInUI:SignInSucessNotify()
	self:Refresh()
	self.CommonTable.IsSignImg:SetActive(SignInModule.CurDateState)
	self:SignItemSelect(SignInModule.MonthSignDay)
end

function SignInUI:BuyMonthCard()
	SignInModule.BuyMonthCard()
end

function SignInUI:OnCloseBtnClick()
	UIModule.CloseSelf(self)
end

function SignInUI:LoadImg(path, obj)
	AssetUtil.LoadImage(self, path, obj:GetComponent("Image"))
end

return SignInUI
