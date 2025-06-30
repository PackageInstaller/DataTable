-- chunkname: @IQIGame\\UI\\NoviceTaskUI\\DayBtnCall.lua

local m = {}

function m.New(go, v, index)
	local o = Clone(m)

	o:Initialize(go, v, index)

	return o
end

function m:Initialize(go, v, index)
	LuaCodeInterface.BindOutlet(go, self)

	function self.DelegateOnDayTabClick(isOn)
		self.v.DelegateOnDayTabClick(isOn, self.tabIndex)
		self:SetTextColor()
	end

	self.tabIndex = index
	self.gameObject = go
	self.v = v
	self.toggle = self.toggleBtn:GetComponent("Toggle")
	self.toggle.group = self.v.dayTabGroup

	self:AddListener()
end

function m:OnDestroy()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function m:AddListener()
	self.toggle.onValueChanged:AddListener(self.DelegateOnDayTabClick)
end

function m:RemoveListener()
	self.toggle.onValueChanged:RemoveListener(self.DelegateOnDayTabClick)
end

function m:_OnClick()
	return
end

function m:Refresh(data, index)
	self.data = data
	self.tabIndex = index
	self.toggle.isOn = self.v.currentDayTag == self.tabIndex

	self:SetTextColor()
	LuaUtility.SetGameObjectShow(self.lockImg.gameObject, data.isLock)
	LuaUtility.SetGameObjectShow(self.lockBottomImg.gameObject, data.isLock)
	LuaUtility.SetGameObjectShow(self.RedDot.gameObject, data.isRed)
end

function m:SetTextColor()
	local dayTip = NoviceTaskUIApi:GetDayTipText()
	local dayCount = NoviceTaskUIApi:GetDayCountText(self.data.key)

	if self.data.isLock then
		UGUIUtil.SetText(self.dayTips, string.format(ColorCfg.LightGray, dayTip))
		UGUIUtil.SetText(self.dayText, string.format(ColorCfg.LightGray, dayCount))

		self.toggle.interactable = false
	else
		if self.toggle.isOn then
			UGUIUtil.SetText(self.dayTips, string.format(ColorCfg.Black, dayTip))
			UGUIUtil.SetText(self.dayText, string.format(ColorCfg.Black, dayCount))
		else
			UGUIUtil.SetText(self.dayTips, string.format(ColorCfg.White, dayTip))
			UGUIUtil.SetText(self.dayText, string.format(ColorCfg.White, dayCount))
		end

		self.toggle.interactable = not self.toggle.isOn
	end
end

return m
