-- chunkname: @IQIGame\\UI\\LunaBattleLine\\DetailUI\\LunaBattleLineDetailController.lua

local FormationPanelController = require("IQIGame.UI.FormationUI.FormationPanelController")
local MazeRewardCell = require("IQIGame.UI.MazeDetail.MazeRewardCell")
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local MonsterElementCell = require("IQIGame.UI.MazeDetail.MonsterElementCell")
local LunaBattleAssistantSoulHeadCell = require("IQIGame.UI.LunaBattleLine.DetailUI.LunaBattleAssistantSoulHeadCell")
local m = {
	HasRepeatSoul = false,
	MazeCid = 0,
	IsShow = false,
	MonsterElementCells = {}
}

function m.New(view, host, onShow, onHide)
	local obj = Clone(m)

	obj:Init(view, host, onShow, onHide)

	return obj
end

function m:Init(view, host, onShow, onHide)
	self.View = view
	self.Host = host
	self.OnShowCallback = onShow
	self.OnHideCallback = onHide

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickEnterBtn()
		self:OnClickEnterBtn()
	end

	function self.DelegateOnClickChangeAssistantBtn()
		self:OnClickChangeAssistantBtn()
	end

	function self.DelegateOnRefreshAssists(assistUnits)
		self:OnRefreshAssists(assistUnits)
	end

	self.IsShow = self.View.activeSelf
	self.FormationPanelController = FormationPanelController.New(self.FormationPanel, function()
		self:OnUpdateFormation()
	end)
	self.MonsterElementPool = UIObjectPool.New(5, function()
		local cell = MonsterElementCell.New(UnityEngine.Object.Instantiate(self.WeakPrefab))

		return cell
	end, function(cell)
		local v = cell.View

		cell:Dispose()
		UnityEngine.Object.Destroy(v)
	end)
	self.RewardCells = {}

	for i = 1, 5 do
		local itemCell = MazeRewardCell.New(UnityEngine.Object.Instantiate(self.RewardPrefab))

		itemCell.View.transform:SetParent(self.RewardGrid.transform, false)
		table.insert(self.RewardCells, itemCell)
	end

	self.AssistantSoulHead = LunaBattleAssistantSoulHeadCell.New(self.AssistantSoulHeadView)

	UGUIUtil.SetText(self.WeakLabel, LunaBattleLineDetailUIApi:GetString("DetailViewWeakLabel"))
	UGUIUtil.SetText(self.RewardLabel, LunaBattleLineDetailUIApi:GetString("DetailViewRewardLabel"))
	UGUIUtil.SetText(self.AssistanceTipText, LunaBattleLineDetailUIApi:GetString("DetailViewAssistanceTipText"))
	UGUIUtil.SetTextInChildren(self.EnterBtn, LunaBattleLineDetailUIApi:GetString("DetailViewEnterBtnText"))
	UGUIUtil.SetTextInChildren(self.AssistantTag, LunaBattleLineDetailUIApi:GetString("DetailViewAssistantTagText"))
end

function m:Show(zonePOD, mazeInstanceCid)
	if self.IsShow then
		return
	end

	self.IsShow = true

	self:AddListeners()
	self.View:SetActive(true)
	self:SetData(zonePOD, mazeInstanceCid)

	if self.OnShowCallback ~= nil then
		self.OnShowCallback()
	end
end

function m:Hide()
	if not self.IsShow then
		return
	end

	self.IsShow = false

	self:RemoveListeners()
	self.View:SetActive(false)

	if self.OnHideCallback ~= nil then
		self.OnHideCallback()
	end
end

function m:AddListeners()
	self.FormationPanelController:AddEventListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.EnterBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickEnterBtn)
	self.ChangeAssistantBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickChangeAssistantBtn)
	EventDispatcher.AddEventListener(EventID.LunaBattleLineRefreshAssists, self.DelegateOnRefreshAssists)
end

function m:RemoveListeners()
	self.FormationPanelController:RemoveEventListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.EnterBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickEnterBtn)
	self.ChangeAssistantBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickChangeAssistantBtn)
	EventDispatcher.RemoveEventListener(EventID.LunaBattleLineRefreshAssists, self.DelegateOnRefreshAssists)
end

function m:SetData(zonePOD, mazeInstanceCid)
	self.ZonePOD = zonePOD
	self.MazeCid = mazeInstanceCid

	local cfgLunaBattleLineZoneData = CfgLunaBattleLineZoneTable[self.ZonePOD.zoneId]
	local cfgMazeInstanceData = CfgMazeInstanceTable[mazeInstanceCid]

	UGUIUtil.SetText(self.TitleText, LunaBattleLineDetailUIApi:GetString("DetailViewTitleText", cfgLunaBattleLineZoneData.Name, cfgMazeInstanceData.Name))
	self:ClearMonsterElementCells(false)

	local elements = MazeModule.GetWeakShowData(cfgMazeInstanceData)

	self.WeakView:SetActive(#elements > 0)

	for i = 1, #elements do
		local cell = self.MonsterElementPool:Obtain()

		cell.View:SetActive(true)
		cell.View.transform:SetParent(self.WeakGrid.transform, false)
		cell:SetData(elements[i], cfgMazeInstanceData.MainWeakType)
		table.insert(self.MonsterElementCells, cell)
	end

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

	self.FormationPanelController:UpdateView()
	self:SetAssistant(nil)

	local isNotFortMaze = mazeInstanceCid ~= cfgLunaBattleLineZoneData.StationingLevel

	self.ChangeAssistantBtn:SetActive(isNotFortMaze)
end

function m:ClearMonsterElementCells(isDestroy)
	for i = 1, #self.MonsterElementCells do
		local cell = self.MonsterElementCells[i]

		cell.View:SetActive(false)

		if not isDestroy then
			cell.View.transform:SetParent(self.Host.UIController.transform, false)
		end

		self.MonsterElementPool:Release(cell)
	end

	self.MonsterElementCells = {}
end

function m:OnUpdateFormation()
	self:CheckRepeatSoul()
end

function m:OnClickCloseBtn()
	self.Host:HideZoneDetail()
end

function m:OnClickEnterBtn()
	local validate, noticeCid, formationPOD = self:CheckValidation()

	if validate then
		if noticeCid ~= 0 then
			NoticeModule.ShowNotice(noticeCid, function()
				self:EnterMaze(formationPOD.id)
			end)
		else
			self:EnterMaze(formationPOD.id)
		end
	end
end

function m:OnClickChangeAssistantBtn()
	if self.Assistant ~= nil then
		self:SetAssistant(nil)
	else
		LunaBattleLineModule.SendGetAssists(self.ZonePOD.zoneId, function(assistUnits)
			UIModule.Open(Constant.UIControllerName.LunaBattleLineAssistantUI, Constant.UILayer.UI, {
				zoneId = self.ZonePOD.zoneId,
				assistUnits = assistUnits,
				onChooseComplete = function(assistant)
					self:SetAssistant(assistant)
				end
			})
		end)
	end
end

function m:OnRefreshAssists(assistUnits)
	if self.Assistant ~= nil then
		local found = false

		for i = 1, #assistUnits do
			local assistUnit = assistUnits[i]

			if assistUnit.player.pid == self.Assistant.player.pid then
				found = true

				break
			end
		end

		if not found then
			self:SetAssistant(nil)
		end
	end
end

function m:CheckValidation()
	local formationPOD = FormationModule.GetFormationByIndex(self.FormationPanelController.FormationTabIndex)
	local soulNum = 0
	local soulPrefabDataList = {}

	for prefabId, prefabIndex in pairs(formationPOD.formation) do
		local soulPrefabData = SoulPrefabModule.GetPrefab(prefabId)

		if soulPrefabData.soulCid ~= nil then
			soulNum = soulNum + 1

			table.insert(soulPrefabDataList, soulPrefabData)
		end
	end

	if self.Assistant ~= nil and self.Assistant.soulPrefab ~= nil then
		soulNum = soulNum + 1

		local soulPrefabData = self:CreateSoulPrefabData(self.Assistant.soulPrefab)

		table.insert(soulPrefabDataList, soulPrefabData)
	end

	if soulNum == 0 then
		NoticeModule.ShowNotice(21040093)

		return false, 0, nil
	end

	if self.HasRepeatSoul then
		NoticeModule.ShowNotice(21062003)

		return false, 0, nil
	end

	local valid2, noticeCid = MazeModule.CheckCanEnterMaze(self.MazeCid, formationPOD, false, soulPrefabDataList)

	return valid2, noticeCid, formationPOD
end

function m:CreateSoulPrefabData(soulPrefab)
	local soulPrefabData = SoulPrefabData.New()

	soulPrefabData.customSkills = {}
	soulPrefabData.attrs = {}
	soulPrefabData.equipItemDatum = {}
	soulPrefabData.soulCid = soulPrefab.soulCid
	soulPrefabData.id = 0
	soulPrefabData.power = soulPrefab.power

	if soulPrefabData.power == nil then
		soulPrefabData.power = 0
	end

	soulPrefabData.attrs = soulPrefab.attr
	soulPrefabData.skillGroupId = soulPrefab.skillGroupId
	soulPrefabData.customSkills = soulPrefab.customSkills

	for i, formationEquipPOD in pairs(soulPrefab.equipments) do
		local itemData = LunaBattleLineModule.CreateEquipData(formationEquipPOD, i, true)

		soulPrefabData.equipItemDatum[i] = itemData
	end

	soulPrefabData.position = soulPrefab.position
end

function m:EnterMaze(formationId)
	MazeModule.SaveEntranceDataBeforeEnter(LunaBattleLineModule.GetRecoverMazeEntranceData(self.ZonePOD.zoneId))

	local cfgMazeInstanceData = CfgMazeInstanceTable[self.MazeCid]
	local cfgChapterData = CfgChapterTable[cfgMazeInstanceData.ChapterId]

	if cfgChapterData.Type == Constant.Maze.ChapterTypeLunaFort then
		MazeModule.SendEnterFortMaze(self.ZonePOD.zoneId, formationId)
	elseif cfgChapterData.Type == Constant.Maze.ChapterTypeScroll then
		local pid = ""

		if self.Assistant ~= nil and self.Assistant.player ~= nil then
			pid = self.Assistant.player.pid
		end

		MazeModule.SendEnterSealMaze(self.ZonePOD.zoneId, formationId, pid)
	else
		logError("迷宫类型错误：" .. cfgChapterData.Type)
	end
end

function m:SetAssistant(assistant)
	local soulPrefab

	if assistant ~= nil then
		soulPrefab = assistant.soulPrefab
	end

	self.Assistant = assistant

	self.AssistantSoulHead:SetData(soulPrefab)
	UGUIUtil.SetTextInChildren(self.ChangeAssistantBtn, LunaBattleLineDetailUIApi:GetString("SealingViewChangeAssistantBtnText", soulPrefab == nil))
	self.AssistantTag:SetActive(soulPrefab ~= nil)
	self:CheckRepeatSoul()
end

function m:CheckRepeatSoul()
	self.HasRepeatSoul = false

	if self.Assistant ~= nil and self.Assistant.soulPrefab ~= nil then
		local curFormationIndex = self.FormationPanelController.FormationTabIndex
		local formationPOD = FormationModule.GetFormationByIndex(curFormationIndex)

		for prefabId, prefabIndex in pairs(formationPOD.formation) do
			local soulPrefabData = SoulPrefabModule.GetPrefab(prefabId)

			if prefabIndex ~= 1 and soulPrefabData.soulCid == self.Assistant.soulPrefab.soulCid then
				self.HasRepeatSoul = true

				break
			end
		end
	end

	self.AssistanceTipText:SetActive(self.HasRepeatSoul)
end

function m:Dispose()
	self:ClearMonsterElementCells(true)
	self.MonsterElementPool:Dispose()

	for i = 1, #self.RewardCells do
		local itemCell = self.RewardCells[i]

		itemCell:Dispose()
	end

	self.RewardCells = nil

	self.FormationPanelController:Dispose()
	self.AssistantSoulHead:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.Host = nil
	self.ZonePOD = nil
	self.Assistant = nil
	self.OnShowCallback = nil
	self.OnHideCallback = nil
end

return m
