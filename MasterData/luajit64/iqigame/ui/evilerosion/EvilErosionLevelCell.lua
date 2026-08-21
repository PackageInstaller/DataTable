-- chunkname: @IQIGame\\UI\\EvilErosion\\EvilErosionLevelCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function m:SetData(levelCid, index)
	local cfgEvilErosionGlobalData = EvilErosionModule.GetGlobalData()
	local cellLevelIndex = table.indexOf(cfgEvilErosionGlobalData.EvilErosionLevel, levelCid)
	local playerCurLevelIndex = table.indexOf(cfgEvilErosionGlobalData.EvilErosionLevel, EvilErosionModule.GetCurrentLevelCid())
	local isPassed = cellLevelIndex < playerCurLevelIndex or EvilErosionModule.IsAllPassed()
	local isUnlock, unlockTime = EvilErosionModule.IsLevelUnlockByTime(levelCid)
	local isCurrent = cellLevelIndex == playerCurLevelIndex

	self.LockView:SetActive(not isUnlock)
	self.CurrentView:SetActive(isCurrent)
	self.NormalView:SetActive(not isPassed and not isCurrent)
	self.PassView:SetActive(isPassed)

	for i = 1, 2 do
		self["NormalImage" .. i]:SetActive(not isPassed and index < 5)
		self["BossImage" .. i]:SetActive(not isPassed and index == 5)
	end

	local cfgEvilErosionLevelData = CfgEvilErosionLevelTable[levelCid]

	UGUIUtil.SetText(self.GamePlayLevelText, EvilErosionUIApi:GetString("LevelCell_GamePlayLevelText", cfgEvilErosionLevelData.Level, cfgEvilErosionLevelData.Name))
end

function m:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
