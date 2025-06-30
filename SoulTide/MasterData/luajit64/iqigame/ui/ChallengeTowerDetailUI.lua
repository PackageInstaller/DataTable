-- chunkname: @IQIGame\\UI\\ChallengeTowerDetailUI.lua

local ChallengeTowerDetailUI = Base:Extend("ChallengeTowerDetailUI", "IQIGame.Onigao.UI.ChallengeTowerDetailUI", {
	tempLayer = 1,
	failureCD = 0,
	currentLayer = 1,
	turning = false,
	currentPage = 1,
	isUpdate = false,
	floorCells = {},
	MonsterElementCells = {},
	ItemCells = {}
})
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local MonsterElementCell = require("IQIGame.UI.MazeDetail.MonsterElementCell")
local MazeRewardCell = require("IQIGame.UI.MazeDetail.MazeRewardCell")
local ChallengeTowerFloorRender = require("IQIGame.UI.ChallengeTower.ChallengeTowerFloorRender")
local FormationPanelController = require("IQIGame.UI.FormationUI.FormationPanelController")

function ChallengeTowerDetailUI:OnInit()
	UGUIUtil.SetText(self.TextShop, ChallengeTowerUIApi:GetString("TextShop"))
	UGUIUtil.SetText(self.TextBtnForward, ChallengeTowerUIApi:GetString("TextBtnForward"))
	UGUIUtil.SetText(self.TextMaxFloor, ChallengeTowerUIApi:GetString("TextMaxFloor"))
	UGUIUtil.SetText(self.TextMonster, ChallengeTowerUIApi:GetString("TextMonster"))
	UGUIUtil.SetText(self.TextReward, ChallengeTowerUIApi:GetString("TextReward"))
	UGUIUtil.SetText(self.TextTips, ChallengeTowerUIApi:GetString("TextTips"))

	self.moneyCellBuilder = MoneyCellsBuilder.New(self.CurrencyCom)
	self.energyCell = EnergyCell.New(self.EnergyCom)

	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	self.FormationPanelController = FormationPanelController.New(self.Formation, function()
		self:OnUpdateFormation()
	end)

	function self.delegateBtnShop()
		self:OnClickBtnShop()
	end

	function self.delegateTweenEnd()
		self:OnTweenFlyOver()
	end

	function self.delegateBtnForward()
		self:OnClickBtnForward()
	end

	function self.delegateUpdateChallengeFailure(dupCid)
		self:OnUpdateChallengeFailure(dupCid)
	end

	function self.delegateUpdateTower(type)
		self:ChangeData(type)
	end

	function self.delegateUpdateTime()
		self:OnUpdateTime()
	end

	function self.delegateBtnLeft()
		self:OnBtnLeft()
	end

	function self.delegateBtnRight()
		self:OnBtnRight()
	end

	self.MonsterElementPool = UIObjectPool.New(5, function()
		local cell = MonsterElementCell.New(UnityEngine.Object.Instantiate(self.Mould))

		return cell
	end, function(cell)
		local v = cell.View

		cell:Dispose()
		UnityEngine.Object.Destroy(v)
	end)
	self.ItemCellPool = UIObjectPool.New(10, function()
		return MazeRewardCell.New(UnityEngine.Object.Instantiate(self.Mould1))
	end, function(cell)
		cell:Dispose()
	end)
	self.timer = Timer.New(self.delegateUpdateTime, 1, -1)
end

function ChallengeTowerDetailUI:GetPreloadAssetPaths()
	return nil
end

function ChallengeTowerDetailUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function ChallengeTowerDetailUI:IsManualShowOnOpen(userData)
	return false
end

function ChallengeTowerDetailUI:GetBGM(userData)
	return nil
end

function ChallengeTowerDetailUI:OnOpen(userData)
	self.BtnShop:SetActive(false)

	self.cfgDailyUp = userData

	self.moneyCellBuilder:RefreshView({
		Constant.ItemID.MONEY,
		Constant.ItemID.TREASURE
	})

	self.tempLayer = ChallengeTowerModule.towerDailyPOD.towerPOD.nowLayer
	self.currentLayer = ChallengeTowerModule.towerDailyPOD.towerPOD.nowLayer + 1
	self.currentPage = self:GetCfgAreaPage(self.currentLayer)

	self:UpdateView(1)
end

function ChallengeTowerDetailUI:OnClose(userData)
	return
end

function ChallengeTowerDetailUI:OnAddListeners()
	self.FormationPanelController:AddEventListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	self.BtnShop:GetComponent("Button").onClick:AddListener(self.delegateBtnShop)
	self.BtnForward:GetComponent("Button").onClick:AddListener(self.delegateBtnForward)
	self.BtnLeft:GetComponent("Button").onClick:AddListener(self.delegateBtnLeft)
	self.BtnRight:GetComponent("Button").onClick:AddListener(self.delegateBtnRight)
	EventDispatcher.AddEventListener(EventID.UpdateTowerFailure, self.delegateUpdateChallengeFailure)
	EventDispatcher.AddEventListener(EventID.UpdateTowerEvent, self.delegateUpdateTower)
end

function ChallengeTowerDetailUI:OnRemoveListeners()
	self.FormationPanelController:RemoveEventListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	self.BtnShop:GetComponent("Button").onClick:RemoveListener(self.delegateBtnShop)
	self.BtnForward:GetComponent("Button").onClick:RemoveListener(self.delegateBtnForward)
	self.BtnLeft:GetComponent("Button").onClick:RemoveListener(self.delegateBtnLeft)
	self.BtnRight:GetComponent("Button").onClick:RemoveListener(self.delegateBtnRight)
	EventDispatcher.RemoveEventListener(EventID.UpdateTowerFailure, self.delegateUpdateChallengeFailure)
	EventDispatcher.RemoveEventListener(EventID.UpdateTowerEvent, self.delegateUpdateTower)
end

function ChallengeTowerDetailUI:OnPause()
	return
end

function ChallengeTowerDetailUI:OnResume()
	return
end

function ChallengeTowerDetailUI:OnCover()
	return
end

function ChallengeTowerDetailUI:OnReveal()
	return
end

function ChallengeTowerDetailUI:OnRefocus(userData)
	return
end

function ChallengeTowerDetailUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.isUpdate == true then
		return
	end

	if UIModule.HasUI(Constant.UIControllerName.ChallengeRewardUI) == false then
		self.isUpdate = true

		self:UpdateView()
	end
end

function ChallengeTowerDetailUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ChallengeTowerDetailUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ChallengeTowerDetailUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ChallengeTowerDetailUI:OnDestroy()
	if self.timer then
		self.timer:Stop()
	end

	self.timer = nil

	if self.timerEffect then
		self.timerEffect:Stop()
	end

	self.timerEffect = nil

	self.FormationPanelController:Dispose()
	self.moneyCellBuilder:Dispose()

	self.moneyCellBuilder = nil

	self.energyCell:Dispose()

	self.energyCell = nil

	for i, v in pairs(self.floorCells) do
		v:Dispose()
	end

	self.floorCells = {}

	for i, v in pairs(self.MonsterElementCells) do
		self.MonsterElementPool:Release(v)
	end

	self.MonsterElementCells = {}

	self.MonsterElementPool:Dispose()

	for i, v in pairs(self.ItemCells) do
		self.ItemCellPool:Release(v)
	end

	self.ItemCells = {}

	self.ItemCellPool:Dispose()
end

function ChallengeTowerDetailUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.ChallengeTowerDetailUI)
end

function ChallengeTowerDetailUI:CreateAndShowLayers(type)
	local maxChangeLayer = ChallengeTowerModule.towerDailyPOD.towerPOD.nowLayer + 1
	local maxFloor = ChallengeTowerModule.GetCfgMaxFloor()

	maxChangeLayer = maxFloor < maxChangeLayer and maxFloor or maxChangeLayer

	local area = self.cfgTowerFloor.Area
	local areaCfgTab = {}

	for i, v in pairsCfg(CfgTowerFloorTable) do
		if area == v.Area and v.Unlock == 1 then
			table.insert(areaCfgTab, v)
		end
	end

	table.sort(areaCfgTab, function(tab1, tab2)
		return tab1.Id < tab2.Id
	end)

	for i, v in pairs(self.floorCells) do
		v:Dispose()
	end

	self.floorCells = {}

	local index = 0.2

	for i = 1, #areaCfgTab do
		local cfg = areaCfgTab[i]
		local obj

		if cfg.Type == 1 then
			obj = UnityEngine.Object.Instantiate(self.MouldLeft)
		else
			obj = UnityEngine.Object.Instantiate(self.MouldRight)
		end

		obj.transform:SetParent(self.Items.transform, false)

		obj.transform.anchoredPosition = Vector3.New(cfg.Position[1], cfg.Position[2], cfg.Position[3])

		if type == 1 then
			obj:SetActive(false)

			local timer = Timer.New(function()
				if obj and not LuaCodeInterface.GameObjIsDestroy(obj) then
					obj:SetActive(true)
				end
			end, index * i)

			timer:Start()
		else
			obj:SetActive(true)
		end

		local towerFloor = ChallengeTowerFloorRender.__New(obj)

		function towerFloor.selectCallBack(cfgTowerFloor)
			self:SelectRender(cfgTowerFloor)
		end

		towerFloor:SetData(cfg, maxChangeLayer, self.currentLayer)
		table.insert(self.floorCells, towerFloor)
	end

	local goAnimation = self.TowerEffect.transform:GetChild(0).gameObject
	local animation = goAnimation:GetComponent(typeof(UnityEngine.Animation))

	if animation ~= nil then
		animation:Play("FX_jiazailuoxuan02")
	end
end

function ChallengeTowerDetailUI:OnUpdateChallengeFailure(dupCid)
	self:SetPlayerPrefabs(self.cfgTowerFloor.Id, PlayerModule.GetServerTime())
	self:ShowCD(self.cfgTowerFloor)
end

function ChallengeTowerDetailUI:ChangeData(type)
	if type == 2 then
		self.isUpdate = true

		self:UpdateView(2)
	else
		self.isUpdate = false
	end
end

function ChallengeTowerDetailUI:UpdateView(type, layer)
	if self.tempLayer < ChallengeTowerModule.towerDailyPOD.towerPOD.nowLayer then
		self.currentLayer = ChallengeTowerModule.towerDailyPOD.towerPOD.nowLayer + 1
		self.tempLayer = ChallengeTowerModule.towerDailyPOD.towerPOD.nowLayer
	end

	local maxFloor = ChallengeTowerModule.GetCfgMaxFloor()

	if maxFloor <= ChallengeTowerModule.towerDailyPOD.towerPOD.nowLayer then
		self.currentLayer = maxFloor
	end

	if layer then
		self.currentLayer = layer
	end

	self.cfgTowerFloor = ChallengeTowerModule.GetTowerDataByLayer(self.currentLayer)

	UGUIUtil.SetText(self.TitleName, self.cfgDailyUp.Name)

	self.turning = false

	local isMaxLv = false

	self.BtnForward:SetActive(true)
	self.TextMaxFloor:SetActive(false)

	if maxFloor < ChallengeTowerModule.towerDailyPOD.towerPOD.nowLayer + 1 then
		self.TimeView:SetActive(false)

		isMaxLv = true
	else
		self.TimeView:SetActive(true)

		isMaxLv = false
	end

	if self.pageLayer ~= self.cfgTowerFloor.Area and type ~= 1 then
		self:PlayTurningEffect()
	else
		self:CreateAndShowLayers(2)
		self.Items:SetActive(true)

		if not isMaxLv then
			self.BtnForward:SetActive(true)
		end
	end

	self.pageLayer = self.cfgTowerFloor.Area

	self:RefreshSelectLayMsg(self.currentLayer)
	self.FormationPanelController:UpdateView()
end

function ChallengeTowerDetailUI:RefreshSelectLayMsg(layer)
	local cfgTowerFloor = ChallengeTowerModule.GetTowerDataByLayer(layer)

	for i, v in pairs(self.MonsterElementCells) do
		v.View.transform:SetParent(self.UIController.transform, false)
		v.View:SetActive(false)
		self.MonsterElementPool:Release(v)
	end

	self.MonsterElementCells = {}

	local tab = {}
	local cfgMonsterTeam = CfgMonsterTeamTable[cfgTowerFloor.MonsterTeam]

	for i = 1, #cfgMonsterTeam.TeamUnit do
		local monsterID = cfgMonsterTeam.TeamUnit[i]

		if monsterID > 0 then
			local cfgMonster = CfgMonsterTable[monsterID]

			if #cfgMonster.WeakType > 0 then
				for i = 1, #cfgMonster.WeakType do
					local id = cfgMonster.WeakType[i]

					if tab[id] == nil then
						local t = {}

						t.weakType = id
						t.num = 1
						tab[id] = t
					else
						tab[id].num = tab[id].num + 1
					end
				end
			end
		end
	end

	local sortTab = {}

	for i, v in pairs(tab) do
		table.insert(sortTab, v)
	end

	table.sort(sortTab, function(a, b)
		local res = false

		if a.num == b.num then
			res = a.weakType < b.weakType
		else
			res = a.num > b.num
		end

		return res
	end)

	for i = 1, #sortTab do
		local b = sortTab[i]
		local cell = self.MonsterElementPool:Obtain()

		cell.View:SetActive(true)
		cell.View.transform:SetParent(self.MonsterGrid.transform, false)
		cell:SetData(b.weakType)
		table.insert(self.MonsterElementCells, cell)
	end

	for i, v in pairs(self.ItemCells) do
		self.ItemCellPool:Release(v)
		v.View:SetActive(false)
		v.View.transform:SetParent(self.UIController.transform, false)
	end

	self.ItemCells = {}

	for i = 1, #cfgTowerFloor.ClearReward, 2 do
		local itemID = cfgTowerFloor.ClearReward[i]
		local itemNum = cfgTowerFloor.ClearReward[i + 1]

		if CfgItemTable[itemID].IsPanelShow then
			local itemCell = self.ItemCellPool:Obtain()

			itemCell.View:SetActive(true)
			itemCell.View.transform:SetParent(self.RewardGrid.transform, false)
			itemCell:SetData(itemID, itemNum)
			table.insert(self.ItemCells, itemCell)
		end
	end

	self:ShowCD(cfgTowerFloor)
	self:RefreshPageBtn()
end

function ChallengeTowerDetailUI:ShowCD(cfgTowerFloor)
	local preData = self:GetChallengeCD(cfgTowerFloor.Id)

	if preData ~= nil then
		self.failureCD = CfgDiscreteDataTable[6507089].Data[1] - (PlayerModule.GetServerTime() - tonumber(preData))

		self:OnUpdateTime()
	else
		self.failureCD = 0

		self.TimeView:SetActive(false)
	end

	self.timer:Stop()

	if self.failureCD > 0 then
		self.timer:Start()
	end
end

function ChallengeTowerDetailUI:SetPlayerPrefabs(key, value)
	local dataTab = PlayerPrefsUtil.GetLuaTable(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.ChallengeTowerCD)

	if dataTab == nil then
		dataTab = {}
	end

	dataTab[tostring(key)] = value

	PlayerPrefsUtil.SetLuaTable(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.ChallengeTowerCD, dataTab)
end

function ChallengeTowerDetailUI:GetChallengeCD(id)
	local dataTab = PlayerPrefsUtil.GetLuaTable(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.ChallengeTowerCD)

	if dataTab then
		return dataTab[tostring(id)]
	end

	return nil
end

function ChallengeTowerDetailUI:OnUpdateTime()
	local preData = self:GetChallengeCD(self.cfgTowerFloor.Id)

	if preData ~= nil then
		self.failureCD = CfgDiscreteDataTable[6507089].Data[1] - (PlayerModule.GetServerTime() - tonumber(preData))
	end

	if self.failureCD >= 0 then
		UGUIUtil.SetText(self.TextTimeCD, ChallengeTowerUIApi:GetString("TextTimeCD", self:GetFormatTime(self.failureCD)))
		self.TimeView:SetActive(true)
	else
		self.TimeView:SetActive(false)
		self.timer:Stop()
	end
end

function ChallengeTowerDetailUI:GetFormatTime(second)
	local timeText = ""
	local h = math.floor(second / 3600)

	h = h < 10 and "0" .. h or tostring(h)

	local m = math.floor(second % 3600 / 60)

	m = m < 10 and "0" .. m or tostring(m)

	local s = math.floor(second % 60)

	s = s < 10 and "0" .. s or tostring(s)
	timeText = string.format("%s:%s:%s", h, m, s)

	return timeText
end

function ChallengeTowerDetailUI:OnUpdateFormation()
	local cfgRecommendPower = CfgRecommendPowerTable[self.cfgTowerFloor.RecommendPowerId]

	self:ShowPower(self.FormationPanelController:GetPower(), cfgRecommendPower.RecommendPower)
end

function ChallengeTowerDetailUI:ShowPower(power1, power2)
	UGUIUtil.SetText(self.TextPowerNum, MazeDetailUIApi:GetString("RecommendPowerText", power2))
	UGUIUtil.SetText(self.TextCurrentNum, ChallengeUIApi:GetString("TextPower", power1, power2))
end

function ChallengeTowerDetailUI:OnTweenFlyOver()
	if self.timerEffect then
		self.timerEffect:Stop()
	end

	self.turning = false
	self.timerEffect = nil

	self:CreateAndShowLayers(1)
	self.Items:SetActive(true)
	self.BtnForward:SetActive(true)
end

function ChallengeTowerDetailUI:OnClickBtnForward()
	if MainCityBattleModule.Instance.FightStarted then
		return
	end

	local isOpenTime = DailyDupModule.IsOpenTime(self.cfgDailyUp.Id)

	if isOpenTime == false then
		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, ChallengeTowerUIApi:GetString("TextNotOpen"))

		return
	end

	if #PlayerModule.PlayerInfo.formations == 0 then
		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, ChallengeTowerUIApi:GetString("NoFormations"))

		return
	end

	local valid, formationPOD = self.FormationPanelController:CheckValidation()

	if not valid then
		return
	end

	self.formationID = formationPOD.id

	if self.failureCD > 0 then
		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, ChallengeTowerUIApi:GetString("GetTimeCD"))

		return
	end

	local cfgTowerFloor = ChallengeTowerModule.GetTowerDataByLayer(self.currentLayer)

	ChallengeTowerModule.ClimbingTower(cfgTowerFloor.Id, self.formationID)
end

function ChallengeTowerDetailUI:PlayTurningEffect()
	if self.timerEffect then
		self.timerEffect:Stop()
	end

	self.timerEffect = nil
	self.timerEffect = Timer.New(self.delegateTweenEnd, 3)

	self.timerEffect:Start()
	self.Items:SetActive(false)
	self.BtnForward:SetActive(false)

	self.turning = true

	local goAnimation = self.TowerEffect.transform:GetChild(0).gameObject
	local animation = goAnimation:GetComponent(typeof(UnityEngine.Animation))

	if animation ~= nil then
		animation:Play("FX_jiazailuoxuan01")
	end
end

function ChallengeTowerDetailUI:OnBtnLeft()
	if self.turning then
		return
	end

	if self.currentPage > 1 then
		self.currentPage = self.currentPage - 1
		self.currentLayer = self:GetFirstLayerInArea(self.currentPage)

		self:UpdateView(nil, self.currentLayer)
	end
end

function ChallengeTowerDetailUI:OnBtnRight()
	if self.turning then
		return
	end

	local seePage, maxPage = self:GetUnlockMaxAreaPage()

	if seePage > self.currentPage then
		self.currentPage = self.currentPage + 1
		self.currentLayer = self:GetFirstLayerInArea(self.currentPage)

		self:UpdateView(nil, self.currentLayer)
	end
end

function ChallengeTowerDetailUI:GetFirstLayerInArea(areaPage)
	local areaCfgTab = {}

	for i, v in pairsCfg(CfgTowerFloorTable) do
		if areaPage == v.Area and v.Unlock == 1 then
			table.insert(areaCfgTab, v)
		end
	end

	table.sort(areaCfgTab, function(tab1, tab2)
		return tab1.Id < tab2.Id
	end)

	return areaCfgTab[1].Floor
end

function ChallengeTowerDetailUI:GetCfgAreaPage(layer)
	for i, v in pairsCfg(CfgTowerFloorTable) do
		if v.Floor == layer then
			return v.Area
		end
	end

	local nowLayer = ChallengeTowerModule.towerDailyPOD.towerPOD.nowLayer

	if nowLayer < layer then
		for i, v in pairsCfg(CfgTowerFloorTable) do
			if v.Floor == nowLayer then
				return v.Area
			end
		end
	end

	return 1
end

function ChallengeTowerDetailUI:GetUnlockMaxAreaPage()
	local maxCfgPage = 0
	local seeMaxPage = 0

	for i, v in pairsCfg(CfgTowerFloorTable) do
		if maxCfgPage < v.Area and v.Unlock == 1 then
			maxCfgPage = v.Area
		end
	end

	local showMaxLayer = ChallengeTowerModule.towerDailyPOD.towerPOD.nowLayer + 1
	local maxFloor = ChallengeTowerModule.GetCfgMaxFloor()

	if maxFloor <= ChallengeTowerModule.towerDailyPOD.towerPOD.nowLayer then
		showMaxLayer = maxFloor
	end

	seeMaxPage = self:GetCfgAreaPage(showMaxLayer)

	return seeMaxPage, maxCfgPage
end

function ChallengeTowerDetailUI:RefreshPageBtn()
	local seePage, maxPage = self:GetUnlockMaxAreaPage()

	self.BtnLeft:SetActive(self.currentPage > 1)
	self.BtnRight:SetActive(seePage > self.currentPage)
	self.TextTips:SetActive(self.currentLayer <= ChallengeTowerModule.towerDailyPOD.towerPOD.nowLayer)
end

function ChallengeTowerDetailUI:SelectRender(cfgTower)
	if ChallengeTowerModule.towerDailyPOD.towerPOD.nowLayer < cfgTower.Floor - 1 then
		return
	end

	self.currentLayer = cfgTower.Floor

	self:RefreshSelectLayMsg(self.currentLayer)

	for i, v in pairs(self.floorCells) do
		v:Select(v.cfgTowerFloor.Floor == self.currentLayer)
	end
end

function ChallengeTowerDetailUI:OnClickBtnShop()
	return
end

return ChallengeTowerDetailUI
