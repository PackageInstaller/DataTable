-- chunkname: @IQIGame\\UI\\EndlessPlusMaze\\EndlessPlusMazeLevelBtnController.lua

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

	UGUIUtil.SetText(self.ConditionLabel, ExploreHallUIApi:GetString("EndlessPlusBtnUnlockLabel"))
end

function m:AddListeners()
	self.MainBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickMainBtn)
end

function m:RemoveListeners()
	self.MainBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickMainBtn)
end

function m:Refresh()
	local cfgEndlessPlusGlobalData = CfgEndlessPlusGlobalTable[EndlessPlusMazeModule.GlobalCid]
	local levelCid = cfgEndlessPlusGlobalData.Level[self.Index]
	local cfgEndlessPlusLevelData = CfgEndlessPlusLevelTable[levelCid]
	local isUnlock = EndlessPlusMazeModule.IsPreviousLevelPassed(levelCid)

	self.NormalView:SetActive(isUnlock)
	self.LockView:SetActive(not isUnlock)
	UGUIUtil.SetTextInChildren(self.MainBtn, cfgEndlessPlusLevelData.MazeName)
	UGUIUtil.SetTextInChildren(self.LockBtn, cfgEndlessPlusLevelData.MazeName)
	UGUIUtil.SetTextInChildren(self.LevelDescText, cfgEndlessPlusLevelData.Desc)

	if not isUnlock then
		UGUIUtil.SetText(self.ConditionDescText, ExploreHallUIApi:GetString("EndlessPlusBtnUnlockDescText", not isUnlock))
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
