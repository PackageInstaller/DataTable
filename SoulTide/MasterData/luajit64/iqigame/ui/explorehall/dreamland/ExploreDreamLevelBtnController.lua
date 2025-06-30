-- chunkname: @IQIGame\\UI\\ExploreHall\\Dreamland\\ExploreDreamLevelBtnController.lua

local m = {
	Index = 0
}

function m.New(view, index, onClick)
	local obj = Clone(m)

	obj:Init(view, index, onClick)

	return obj
end

function m:Init(view, index, onClick)
	self.View = view
	self.Index = index
	self.OnClickCallback = onClick

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickMainBtn()
		self:OnClickMainBtn()
	end

	UGUIUtil.SetText(self.ConditionLabel, ExploreHallUIApi:GetString("DreamLevelBtnUnlockLabel"))
end

function m:AddListeners()
	self.MainBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickMainBtn)
end

function m:RemoveListeners()
	self.MainBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickMainBtn)
end

function m:Refresh()
	local cfgDreamMapGlobalData = CfgDreamMapGlobalTable[DreamlandModule.GlobalCid]
	local dreamMapListCid = cfgDreamMapGlobalData.DreamMapList[self.Index]
	local cfgDreamMapListData = CfgDreamMapListTable[dreamMapListCid]
	local isUnlock = cfgDreamMapListData.IsUnlock or table.indexOf(DreamlandModule.DailyDupPOD.dreamMapPOD.unlockMaps, dreamMapListCid) ~= -1
	local startTime = cfgDateTimeToTimeStamp(cfgDreamMapListData.OpenDate, PlayerModule.TimeZone)
	local currentServerTime = PlayerModule.GetServerTime()
	local isFinalUnlock = isUnlock and startTime < currentServerTime

	self.NormalView:SetActive(isFinalUnlock)
	self.LockView:SetActive(not isFinalUnlock)
	UGUIUtil.SetTextInChildren(self.MainBtn, cfgDreamMapListData.Name)
	UGUIUtil.SetTextInChildren(self.LockBtn, cfgDreamMapListData.Name)

	if not isFinalUnlock then
		UGUIUtil.SetText(self.ConditionDescText, ExploreHallUIApi:GetString("DreamLevelBtnUnlockDescText", not isUnlock, currentServerTime, startTime))
	end
end

function m:OnClickMainBtn()
	self.OnClickCallback(self.Index)
end

function m:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.OnClickCallback = nil
end

return m
