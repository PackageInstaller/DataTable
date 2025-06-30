-- chunkname: @IQIGame\\UI\\Lottery\\LotteryTabView.lua

local m = {}

function m.New(view, onSelectEvent)
	local obj = Clone(m)

	obj:Init(view, onSelectEvent)

	return obj
end

function m:Init(view, onSelectEvent)
	self.View = view
	self.OnSelectEvent = onSelectEvent

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.delegateTabClick(isOn)
		self:OnClickTab(isOn)
	end

	self:AddListeners()
end

function m:AddListeners()
	self.View:GetComponent("Toggle").onValueChanged:AddListener(self.delegateTabClick)
end

function m:RemoveListeners()
	self.View:GetComponent("Toggle").onValueChanged:AddListener(self.delegateTabClick)
end

function m:SetData(data, index)
	self.Index = index
	self.poolData = data

	self:RefreshTime()
	AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(CfgCardJackpotTable[self.poolData.id].ShowTabImg[1]), self.OffImg:GetComponent("Image"))
	AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(CfgCardJackpotTable[self.poolData.id].ShowTabImg[2]), self.OnImg:GetComponent("Image"))
end

function m:OnClickTab(isOn)
	if isOn and self.OnSelectEvent ~= nil then
		self.OnSelectEvent(self.Index)
	end
end

function m:SetToggleState(index)
	if index == self.Index then
		self.View:GetComponent("Toggle").isOn = true
	end
end

function m:RefreshTime()
	if self.poolData.activityId == 0 then
		LuaUtility.SetGameObjectShow(self.TimeText, false)

		return
	end

	LuaUtility.SetGameObjectShow(self.TimeText, true)
	self:SetTimeText()

	if self.timer == nil then
		self.timer = Timer.New(function()
			self:SetTimeText()
		end, 1, -1)

		self.timer:Start()
	end
end

function m:SetTimeText()
	self.curTime = tonumber(self.poolData.endTime) - tonumber(PlayerModule.GetServerTimeByMs())

	local time = self.curTime / 1000

	if time > 86400 then
		UGUIUtil.SetText(self.TimeText, DateTimeFormat(time, LotteryUIApi:GetDateTimeFormat_DDHHText(), false))
	else
		UGUIUtil.SetText(self.TimeText, DateTimeFormat(time, LotteryUIApi:GetDateTimeFormat_MMSSText(), false))
	end
end

function m:Dispose()
	if self.timer ~= nil then
		self.timer:Stop()

		self.timer = nil
	end

	self.curTime = nil

	AssetUtil.UnloadAsset(self)
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
