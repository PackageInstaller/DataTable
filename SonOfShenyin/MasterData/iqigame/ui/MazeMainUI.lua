-- chunkname: @IQIGame\\UI\\MazeMainUI.lua

local mazeStageDetailsView = require("IQIGame.UI.Maze.UI.MazeDetailsUI.MazeStageDetailsView")
local mazeStageItem = {}

function mazeStageItem.New(view)
	local obj = Clone(mazeStageItem)

	obj:Init(view)

	return obj
end

function mazeStageItem:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnSelectMazeStageEvent(stageID)
		self:OnSelectMazeStageEvent(stageID)
	end

	function self.DelegateOnClickSelectBtn()
		self:OnClickSelectBtn()
	end

	function self.DelegateOnActivityOpenEvent(activityCid)
		self:OnActivityOpenEvent(activityCid)
	end

	self.mazeImgCom = self.mazeImg:GetComponent("Image")

	self:AddListeners()
end

function mazeStageItem:AddListeners()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSelectBtn)
	EventDispatcher.AddEventListener(EventID.SelectMazeStageEvent, self.DelegateOnSelectMazeStageEvent)
	EventDispatcher.AddEventListener(EventID.ActivityOpenEvent, self.DelegateOnActivityOpenEvent)
	EventDispatcher.AddEventListener(EventID.ActivityCloseEvent, self.DelegateOnActivityOpenEvent)
end

function mazeStageItem:RemoveListeners()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSelectBtn)
	EventDispatcher.RemoveEventListener(EventID.SelectMazeStageEvent, self.DelegateOnSelectMazeStageEvent)
	EventDispatcher.RemoveEventListener(EventID.ActivityOpenEvent, self.DelegateOnActivityOpenEvent)
	EventDispatcher.RemoveEventListener(EventID.ActivityCloseEvent, self.DelegateOnActivityOpenEvent)
end

function mazeStageItem:SetData(stageCfg, newUnlockStageId, index)
	self.stageCfg = stageCfg
	self.newUnlockStageId = newUnlockStageId
	self.Index = index

	AssetUtil.LoadImage(self, self.stageCfg.MazeImage, self.mazeImgCom)
	self:ResetTimer()
	UGUIUtil.SetText(self.MazeName, stageCfg.StageName)
	UGUIUtil.SetText(self.IndexNumText, self.Index)

	self.isUnlock = ConditionModule.Check(stageCfg.Condition)
	self.isOpen = ActivityModule.IsOpenByTime(stageCfg.ActivityId)

	LuaUtility.SetGameObjectShow(self.UnlockInfo, self.isUnlock and self.isOpen)
	LuaUtility.SetGameObjectShow(self.LockInfo, not self.isUnlock or not self.isOpen)

	self.progressStr = "0%"

	if self.isUnlock and self.isOpen then
		self.mazeStageData = MazeModule.GetMazeStageDataByMazeID(stageCfg.Id)

		LuaUtility.SetGameObjectShow(self.RemaingTimeParent, self.mazeStageData ~= nil and self.mazeStageData.state ~= 2)
		LuaUtility.SetGameObjectShow(self.Finished, self.mazeStageData ~= nil and self.mazeStageData.state == 2)

		if self.mazeStageData == nil then
			self.progressStr = "0%"
		else
			self:UpdateSurplusTime()

			self.timer = Timer.New(function()
				self:UpdateSurplusTime()
			end, 1, -1)
			self.progressStr = self.mazeStageData.progress .. "%"

			self.timer:Start()
		end
	end

	if self.stageCfg.Id == newUnlockStageId then
		self:OnClickSelectBtn()
	else
		self:SetSelectState(false)
	end
end

function mazeStageItem:SetSelectState(state)
	LuaUtility.SetGameObjectShow(self.selectImg, state)

	if state then
		UGUIUtil.SetText(self.ProgressText, string.format(ColorCfg.Maze.Black, self.progressStr))
	else
		UGUIUtil.SetText(self.ProgressText, string.format(ColorCfg.Maze.LightGray, self.progressStr))
	end
end

function mazeStageItem:UpdateSurplusTime()
	local surplusTime = tonumber(self.mazeStageData.endTime) / 1000 - PlayerModule.GetServerTime()

	if surplusTime <= 0 then
		UGUIUtil.SetText(self.RemainingTimeText, "END")
	else
		UGUIUtil.SetText(self.RemainingTimeText, DateTimeFormat(surplusTime, self:GetTimeSurplusState(surplusTime)))
	end
end

function mazeStageItem:GetTimeSurplusState(second)
	if second <= 3600 then
		return MazeApi:GetTimeFormat(1)
	elseif second <= 86400 then
		return MazeApi:GetTimeFormat(2)
	else
		return MazeApi:GetTimeFormat(3)
	end
end

function mazeStageItem:ResetTimer()
	if self.timer ~= nil then
		self.timer:Stop()

		self.timer = nil
	end
end

function mazeStageItem:OnSelectMazeStageEvent(stageID)
	if self.stageCfg == nil or self.stageCfg.Id == stageID then
		return
	end

	self:SetSelectState(false)
end

function mazeStageItem:OnActivityOpenEvent(activityId)
	if self.stageCfg.ActivityId == activityId then
		self:SetData(self.stageCfg, self.newUnlockStageId, self.Index)
	end
end

function mazeStageItem:OnClickSelectBtn()
	self:SetSelectState(true)
	EventDispatcher.Dispatch(EventID.SelectMazeStageEvent, self.stageCfg.Id, self.Index)
end

function mazeStageItem:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function mazeStageItem:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function mazeStageItem:Dispose()
	self:ResetTimer()
	self:RemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

local mazeStageContentItem = {
	mazeStageItemList = {}
}

mazeStageContentItem.MazeStageItem = mazeStageItem

function mazeStageContentItem.New(view)
	local obj = Clone(mazeStageContentItem)

	obj:Init(view)

	return obj
end

function mazeStageContentItem:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	for i = 1, 4 do
		self.mazeStageItemList[i] = mazeStageContentItem.MazeStageItem.New(self["MazeStageItem" .. i])
	end
end

function mazeStageContentItem:SetData(stageCfgs, newUnlockStageId, index)
	self.Index = index

	for i = 1, #self.mazeStageItemList do
		if i > #stageCfgs then
			self.mazeStageItemList[i]:Hide()
		else
			self.mazeStageItemList[i]:Show()
			self.mazeStageItemList[i]:SetData(stageCfgs[i], newUnlockStageId, (self.Index - 1) * 4 + i)
		end
	end
end

function mazeStageContentItem:Dispose()
	for k, v in pairs(self.mazeStageItemList) do
		v:Dispose()
	end

	self.mazeStageItemList = {}

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

local MazeMainUI = {
	MazeStageDataList = {},
	MazeItemList = {}
}

MazeMainUI.MazeStageContentItem = mazeStageContentItem
MazeMainUI = Base:Extend("MazeMainUI", "IQIGame.Onigao.UI.MazeMainUI", MazeMainUI)

function MazeMainUI:OnInit()
	function self.DelegateOnClickShopBtn()
		self:OnClickShopBtn()
	end

	function self.DelegateOnClickOrbmentBtn()
		self:OnClickOrbmentBtn()
	end

	function self.DelegateOnClickMazeBtn()
		self:OnClickMazeBtn()
	end

	function self.DelegateOnClickStartBtn()
		self:OnClickStartBtn()
	end

	function self.DelegateOnClickDetailBtn()
		self:OnClickDetailBtn()
	end

	function self.DelegateOnClickContinueBtn()
		self:OnClickContinueBtn()
	end

	function self.DelegateOnClickQuitBtn()
		self:OnClickQuitBtn()
	end

	function self.DelegateOnSelectMazeStageEvent(stageID, index)
		self:OnSelectMazeStageEvent(stageID, index)
	end

	function self.DelegateOnFinishMazeStageEvent()
		self:OnFinishMazeStageEvent()
	end

	self.wrapContent = self.MazeStageScrollView:GetComponent("ScrollAreaList")

	function self.wrapContent.onRenderCell(cell)
		self:OnRenderItem(cell)
	end

	self.MazeStageDetailsView = mazeStageDetailsView.New(self.DetailsPanel)
	self.commonReturnBtn = CommonReturnBtn.New(self.Com_ReturnBtn, self)
	self.moneyCell = CurrencyCell.New(self.CurrencyContainer)
end

function MazeMainUI:GetPreloadAssetPaths()
	return nil
end

function MazeMainUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MazeMainUI:IsManualShowOnOpen(userData)
	return false
end

function MazeMainUI:GetBGM(userData)
	return nil
end

function MazeMainUI:OnOpen(userData)
	self.moneyCell:RefreshItem(Constant.TopMoneyType.GameLevelUI)
	self:RefreshStageData()
end

function MazeMainUI:OnClose(userData)
	return
end

function MazeMainUI:OnAddListeners()
	self.ShopBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickShopBtn)
	self.OrbmentBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickOrbmentBtn)
	self.MazeBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickMazeBtn)
	self.startBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickStartBtn)
	self.detailBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickDetailBtn)
	self.continueBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickContinueBtn)
	self.quitBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickQuitBtn)
	EventDispatcher.AddEventListener(EventID.SelectMazeStageEvent, self.DelegateOnSelectMazeStageEvent)
	EventDispatcher.AddEventListener(EventID.FinishMazeStageEvent, self.DelegateOnFinishMazeStageEvent)
end

function MazeMainUI:OnRemoveListeners()
	self.ShopBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickShopBtn)
	self.OrbmentBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickOrbmentBtn)
	self.MazeBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickMazeBtn)
	self.startBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickStartBtn)
	self.detailBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickDetailBtn)
	self.continueBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickContinueBtn)
	self.quitBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickQuitBtn)
	EventDispatcher.RemoveEventListener(EventID.SelectMazeStageEvent, self.DelegateOnSelectMazeStageEvent)
	EventDispatcher.RemoveEventListener(EventID.FinishMazeStageEvent, self.DelegateOnFinishMazeStageEvent)
end

function MazeMainUI:OnPause()
	return
end

function MazeMainUI:OnResume()
	return
end

function MazeMainUI:OnCover()
	return
end

function MazeMainUI:OnReveal()
	return
end

function MazeMainUI:OnRefocus(userData)
	return
end

function MazeMainUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MazeMainUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MazeMainUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MazeMainUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MazeMainUI:OnDestroy()
	self.moneyCell:Dispose()
	self.commonReturnBtn:Dispose()
	self.MazeStageDetailsView:Dispose()

	self.MazeStageDetailsView = nil

	for k, v in pairs(self.MazeItemList) do
		v:Dispose()
	end

	self.MazeItemList = nil

	AssetUtil.UnloadAsset(self)
end

function MazeMainUI:RefreshStageData()
	self.MazeStageDataList = {}

	local index = 1

	for k, v in pairsCfg(CfgMazeStageTable) do
		if self.MazeStageDataList[index] == nil then
			self.MazeStageDataList[index] = {}
		end

		table.insert(self.MazeStageDataList[index], v)

		if #self.MazeStageDataList[index] >= 4 then
			index = index + 1
		end
	end

	for i = 1, #self.MazeStageDataList do
		table.sort(self.MazeStageDataList[i], function(a, b)
			return a.Id < b.Id
		end)
	end

	self.newUnlockStageId = self.MazeStageDataList[1][1].Id

	self.wrapContent:Refresh(#self.MazeStageDataList)
end

function MazeMainUI:OnRenderItem(cell)
	local stageCfgs = self.MazeStageDataList[cell.index + 1]
	local instanceId = cell.gameObject:GetInstanceID()
	local itemCell = self.MazeItemList[instanceId]

	if itemCell == nil then
		self.MazeItemList[instanceId] = self.MazeStageContentItem.New(cell.gameObject)
		itemCell = self.MazeItemList[instanceId]
	end

	itemCell:SetData(stageCfgs, self.newUnlockStageId, cell.index + 1)
end

function MazeMainUI:GetNewUnlockStageId()
	for i = #self.MazeStageDataList, 1, -1 do
		for j = #self.MazeStageDataList[i], 1, -1 do
			if ConditionModule.Check(self.MazeStageDataList[i][j].Condition) then
				return self.MazeStageDataList[i][j].Id
			end
		end
	end
end

function MazeMainUI:OnSelectMazeStageEvent(stageID, index)
	self.curSelectStageID = stageID
	self.curSelectStageData = MazeModule.GetMazeStageDataByMazeID(self.curSelectStageID)

	local mazeStageCfg = CfgMazeStageTable[self.curSelectStageID]

	UGUIUtil.SetText(self.MazeStageIndexText, index)
	UGUIUtil.SetText(self.StageDesc, mazeStageCfg.MazeTips)
	UGUIUtil.SetText(self.StageName, mazeStageCfg.StageName)

	self.NeedConsumeCount = 0

	if #mazeStageCfg.Cost > 0 and (self.curSelectStageData == nil or self.curSelectStageData.state <= 0 or self.curSelectStageData.state == 2) then
		LuaUtility.SetGameObjectShow(self.consumeParent, true)
		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[mazeStageCfg.Cost[1]].SmallIcon), self.consumeImg:GetComponent("Image"))
		UGUIUtil.SetText(self.consumeNumText, "×" .. mazeStageCfg.Cost[2])

		self.NeedConsumeCount = mazeStageCfg.Cost[2]
	else
		LuaUtility.SetGameObjectShow(self.consumeParent, false)
	end

	self:OnRefreshBtnState()
	self.MazeStageDetailsView:SetData(self.curSelectStageID)
end

function MazeMainUI:OnRefreshBtnState()
	LuaUtility.SetGameObjectShow(self.continueBtn, self.curSelectStageData ~= nil and self.curSelectStageData.state == 1)
	LuaUtility.SetGameObjectShow(self.quitBtn, self.curSelectStageData ~= nil and self.curSelectStageData.state == 1)
	LuaUtility.SetGameObjectShow(self.startBtn, self.curSelectStageData == nil or self.curSelectStageData.state <= 0 or self.curSelectStageData.state == 2)
end

function MazeMainUI:OnFinishMazeStageEvent()
	self:RefreshStageData()
end

function MazeMainUI:OnClickShopBtn()
	if UnlockFunctionModule.IsUnlock(Constant.UnlockType.FUNC_STORE) then
		UIModule.Open(Constant.UIControllerName.ShopUI, Constant.UILayer.UI, {
			Constant.ShopType.Token.Type,
			{
				enterType = Constant.ShopEnterType.Normal
			}
		})
	else
		NoticeModule.ShowNotice(19001)
	end
end

function MazeMainUI:OnClickOrbmentBtn()
	MazeModule.InTheMaze = false

	UIModule.Open(Constant.UIControllerName.MazeEquipUI, Constant.UILayer.UI)
end

function MazeMainUI:OnClickMazeBtn()
	return
end

function MazeMainUI:OnClickStartBtn()
	self.isUnlock = ConditionModule.Check(CfgMazeStageTable[self.curSelectStageID].Condition)
	self.isOpen = ActivityModule.IsOpenByTime(CfgMazeStageTable[self.curSelectStageID].ActivityId)

	if not self.isUnlock then
		NoticeModule.ShowNotice(80003)

		return
	end

	if not self.isOpen then
		NoticeModule.ShowNotice(80004)

		return
	end

	if self.NeedConsumeCount > WarehouseModule.GetPlayerStrengthNum() then
		NoticeModule.ShowNotice(11013)

		return
	end

	local userData = {}

	userData.StageId = self.curSelectStageID
	userData.OpenType = Constant.FormationOpenType.Maze
	userData.ChapterType = Constant.ChapterPassType.TYPE_Maze

	UIModule.Open(Constant.UIControllerName.FormationUI, Constant.UILayer.UI, userData)
end

function MazeMainUI:OnClickDetailBtn()
	if self.curSelectStageID ~= nil then
		self.MazeStageDetailsView:SetData(self.curSelectStageID)
		self.MazeStageDetailsView:Show()
	end
end

function MazeMainUI:OnClickContinueBtn()
	local enterDupData = {}

	enterDupData.ChapterType = Constant.ChapterPassType.TYPE_Maze
	enterDupData.PassId = self.curSelectStageID
	enterDupData.FormationID = self.curSelectStageData.formationPOD.cid

	GameChapterModule.EnterDupByChapterType(enterDupData)
end

function MazeMainUI:OnClickQuitBtn()
	NoticeModule.ShowNotice(80002, function()
		MazeModule.FinishMazeStage(self.curSelectStageID)
	end)
end

return MazeMainUI
