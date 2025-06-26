-- chunkname: @IQIGame\\UI\\Achievement\\AchievementTaskDetailItem.lua

local AchievementTaskDetailItem = {}

function AchievementTaskDetailItem.New(go, mainView)
	local o = Clone(AchievementTaskDetailItem)

	o:Initialize(go, mainView)

	return o
end

function AchievementTaskDetailItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()

	self.content = self.detailTitleText:GetComponent("Text").text
end

function AchievementTaskDetailItem:InitComponent()
	self.imageAchievementItem = self.achievementItem:GetComponent("Image")
end

function AchievementTaskDetailItem:InitDelegate()
	function self.rewardLeftDelegate()
		self:OnRewardLeftClick()
	end
end

function AchievementTaskDetailItem:AddListener()
	self.rewardLeft:GetComponent("Button").onClick:AddListener(self.rewardLeftDelegate)
end

function AchievementTaskDetailItem:RemoveListener()
	self.rewardLeft:GetComponent("Button").onClick:RemoveListener(self.rewardLeftDelegate)
end

function AchievementTaskDetailItem:ResetStatus()
	LuaUtility.SetGameObjectShow(self.textProgress, false)
	LuaUtility.SetGameObjectShow(self.textHadGot, false)
end

function AchievementTaskDetailItem:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function AchievementTaskDetailItem:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function AchievementTaskDetailItem:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function AchievementTaskDetailItem:OnRewardLeftClick()
	return
end

function AchievementTaskDetailItem:Refresh(Data, OptimizedViewsHolder)
	self.Data = Data.data
	self.type = Data.type
	self.tabIndex = Data.tabIndex

	if self.type == 0 then
		LuaUtility.SetGameObjectShow(self.achievementTaskItem, true)
		LuaUtility.SetGameObjectShow(self.typeParent, false)

		OptimizedViewsHolder.ControlSize = 106
	else
		LuaUtility.SetGameObjectShow(self.achievementTaskItem, false)
		LuaUtility.SetGameObjectShow(self.typeParent, true)

		OptimizedViewsHolder.ControlSize = 40
	end

	if table.len(self.Data) == 0 then
		return
	end

	self:ResetStatus()

	local cfgData = TaskSystemModule.GetCfgTaskDataWithID(self.Data.cid)

	LuaUtility.SetText(self.textName, cfgData.Name)
	LuaUtility.SetText(self.textTaskDetail, cfgData.Desc)
	LuaUtility.SetText(self.textGrade, cfgData.GradeText)

	if TaskSystemModule.GetFinishedTaskWithID(self.Data.cid) then
		LuaUtility.SetGameObjectShow(self.textHadGot, true)

		if self.Data.completeTime == nil then
			LuaUtility.SetGameObjectShow(self.TextSort, false)
			LuaUtility.SetGameObjectShow(self.textGotTime, false)
		else
			LuaUtility.SetText(self.textGotTime, getDateText(self.Data.completeTime / 1000))

			if cfgData.IsShowCount then
				LuaUtility.SetText(self.textNumber, math.floor(self.Data.schedule / cfgData.NeedSchedule))
				LuaUtility.SetGameObjectShow(self.TextSort, true)
			else
				LuaUtility.SetGameObjectShow(self.TextSort, false)
			end

			LuaUtility.SetGameObjectShow(self.textGotTime, true)
		end

		LuaUtility.SetGameObjectShow(self.IsFinishbg, false)
		LuaUtility.SetText(self.textName, string.format(ColorCfg.ActivityPassUI.activityTypeSelect, cfgData.Name))
		LuaUtility.SetText(self.detailTitleText, string.format(ColorCfg.ActivityPassUI.activityLevelText, self.content))
		LuaUtility.SetText(self.textTaskDetail, string.format(ColorCfg.ActivityPassUI.activityLevelText, cfgData.Desc))
	elseif self.Data.status == Constant.TaskStatus.doing then
		LuaUtility.SetGameObjectShow(self.IsFinishbg, true)
		LuaUtility.SetGameObjectShow(self.textProgress, true)
		LuaUtility.SetText(self.textProgress, self.Data.schedule .. "/" .. cfgData.NeedSchedule)
		LuaUtility.SetText(self.textName, string.format(ColorCfg.ActivityPassUI.activityTypeNoSelect, cfgData.Name))
		LuaUtility.SetText(self.detailTitleText, string.format(ColorCfg.ActivityPassUI.activityLevelNoText, self.content))
		LuaUtility.SetText(self.textTaskDetail, string.format(ColorCfg.ActivityPassUI.activityLevelNoText, cfgData.Desc))
	elseif self.Data.status == Constant.TaskStatus.hasDone then
		LuaUtility.SetGameObjectShow(self.IsFinishbg, false)
		LuaUtility.SetText(self.textName, string.format(ColorCfg.ActivityPassUI.activityTypeSelect, cfgData.Name))
		LuaUtility.SetText(self.detailTitleText, string.format(ColorCfg.ActivityPassUI.activityLevelText, self.content))
		LuaUtility.SetText(self.textTaskDetail, string.format(ColorCfg.ActivityPassUI.activityLevelText, cfgData.Desc))
	end

	LuaUtility.LoadImage(self, UIGlobalApi.GetIconPath(cfgData.EmblemIcon), self.imageAchievementItem)
	LuaUtility.SetGameObjectShow(self.rewardLeft, true)
end

return AchievementTaskDetailItem
