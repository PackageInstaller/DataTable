-- chunkname: @IQIGame\\UI\\ActivityStage\\ActivityStageUI_rewardPanel_stageItem.lua

local ActivityStageUI_rewardPanel_stageItem = {}

function ActivityStageUI_rewardPanel_stageItem.New(go, mainView)
	local o = Clone(ActivityStageUI_rewardPanel_stageItem)

	o:Initialize(go, mainView)

	return o
end

function ActivityStageUI_rewardPanel_stageItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function ActivityStageUI_rewardPanel_stageItem:InitComponent()
	return
end

function ActivityStageUI_rewardPanel_stageItem:InitDelegate()
	function self.delegateOnClickButtonClick()
		self:OnClickButtonClick()
	end
end

function ActivityStageUI_rewardPanel_stageItem:AddListener()
	self.buttonClick:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonClick)
end

function ActivityStageUI_rewardPanel_stageItem:RemoveListener()
	self.buttonClick:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonClick)
end

function ActivityStageUI_rewardPanel_stageItem:OnClickButtonClick()
	if not self.isOpen then
		NoticeModule.ShowNotice(49005)

		return
	end

	self.mainView:SelectStage(self)
	self.mainView:RefreshReward(self.data)
end

function ActivityStageUI_rewardPanel_stageItem:Selected()
	LuaUtility.SetGameObjectShow(self.selected, true)
end

function ActivityStageUI_rewardPanel_stageItem:UnSelected()
	LuaUtility.SetGameObjectShow(self.selected, false)
end

function ActivityStageUI_rewardPanel_stageItem:Refresh(Data)
	self.data = Data

	local cfgChapter = CfgUtil.GetCfgActivityChapterDataWithID(self.data.chapterId)

	LuaUtility.SetText(self.textName, cfgChapter.Name)

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	self.isOpen = PlayerModule.GetIsInTime(self.data.startTime, self.data.endTime)

	LuaUtility.SetGameObjectShow(self.Locked, not self.isOpen)

	if not self.isOpen then
		self.timer = Timer.New(function()
			self:RefreshTime()
		end, 1, -1)

		self.timer:Start()
		self:RefreshTime()
	end

	local maxNum = #cfgChapter.RewardDrop / 2
	local doneNum = 0

	for i, v in pairs(self.data.starState) do
		doneNum = doneNum + 1
	end

	LuaUtility.SetText(self.textDone, doneNum)
	LuaUtility.SetText(self.textMax, maxNum)
	LuaUtility.SetGameObjectShow(self.numRoot, doneNum ~= maxNum)
	LuaUtility.SetGameObjectShow(self.doneRoot, doneNum == maxNum)

	if maxNum == 0 then
		LuaUtility.SetImageFillAmount(self.imageFill, 0)
	else
		LuaUtility.SetImageFillAmount(self.imageFill, doneNum / maxNum)
	end

	LuaUtility.SetGameObjectShow(self.perfectRoot, ActivityDungeonModule.CheckChapterIsPerfectPass(self.data))
	self:UnSelected()
	self:RefreshDot()
end

function ActivityStageUI_rewardPanel_stageItem:RefreshDot()
	LuaUtility.SetGameObjectShow(self.RedDot, RedDotModule.GetRedDotCntByRedDotID(Constant.E_RedDotPath.BattleActivity_Chapter_Reward_List) >= 1 and RedDotModule.BattleActivityChapterRedDot[self.data.chapterId])
end

function ActivityStageUI_rewardPanel_stageItem:RefreshTime()
	local s = tonumber(self.data.startTime) / 1000 - PlayerModule.GetServerTime()

	LuaUtility.SetText(self.textLock, DateStandardFormation(s))

	self.isOpen = PlayerModule.GetIsInTime(self.data.startTime, self.data.endTime)

	if self.isOpen then
		if self.timer then
			self.timer:Stop()

			self.timer = nil
		end

		LuaUtility.SetGameObjectShow(self.Locked, not self.isOpen)
	end
end

function ActivityStageUI_rewardPanel_stageItem:OnDestroy()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end
end

return ActivityStageUI_rewardPanel_stageItem
