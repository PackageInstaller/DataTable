-- chunkname: @IQIGame\\UI\\Main\\MainCityWorldSpaceUI.lua

local bannerItemCell = require("IQIGame.UI.Main.BannerItemCell")
local m = {
	bannerTimes = 1,
	bannerTotalTimes = 4,
	BannerItemList = {}
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnScrollDragEnd(index)
		self:OnScrollDragEnd(index)
	end

	function self.DelegateNotifyUpdateStage()
		self:NotifyUpdateStage()
	end

	function self.DelegateOnUnlockFunctionUpdateEvent()
		self:OnRefreshUnlockBtn()
	end

	function self.delegateOnClickStartGameBtn()
		self:OnClickStartGameBtn()
	end

	self.BannerScrollPageExt = self.BannerScroll:GetComponent(typeof(ScrollRectPageExt))
	self.BannerScrollPageExt.OnDrageEnd = self.DelegateOnScrollDragEnd

	UGUIUtil.SetText(self.TaskText, MainUIAPI:GetTaskManualTitle())
	self:InitBannerDataCfg()
	self:AddListeners()
end

function m:AddListeners()
	EventDispatcher.AddEventListener(EventID.OnNotifyStage, self.DelegateNotifyUpdateStage)
	EventDispatcher.AddEventListener(EventID.UnlockFunction, self.DelegateOnUnlockFunctionUpdateEvent)
	self.StartGameBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickStartGameBtn)
	RedDotModule.Subscribe(Constant.E_RedDotPath.Task, self.TaskBtn.transform:Find("RedDot").gameObject)
end

function m:RemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.OnNotifyStage, self.DelegateNotifyUpdateStage)
	EventDispatcher.RemoveEventListener(EventID.UnlockFunction, self.DelegateOnUnlockFunctionUpdateEvent)
	self.StartGameBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickStartGameBtn)
	RedDotModule.Unsubscribe(Constant.E_RedDotPath.Task, self.TaskBtn.transform:Find("RedDot").gameObject)
end

function m:OnClickStartGameBtn()
	UIModule.Open(Constant.UIControllerName.PlayingMethodUI, Constant.UILayer.UI)
end

function m:SetData()
	self:RefreshBannerScroll()
	self:BannerRoll()
	self:RefreshMainLineProcess()
	self:OnRefreshUnlockBtn()
end

function m:RefreshMainLineProcess()
	local storyStageCfg = MapModule.GetMainLineNewUnlock()

	if storyStageCfg ~= nil then
		UGUIUtil.SetText(self.MainLineProcessText, storyStageCfg.Name)
	else
		UGUIUtil.SetText(self.MainLineProcessText, "")
	end
end

function m:InitBannerDataCfg()
	self.bannerCfgs = {}

	for k, v in pairsCfg(CfgPayActivityTable) do
		table.insert(self.bannerCfgs, v)
	end

	table.sort(self.bannerCfgs, function(a, b)
		return a.Id < b.Id
	end)
end

function m:RefreshBannerScroll()
	self.BannerScrollPageExt.allPageCount = 0

	local tempBannerCfgs = {}

	for i = 1, #self.bannerCfgs do
		if (self.bannerCfgs[i].Skip == 0 or CfgFunctionTable[self.bannerCfgs[i].Skip].FuncSwitchOpen == 0 or UnlockFunctionModule.IsUnlock(CfgFunctionTable[self.bannerCfgs[i].Skip].FuncSwitchOpen)) and self.bannerCfgs[i].Type == 2 then
			table.insert(tempBannerCfgs, self.bannerCfgs[i])
		end
	end

	for i = 1, #self.BannerItemList do
		self.BannerItemList[i]:Hide()
	end

	for i = 1, #tempBannerCfgs do
		local bannerItemView = self:CreateBannerItem(i, self.BannerScrollPageExt.Content.transform, self.BannerItemList)

		bannerItemView:SetData(tempBannerCfgs[i])
	end

	self.BannerScrollPageExt.allPageCount = #tempBannerCfgs

	if self.BannerScrollPageExt.allPageCount <= 0 then
		return
	end

	if self.BannerScrollPageExt.allPageCount >= 1 then
		self.BannerScrollPageExt:SetHorizontalPos(0)
	end

	self.BannerScrollPageExt:ListPageValueInit()
end

function m:CreateBannerItem(index, transPrent, itemList)
	local luaTable = itemList[index]

	if luaTable == nil then
		local bannerItem = UnityEngine.Object.Instantiate(self.BannerPrefab)

		bannerItem.transform:SetParent(transPrent, false)

		luaTable = bannerItemCell.New(bannerItem)
		itemList[index] = luaTable
	end

	luaTable:Show()

	return luaTable
end

function m:BannerRoll()
	self:StopBannerTimer()

	if self.BannerScrollPageExt.allPageCount <= 1 then
		return
	end

	self.bannerSelectIndex = 0

	self.BannerScrollPageExt:ResetHorizontalPos()
	self.BannerScrollPageExt:SetHorizontalPos(0)

	self.bannerRollTimer = Timer.New(function()
		self.bannerTimes = self.bannerTimes + 1

		if self.bannerTimes >= self.bannerTotalTimes then
			self.bannerSelectIndex = self.bannerSelectIndex + 1

			if self.bannerSelectIndex > self.BannerScrollPageExt.allPageCount then
				self.bannerSelectIndex = 1
			end

			self.BannerScrollPageExt:SetHorizontalPos(self.bannerSelectIndex - 1)
		end
	end, 1, -1)

	self.bannerRollTimer:Start()
end

function m:OnScrollDragEnd(index)
	self.bannerSelectIndex = index + 1
	self.bannerTimes = 1
end

function m:StopBannerTimer()
	if self.bannerRollTimer ~= nil then
		self.bannerRollTimer:Stop()

		self.bannerRollTimer = nil
	end
end

function m:OnRefreshUnlockBtn()
	local funcList = {}

	funcList[Constant.UnlockType.FUNC_TASK] = self.TaskBtn

	UnlockFunctionModule.FuncSwitchHandler(funcList)
	self:RefreshBtnVisable()
end

function m:RefreshBtnVisable()
	self:RefreshBannerScroll()
end

function m:NotifyUpdateStage()
	self:RefreshMainLineProcess()
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
	self:SetData()
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()
	self:StopBannerTimer()

	for k, v in pairs(self.BannerItemList) do
		v:Dispose()
	end

	self.ScrollPageExt = nil
	self.BannerScrollPageExt = nil

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
