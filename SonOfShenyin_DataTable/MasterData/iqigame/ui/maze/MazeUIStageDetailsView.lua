-- chunkname: @IQIGame\\UI\\Maze\\MazeUIStageDetailsView.lua

local MazeUIFormationElement = require("IQIGame/UI/Maze/MazeUIFormationElement")
local mazeUIStageBuffDetailsView = require("IQIGame/UI/Maze/MazeUIStageBuffDetailsView")
local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")
local ItemCell = {}

function ItemCell.New(view, clickHandler)
	local obj = Clone(ItemCell)

	obj:__Init(view, clickHandler)

	return obj
end

function ItemCell:__Init(view, clickHandler)
	self.gameObject = view
	self.clickHandler = clickHandler

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	function self.__delegateOnItemCellClick()
		self:__OnItemCellClick()
	end

	self.gameObject:GetComponent("Button").onClick:AddListener(self.__delegateOnItemCellClick)
end

function ItemCell:__OnItemCellClick()
	if self.clickHandler ~= nil then
		self.clickHandler()
	end
end

function ItemCell:Show(buffCid)
	self.gameObject:SetActive(true)
	self:__RefreshShow(buffCid)
end

function ItemCell:__RefreshShow(buffCid)
	self.buffCid = buffCid

	if self.buffCid == nil then
		LuaUtility.SetGameObjectShow(self.lockParent, true)
		LuaUtility.SetGameObjectShow(self.unLockParent, false)
	else
		LuaUtility.SetGameObjectShow(self.lockParent, false)
		LuaUtility.SetGameObjectShow(self.unLockParent, true)

		local buffCfg = CfgBuffTable[buffCid]

		AssetUtil.LoadImage(self, BattleApi:GetAttributeIconUrl(buffCfg.Icon), self.buffImg:GetComponent("Image"))
	end

	LuaUtility.SetGameObjectShow(self.NewTag, false)
end

function ItemCell:Hide()
	self.gameObject:SetActive(false)
end

function ItemCell:Dispose()
	AssetUtil.UnloadAsset(self)
	self.gameObject:GetComponent("Button").onClick:RemoveListener(self.__delegateOnItemCellClick)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local m = {
	diffMaxIndex = 0,
	diffSelectionIndex = 0,
	mainTeamHeroCount = 0,
	lastSelectIndex = 0,
	teamHeroItems = {},
	buffItems = {}
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.delegateOnClickEnterBtn()
		self:OnClickEnterBtn()
	end

	function self.delegateOnClickLeftBtn()
		self:OnClickLeftBtn()
	end

	function self.delegateOnClickRightBtn()
		self:OnClickRightBtn()
	end

	self.formationElement = MazeUIFormationElement.New(self.formationContent, function(teamHeroItems, mainTeamHeroCount)
		self:OnSelectHeroEvent(teamHeroItems, mainTeamHeroCount)
	end)
	self.itemPool = UIViewObjectPool.New(self.informationItemPrefab, self.informationGrid.transform)

	ForTransformChild(self.buffGrid.transform, function(_trans, _index)
		local buffItem = ItemCell.New(_trans.gameObject, function()
			self:OpenBuffDetailsView()
		end)

		table.insert(self.buffItems, buffItem)
	end)

	self.buffDetailsView = mazeUIStageBuffDetailsView.New(self.buffDetailsRoot)
	self.commonReturnBtn = CommonReturnBtn.New(self.commonReturnBtn, self)

	self.commonReturnBtn:SetHomeBtnState(false)
	self.commonReturnBtn:RegisterReturnEvent(function()
		self:Hide()
	end)

	self.moneyCell = CurrencyCell.New(self.moneyTopRoot)

	self:AddListeners()
end

function m:AddListeners()
	self.enterBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickEnterBtn)
	self.diffLeftSelectionBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickLeftBtn)
	self.diffRightSelectionBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickRightBtn)
end

function m:RemoveListeners()
	self.enterBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickEnterBtn)
	self.diffRightSelectionBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickRightBtn)
	self.diffRightSelectionBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickRightBtn)
end

function m:SetData(stageCid)
	self.stageCid = stageCid

	local labyrinthStagePOD = MazeModule.GetLabyrinthStagePOD(stageCid)

	self.labyrinthData = MazeModule.GetLabyrinthData()
	self.mazeStages = self.labyrinthData.labyrinthStagePODs
	self.diffMaxIndex = table.len(self.mazeStages)
	self.diffSelectionIndex = self:GetSelectDiffSelectIndex()

	self:InitDiffInfo()
end

function m:SetSelectDiffSelectIndex()
	PlayerPrefsUtil.SetInt(PlayerModule.GetPlayerPid(), Constant.PlayerPrefsConst.MazeDiffSelectIndex .. MazeModule.GetMazeSeason(), self.diffSelectionIndex)
	PlayerPrefsUtil.Save()
end

function m:GetSelectDiffSelectIndex()
	local index = PlayerPrefsUtil.GetInt(PlayerModule.GetPlayerPid(), Constant.PlayerPrefsConst.MazeDiffSelectIndex .. MazeModule.GetMazeSeason(), 1)

	if index > self.diffMaxIndex then
		index = 1
	end

	return index
end

function m:RefreshStageInfo()
	self.itemPool:ForItems(function(_item)
		LuaUtility.SetGameObjectShow(_item, false)
	end)

	local obj = self.itemPool:GetFree(function(_item)
		return not _item.activeSelf
	end)

	LuaUtility.SetGameObjectShow(obj, true)
	UGUIUtil.SetText(obj.transform:Find("titleText/contentText").gameObject, self.stageCfg.LevelDesc)
	self:RefreshBuffInfo()
end

function m:RefreshBuffInfo()
	for k, v in ipairs(self.buffItems) do
		v:Show(self.stageCfg.BuffGroup[k])
	end
end

function m:RefreshFormation()
	self.formationElement:SetData(self.stageCid)
end

function m:OnSelectHeroEvent(teamHeroItems, mainTeamHeroCount)
	self.teamHeroItems = teamHeroItems
	self.mainTeamHeroCount = mainTeamHeroCount

	local formationHeroMap = {}
	local replaceHeroList = {}

	ForArray(self.teamHeroItems, function(_index, _item)
		if _item.heroCid == 0 then
			return
		end

		if _index <= self.mainTeamHeroCount then
			formationHeroMap[_index * 2] = _item.heroCid
		else
			table.insert(replaceHeroList, _item.heroCid)
		end
	end)

	if getTableLength(formationHeroMap) == 0 then
		return
	end

	MazeModule.SetFormation(formationHeroMap, replaceHeroList)
end

function m:InitDiffInfo()
	self:RefreshDiffInfo()
end

function m:OnClickLeftBtn()
	self.diffSelectionIndex = self.diffSelectionIndex - 1

	if self.diffSelectionIndex <= 1 then
		self.diffSelectionIndex = 1
	end

	self:RefreshDiffInfo()
end

function m:OnClickRightBtn()
	self.diffSelectionIndex = self.diffSelectionIndex + 1

	if self.diffSelectionIndex >= self.diffMaxIndex then
		self.diffSelectionIndex = self.diffMaxIndex
	end

	self:RefreshDiffInfo()
end

function m:RefreshDiffInfo()
	self.mazeStageData = self.mazeStages[self.diffSelectionIndex]
	self.stageCfg = MazeModule.GetMazeStageCfg(self.mazeStageData.difficulty)
	self.stageCid = self.stageCfg.Id

	if not self:StageIsUnLock(self.stageCfg) then
		self.diffSelectionIndex = self.lastSelectIndex
		self.mazeStageData = self.mazeStages[self.diffSelectionIndex]

		NoticeModule.ShowNotice(80011)

		return
	end

	self:SetSelectDiffSelectIndex()

	self.lastSelectIndex = self.diffSelectionIndex

	UGUIUtil.SetText(self.stageName, self.stageCfg.StageName)
	UGUIUtil.SetText(self.detailDesc, self.stageCfg.StageDesc)
	LuaUtility.SetGameObjectShow(self.diffLeftSelectionBtn, self.diffSelectionIndex > 1)
	LuaUtility.SetGameObjectShow(self.diffRightSelectionBtn, self.diffSelectionIndex < self.diffMaxIndex)
	UGUIUtil.SetText(self.diffCNText, MazeApi:GetMazeStageDiffCNText(self.diffSelectionIndex))
	UGUIUtil.SetText(self.targetText, self.stageCfg.DetailDesc)

	if table.len(self.stageCfg.Cost) > 0 then
		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[self.stageCfg.Cost[1]].SmallIcon), self.consumeImg:GetComponent("Image"))
		UGUIUtil.SetText(self.consumeText, "×" .. self.stageCfg.Cost[2])
	end

	self:RefreshStageInfo()
	self:RefreshFormation()
end

function m:StageIsUnLock(stageCfg)
	return ConditionModule.CheckMultipleAllIsPass(ConditionModule.CheckMultiple(stageCfg.UnlockCondition))
end

function m:OpenBuffDetailsView()
	self.buffDetailsView:Show()
	self.buffDetailsView:SetData(self.stageCfg.BuffGroup)
end

function m:OnClickEnterBtn()
	local formationHeroMap = {}

	ForArray(self.teamHeroItems, function(_index, _item)
		if _item.heroCid == 0 then
			return
		end

		if _index <= self.mainTeamHeroCount then
			formationHeroMap[_index * 2] = _item.heroCid
		end
	end)

	if table.len(self.stageCfg.Cost) > 0 and WarehouseModule.GetItemNumByCfgID(self.stageCfg.Cost[1]) < self.stageCfg.Cost[2] then
		NoticeModule.ShowNotice(80012)

		return
	end

	if getTableLength(formationHeroMap) == 0 then
		NoticeModule.ShowNotice(49008)

		return
	end

	MazeModule.OnEnterStage(self.mazeStageData.difficulty)
end

function m:ShowOpenEffect()
	LuaUtility.SetGameObjectShow(self.openMask, true)

	local alphaTween = TweenAlpha.Begin(self.openMask, 1.5, 1, 0)

	alphaTween:SetOnFinished(function()
		LuaUtility.SetGameObjectShow(self.openMask, false)
		UnityEngine.Object.Destroy(alphaTween)
	end)
end

function m:Show()
	self:ShowOpenEffect()
	self.moneyCell:RefreshItem(Constant.TopMoneyType.MazeUI)
	self.buffDetailsView:Hide()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()
	self.formationElement:Dispose()
	self.commonReturnBtn:Dispose()
	self.buffDetailsView:Dispose()
	self.moneyCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
