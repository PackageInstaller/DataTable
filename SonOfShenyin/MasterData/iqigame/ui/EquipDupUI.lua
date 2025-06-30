-- chunkname: @IQIGame\\UI\\EquipDupUI.lua

local EquipDupUI = {
	curNewUnlockPass = 1,
	toggleItems = {}
}

EquipDupUI = Base:Extend("EquipDupUI", "IQIGame.Onigao.UI.EquipDupUI", EquipDupUI)

local equipDiffToggleItem = require("IQIGame.UI.Chapter.EquipChapter.EquipDiffToggleItem")
local equipRewardItem = require("IQIGame.UI.Chapter.EquipChapter.EquipRewardItem")
local StageDetailPanel = require("IQIGame.UI.Chapter.StageDetailPanel")

function EquipDupUI:OnInit()
	LuaCodeInterface.BindOutlet(self.View, self)
	self:InitBaseInfo()
end

function EquipDupUI:GetPreloadAssetPaths()
	return nil
end

function EquipDupUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function EquipDupUI:IsManualShowOnOpen(userData)
	return false
end

function EquipDupUI:GetBGM(userData)
	return nil
end

function EquipDupUI:OnOpen(chapterData)
	self:InitChapterInfo(chapterData)
	self.moneyCell:RefreshItem(Constant.TopMoneyType.GameLevelUI)
end

function EquipDupUI:OnClose(userData)
	self.StageDetail:OnClose()
end

function EquipDupUI:OnPause()
	return
end

function EquipDupUI:OnResume()
	return
end

function EquipDupUI:OnCover()
	return
end

function EquipDupUI:OnReveal()
	return
end

function EquipDupUI:OnRefocus(userData)
	return
end

function EquipDupUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function EquipDupUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function EquipDupUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function EquipDupUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function EquipDupUI:OnDestroy()
	self.commonReturnBtn:Dispose()
	self.StageDetail:OnDestroy()

	if self.itemList and getTypeIsTable(self.itemList) then
		for k, v in pairs(self.itemList) do
			v:Dispose()
		end
	end

	if self.toggleItems and getTypeIsTable(self.toggleItems) then
		for k, v in pairs(self.toggleItems) do
			v:Dispose()
		end
	end

	self.moneyCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)
end

function EquipDupUI:OnAddListeners()
	self.StartBtn:GetComponent("Button").onClick:AddListener(self.delegateEnterBtn)
	self.StageDetailParent:GetComponent("Button").onClick:AddListener(self.delegateOpenStageDetailBtn)
end

function EquipDupUI:OnRemoveListeners()
	self.StartBtn:GetComponent("Button").onClick:RemoveListener(self.delegateEnterBtn)
	self.StageDetailParent:GetComponent("Button").onClick:RemoveListener(self.delegateOpenStageDetailBtn)
end

function EquipDupUI:InitBaseInfo()
	self.commonReturnBtn = CommonReturnBtn.New(self.Com_ReturnBtn, self)
	self.diffScrollView = self.DiffScrollView:GetComponent("ScrollAreaList")

	function self.diffScrollView.onRenderCell(cell)
		self:OnRenderDiffItem(cell)
	end

	function self.diffScrollView.onSelectedCell(cell)
		self:OnSelectCell(cell)
	end

	self.rewardScrollView = self.RewardScrollView:GetComponent("ScrollAreaList")

	function self.rewardScrollView.onRenderCell(cell)
		self:OnRenderRewardItem(cell)
	end

	function self.delegateEnterBtn()
		self:OnEnterBtnClick()
	end

	self.StageDetail = StageDetailPanel.New(self.StageDetailPanel)

	function self.delegateOpenStageDetailBtn()
		local monsterTeamID = self.stageData:GetCfg().MonsterTeam

		self.StageDetail:OnOpen(monsterTeamID)
	end

	UGUIUtil.SetText(self.DescTitle, ChapterUIApi:GetEquipChapterTitle(1))
	UGUIUtil.SetText(self.ElementTitle, ChapterUIApi:GetEquipChapterTitle(2))
	UGUIUtil.SetText(self.DifficultyTitle, ChapterUIApi:GetEquipChapterTitle(3))
	UGUIUtil.SetText(self.ConsumTitle, ChapterUIApi:GetConsumTitle())

	self.moneyCell = CurrencyCell.New(self.CurrencyContainer)
end

function EquipDupUI:InitChapterInfo(chapterData)
	self.chapterData = chapterData

	UGUIUtil.SetText(self.ChapterName, self.chapterData:GetCfg().Name)

	local path = UIGlobalApi.GetImagePath(self.chapterData:GetCfg().BackPicture)

	self:OnLoadImg(path, self.BG)

	self.stageList = {}
	self.itemList = {}

	local list = self.chapterData.passStatus

	for k, v in pairs(list) do
		table.insert(self.stageList, v)
	end

	table.sort(self.stageList, function(a, b)
		return a.cid < b.cid
	end)

	self.curNewUnlockPass = EquipChapterModule.GetNewUnLockPass(self.chapterData.cid)

	self.diffScrollView:Refresh(#self.stageList)
end

function EquipDupUI:OnRenderDiffItem(cell)
	local data = self.stageList[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local toggleObj = self.toggleItems[instanceID]

	if toggleObj == nil then
		toggleObj = equipDiffToggleItem.New(cell.gameObject, function(stageData)
			self:RefreshStageInfo(stageData)
		end)
		self.toggleItems[instanceID] = toggleObj
	end

	toggleObj:SetData(data, cell.index + 1)

	if cell.index + 1 == self.curNewUnlockPass then
		self:OnSelectCell(cell)
	end
end

function EquipDupUI:OnSelectCell(cell)
	if self.stageList[cell.index + 1].isUnLock == false then
		NoticeModule.ShowNotice(49005)

		return
	end

	local instanceID = cell.gameObject:GetInstanceID()
	local Cell = self.toggleItems[instanceID]

	self:UnselectedHeadCells()
	Cell:OnClickCell()

	self.selectIndex = cell.index + 1
end

function EquipDupUI:UnselectedHeadCells()
	for i, v in pairs(self.toggleItems) do
		v:OnUnselected()
	end
end

function EquipDupUI:RefreshStageInfo(stageData)
	self.stageData = stageData

	UGUIUtil.SetText(self.DescText, self.stageData:GetCfg().Desc)
	self:GetShowReward()
	self:RecommendElement()
	self:DifficultyDesc()
	self:RefreshEnterConsumItem()
end

function EquipDupUI:GetShowReward()
	self.rewardItems = {}

	for k = 1, #self.stageData:GetCfg().PassReward do
		for i, j in pairs(CfgDropLibTable[self.stageData:GetCfg().PassReward[k]].DropShowItem) do
			table.insert(self.rewardItems, j)
		end
	end

	self.rewardScrollView:Refresh(#self.rewardItems)
end

function EquipDupUI:RecommendElement()
	local elements = self.stageData:GetCfg().OddsValues

	for i = self.ElementGrid.transform.childCount, 1, -1 do
		local obj = self.ElementGrid.transform:GetChild(i - 1).gameObject

		UnityEngine.GameObject.Destroy(obj)
	end

	local obj

	for i = 1, #elements do
		obj = UnityEngine.Object.Instantiate(self.ElementItemPrefab)

		self:OnLoadImg(WarlockApi:GetElementIconPath(elements[i]), obj.transform:Find("Image"))
		obj.transform:SetParent(self.ElementGrid.transform, false)
	end
end

function EquipDupUI:DifficultyDesc()
	local descs = self.stageData:GetCfg().Difficultydesc

	for i = self.DifficultyGrid.transform.childCount, 1, -1 do
		local obj = self.DifficultyGrid.transform:GetChild(i - 1).gameObject

		UnityEngine.GameObject.Destroy(obj)
	end

	local obj

	for i = 1, #descs do
		obj = UnityEngine.Object.Instantiate(self.DifficultyItemPrefab)

		obj.transform:SetParent(self.DifficultyGrid.transform, false)
		UGUIUtil.SetText(obj.transform:Find("number").gameObject, ChapterUIApi:GetRomanNum(i))
		UGUIUtil.SetText(obj.transform:Find("desc").gameObject, descs[i])
	end
end

function EquipDupUI:RefreshEnterConsumItem()
	local cfgData = self.stageData:GetCfg()
	local consumNum, enterConsum, passConsum = 0, 0, 0
	local needItemCid = 0

	if cfgData.EnterCost ~= nil and #cfgData.EnterCost ~= 0 then
		enterConsum = cfgData.EnterCost[2]
		needItemCid = cfgData.EnterCost[1]
	end

	if cfgData.PassCost ~= nil and #cfgData.PassCost ~= 0 then
		passConsum = cfgData.PassCost[2]
		needItemCid = cfgData.PassCost[1]
	end

	consumNum = enterConsum + passConsum

	UGUIUtil.SetText(self.ConsumNumText, consumNum)

	local path = UIGlobalApi.GetIconPath(CfgItemTable[needItemCid].SmallIcon)

	self:OnLoadImg(path, self.ConsumSlotImg)
end

function EquipDupUI:OnRenderRewardItem(cell)
	local data = self.rewardItems[cell.index + 1]
	local Obj = self.itemList[cell.gameObject]

	if Obj == nil then
		Obj = equipRewardItem.New(cell.gameObject)
		self.itemList[cell.gameObject] = Obj
	end

	Obj:SetData(data)
end

function EquipDupUI:OnLoadImg(path, obj)
	AssetUtil.LoadImage(self, path, obj:GetComponent("Image"))
end

function EquipDupUI:OnEnterBtnClick()
	if self.stageData then
		local userData = {}

		userData.OpenType = 2
		userData.ChapterType = Constant.ChapterPassType.TYPE_EQUIP
		userData.StageId = self.stageData.cid

		UIModule.Open(Constant.UIControllerName.FormationUI, Constant.UILayer.UI, userData)
	end
end

return EquipDupUI
