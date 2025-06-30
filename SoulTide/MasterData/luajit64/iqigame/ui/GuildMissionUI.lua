-- chunkname: @IQIGame\\UI\\GuildMissionUI.lua

local GuildMissionUI = {
	TaskItems = {},
	GuildMissionItems = {},
	guildRewardDataTab = {}
}

GuildMissionUI = Base:Extend("GuildMissionUI", "IQIGame.Onigao.UI.GuildMissionUI", GuildMissionUI)

require("IQIGame.UIExternalApi.GuildMissionUIApi")

local GuildTaskItem = require("IQIGame.UI.Guild.GuildTask.GuildTaskItem")
local GuildMissionItem = require("IQIGame.UI.Guild.GuildTask.GuildMissionItem")

function GuildMissionUI:OnInit()
	UGUIUtil.SetText(self.TitleText, GuildMissionUIApi:GetString("TitleText"))
	UGUIUtil.SetText(self.DailyTaskTitle, GuildMissionUIApi:GetString("DailyTaskTitle"))
	UGUIUtil.SetText(self.WeeklyTaskTitle, GuildMissionUIApi:GetString("WeeklyTaskTitle"))
	UGUIUtil.SetTextInChildren(self.GetAllTaskBtn, GuildMissionUIApi:GetString("GetAllTaskBtnLabel"))
	UGUIUtil.SetTextInChildren(self.GetAllWeeklyBtn, GuildMissionUIApi:GetString("GetAllWeeklyBtn"))
	UGUIUtil.SetTextInChildren(self.LookRewardBtn, GuildMissionUIApi:GetString("LookRewardBtn"))

	self.DailyTaskScrollArea:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderDailyTaskCell(cell)
	end
	self.WeeklyTaskScrollArea:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderWeeklyTaskCell(cell)
	end

	function self.DelegateFullScreenCloseBtn()
		self:OnCloseBtn()
	end

	function self.DelegateCloseBtn()
		self:OnCloseBtn()
	end

	function self.DelegateGetAllTaskBtn()
		self:OnGetAllTaskBtn()
	end

	function self.DelegateGetAllWeeklyBtn()
		self:OnGetAllWeeklyBtn()
	end

	function self.DelegateOnTaskUpdate()
		self:OnTaskUpdate()
	end

	function self.DelegateOnUpdateMissionEvent()
		self:OnUpdateMissionEvent()
	end

	function self.DelegateUpdateDailySupply()
		self:OnUpdateDailySupply()
	end

	function self.DelegateLookRewardBtn()
		self:OnLookReward()
	end

	function self.DelegateOnTaskCommitResponse(cids, awards)
		self:OnTaskCommitResponse(cids, awards)
	end

	self.guildRewardDataTab = {}

	for i, v in pairsCfg(CfgGuildActiveRewardTable) do
		table.insert(self.guildRewardDataTab, v)
	end

	table.sort(self.guildRewardDataTab, function(a, b)
		return a.Level > b.Level
	end)
end

function GuildMissionUI:GetPreloadAssetPaths()
	return nil
end

function GuildMissionUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function GuildMissionUI:IsManualShowOnOpen(userData)
	return false
end

function GuildMissionUI:GetBGM(userData)
	return nil
end

function GuildMissionUI:OnOpen(userData)
	GuildModule.GetQuestProgress()
	self:UpdateView()
end

function GuildMissionUI:OnClose(userData)
	return
end

function GuildMissionUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateCloseBtn)
	self.FullScreenCloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateFullScreenCloseBtn)
	self.GetAllTaskBtn:GetComponent("Button").onClick:AddListener(self.DelegateGetAllTaskBtn)
	self.GetAllWeeklyBtn:GetComponent("Button").onClick:AddListener(self.DelegateGetAllWeeklyBtn)
	self.LookRewardBtn:GetComponent("Button").onClick:AddListener(self.DelegateLookRewardBtn)
	EventDispatcher.AddEventListener(EventID.TaskUpdate, self.DelegateOnTaskUpdate)
	EventDispatcher.AddEventListener(EventID.GuildUpdateMissionEvent, self.DelegateOnUpdateMissionEvent)
	EventDispatcher.AddEventListener(EventID.UpdateDailySupply, self.DelegateUpdateDailySupply)
	EventDispatcher.AddEventListener(EventID.TaskCommitResponse, self.DelegateOnTaskCommitResponse)
end

function GuildMissionUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateCloseBtn)
	self.FullScreenCloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateFullScreenCloseBtn)
	self.GetAllTaskBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateGetAllTaskBtn)
	self.GetAllWeeklyBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateGetAllWeeklyBtn)
	self.LookRewardBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateLookRewardBtn)
	EventDispatcher.RemoveEventListener(EventID.TaskUpdate, self.DelegateOnTaskUpdate)
	EventDispatcher.RemoveEventListener(EventID.GuildUpdateMissionEvent, self.DelegateOnUpdateMissionEvent)
	EventDispatcher.RemoveEventListener(EventID.UpdateDailySupply, self.DelegateUpdateDailySupply)
	EventDispatcher.RemoveEventListener(EventID.TaskCommitResponse, self.DelegateOnTaskCommitResponse)
end

function GuildMissionUI:OnPause()
	return
end

function GuildMissionUI:OnResume()
	return
end

function GuildMissionUI:OnCover()
	return
end

function GuildMissionUI:OnReveal()
	return
end

function GuildMissionUI:OnRefocus(userData)
	return
end

function GuildMissionUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function GuildMissionUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GuildMissionUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function GuildMissionUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function GuildMissionUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for gameObject, item in pairs(self.TaskItems) do
		item:Dispose()
	end

	for gameObject, item in pairs(self.GuildMissionItems) do
		item:Dispose()
	end
end

function GuildMissionUI:OnCloseBtn()
	UIModule.CloseSelf(self)
end

function GuildMissionUI:OnTaskUpdate()
	self:UpdateEveryDayTask()
end

function GuildMissionUI:OnUpdateMissionEvent()
	self:UpdateWeeklyMission()
end

function GuildMissionUI:OnUpdateDailySupply()
	self:UpdateWeeklyMission()
end

function GuildMissionUI:UpdateView()
	self:UpdateEveryDayTask()
	self:UpdateWeeklyMission()
end

function GuildMissionUI:UpdateEveryDayTask()
	self.DailyTaskDataList = GuildModule.GetGuildTaskDataList({
		1
	})

	self.DailyTaskScrollArea:GetComponent("ScrollAreaList"):Refresh(#self.DailyTaskDataList)
end

function GuildMissionUI:UpdateWeeklyMission()
	UGUIUtil.SetText(self.TextActivePoint, GuildMissionUIApi:GetString("TextActivePoint", GuildModule.guildTaskPoints))
	self.Null:SetActive(GuildModule.guildTaskPoints == 0)
	self.NotNull:SetActive(GuildModule.guildTaskPoints > 0)

	local groupMissions = GuildModule.guildMissionDataList

	self.WeeklyTaskDataList = {}

	for i, v in pairs(groupMissions) do
		local data, completeData

		for i = 1, #v do
			local missData = v[i]

			if missData.TaskStatus == 2 or missData.TaskStatus == 1 then
				data = missData

				break
			end

			if missData.TaskStatus == TaskModule.TaskStatus.FINISH_TASK then
				completeData = missData
			end
		end

		if data == nil then
			if completeData then
				data = completeData
			else
				data = v[1]
			end
		end

		table.insert(self.WeeklyTaskDataList, data)
	end

	self.WeeklyTaskScrollArea:GetComponent("ScrollAreaList"):Refresh(#self.WeeklyTaskDataList)

	local currentRewardData

	for i = 1, #self.guildRewardDataTab do
		local data = self.guildRewardDataTab[i]

		if GuildModule.guildTaskPoints >= data.LevelNeed then
			currentRewardData = data

			break
		end
	end

	if currentRewardData then
		local path = UIGlobalApi.GetImagePath(currentRewardData.Image)

		AssetUtil.LoadImage(self, path, self.ImgBox:GetComponent("Image"))
	end
end

function GuildMissionUI:OnRenderDailyTaskCell(cell)
	local item = self.TaskItems[cell.gameObject:GetInstanceID()]

	if item == nil then
		item = GuildTaskItem.New(cell.gameObject, nil, GuildMissionUIApi)
		self.TaskItems[cell.gameObject:GetInstanceID()] = item
	end

	item:SetData(self.DailyTaskDataList[cell.index + 1])
end

function GuildMissionUI:OnRenderWeeklyTaskCell(cell)
	local item = self.GuildMissionItems[cell.gameObject:GetInstanceID()]

	if item == nil then
		item = GuildMissionItem.New(cell.gameObject, nil, GuildMissionUIApi)
		self.GuildMissionItems[cell.gameObject:GetInstanceID()] = item
	end

	item:SetData(self.WeeklyTaskDataList[cell.index + 1])
end

function GuildMissionUI:OnGetAllWeeklyBtn()
	local tasks = {}

	for groupID, dataList in pairs(GuildModule.guildMissionDataList) do
		for i, v in pairs(dataList) do
			if v.TaskStatus == 2 then
				table.insert(tasks, v.Cid)
			end
		end
	end

	if #tasks > 0 then
		GuildModule.GetGuildQuestRewards(tasks)
	end
end

function GuildMissionUI:OnGetAllTaskBtn()
	local tasks = {}

	for i, v in pairs(self.DailyTaskDataList) do
		if v.TaskStatus ~= TaskModule.TaskStatus.FINISH_TASK and v.CurrentNum >= v.TargetNum then
			table.insert(tasks, v.cid)
		end
	end

	if #tasks > 0 then
		TaskModule.SendCommitTaskMsgBatch(tasks)
	end
end

function GuildMissionUI:OnLookReward()
	UIModule.Open(Constant.UIControllerName.GuildActiveRewardUI, Constant.UILayer.UI)
end

function GuildMissionUI:OnTaskCommitResponse(cids, rewards)
	if #rewards > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, rewards)
	end
end

return GuildMissionUI
