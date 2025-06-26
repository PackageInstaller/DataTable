-- chunkname: @IQIGame\\UI\\Lottery\\LotteryTabBtnController.lua

local m = {
	Index = 0,
	UpdateIntervalTimer = 0,
	UPDATE_INTERVAL = 0.5
}

function m.New(view, host, onSelectCallback)
	local obj = Clone(m)

	obj:Init(view, host, onSelectCallback)

	return obj
end

function m:Init(view, host, onSelectCallback)
	self.View = view
	self.Host = host
	self.OnSelectCallback = onSelectCallback

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickTabBtn(isOn)
		self:OnClickTabBtn(isOn)
	end

	UGUIUtil.SetText(self.LimitLabel, LotteryUIApi:GetString("TabBtnLimitLabel"))
	self.View:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnClickTabBtn)
end

function m:SetData(cfgLotteryShowData, leftTimeSec, index)
	self.LeftTimeSec = leftTimeSec

	self.View:SetActive(cfgLotteryShowData ~= nil)

	if cfgLotteryShowData == nil then
		return
	end

	self.View.name = "LotteryShow_" .. cfgLotteryShowData.Id
	self.Index = index

	UGUIUtil.SetText(self.Text1, cfgLotteryShowData.Name)
	UGUIUtil.SetText(self.Text2, cfgLotteryShowData.Name)
	self.LimitNode:SetActive(leftTimeSec ~= nil)

	local hasPoolCanDrawForFree = false

	for i, poolCid in pairs(cfgLotteryShowData.Pool) do
		local cfgLotteryData = CfgLotteryTable[poolCid]
		local leftFreeTime, haveFreeFunc = LotteryModule.CanFreeDraw(cfgLotteryData)

		if leftFreeTime == 0 then
			hasPoolCanDrawForFree = true

			break
		end
	end

	self.RedPoint:SetActive(hasPoolCanDrawForFree)
end

function m:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.LeftTimeSec ~= nil then
		self.LeftTimeSec = self.LeftTimeSec - realElapseSeconds
		self.UpdateIntervalTimer = self.UpdateIntervalTimer + elapseSeconds

		if self.UpdateIntervalTimer > m.UPDATE_INTERVAL then
			self.UpdateIntervalTimer = 0

			UGUIUtil.SetText(self.LimitTimeText, getSimpleTimeDurationText(self.LeftTimeSec >= 0 and self.LeftTimeSec or 0))
		end
	end
end

function m:OnClickTabBtn(isOn)
	if isOn and self.OnSelectCallback ~= nil then
		self.OnSelectCallback(self.Index)
	end
end

function m:SetIsOn(value)
	self.View:GetComponent("Toggle").isOn = value
end

function m:SetSplitLineVisible(value)
	self.SplitLine:SetActive(value)
end

function m:SetGroup(toggleGroup)
	self.View:GetComponent("Toggle").group = toggleGroup
end

function m:Dispose()
	self.View:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnClickTabBtn)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.Host = nil
end

return m
