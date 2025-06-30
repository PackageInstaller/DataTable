-- chunkname: @IQIGame\\UI\\ActivityList\\StrengthActivity\\StrengthSupplyInfoItemView.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickReceiveBtn()
		self:OnClickReceiveBtn()
	end

	self:AddListeners()
end

function m:AddListeners()
	self.receiveBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickReceiveBtn)
end

function m:RemoveListeners()
	self.receiveBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickReceiveBtn)
end

function m:SetData(activityCid, status, index, time1, time2, itemCid)
	self.status = status
	self.activityCid = activityCid
	self.Index = index - 1

	local itemCfg = CfgItemTable[itemCid]
	local previewItems = ItemModule.GetGiftPreviewItems(itemCfg)

	UGUIUtil.SetText(self.ItemNameText, CfgItemTable[previewItems[1].cid].Name)
	UGUIUtil.SetText(self.ItemNumberText, previewItems[1].count)
	UGUIUtil.SetText(self.TimeText1, GetFormatTime(tonumber(time1)))
	UGUIUtil.SetText(self.TimeText2, GetFormatTime(tonumber(time2)))

	if self.status == nil then
		self.status = 0
	end

	self:RefreshReceiveState()
end

function m:RefreshReceiveState()
	LuaUtility.SetGameObjectShow(self.canReceiveFrame, self.status == 1)
	LuaUtility.SetGameObjectShow(self.canNotReceiveFrame, self.status == 0 or self.status == 2)
	LuaUtility.SetGameObjectShow(self.receiveBtn, self.status ~= 2)
	LuaUtility.SetGameObjectShow(self.receiveText, self.status == 1)
	LuaUtility.SetGameObjectShow(self.receivedText, self.status == 2)
	LuaUtility.SetGameObjectShow(self.notReceiveText, self.status == 0)
end

function m:OnClickReceiveBtn()
	if self.status == 0 then
		NoticeModule.ShowNotice(53004)

		return
	end

	ActivityModule.ReceiveSupply(self.activityCid, self.Index)
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
