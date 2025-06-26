-- chunkname: @IQIGame\\UI\\RPGActivityUI\\RpgMazeDetailUIController.lua

local MazeRewardCell = require("IQIGame.UI.MazeDetail.MazeRewardCell")
local RpgMazeDetailFormationCell = require("IQIGame.UI.RpgMaze.RpgMazeDetailFormationCell")
local RpgMazeDetailUIController = {
	MazeCid = 0,
	RewardCells = {},
	FormationCells = {}
}

function RpgMazeDetailUIController.New(uiController)
	local obj = Clone(RpgMazeDetailUIController)

	obj:__Init(uiController)

	return obj
end

function RpgMazeDetailUIController:__Init(uiController)
	self.UIController = uiController
end

function RpgMazeDetailUIController:InitView(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function RpgMazeDetailUIController:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickConfirmBtn()
		self:OnClickConfirmBtn()
	end

	function self.DelegateOnClickFormationNoticeBtn()
		self:OnClickFormationNoticeBtn()
	end

	for i = 1, 5 do
		local itemCell = MazeRewardCell.New(UnityEngine.Object.Instantiate(self.RewardPrefab))

		itemCell.View.transform:SetParent(self.RewardGrid.transform, false)

		self.RewardCells[i] = itemCell
	end

	for i = 1, 5 do
		local cell = RpgMazeDetailFormationCell.New(UnityEngine.Object.Instantiate(self.FormationCellPrefab))

		cell.View.transform:SetParent(self.FormationCellGrid.transform, false)

		self.FormationCells[i] = cell
	end

	UGUIUtil.SetText(self.TitleText, RpgMazeDetailUIApi:GetString("TitleText"))
	UGUIUtil.SetText(self.RewardLabelText, RpgMazeDetailUIApi:GetString("RewardLabelText"))
	UGUIUtil.SetTextInChildren(self.ConfirmBtn, RpgMazeDetailUIApi:GetString("ConfirmBtnText"))
	UGUIUtil.SetText(self.ExploreLabel, RpgMazeDetailUIApi:GetString("ExploreLabel"))
	UGUIUtil.SetText(self.CheckPointText, RpgMazeDetailUIApi:GetString("CheckPointText"))
end

function RpgMazeDetailUIController:GetPreloadAssetPaths()
	return nil
end

function RpgMazeDetailUIController:GetOpenPreloadAssetPaths(userData)
	return nil
end

function RpgMazeDetailUIController:IsManualShowOnOpen(userData)
	return false
end

function RpgMazeDetailUIController:GetBGM(userData)
	return nil
end

function RpgMazeDetailUIController:OnOpen(userData)
	self.ClickConfirmEffect:SetActive(false)
	self:UpdateView(userData.mazeCid)
end

function RpgMazeDetailUIController:OnClose(userData)
	return
end

function RpgMazeDetailUIController:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmBtn)
	self.FormationNoticeBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickFormationNoticeBtn)
end

function RpgMazeDetailUIController:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
	self.FormationNoticeBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickFormationNoticeBtn)
end

function RpgMazeDetailUIController:OnPause()
	return
end

function RpgMazeDetailUIController:OnResume()
	return
end

function RpgMazeDetailUIController:OnCover()
	return
end

function RpgMazeDetailUIController:OnReveal()
	return
end

function RpgMazeDetailUIController:OnRefocus(userData)
	return
end

function RpgMazeDetailUIController:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function RpgMazeDetailUIController:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function RpgMazeDetailUIController:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function RpgMazeDetailUIController:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function RpgMazeDetailUIController:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i = 1, #self.RewardCells do
		local itemCell = self.RewardCells[i]

		itemCell:Dispose()
	end

	self.RewardCells = nil

	for i = 1, #self.FormationCells do
		local cell = self.FormationCells[i]

		cell:Dispose()
	end

	self.FormationCells = nil

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.UIController = nil
end

function RpgMazeDetailUIController:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function RpgMazeDetailUIController:OnClickConfirmBtn()
	local cfgMazeInstanceData = CfgMazeInstanceTable[self.MazeCid]

	if cfgMazeInstanceData.TimesLimit ~= 0 then
		local leftNum = PlayerModule.GetMazeLeftCount(self.MazeCid)

		if leftNum <= 0 then
			NoticeModule.ShowNotice(21040092)

			return
		end
	end

	MazeModule.SendEnterRpgMaze(self.MazeCid)
	self.ClickConfirmEffect:SetActive(true)
end

function RpgMazeDetailUIController:UpdateView(mazeCid)
	self.MazeCid = mazeCid

	local cfgMazeInstanceData = CfgMazeInstanceTable[self.MazeCid]
	local cfgChapterData = CfgChapterTable[cfgMazeInstanceData.ChapterId]

	UGUIUtil.SetText(self.MazeOrderText, RpgMazeDetailUIApi:GetString("MazeOrderText", cfgChapterData.Order, cfgMazeInstanceData.Order))
	UGUIUtil.SetText(self.MazeNameText, cfgMazeInstanceData.Name)
	UGUIUtil.SetText(self.MazeDescText, cfgMazeInstanceData.Desc)

	local rewards = MazeModule.GetRewardShowData(cfgMazeInstanceData)

	for i = 1, #self.RewardCells do
		local itemCell = self.RewardCells[i]
		local itemInfo = rewards[i]
		local itemCid = 0
		local itemNum = 0
		local isFirstPassReward = false
		local isUncertain = false

		if itemInfo ~= nil then
			itemCid = itemInfo.cid
			itemNum = itemInfo.number
			isFirstPassReward = itemInfo.isFirstPassReward
			isUncertain = itemInfo.isUncertain
		end

		itemCell:SetData(itemCid, itemNum, isFirstPassReward, isUncertain)
	end

	local mazeInfoPOD = PlayerModule.PlayerInfo.mazeInfoPOD[self.MazeCid]
	local score = 0

	if mazeInfoPOD ~= nil then
		score = mazeInfoPOD.score
	end

	UGUIUtil.SetText(self.ExploreText, RpgMazeDetailUIApi:GetString("ExploreText", score))

	self.ExploreBar:GetComponent("Image").fillAmount = score / 100

	self.ExploreMaxImg:SetActive(score >= 100)

	local dolls = {}

	for i = 1, #RpgMazeModule.DailyDupPOD.rpgMazePOD.dolls do
		local dollPOD = RpgMazeModule.DailyDupPOD.rpgMazePOD.dolls[i]

		if dollPOD.formationPos > 0 then
			table.insert(dolls, dollPOD)
		end
	end

	for i = 1, #self.FormationCells do
		local formationCell = self.FormationCells[i]
		local dollPOD = dolls[i]
		local soulData

		if dollPOD ~= nil and dollPOD.soulCid ~= nil then
			soulData = SoulModule.CreateCustomSoulData(dollPOD.soulCid, {
				cid = dollPOD.soulCid,
				lv = dollPOD.lv,
				dress2DCid = dollPOD.dress2DCid,
				dress3DCid = dollPOD.dress3DCid
			})
		end

		formationCell:SetData(soulData, dollPOD)
	end
end

function RpgMazeDetailUIController:OnClickFormationNoticeBtn()
	NoticeModule.ShowNotice(21070000)
end

return RpgMazeDetailUIController
