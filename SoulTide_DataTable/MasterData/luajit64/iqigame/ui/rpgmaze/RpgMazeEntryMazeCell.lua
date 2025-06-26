-- chunkname: @IQIGame\\UI\\RpgMaze\\RpgMazeEntryMazeCell.lua

local m = {
	IsUnlock = false,
	MazeInstanceCid = 0
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickBossBtn()
		self:OnClickBossBtn()
	end

	self:AddListeners()
end

function m:AddListeners()
	self.BossBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBossBtn)
end

function m:RemoveListeners()
	self.BossBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBossBtn)
end

function m:SetData(mazeInstanceCid, rpgMazeBossCid)
	self.MazeInstanceCid = mazeInstanceCid
	self.RpgMazeBossCid = rpgMazeBossCid

	local cfgMazeInstanceData = CfgMazeInstanceTable[mazeInstanceCid]
	local isUnlockConditionOK = ConditionModule.Check(cfgMazeInstanceData.LockCondition)
	local serverTime = PlayerModule.GetServerTime()
	local openTime = cfgDateTimeToTimeStamp(cfgMazeInstanceData.OpenDate, PlayerModule.TimeZone)
	local closeTime = cfgDateTimeToTimeStamp(cfgMazeInstanceData.CloseDate, PlayerModule.TimeZone)
	local isOpenInTime = openTime <= serverTime and serverTime < closeTime

	self.IsUnlock = isUnlockConditionOK and isOpenInTime

	self.NormalView:SetActive(self.IsUnlock)
	self.LockView:SetActive(not self.IsUnlock)
	AssetUtil.LoadImage(self, RpgMazeEntryUIApi:GetString("MazeCellBackground", self.IsUnlock, RpgMazeModule.DailyDupPOD.common.openCount), self.Background:GetComponent("Image"))
	AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(cfgMazeInstanceData.BackgroundRes), self.MazeIcon:GetComponent("Image"))

	if self.IsUnlock then
		UGUIUtil.SetText(self.NormalNameText, cfgMazeInstanceData.Name)

		local mazeInfoPOD = PlayerModule.PlayerInfo.mazeInfoPOD[self.MazeInstanceCid]
		local score = 0

		if mazeInfoPOD ~= nil then
			score = mazeInfoPOD.score
		end

		UGUIUtil.SetText(self.ProgressText, RpgMazeEntryUIApi:GetString("ProgressText", score))

		self.ProgressBar:GetComponent("Image").fillAmount = score / 100

		AssetUtil.LoadImage(self, RpgMazeEntryUIApi:GetString("MazeOrderImage", cfgMazeInstanceData.Order, RpgMazeModule.DailyDupPOD.common.openCount), self.NormalMazeOrderImage:GetComponent("Image"))
	else
		UGUIUtil.SetText(self.LockNameText, cfgMazeInstanceData.Name)

		local unlockConditionText

		if not isOpenInTime then
			local timeState

			timeState = serverTime < openTime and 1 or closeTime <= serverTime and 3 or 2
			unlockConditionText = RpgMazeEntryUIApi:GetString("RpgMazeUnlockTimeText", getCustomDateTimeText(openTime, "MonthToMinuteFormat"), getCustomDateTimeText(closeTime, "MonthToMinuteFormat"), timeState)
		else
			local cfgConditionData = CfgConditionTable[cfgMazeInstanceData.LockCondition]

			unlockConditionText = cfgConditionData.Name
		end

		UGUIUtil.SetText(self.UnlockConditionText, unlockConditionText)
		AssetUtil.LoadImage(self, RpgMazeEntryUIApi:GetString("MazeOrderImage", cfgMazeInstanceData.Order, RpgMazeModule.DailyDupPOD.common.openCount), self.LockMazeOrderImage:GetComponent("Image"))
	end

	local isBossUnlock = table.indexOf(RpgMazeModule.DailyDupPOD.rpgMazePOD.unlockBoss, self.RpgMazeBossCid) ~= -1

	self.BossNormalView:SetActive(isBossUnlock)
	self.BossLockView:SetActive(not isBossUnlock)

	local cfgRPGMazeBossData = CfgRPGMazeBossTable[self.RpgMazeBossCid]
	local cfgMonsterTeamData = CfgMonsterTeamTable[cfgRPGMazeBossData.MonsterTeam]
	local cfgBossMonsterData

	for i = 1, #cfgMonsterTeamData.TeamUnit do
		local monsterCid = cfgMonsterTeamData.TeamUnit[i]

		if monsterCid ~= 0 then
			local cfgMonsterData = CfgMonsterTable[monsterCid]

			if cfgMonsterData.IsBoss then
				cfgBossMonsterData = cfgMonsterData

				break
			end
		end
	end

	AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(cfgBossMonsterData.HeadIcon), self.BossIcon:GetComponent("Image"))
end

function m:OnClickBossBtn()
	local isBossUnlock = table.indexOf(RpgMazeModule.DailyDupPOD.rpgMazePOD.unlockBoss, self.RpgMazeBossCid) ~= -1

	if not isBossUnlock then
		local cfgDailyDupData = CfgDailyDupTable[RpgMazeModule.DailyDupPOD.common.cid]
		local chapterName = cfgDailyDupData.ChapterName[RpgMazeModule.DailyDupPOD.common.openCount]

		NoticeModule.ShowNoticeNoCallback(21057002, chapterName)

		return
	end

	UIModule.Open(Constant.UIControllerName.MazeBossChallengeEntryUI, Constant.UILayer.UI, self.RpgMazeBossCid)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
