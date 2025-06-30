-- chunkname: @IQIGame\\UI\\MazeUI.lua

local MazeUIShopElement = require("IQIGame/UI/Maze/MazeUIShopElement")
local MazeUISenroElement = require("IQIGame/UI/Maze/MazeUISenroElement")
local MazeUICollectionViewClass = require("IQIGame/UI/Maze/MazeActivityCollectionView")
local MazeUIStageDetailsViewClass = require("IQIGame.UI.Maze.MazeUIStageDetailsView")
local MazeUIStageViewClass = require("IQIGame.UI.Maze.MazeUIStageView")
local MazeUI = {}

MazeUI = Base:Extend("MazeUI", "IQIGame.Onigao.UI.MazeUI", MazeUI)

function MazeUI:OnInit()
	self:__OnInitEventDelegateFunc()

	self.shopElement = MazeUIShopElement.New(self.shopContent)
	self.senroElement = MazeUISenroElement.New(self.senroContent)
	self.collectionView = MazeUICollectionViewClass.New(self.collectionContent, self)
	self.stageDetailsView = MazeUIStageDetailsViewClass.New(self.mazeDetailsContent, self)
	self.stageView = MazeUIStageViewClass.New(self.stageRoot, function(_stageCid)
		self:__OnStageElementItemSelected(_stageCid)
	end)
	self.commonReturnBtn = CommonReturnBtn.New(self.commonReturnBtn, self)
end

function MazeUI:GetPreloadAssetPaths()
	self.stageContentPath = "Assets/03_Prefabs/UI/Maze/MazeStageContent_1.prefab"

	return {
		self.stageContentPath
	}
end

function MazeUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MazeUI:IsManualShowOnOpen(userData)
	return false
end

function MazeUI:GetBGM(userData)
	return MazeApi:GetMazeUIBGMID()
end

function MazeUI:OnOpen(userData)
	self.shopElement:Hide()
	self.senroElement:Hide()
	self.collectionView:Hide()
	self.stageDetailsView:Hide()
	self.stageView:Hide()
	self:RefreshInfo()
	self:OpenDialogue()

	if userData ~= nil and userData.isOpenMazeDetails ~= nil then
		self:__OnMazeStageBtnClick()
	end
end

function MazeUI:OnClose(userData)
	return
end

function MazeUI:__OnInitEventDelegateFunc()
	function self.__delegateOnAchievementBtnClick()
		self:__OnAchievementBtnClick()
	end

	function self.__delegateOnShopBtnClick()
		self:__OnShopBtnClick()
	end

	function self.__delegateOnBuffBtnBtnClick()
		self:__OnBuffBtnClick()
	end

	function self.__delegateOnMazeStageBtnClick()
		self:__OnMazeStageBtnClick()
	end
end

function MazeUI:OnAddListeners()
	self.achievementBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnAchievementBtnClick)
	self.shopBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnShopBtnClick)
	self.buffBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnBuffBtnBtnClick)
	self.mazeStageBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnMazeStageBtnClick)
end

function MazeUI:OnRemoveListeners()
	self.achievementBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnAchievementBtnClick)
	self.shopBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnShopBtnClick)
	self.buffBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnBuffBtnBtnClick)
	self.mazeStageBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnMazeStageBtnClick)
end

function MazeUI:OnPause()
	return
end

function MazeUI:OnResume()
	return
end

function MazeUI:OnCover()
	return
end

function MazeUI:OnReveal()
	return
end

function MazeUI:OnRefocus(userData)
	return
end

function MazeUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MazeUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MazeUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MazeUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MazeUI:OnDestroy()
	self.commonReturnBtn:Dispose()
	self.shopElement:Dispose()
	self.senroElement:Dispose()
	self.collectionView:OnDestroy()
	self.stageDetailsView:Dispose()
	self.stageView:Dispose()
end

function MazeUI:__OnStageElementItemSelected(stageCid)
	self.stageDetailsView:Show()
	self.stageDetailsView:SetData(stageCid)
end

function MazeUI:__OnAchievementBtnClick()
	self.collectionView:Show()
	self.collectionView:Refresh()
end

function MazeUI:__OnShopBtnClick()
	self.shopElement:Show()
end

function MazeUI:__OnBuffBtnClick()
	self.senroElement:Show()
end

function MazeUI:__OnMazeStageBtnClick()
	if StoryModule.IsStoring then
		NoticeModule.ShowNotice(240036)

		return
	end

	local labyrinthData = MazeModule.GetLabyrinthData()

	if labyrinthData == nil then
		return
	end

	if not labyrinthData.state then
		return
	end

	if table.len(labyrinthData.labyrinthStagePODs) > 0 then
		self:__OnStageElementItemSelected()
	else
		MazeModule.log("当前迷宫没有关卡")
	end
end

function MazeUI:RefreshInfo()
	local labyrinthData = MazeModule.GetLabyrinthData()
	local activityPods = ActivityModule.GetActivityPodByActivityType({
		Constant.ActivityType.ActivityType_Maze
	})
	local activityPod

	ForArray(activityPods, function(k, v)
		if CfgActivityTable[v.cid].OpenActionParams[2] == labyrinthData.seasonId then
			activityPod = v

			return true
		end
	end)

	if activityPod == nil then
		UGUIUtil.SetText(self.activityTimeText, "")
		UGUIUtil.SetText(self.stageTimeText, "")

		return
	end

	UGUIUtil.SetText(self.activityTimeText, getMonthAndDayText(tonumber(activityPod.openDateTime) / 1000) .. "-" .. getMonthAndDayText(tonumber(activityPod.closeDateTime) / 1000))
	UGUIUtil.SetText(self.stageTimeText, getMonthAndDayText(tonumber(labyrinthData.startTime) / 1000) .. "-" .. getMonthAndDayText(tonumber(labyrinthData.endTime) / 1000))
end

function MazeUI:OpenDialogue()
	local isPlayDialogue = PlayerPrefsUtil.GetInt(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.MazeUIPlayDialogue, 0)
	local labyrinthData = MazeModule.GetLabyrinthData()

	if isPlayDialogue == 1 or labyrinthData.animation == true then
		return
	end

	local eventCfg = CfgLabyrinthEventNpcTable[CfgDiscreteDataTable[204].Data[1]]

	UIModule.Open(Constant.UIControllerName.CommonDialogPanel, Constant.UILayer.UI, {
		DialogType = Constant.CommonDialogPanelType.LRDialog,
		DialogCid = eventCfg.DialogueID,
		Callback = function()
			PlayerPrefsUtil.SetInt(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.MazeUIPlayDialogue, 1)
			PlayerPrefsUtil.Save()
			UIModule.Close(Constant.UIControllerName.CommonDialogPanel)
		end
	})
end

return MazeUI
