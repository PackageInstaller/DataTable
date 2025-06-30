-- chunkname: @IQIGame\\UI\\Activity\\NewCharacter\\ActiveNewCharacterView.lua

local m = {
	isPause = false,
	numImg = {}
}
local NPCActionView = require("IQIGame.UI.NPCAction.NPCActionView")

function m.New(view, root, operateEventID)
	local obj = Clone(m)

	obj:Init(view, root, operateEventID)

	return obj
end

function m:Init(view, root, operateEventID)
	self.root = root
	self.View = view
	self.operateEventID = operateEventID
	DollBingoModule.operateEventID = operateEventID

	LuaCodeInterface.BindOutlet(self.View, self)

	self.canvas = self.root.UIController.gameObject:GetComponent("Canvas")

	UIUtil.InitSortedComponents(self.root.UIController:GetComponent("Canvas"), self.View)

	self.NpcView = NPCActionView.New(self.NpcActionGo)

	UGUIUtil.SetText(self.TextBtnTip, ActivityUIApi:GetString("TextBtnTip"))
	UGUIUtil.SetText(self.TextBtnBingo, ActivityUIApi:GetString("TextBtnBingo"))
	UGUIUtil.SetText(self.TextBtnStory, ActivityUIApi:GetString("TextBtnStory"))
	UGUIUtil.SetText(self.TextBtnNewCharacterTask, ActivityUIApi:GetString("TextBtnNewCharacterTask"))
	UGUIUtil.SetText(self.TextTotalScore, ActivityUIApi:GetString("TextTotalScore"))
	UGUIUtil.SetText(self.NewCharacterTextOpen, ActivityUIApi:GetString("NewCharacterTextOpen"))

	function self.delegateUpdateOperations()
		self:OnUpdateOperations()
	end

	function self.delegateBtnTip()
		self:OnBtnTip()
	end

	function self.delegateBtnTask()
		self:OnBtnTask()
	end

	function self.delegateBtnBingo()
		self:OnBtnBingo()
	end

	function self.delegateBtnStory()
		self:OnBtnStory()
	end
end

function m.GetPreloadAssetPaths()
	return
end

function m:Update(elapseSeconds, realElapseSeconds)
	self.NpcView:Update(elapseSeconds, realElapseSeconds)

	if self.canvas.enabled and self.isPause == true then
		self.isPause = false

		self.NpcView:Resume()
	end
end

function m:AddListener()
	self.BtnBingo:GetComponent("Button").onClick:AddListener(self.delegateBtnBingo)
	self.BtnStory:GetComponent("Button").onClick:AddListener(self.delegateBtnStory)
	self.BtnTask:GetComponent("Button").onClick:AddListener(self.delegateBtnTask)
	self.BtnTip:GetComponent("Button").onClick:AddListener(self.delegateBtnTip)
	EventDispatcher.AddEventListener(EventID.UpdateOperationsEvent, self.delegateUpdateOperations)
end

function m:RemoveListener()
	self.BtnBingo:GetComponent("Button").onClick:RemoveListener(self.delegateBtnBingo)
	self.BtnStory:GetComponent("Button").onClick:RemoveListener(self.delegateBtnStory)
	self.BtnTask:GetComponent("Button").onClick:RemoveListener(self.delegateBtnTask)
	self.BtnTip:GetComponent("Button").onClick:RemoveListener(self.delegateBtnTip)
	EventDispatcher.RemoveEventListener(EventID.UpdateOperationsEvent, self.delegateUpdateOperations)
end

function m:RefreshNpc()
	local cfgNpcActionData = NPCActionModule.GetAction(self.cfgNewCharacterActivity.NPCAction, PlayerModule.PlayerInfo.baseInfo.pLv, Constant.NPCTriggerType.Standby, getDateTimeTable(PlayerModule.GetServerTime()).hour)
	local pos = cfgNpcActionData.Position
	local scale = cfgNpcActionData.Scale
	local talkOffset = cfgNpcActionData.TalkPosition
	local goNpc = UnityEngine.GameObject.Instantiate(self.root.UIController:GetPreloadedAsset(UIGlobalApi.GetPrefabRoot(cfgNpcActionData.NPC)))

	self.NpcView:Refresh(cfgNpcActionData, goNpc, cfgNpcActionData.NPC, self.NpcPoint.transform, pos, scale, talkOffset)
end

function m:OnUpdateOperations()
	self:UpDateView()
end

function m:OnBtnTip()
	UIModule.Open(Constant.UIControllerName.DailyActivityTipsUI, Constant.UILayer.UI, self.cfgNewCharacterActivity.Desc)
end

function m:OnBtnBingo()
	UIModule.Open(Constant.UIControllerName.ActivityNewDollBingoUI, Constant.UILayer.UI, self.operateEventID)
	self.NpcView:Pause()
	self:DelayPause()
end

function m:OnBtnStory()
	UIModule.Open(Constant.UIControllerName.ActivityNewDollStoryUI, Constant.UILayer.UI, self.operateEventID)
	self.NpcView:Pause()
	self:DelayPause()
end

function m:DelayPause()
	local tim = Timer.New(function()
		self.isPause = true
	end, 1)

	tim:Start()
end

function m:OnBtnTask()
	UIModule.Open(Constant.UIControllerName.ActivityNewDollMissionUI, Constant.UILayer.UI, self.operateEventID)
end

function m:UpDateView()
	if not ActiveOperationEventModule.CheckIsOpen(self.operateEventID) then
		return
	end

	self.eventPOD = ActiveOperationEventModule.GetActiveOperationData(self.operateEventID)

	if self.eventPOD then
		self.cfgNewCharacterActivity = CfgNewCharacterActivityTable[self.eventPOD.dataCfgId]

		UGUIUtil.SetText(self.TextNewCharacterOpenTime, ActivityUIApi:GetString("TextNewCharacterOpenTime", getCustomDateTimeText(self.eventPOD.startTime, "MonthToMinuteFormat"), getCustomDateTimeText(self.eventPOD.endTime, "MonthToMinuteFormat")))
		self:OnItemUpdate()
	end

	self:RefreshRed()
end

function m:OnItemUpdate()
	self:ShowScoreNum()

	local operationEventDataPOD = ActiveOperationEventModule.GetEventDataPOD(self.operateEventID)

	if operationEventDataPOD and operationEventDataPOD.ncData then
		local num = operationEventDataPOD.ncData.totalTicket

		if num == nil then
			num = 0
		end

		local cfgNewCharacterData = CfgNewCharacterActivityTable[operationEventDataPOD.dataCfgId]
		local itemID = cfgNewCharacterData.CardID

		UGUIUtil.SetText(self.TextEXPRESS, ActivityUIApi:GetString("TextEXPRESS", CfgItemTable[itemID].Name, num))
	end

	self:RefreshRed()
end

function m:OnUpdateItem()
	self:RefreshRed()
end

function m:ShowScoreNum()
	local num = WarehouseModule.GetItemNumByCfgID(Constant.ItemID.NEW_CHARACTER_SCORE)
	local numString = tostring(num)
	local reverseLvString = string.reverse(numString)
	local index = 1

	for i = #self.numImg, 1, -1 do
		local numImgObj = self.numImg[i]
		local str = string.sub(reverseLvString, index, index)

		if str ~= "" then
			numImgObj:SetActive(true)
			AssetUtil.LoadImage(self, ActivityNewDollStoryUIApi:GetString("ImgNumPath", tonumber(str)), numImgObj:GetComponent("Image"))
		else
			numImgObj:SetActive(false)
		end

		index = index + 1
	end
end

function m:RefreshRed()
	local storyRed = ActiveNewCharacterModule.CheckStoryRedPoint(self.operateEventID)

	self.RedStory:SetActive(storyRed)
	self.RedBingo:SetActive(DollBingoModule.CheckRedPoint(self.operateEventID))
	self.RedTask:SetActive(ActivityDollMissionModule.CheckRedPoint())
end

function m:Open()
	self.numImg = {}

	for i = 0, self.NumSort.transform.childCount - 1 do
		self.numImg[i + 1] = self.NumSort.transform:GetChild(i).gameObject
	end

	self.isPause = false

	self:AddListener()
	self.View:SetActive(true)
	self:UpDateView()
	self:RefreshNpc()
end

function m:Close()
	self.View:SetActive(false)
	self:OnHide()
end

function m:OnHide()
	self.NpcView:OnHide()
	self:RemoveListener()
end

function m:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.NpcView:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
