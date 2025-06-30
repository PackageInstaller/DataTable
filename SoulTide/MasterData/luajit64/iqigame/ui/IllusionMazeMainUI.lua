-- chunkname: @IQIGame\\UI\\IllusionMazeMainUI.lua

local IllusionMazeMainUI = {
	ResourceItems = {},
	EmotionBars = {},
	EmotionFragmentItemCells = {}
}

IllusionMazeMainUI = Base:Extend("IllusionMazeMainUI", "IQIGame.Onigao.UI.IllusionMazeMainUI", IllusionMazeMainUI)

local MazeMainUICommonModuleController = require("IQIGame.UI.Maze.MazeMainUICommonModuleController")
local IllusionMazeResourceItem = require("IQIGame.UI.Maze.IllusionMazeResourceItem")
local IllusionMazeEmotionBar = require("IQIGame.UI.Maze.IllusionMazeEmotionBar")
local IllusionMazeEmotionBubble = require("IQIGame.UI.Maze.IllusionMazeEmotionBubble")
local IllusionMazeEmotionFragmentItem = require("IQIGame.UI.Maze.IllusionMazeEmotionFragmentItem")

function IllusionMazeMainUI:OnInit()
	function self.DelegateOnUpdatePlayerParams()
		self:OnUpdatePlayerParams()
	end

	function self.DelegateOnUpdateItem()
		self:OnUpdateItem()
	end

	function self.DelegateOnMazeStagePlay(isPlay)
		self:OnMazeStagePlay(isPlay)
	end

	function self.DelegateOnClickMazeIntroductionBtn()
		self:OnClickMazeIntroductionBtn()
	end

	function self.DelegateOnClickCloseMazeIntroductionBtn()
		self:OnClickCloseMazeIntroductionBtn()
	end

	self.CommonModule = MazeMainUICommonModuleController.New(self.CommonModule, self.UIController, self.Top, self.BtnGroup, self.Bottom, function()
		return self:GetCustomData()
	end)

	self.CommonModule:OnInit()

	for i = 1, #self.ResourceItemCids do
		local cfgItemData = CfgItemTable[self.ResourceItemCids[i]]
		local item = IllusionMazeResourceItem.New(UnityEngine.Object.Instantiate(self.ResourceItemPrefab), self.ResourceItemCids[i], self.UIController:GetPreloadedAsset(UIGlobalApi.GetIconPath(cfgItemData.Icon)))

		item.View.transform:SetParent(self.ResourceBar.transform, false)
		table.insert(self.ResourceItems, item)
	end

	local emotionIconFileNames = IllusionMazeMainUIApi:GetString("EmotionIcons")

	for i = 1, 4 do
		local bar = IllusionMazeEmotionBar.New(UnityEngine.Object.Instantiate(self.EmotionBarPrefab), IllusionMazeMainUIApi:GetString("EmotionParamId", i), IllusionMazeMainUIApi:GetString("EmotionOverloadValue", i), self.UIController:GetPreloadedAsset(emotionIconFileNames[i]))

		bar.View.transform:SetParent(self.EmotionBarGrid.transform, false)
		table.insert(self.EmotionBars, bar)
	end

	local emotionFragmentItemCids = IllusionMazeMainUIApi:GetString("EmotionFragmentItemCids")

	for i = 1, #emotionFragmentItemCids do
		local item = IllusionMazeEmotionFragmentItem.New(UnityEngine.Object.Instantiate(self.RewardItemPrefab), emotionFragmentItemCids[i])

		item.View.transform:SetParent(self.RewardItemGrid.transform, false)
		table.insert(self.EmotionFragmentItemCells, item)
	end

	self.EmotionBubbleController = IllusionMazeEmotionBubble.New(self.EmotionBubble)

	UGUIUtil.SetTextInChildren(self.BagBtn, IllusionMazeMainUIApi:GetString("BagBtnText"))
	UGUIUtil.SetTextInChildren(self.MazeIntroductionText, IllusionMazeMainUIApi:GetString("MazeIntroductionText"))
end

function IllusionMazeMainUI:GetPreloadAssetPaths()
	local paths = {}
	local commonModulePaths = MazeMainUICommonModuleController.GetPreloadAssetPaths()

	if commonModulePaths ~= nil then
		for i = 1, #commonModulePaths do
			table.insert(paths, commonModulePaths[i])
		end
	end

	local emotionIconFileNames = IllusionMazeMainUIApi:GetString("EmotionIcons")

	for i = 1, #emotionIconFileNames do
		table.insert(paths, emotionIconFileNames[i])
	end

	self.ResourceItemCids = {
		Constant.ItemID.GUIDE_LAMP
	}

	for i = 1, #self.ResourceItemCids do
		local cfgItemData = CfgItemTable[self.ResourceItemCids[i]]

		table.insert(paths, UIGlobalApi.GetIconPath(cfgItemData.Icon))
	end

	return paths
end

function IllusionMazeMainUI:GetOpenPreloadAssetPaths(userData)
	return MazeMainUICommonModuleController.GetOpenPreloadAssetPaths(userData)
end

function IllusionMazeMainUI:IsManualShowOnOpen(userData)
	return false
end

function IllusionMazeMainUI:GetBGM(userData)
	return nil
end

function IllusionMazeMainUI:OnOpen(userData)
	self.CommonModule:OnOpen(userData)
	self:UpdateView()
end

function IllusionMazeMainUI:OnClose(userData)
	self.CommonModule:OnClose(userData)
end

function IllusionMazeMainUI:OnAddListeners()
	self.CommonModule:OnAddListeners()

	for i = 1, #self.EmotionFragmentItemCells do
		local cell = self.EmotionFragmentItemCells[i]

		cell:AddListeners()
	end

	self.BagBtn:GetComponent("Button").onClick:AddListener(self.OnClickBagBtn)
	self.MazeIntroductionBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickMazeIntroductionBtn)
	self.CloseMazeIntroductionBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseMazeIntroductionBtn)
	EventDispatcher.AddEventListener(EventID.MazeUpdatePlayerParams, self.DelegateOnUpdatePlayerParams)
	EventDispatcher.AddEventListener(EventID.MazeUpdateItem, self.DelegateOnUpdateItem)
	EventDispatcher.AddEventListener(EventID.MazeStagePlay, self.DelegateOnMazeStagePlay)
end

function IllusionMazeMainUI:OnRemoveListeners()
	self.CommonModule:OnRemoveListeners()

	for i = 1, #self.EmotionFragmentItemCells do
		local cell = self.EmotionFragmentItemCells[i]

		cell:RemoveListeners()
	end

	self.BagBtn:GetComponent("Button").onClick:RemoveListener(self.OnClickBagBtn)
	self.MazeIntroductionBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickMazeIntroductionBtn)
	self.CloseMazeIntroductionBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseMazeIntroductionBtn)
	EventDispatcher.RemoveEventListener(EventID.MazeUpdatePlayerParams, self.DelegateOnUpdatePlayerParams)
	EventDispatcher.RemoveEventListener(EventID.MazeUpdateItem, self.DelegateOnUpdateItem)
	EventDispatcher.RemoveEventListener(EventID.MazeStagePlay, self.DelegateOnMazeStagePlay)
end

function IllusionMazeMainUI:OnPause()
	self.CommonModule:OnPause()
end

function IllusionMazeMainUI:OnResume()
	self.CommonModule:OnResume()
end

function IllusionMazeMainUI:OnCover()
	self.CommonModule:OnCover()
end

function IllusionMazeMainUI:OnReveal()
	self.CommonModule:OnReveal()
end

function IllusionMazeMainUI:OnRefocus(userData)
	self.CommonModule:OnRefocus(userData)
end

function IllusionMazeMainUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.CommonModule:OnUpdate(elapseSeconds, realElapseSeconds)
	self:UpdateEmotionBubblePosition()
end

function IllusionMazeMainUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	self.CommonModule:OnDepthChanged(uiGroupDepth, depthInUIGroup)
end

function IllusionMazeMainUI:OnLoadSucceed(assetName, asset, duration, userData)
	self.CommonModule:OnLoadSucceed(assetName, asset, duration, userData)
end

function IllusionMazeMainUI:OnLoadFailed(assetName, status, errorMessage, userData)
	self.CommonModule:OnLoadFailed(assetName, status, errorMessage, userData)
end

function IllusionMazeMainUI:OnDestroy()
	self.CommonModule:OnDestroy()

	for i = 1, #self.ResourceItems do
		local item = self.ResourceItems[i]

		item:Dispose()
	end

	for i = 1, #self.EmotionBars do
		local bar = self.EmotionBars[i]

		bar:Dispose()
	end

	for i = 1, #self.EmotionFragmentItemCells do
		local cell = self.EmotionFragmentItemCells[i]

		cell:Dispose()
	end

	self.EmotionBubbleController:Dispose()
end

function IllusionMazeMainUI:GetCustomData()
	local cfgMazeInstanceData = CfgMazeInstanceTable[MazeDataModule.MazeInstanceID]

	return {
		startTitle = IllusionMazeMainUIApi:GetString("StartTitleText"),
		startTip = IllusionMazeMainUIApi:GetString("StartTipText", cfgMazeInstanceData.ConditionsDesc)
	}
end

function IllusionMazeMainUI:UpdateView()
	self.CfgMazeInstanceData = CfgMazeInstanceTable[MazeDataModule.MazeInstanceID]

	UGUIUtil.SetText(self.MazeNameText, self.CfgMazeInstanceData.Name)

	for i = 1, #self.ResourceItems do
		local item = self.ResourceItems[i]

		item:UpdateNum()
	end

	self:UpdateEmotion()
	self:UpdateFragmentItemCells()
	self.MazeIntroductionView:SetActive(false)
end

function IllusionMazeMainUI:UpdateFragmentItemCells()
	for i = 1, #self.EmotionFragmentItemCells do
		local cell = self.EmotionFragmentItemCells[i]

		cell:Refresh()
	end
end

function IllusionMazeMainUI.OnClickBagBtn()
	UIModule.Open(Constant.UIControllerName.MazeBagUI, Constant.UILayer.UI)
end

function IllusionMazeMainUI:OnUpdatePlayerParams()
	self:UpdateEmotion()
end

function IllusionMazeMainUI:UpdateEmotion()
	local overloadParamId
	local overloadNum = 0

	for i = 1, #self.EmotionBars do
		local bar = self.EmotionBars[i]

		bar:UpdateBar()

		if bar:IsOverload() then
			overloadParamId = bar.ParamId
			overloadNum = overloadNum + 1
		end
	end

	local isStageShow = MazeModule.IsStageShow()
	local showBubble = not isStageShow and overloadNum > 0

	self.EmotionBubbleController.View:SetActive(showBubble)

	if showBubble then
		self.EmotionBubbleController:SetData(overloadParamId, overloadNum)
		self:UpdateEmotionBubblePosition()
	end
end

function IllusionMazeMainUI:UpdateEmotionBubblePosition()
	if not self.EmotionBubbleController.View.activeSelf then
		return
	end

	local playerHeadTrans = getMountPoint(MazeModule.MazeScene.Hero.gameObject.transform, Constant.MountPoint.PointHead)
	local screenPoint = MazeModule.MazeScene.MainCamera:WorldToScreenPoint(playerHeadTrans.position)
	local uiWorldPoint = self.UIController:GetComponent("Canvas").worldCamera:ScreenToWorldPoint(screenPoint)

	self.EmotionBubbleController.View.transform.position = uiWorldPoint
end

function IllusionMazeMainUI:OnUpdateItem()
	self:UpdateFragmentItemCells()
end

function IllusionMazeMainUI:OnMazeStagePlay(isPlay)
	self:UpdateEmotion()
end

function IllusionMazeMainUI:OnClickMazeIntroductionBtn()
	self.MazeIntroductionView:SetActive(true)
end

function IllusionMazeMainUI:OnClickCloseMazeIntroductionBtn()
	self.MazeIntroductionView:SetActive(false)
end

return IllusionMazeMainUI
