-- chunkname: @IQIGame\\UI\\Lottery\\LotteryTabGroupController.lua

local m = {
	TabBtns = {}
}
local LotteryTabBtnController = require("IQIGame.UI.Lottery.LotteryTabBtnController")
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")

function m.New(view, onSelect, togglePrefab, toggleGroup, host)
	local obj = Clone(m)

	obj:Init(view, onSelect, togglePrefab, toggleGroup, host)

	return obj
end

function m:Init(view, onSelect, togglePrefab, toggleGroup, host)
	self.View = view
	self.ToggleGroup = toggleGroup
	self.Host = host

	LuaCodeInterface.BindOutlet(self.View, self)

	self.TabBtnPool = UIObjectPool.New(5, function()
		return LotteryTabBtnController.New(UnityEngine.Object.Instantiate(togglePrefab), host, onSelect)
	end, function(controller)
		local v = controller.View

		controller:Dispose()
		UnityEngine.Object.Destroy(v)
	end)
end

function m:OnUpdate(elapseSeconds, realElapseSeconds)
	for i = 1, #self.TabBtns do
		local btn = self.TabBtns[i]

		btn:OnUpdate(elapseSeconds, realElapseSeconds)
	end
end

function m:SetData(dataList, type, leftTimeSecs)
	self:ClearTabBtns()

	for i = 1, #dataList do
		local cfgLotteryShowData = dataList[i]
		local btn = self.TabBtnPool:Obtain()

		btn.View:SetActive(true)
		btn.View.transform:SetParent(self.TabGrid.transform, false)
		btn:SetData(cfgLotteryShowData, leftTimeSecs[cfgLotteryShowData.Id], i)
		btn:SetSplitLineVisible(i < #dataList)
		btn:SetGroup(self.ToggleGroup)

		self.TabBtns[i] = btn
	end

	UGUIUtil.SetText(self.NameText, LotteryUIApi:GetString("ToggleGroupName", type == Constant.LotteryType.Lottery_Soul))
end

function m:ClearTabBtns(isDestroy)
	for i = 1, #self.TabBtns do
		local btn = self.TabBtns[i]

		btn:SetGroup(nil)
		btn.View:SetActive(false)

		if not isDestroy then
			btn.View.transform:SetParent(self.Host.UIController.transform, false)
		end

		self.TabBtnPool:Release(btn)
	end

	self.TabBtns = {}
end

function m:SetSelectToggle(tabIndex)
	self.TabBtns[tabIndex]:SetIsOn(true)
end

function m:Dispose()
	self:ClearTabBtns(true)
	self.TabBtnPool:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.ToggleGroup = nil
	self.Host = nil
end

return m
