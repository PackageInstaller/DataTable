-- chunkname: @IQIGame\\UI\\Activity\\PicturePuzzle\\ActivityPicturePuzzleView.lua

local m = {
	isAmple = false,
	isPlayEffect = false,
	effectCD = 0.1,
	EffectRandomCount = 5,
	playRandomCount = 0,
	puzzleCells = {},
	puzzleRewardCellPool = {},
	puzzleRewardCells = {},
	lastReward = {},
	lastUnlockedPlace = {},
	unlockPlace = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local PicturePuzzleCell = require("IQIGame.UI.Activity.PicturePuzzle.PicturePuzzleCell")
local PicturePuzzleRewardCell = require("IQIGame.UI.Activity.PicturePuzzle.PicturePuzzleRewardCell")

function m.New(view, root, picturePuzzleID)
	local obj = Clone(m)

	obj:Init(view, root, picturePuzzleID)

	return obj
end

function m:Init(view, root, picturePuzzleID)
	self.View = view
	self.root = root
	self.picturePuzzleID = picturePuzzleID

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetText(self.TextBtnUnlockPic, ActivityUIApi:GetString("TextBtnUnlockPic"))
	UGUIUtil.SetText(self.TextBtnTask, ActivityUIApi:GetString("TextBtnTask"))
	UGUIUtil.SetText(self.TextCompletedDes, ActivityUIApi:GetString("TextCompletedDes"))
	UGUIUtil.SetText(self.TextUnlockReward, ActivityUIApi:GetString("TextUnlockReward"))

	function self.delegateBtnTip()
		self:OnBtnTip()
	end

	function self.delegateUpdateOperations()
		self:UpdateOperations()
	end

	function self.delegateBtnUnlockPic()
		self:OnBtnUnlockPic()
	end

	function self.delegateBtnTask()
		self:OnBtnTask()
	end

	self.PicModule:SetActive(false)

	self.puzzleCells = {}

	for i = 1, 16 do
		local puzzleCell = PicturePuzzleCell.New(UnityEngine.Object.Instantiate(self.PicModule), i)

		puzzleCell.View.transform:SetParent(self.picContent.transform, false)
		puzzleCell.View:SetActive(true)

		self.puzzleCells[i] = puzzleCell
	end

	self.puzzleRewardCellPool = UIObjectPool.New(8, function()
		return PicturePuzzleRewardCell.New(UnityEngine.Object.Instantiate(self.RewardMould))
	end, function(cell)
		cell:Dispose()
	end)
	self.progressRewardCell = ItemCell.PackageOrReuseView(self, self.CountReward)
	self.timer = Timer.New(function()
		self:ShowCD()
	end, 1, -1)
	self.isCreate = true
	self.randomTimer = Timer.New(function()
		self:PlayRandomEffect()
	end, self.effectCD, -1)
end

function m.GetPreloadAssetPaths()
	return
end

function m:Update(elapseSeconds, realElapseSeconds)
	return
end

function m:AddListener()
	self:RemoveListener()
	self.BtnTips:GetComponent("Button").onClick:AddListener(self.delegateBtnTip)
	self.BtnUnlockPic:GetComponent("Button").onClick:AddListener(self.delegateBtnUnlockPic)
	self.BtnTask:GetComponent("Button").onClick:AddListener(self.delegateBtnTask)
	EventDispatcher.AddEventListener(EventID.UpdateOperationsEvent, self.delegateUpdateOperations)
end

function m:RemoveListener()
	self.BtnTips:GetComponent("Button").onClick:RemoveListener(self.delegateBtnTip)
	self.BtnUnlockPic:GetComponent("Button").onClick:RemoveListener(self.delegateBtnUnlockPic)
	self.BtnTask:GetComponent("Button").onClick:RemoveListener(self.delegateBtnTask)
	EventDispatcher.RemoveEventListener(EventID.UpdateOperationsEvent, self.delegateUpdateOperations)
end

function m:UpdateOperations()
	if self.unlockTimer then
		self.unlockTimer:Stop()
	end

	if self.rewardTimer then
		self.rewardTimer:Stop()
	end

	self.playRandomCount = 0

	self.randomTimer:Stop()

	self.EffectRandomCount = 5
	self.unlockPlace = {}

	local newUnlockedPlace

	self.eventPOD = ActiveOperationEventModule.GetActiveOperationData(self.picturePuzzleID)
	self.isPlayEffect = false

	if self.eventPOD then
		newUnlockedPlace = ActivePicturePuzzleModule.ipData.unlockedPlace

		if newUnlockedPlace == nil then
			newUnlockedPlace = {}
		end

		if #newUnlockedPlace > #self.lastUnlockedPlace then
			self.isPlayEffect = true

			local unLockNum = #self.puzzleCells - #self.lastUnlockedPlace

			self.EffectRandomCount = math.min(5, unLockNum)

			if self.EffectRandomCount > 1 then
				for i = 1, #self.puzzleCells do
					if table.indexOf(self.lastUnlockedPlace, i) == -1 then
						table.insert(self.unlockPlace, i)
					end
				end

				self:PlayRandomEffect()
				self.randomTimer:Start()
			end

			local newIndex

			for i, v in pairs(newUnlockedPlace) do
				if table.indexOf(self.lastUnlockedPlace, v) == -1 then
					newIndex = v

					break
				end
			end

			self.unlockTimer = Timer.New(function()
				self:PlayUnlockEffect(newIndex)
			end, self.EffectRandomCount * self.effectCD)

			self.unlockTimer:Start()

			self.updateTimer = Timer.New(function()
				self:UpDateView()

				self.isPlayEffect = false
			end, self.EffectRandomCount * self.effectCD + 1)

			self.updateTimer:Start()

			local newReward = self:CanGetRewardList()

			if #newReward > #self.lastReward then
				local rewardTab = {}

				for i, v in pairs(newReward) do
					if table.indexOf(self.lastReward, v) == -1 then
						table.insert(rewardTab, v)
					end
				end

				self.rewardTimer = Timer.New(function()
					self:PlayRewardEffect(rewardTab)
				end, self.EffectRandomCount * self.effectCD + 1)

				self.rewardTimer:Start()
			end
		else
			self:UpDateView()
		end
	end
end

function m:PlayRewardEffect(rewardTab)
	self:SetDefaultEffect()

	for i, v in pairs(rewardTab) do
		local cfgPuzzlesReward = CfgPuzzlesRewardTable[v]
		local index = cfgPuzzlesReward.Combina[1]
		local des = cfgPuzzlesReward.Combina[2] - cfgPuzzlesReward.Combina[1]

		if des == 4 then
			self.puzzleCells[index].EffectColumnUnlock:SetActive(true)
		elseif des == 1 then
			self.puzzleCells[index].EffectRowUnlock:SetActive(true)
		end
	end
end

function m:PlayUnlockEffect(index)
	self:SetDefaultEffect()
	self.puzzleCells[index].EffectUnlock:SetActive(true)
end

function m:PlayRandomEffect()
	local index = math.random(1, #self.unlockPlace)
	local place = self.unlockPlace[index]

	self:SetDefaultEffect()
	self.puzzleCells[place].EffectRandom:SetActive(true)
	table.remove(self.unlockPlace, index)

	self.playRandomCount = self.playRandomCount + 1

	if self.playRandomCount >= self.EffectRandomCount then
		self.randomTimer:Stop()
	end
end

function m:UpDateView()
	self.eventPOD = ActiveOperationEventModule.GetActiveOperationData(self.picturePuzzleID)

	if self.eventPOD then
		self.cfgPuzzlesGlobal = CfgPuzzlesGlobalTable[self.eventPOD.dataCfgId]

		self.timer:Stop()

		if self.eventPOD.status == Constant.Activity_Operation_Sate.STATUS_STARTED or self.eventPOD.status == Constant.Activity_Operation_Sate.STATUS_END then
			self:ShowCD()
			self.timer:Start()
		else
			UGUIUtil.SetText(self.TextPictureTitle, ActivityUIApi:GetString("TextPictureTitle", getCustomDateTimeText(self.eventPOD.startTime, "MonthToMinuteFormat"), getCustomDateTimeText(self.eventPOD.endTime, "MonthToMinuteFormat")))
		end

		for i = 1, #self.puzzleCells do
			local cell = self.puzzleCells[i]
			local state = ActivePicturePuzzleModule.GetPicturePuzzlePosState(self.picturePuzzleID, i)

			cell:UpdateState(state)
		end

		for i, v in pairs(self.puzzleRewardCells) do
			v.View.transform:SetParent(self.root.UIController.transform, false)
			v.View:SetActive(false)
			self.puzzleRewardCellPool:Release(v)
		end

		self.puzzleRewardCells = {}

		local rewardTab = ActivePicturePuzzleModule.GetPuzzleRewards(self.picturePuzzleID)

		for i = 1, #rewardTab do
			local cfgPuzzleReward = rewardTab[i]
			local parentTransformPos = self.RewardPos.transform:Find("Position_" .. i)

			if cfgPuzzleReward and parentTransformPos then
				local cell = self.puzzleRewardCellPool:Obtain()

				cell.View:SetActive(true)
				cell.View.transform:SetParent(parentTransformPos, false)
				cell:SetData(cfgPuzzleReward, i, self.picturePuzzleID)
				table.insert(self.puzzleRewardCells, cell)
			end
		end

		self.progressReward = ActivePicturePuzzleModule.GetProgressReward(self.picturePuzzleID)

		local progressState = self.progressReward[1]
		local openNum = 0

		if ActivePicturePuzzleModule.ipData then
			openNum = #ActivePicturePuzzleModule.ipData.unlockedPlace
		end

		local showNum = openNum > self.progressReward[1] and self.progressReward[1] or openNum

		UGUIUtil.SetText(self.TextRewardCount, ActivityUIApi:GetString("TextRewardCount", showNum, self.progressReward[1]))

		local openNum = ActivePicturePuzzleModule.GetPictureUnlockPlace(self.picturePuzzleID)

		self.progressRewardCell:SetItem(CfgItemTable[self.progressReward[2]])
		self.progressRewardCell:SetNum(self.progressReward[3])

		if progressState > ActivePicturePuzzleModule.GetMaxProgressStatus(self.picturePuzzleID) and openNum >= self.progressReward[1] then
			self.RedGetReward:SetActive(true)
			self.progressRewardCell:SetClickHandler(function()
				ActivePicturePuzzleModule.ImagePuzzleGetReward(self.picturePuzzleID)
			end)
		else
			self.RedGetReward:SetActive(false)
			self.progressRewardCell:ResetClickHandler()
		end

		local have = WarehouseModule.GetItemNumByCfgID(Constant.ItemID.PUZZLE_PIECES)

		UGUIUtil.SetText(self.TextHave, ActivityUIApi:GetString("TextHave", have))

		self.nextOpen = openNum + 1

		if self.nextOpen > #self.cfgPuzzlesGlobal.UnlockCost then
			self.nextOpen = #self.cfgPuzzlesGlobal.UnlockCost
		end

		local needNum = self.cfgPuzzlesGlobal.UnlockCost[self.nextOpen]

		self.isAmple = needNum <= have

		UGUIUtil.SetText(self.TextNeed, ActivityUIApi:GetString("TextNeed", needNum, self.isAmple))

		local uiTasks, processingReward, finishedReward = ActivePicturePuzzleModule.GetPicturePuzzleTaskData({
			1
		})

		UGUIUtil.SetText(self.TextTaskReward, ActivityUIApi:GetString("TextTaskReward", #finishedReward, #processingReward + #finishedReward))

		local uiTasks, processingDay, finishedDay = ActivePicturePuzzleModule.GetPicturePuzzleTaskData({
			2
		})

		UGUIUtil.SetText(self.TextDayReward, ActivityUIApi:GetString("TextDayReward", #finishedDay, #finishedDay + #processingDay))

		local count, totalCount = ActivePicturePuzzleModule.GetCompletedProgress(self.picturePuzzleID)

		UGUIUtil.SetText(self.TextCompleted, ActivityUIApi:GetString("TextCompleted", count, totalCount))

		local max = #self.puzzleCells
		local isShow = openNum < max and self.eventPOD.status == Constant.Activity_Operation_Sate.STATUS_STARTED

		self.BtnUnlockPic:SetActive(openNum < max)
		self.TaskView:SetActive(isShow)
		self.CostTip:SetActive(openNum < max)

		self.lastUnlockedPlace = ActivePicturePuzzleModule.ipData.unlockedPlace
	end
end

function m:ShowCD()
	if self.eventPOD then
		if PlayerModule.GetServerTime() > self.eventPOD.endTime and PlayerModule.GetServerTime() < self.eventPOD.closeTime then
			local cd = self.eventPOD.closeTime - PlayerModule.GetServerTime()

			if cd >= 0 then
				UGUIUtil.SetText(self.TextPictureTitle, ActivityUIApi:GetString("TextPicTimeClose", cd))
			end
		else
			UGUIUtil.SetText(self.TextPictureTitle, ActivityUIApi:GetString("TextPictureTitle", getCustomDateTimeText(self.eventPOD.startTime, "MonthToMinuteFormat"), getCustomDateTimeText(self.eventPOD.endTime, "MonthToMinuteFormat")))
		end
	end
end

function m:SetDefaultEffect()
	for i, v in pairs(self.puzzleCells) do
		v:SetDefaultEffect()
	end
end

function m:CanGetRewardList()
	local tab = {}
	local rewardTab = ActivePicturePuzzleModule.GetPuzzleRewards(self.picturePuzzleID)

	for i = 1, #rewardTab do
		local cfgPuzzleReward = rewardTab[i]
		local state = ActivePicturePuzzleModule.GetPicRewardState(self.picturePuzzleID, cfgPuzzleReward.Id)

		if state == 2 then
			table.insert(tab, cfgPuzzleReward.Id)
		end
	end

	return tab
end

function m:OnBtnUnlockPic()
	if not self.isAmple then
		NoticeModule.ShowNotice(21080000)

		return
	end

	if self.isPlayEffect then
		return
	end

	self.lastUnlockedPlace = ActivePicturePuzzleModule.ipData.unlockedPlace

	if self.lastUnlockedPlace == nil then
		self.lastUnlockedPlace = {}
	end

	self.lastReward = self:CanGetRewardList()

	ActivePicturePuzzleModule.ImagePuzzleUnlock(self.picturePuzzleID)
end

function m:OnBtnTip()
	UIModule.Open(Constant.UIControllerName.DailyActivityTipsUI, Constant.UILayer.UI, self.cfgPuzzlesGlobal.Desc)
end

function m:OnBtnTask()
	UIModule.Open(Constant.UIControllerName.DailyPicturePuzzleMissionUI, Constant.UILayer.UI)
end

function m:Open()
	self.isPlayEffect = false

	self:AddListener()
	self:SetDefaultEffect()
	self.View:SetActive(true)
	self:UpDateView()
end

function m:Close()
	self.View:SetActive(false)
	self:OnHide()
end

function m:OnHide()
	if self.timer then
		self.timer:Stop()
	end

	if self.randomTimer then
		self.randomTimer:Stop()
	end

	if self.unlockTimer then
		self.unlockTimer:Stop()
	end

	if self.rewardTimer then
		self.rewardTimer:Stop()
	end

	if self.updateTimer then
		self.updateTimer:Stop()
	end

	self:RemoveListener()
end

function m:OnDestroy()
	self.timer = nil
	self.randomTimer = nil
	self.unlockTimer = nil
	self.rewardTimer = nil
	self.updateTimer = nil

	for i, v in pairs(self.puzzleCells) do
		v:Dispose()
	end

	for i, v in pairs(self.puzzleRewardCells) do
		self.puzzleRewardCellPool:Release(v)
	end

	self.puzzleRewardCells = {}

	self.puzzleRewardCellPool:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
