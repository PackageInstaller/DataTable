-- chunkname: @IQIGame\\UI\\LotteryPickUpUI.lua

local LotteryPickUpUI = {
	PickUpItems = {}
}

LotteryPickUpUI = Base:Extend("LotteryPickUpUI", "IQIGame.Onigao.UI.LotteryPickUpUI", LotteryPickUpUI)

local LotteryPickUpItem = require("IQIGame.UI.Lottery.LotteryPickUpItem")
local LotteryPickUpTipController = require("IQIGame.UI.Lottery.LotteryPickUpTipController")

function LotteryPickUpUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	local scrollAreaList = self.PickUpMainScrollArea:GetComponent("ScrollAreaList")

	function scrollAreaList.onRenderCell(cell)
		self:OnRenderPickUpItem(cell)
	end

	function scrollAreaList.onSelectedCell(cell)
		self:OnSelectPickUpItem(cell)
	end

	self.TipController = LotteryPickUpTipController.New(self.TipView)

	UGUIUtil.SetText(self.TitleText, LotteryPickUpUIApi:GetString("TitleText"))
	UGUIUtil.SetText(self.TipText, LotteryPickUpUIApi:GetString("TipText"))
end

function LotteryPickUpUI:GetPreloadAssetPaths()
	return nil
end

function LotteryPickUpUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function LotteryPickUpUI:IsManualShowOnOpen(userData)
	return false
end

function LotteryPickUpUI:GetBGM(userData)
	return nil
end

function LotteryPickUpUI:OnOpen(userData)
	self.OnChangeCallback = userData.onChange

	self:UpdateView(userData.cfgLotteryShowData)
end

function LotteryPickUpUI:OnClose(userData)
	return
end

function LotteryPickUpUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.CloseBtn2:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function LotteryPickUpUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.CloseBtn2:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function LotteryPickUpUI:OnPause()
	return
end

function LotteryPickUpUI:OnResume()
	return
end

function LotteryPickUpUI:OnCover()
	return
end

function LotteryPickUpUI:OnReveal()
	return
end

function LotteryPickUpUI:OnRefocus(userData)
	return
end

function LotteryPickUpUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function LotteryPickUpUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function LotteryPickUpUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function LotteryPickUpUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function LotteryPickUpUI:OnDestroy()
	for gameObject, item in pairs(self.PickUpItems) do
		item:Dispose()
	end

	self.TipController:Dispose()
end

function LotteryPickUpUI:UpdateView(cfgLotteryShowData)
	self.CfgLotteryShowData = cfgLotteryShowData
	self.PickUpDataList = LotteryModule.GetAvailablePickUps(cfgLotteryShowData)

	local selectedPickUps = LotteryModule.GetSelectedPickUps(cfgLotteryShowData, self.PickUpDataList)
	local cfgLotteryPackUpData = selectedPickUps[1]
	local index = 1

	for i = 1, #self.PickUpDataList do
		local cfgData = self.PickUpDataList[i]

		if cfgData.Id == cfgLotteryPackUpData.Id then
			index = i

			break
		end
	end

	local scrollAreaList = self.PickUpMainScrollArea:GetComponent("ScrollAreaList")

	scrollAreaList.defaultSelectedToggle = index - 1
	scrollAreaList.startIndex = index - 1

	scrollAreaList:Refresh(#self.PickUpDataList)
	self.TipController:Hide()
end

function LotteryPickUpUI:OnRenderPickUpItem(cell)
	local item = self.PickUpItems[cell.gameObject]

	if item == nil then
		item = LotteryPickUpItem.New(cell.gameObject, function(cfgLotteryPackUpData)
			self:OnClickTipBtn(cfgLotteryPackUpData)
		end)
		self.PickUpItems[cell.gameObject] = item
	end

	item:SetData(self.PickUpDataList[cell.index + 1])
end

function LotteryPickUpUI:OnSelectPickUpItem(cell)
	self.TipController:Hide()

	local cfgLotteryPackUpData = self.PickUpDataList[cell.index + 1]
	local savedPUMap = PlayerPrefsUtil.GetLuaTable(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.LotteryPackUpCids)

	savedPUMap = savedPUMap or {}
	savedPUMap[tostring(self.CfgLotteryShowData.Id)] = {
		cfgLotteryPackUpData.Id
	}

	PlayerPrefsUtil.SetLuaTable(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.LotteryPackUpCids, savedPUMap)
	self.OnChangeCallback(cfgLotteryPackUpData)
end

function LotteryPickUpUI:OnClickTipBtn(cfgLotteryPackUpData)
	self.TipController:Show(cfgLotteryPackUpData)
end

function LotteryPickUpUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

return LotteryPickUpUI
