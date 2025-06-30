-- chunkname: @IQIGame\\UI\\Formation\\GameFormationView.lua

local m = {
	IsCanGointoBattle = true,
	isShowHeroSelectPanel = false,
	currWave = 1,
	IsCanHelpGointoBattle = true,
	isSeePlayerTeam = true,
	TagIndex = 2,
	BoxTable = {},
	itemList = {},
	heroDataList = {},
	TagTabList = {},
	ElementTabList = {},
	ProfessionTabList = {},
	ForceTabList = {},
	FormationTabList = {},
	fightOrderCellList = {},
	heroFightOrderDataList = {},
	BackupMonsterCell = {}
}
local formationBoxCell = require("IQIGame.UI.Formation.ItemCell.FormationBoxCell")
local formationHeroHeadCell = require("IQIGame.UI.Formation.ItemCell.FormationHeroHeadCell")
local formationHelpBoxCell = require("IQIGame.UI.Formation.ItemCell.FormationHelpBoxCell")
local commonHeroScreenView = require("IQIGame.UI.Common.CommonHeroScreenView")
local FormationFightOrderView = require("IQIGame.UI.Formation.FormationFightOrderView")
local FormationAgentSkillView = require("IQIGame.UI.Formation.FormationAgentSkillView")

function m.New(view, mainUIController, mainUIObj)
	local obj = Clone(m)

	obj:Init(view, mainUIController, mainUIObj)

	return obj
end

function m:Init(view, mainUIController, mainUIObj)
	self.View = view
	self.MainUIController = mainUIController
	self.mainUIObj = mainUIObj

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateGoIntoBattleSuccessEvent()
		self:GoIntoBattleSuccessEvent()
	end

	function self.DelegateFormationToggleClickEvent()
		self:FormationToggleClickEvent()
	end

	function self.DelegateRenderCell(cell)
		self:OnRenderCell(cell)
	end

	function self.DelegateSelectHelpHeroEvent(helpHeroData)
		self:SelectHelpHeroEvent(helpHeroData)
	end

	function self.DelegateOnClickTab(isOn)
		self:OnClickChangeFormationTab(isOn)
	end

	function self.DelegateOnClickTagTab(isOn)
		self:OnClickTab(isOn)
	end

	function self.DelegateOnClickScreenBtn()
		self:OnClickScreenBtn()
	end

	function self.DelegateGetFormationSuccessEvent()
		self:GetFormationSuccessEvent()
	end

	LuaUtility.SetGameObjectShow(self.SyncFormationToggle, false)

	function self.DelegateScreenCallBack(heroDataList)
		self:ScreenCallback(heroDataList)
	end

	function self.DelegateOnClickCloseScreenBtn()
		self:OnClickCloseScreenBtn()
	end

	function self.DelegateOnClickCloseRoleInfoBtn()
		self:OnClickCloseRoleInfoBtn()
	end

	function self.DelegateOnClickSwitchHeroSelectPanelBtn(isOn)
		self:SwitchHeroSelectPanel(isOn)
	end

	function self.DelegateOnClickSwitchTroopType()
		self:OnClickSwitchTroopType()
	end

	function self.DelegateOnClickConfirmBtn()
		LuaUtility.RePlayAnimationWithName(self.BottomParent, "BottomParent_02")

		self.SwitchHeroSelectPanelBtn:GetComponent("Toggle").isOn = true

		LuaUtility.SetGameObjectShow(self.RedDot_90000, false)
	end

	function self.DelegateOnClickClearHeroBtn()
		self:OnClickClearHeroBtn()
	end

	function self.DelegateOnClickPreviousPage()
		self.currWave = self.currWave - 1

		self:GoIntoBattleSuccessEvent()
		self:RefreshFormationTerrain()
		self:OnClickSwitchMonsterTeam()
	end

	function self.DelegateOnClickNextPage()
		self.currWave = self.currWave + 1

		self:GoIntoBattleSuccessEvent()
		self:RefreshFormationTerrain()
		self:OnClickSwitchMonsterTeam()
	end

	function self.DelegateShowBackupMonster()
		self.reserveScroll:SetActive(not self.reserveScroll.activeSelf)
	end

	self.HeroScrollView = self.HeroScroll:GetComponent("ScrollAreaList")
	self.HeroScrollView.onRenderCell = self.DelegateRenderCell
	self.FormationHelpBoxCell = formationHelpBoxCell.New(self.HelpBox, self.MainUIController)
	self.FormationFightOrderView = FormationFightOrderView.New(self.FightOrderParent)

	self.FormationFightOrderView:Hide()

	for i = 1, self.TagTabGroup.transform.childCount do
		table.insert(self.TagTabList, self.TagTabGroup.transform:GetChild(i - 1).gameObject)
	end

	for i = 1, self.TabGroup.transform.childCount do
		table.insert(self.FormationTabList, self.TabGroup.transform:GetChild(i - 1).gameObject)
	end

	for i = 1, self.BoxRoot.transform.childCount do
		self.BoxTable[i] = formationBoxCell.New(self.BoxRoot.transform:Find("Box_" .. i).gameObject, self.MainUIController, i)
	end

	self.commonHeroScreenView = commonHeroScreenView.New(self.CommonScreenPanel, self.MainUIController, self.DelegateScreenCallBack)

	self:InitStaticText()
	self:AddListeners()
end

function m:AddListeners()
	for k, v in pairs(self.TagTabList) do
		v:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnClickTagTab)
	end

	for k, v in pairs(self.FormationTabList) do
		v:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnClickTab)
	end

	self.ScreenBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickScreenBtn)
	self.CloseScreenBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseScreenBtn)
	self.CloseRoleInfoBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseRoleInfoBtn)
	self.SwitchHeroSelectPanelBtn:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnClickSwitchHeroSelectPanelBtn)
	self.enemyDetailBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSwitchTroopType)
	self.ClearHeroBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickClearHeroBtn)
	self.ConfirmBtnBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmBtn)
	self.backBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickPreviousPage)
	self.forwardBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickNextPage)
	self.residueMonsterBtn:GetComponent("Button").onClick:AddListener(self.DelegateShowBackupMonster)
	EventDispatcher.AddEventListener(EventID.GoIntoBattleSuccessEvent, self.DelegateGoIntoBattleSuccessEvent)
	EventDispatcher.AddEventListener(EventID.SelectHelpHeroEvent, self.DelegateSelectHelpHeroEvent)
	EventDispatcher.AddEventListener(EventID.GetFormationSuccessEvent, self.DelegateGetFormationSuccessEvent)
	EventDispatcher.AddEventListener(EventID.ChangeMazeFormationEvent, self.DelegateGoIntoBattleSuccessEvent)
end

function m:RemoveListeners()
	for k, v in pairs(self.TagTabList) do
		v:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnClickTagTab)
	end

	for k, v in pairs(self.FormationTabList) do
		v:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnClickTab)
	end

	self.ScreenBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickScreenBtn)
	self.CloseScreenBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseScreenBtn)
	self.CloseRoleInfoBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseRoleInfoBtn)
	self.SwitchHeroSelectPanelBtn:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnClickSwitchHeroSelectPanelBtn)
	self.ConfirmBtnBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
	self.enemyDetailBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSwitchTroopType)
	self.backBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickPreviousPage)
	self.forwardBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickNextPage)
	self.residueMonsterBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateShowBackupMonster)
	self.ClearHeroBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickClearHeroBtn)
	EventDispatcher.RemoveEventListener(EventID.GoIntoBattleSuccessEvent, self.DelegateGoIntoBattleSuccessEvent)
	EventDispatcher.RemoveEventListener(EventID.SelectHelpHeroEvent, self.DelegateSelectHelpHeroEvent)
	EventDispatcher.RemoveEventListener(EventID.GetFormationSuccessEvent, self.DelegateGetFormationSuccessEvent)
	EventDispatcher.RemoveEventListener(EventID.ChangeMazeFormationEvent, self.DelegateGoIntoBattleSuccessEvent)
end

function m:InitStaticText()
	for i = 1, #self.TagTabList do
		self.TagTabList[i]:GetComponent("ToggleHelperComponent").text = FormationUIApi:GetSortTexts(i)
	end
end

function m:OnRenderCell(cell)
	local warlockData = self.heroDataList[cell.index + 1]
	local instanceId = cell.gameObject:GetInstanceID()
	local itemcell = self.itemList[instanceId]

	if itemcell == nil then
		itemcell = formationHeroHeadCell.New(cell.gameObject, self.MainUIController, self)
		self.itemList[instanceId] = itemcell
	end

	itemcell:SetData(warlockData)
end

function m:SetData()
	local showTroopType = true

	showTroopType = FormationModule.CfgDupStageOrStoryBattleCfg == nil and (FormationModule.FormationTypeIsMaze or FormationModule.FormationInTheMaze) and true or self.isSeePlayerTeam

	local monsters = {}

	if not showTroopType then
		local monsterTeamCid = self.mainUIObj.MonsterTeam[self.currWave]

		monsters = CfgMonsterTeamTable[monsterTeamCid].MonsterTeam
	end

	for k, v in pairs(self.BoxTable) do
		local data

		if showTroopType then
			data = FormationModule.CurFormationDataList[k]
		else
			local row, _ = math.modf((k - 1) / 3)
			local idx = k + 9 - row * 6
			local monsterCid = monsters[idx]

			if monsterCid ~= 0 then
				data = FormationModule.CreateHeroByMonster(monsterCid)
			end
		end

		v:SetData(data, showTroopType)
	end
end

function m:GoIntoBattleSuccessEvent()
	if self.isClearHero == true then
		self.isClearHero = false

		self:InitGointoData()

		return
	end

	self.HeroScrollView:RenderCellsDynamic(#self.heroDataList)
	self:SetData()
	self.FormationFightOrderView:Refresh()

	if self.IsCanGointoBattle then
		-- block empty
	end
end

function m:SelectHelpHeroEvent(helpHeroData)
	local HeroData = WarlockData.New()

	HeroData:CreateTemporaryData(helpHeroData, true)

	HeroData.SkillGroups = helpHeroData.hero.skill
	HeroData.AttributeGroups = helpHeroData.hero.attr

	self.FormationHelpBoxCell:SetData(HeroData)
end

function m:Show(onlyFormation)
	self.View:SetActive(true)
	self:ShowTab(1)

	self.FormationTabList[1]:GetComponent("Toggle").isOn = true
	self.TagTabList[1]:GetComponent("Toggle").isOn = true
	self.SwitchHeroSelectPanelBtn:GetComponent("Toggle").isOn = true
	self.isSeePlayerTeam = true
	self.currWave = 1
	self.onlyFormation = onlyFormation

	LuaUtility.SetText(self.enemyDetailText, FormationUIApi:GetFormationSwitchBtn(not self.isSeePlayerTeam))
	self.monsterFormation:SetActive(not self.isSeePlayerTeam)
	self:RefreshEnemyDetailBtnState()
	self.ConfirmBtnBtn.gameObject:SetActive(false)
	self.ClearHeroBtn.gameObject:SetActive(false)
	self:RefreshFromationState()
	self:OnClickCloseScreenBtn()
	LuaUtility.RePlayAnimationWithName(self.BottomParent, "BottomParent_02")
	self:RefreshTabRedDot()
	LuaUtility.SetGameObjectShow(self.TabGroup, not self.onlyFormation)
	self.FormationHelpBoxCell:Hide()
end

function m:RefreshTabRedDot()
	FormationModule.ChangeAllNewTag()
	LuaUtility.SetGameObjectShow(self.RedDot_90000, RedDotModule.CheckRedDot_GameFormationView())
end

function m:RefreshOnlyFormationInfo()
	return
end

function m:Hide()
	for k, v in pairs(self.BoxTable) do
		v:OnClose()
	end

	self.View:SetActive(false)
end

function m:RefreshFromationState()
	local playerTeam = 1

	self.IsCanHelpGointoBattle = false
	self.IsCanGointoBattle = true

	if not self.onlyFormation then
		playerTeam = FormationModule.CfgDupStageOrStoryBattleCfg.PlayerTeam == 0 and 1 or FormationModule.CfgDupStageOrStoryBattleCfg.PlayerTeam

		local formationType = CfgFormationTable[playerTeam].Type

		self.IsCanHelpGointoBattle = FormationModule.CfgDupStageOrStoryBattleCfg.IsHelp
		self.IsCanGointoBattle = formationType == Constant.FormationType.UNLIMITED or formationType == Constant.FormationType.FIXNPCANDCANMANUAL

		if FormationModule.CfgDupStageOrStoryBattleCfg.PlayerTeam > FormationModule.NormalFormationCount then
			FormationModule.TeamIndex = FormationModule.CfgDupStageOrStoryBattleCfg.PlayerTeam
		end
	end

	self:RefreshFormationTerrain()
	self:RefreshTabState()

	if self.IsCanGointoBattle then
		self.BottomParent.gameObject:SetActive(true)
	else
		self.BottomParent.gameObject:SetActive(false)
	end

	LuaUtility.SetGameObjectShow(self.HeroScroll, self.IsCanGointoBattle)
	LuaUtility.SetGameObjectShow(self.ScreenParent, self.IsCanGointoBattle)
	LuaUtility.SetGameObjectShow(self.BanGointoBattle, not self.IsCanGointoBattle)
	self.FormationHelpBoxCell:InitHelpHeroInfo(self.IsCanHelpGointoBattle)
	self:InitGointoData()
	EventDispatcher.Dispatch(EventID.FormationDragStateChageEvent, false)
end

function m:InitGointoData()
	if FormationModule.FormationInTheMaze then
		self:GetFormationSuccessEvent()
	elseif FormationModule.TeamIndex <= FormationModule.NormalFormationCount then
		FormationModule.GetFormation(FormationModule.TeamIndex)
	else
		self:GetFormationSuccessEvent()
	end
end

function m:GetFormationSuccessEvent()
	FormationModule.InitCurFormationData()
	self:SetData()
	self.HeroScrollView:Refresh(#self.heroDataList)

	if self.IsCanGointoBattle then
		FormationModule.InitAllFightOrder()
		self.FormationFightOrderView:Refresh()
	end
end

function m:RefreshFormationTerrain()
	if FormationModule.FormationInTheMaze or FormationModule.FormationTypeIsMaze then
		for k, v in pairs(self.BoxTable) do
			v:SetTerrainState(false)
		end
	else
		for k, v in pairs(self.BoxTable) do
			v:RefreshTerrain(self.isSeePlayerTeam)
		end
	end
end

function m:RefreshTabState()
	local normalFormation = FormationModule.TeamIndex <= FormationModule.NormalFormationCount and not FormationModule.FormationInTheMaze

	self.TabGroup:SetActive(normalFormation and self.isSeePlayerTeam)
end

function m:OnClickTab(isOn)
	if isOn then
		local currentTarget = self.MainUIController:GetCurrentTarget()

		for i = 1, #self.TagTabList do
			if self.TagTabList[i] == currentTarget then
				self:ShowTab(i)

				return
			end
		end
	end
end

function m:ShowTab(index)
	self:ScreenHeroList(index)
end

function m:OnClickChangeFormationTab(isOn)
	if isOn then
		local currentTarget = self.MainUIController:GetCurrentTarget()

		for i = 1, #self.FormationTabList do
			if self.FormationTabList[i] == currentTarget then
				self:ShowChangeFormationTab(i)

				return
			end
		end
	end
end

function m:ShowChangeFormationTab(index)
	FormationModule.TeamIndex = index

	self:InitGointoData()
	self.FormationHelpBoxCell:InitHelpHeroInfo(self.IsCanHelpGointoBattle)
end

function m:OnClickScreenBtn()
	LuaUtility.SetGameObjectShow(self.ScreenPanel, true)
end

function m:OnClickCloseScreenBtn()
	LuaUtility.SetGameObjectShow(self.ScreenPanel, false)
end

function m:ScreenHeroList(index)
	self.heroDataList = {}

	local warlockDataList = FormationModule.GetHeroDataList()

	for k, v in pairs(warlockDataList) do
		table.insert(self.heroDataList, v)
	end

	if index == 1 then
		table.sort(self.heroDataList, function(a, b)
			if a.lv == b.lv then
				if CfgHeroTable[a.cid].Quality == CfgHeroTable[b.cid].Quality then
					return a.cid < b.cid
				end

				return CfgHeroTable[a.cid].Quality > CfgHeroTable[b.cid].Quality
			end

			return a.lv > b.lv
		end)
	elseif index == 2 then
		table.sort(self.heroDataList, function(a, b)
			if CfgHeroTable[a.cid].Quality == CfgHeroTable[b.cid].Quality then
				if a.lv == b.lv then
					return a.cid < b.cid
				end

				return a.lv > b.lv
			end

			return CfgHeroTable[a.cid].Quality > CfgHeroTable[b.cid].Quality
		end)
	end

	self.commonHeroScreenView:SetData(self.heroDataList)
	self.commonHeroScreenView:RefreshScreen()
end

function m:ScreenCallback(heroDataList)
	self.heroDataList = heroDataList

	self.HeroScrollView:Refresh(#self.heroDataList)
end

function m:OnClickCloseRoleInfoBtn()
	EventDispatcher.Dispatch(EventID.FormationHeroOnLongClickEvent, false)
end

function m:SwitchHeroSelectPanel(isOn)
	if isOn then
		self.FormationFightOrderView:Show()
		LuaCodeInterface.SetGameObjectShow(self.DragEffectRoot, false)
	else
		self.FormationFightOrderView:Hide()
		LuaCodeInterface.SetGameObjectShow(self.DragEffectRoot, true)
		LuaUtility.RePlayAnimationWithName(self.BottomParent, "BottomParent_01")
	end

	ForPairs(self.BoxTable, function(k, v)
		v.canRemove = not isOn
	end)
	self.heroSelectParent:SetActive(not isOn)

	self.SwitchHeroSelectPanelBtn:GetComponent("Toggle").interactable = isOn

	self.ConfirmBtnBtn.gameObject:SetActive(not isOn)
	self.ClearHeroBtn.gameObject:SetActive(not isOn)

	self.mainUIObj.StartBtn:GetComponent("Button").interactable = isOn

	self.mainUIObj.startBg:GetComponent("GrayComponent"):SetGray(not isOn)

	if isOn then
		LuaUtility.SetImageColorWithGameObject(self.mainUIObj.startImg, 1, 1, 1, 1)
	else
		LuaUtility.SetImageColorWithGameObject(self.mainUIObj.startImg, 0.3333333333333333, 0.3333333333333333, 0.3333333333333333, 1)
	end
end

function m:OnClickSwitchTroopType()
	EventDispatcher.Dispatch(EventID.ShowFormationMonsterTeamView)

	do return end

	self.isSeePlayerTeam = not self.isSeePlayerTeam

	self:RefreshEnemyDetailBtnState()

	if self.isSeePlayerTeam then
		LuaUtility.SetText(self.enemyDetailText, FormationUIApi:GetFormationSwitchBtn(false))

		if self.IsCanGointoBattle then
			self.BottomParent.gameObject:SetActive(true)
		else
			self.BottomParent.gameObject:SetActive(false)
		end

		self.TabGroup.gameObject:SetActive(true)
		self.monsterFormation:SetActive(false)
	else
		self.currWave = 1

		LuaUtility.SetText(self.enemyDetailText, FormationUIApi:GetFormationSwitchBtn(true))
		self.BottomParent.gameObject:SetActive(false)
		self.TabGroup.gameObject:SetActive(false)
		self.monsterFormation:SetActive(true)
		self:OnClickSwitchMonsterTeam()
	end

	self:GoIntoBattleSuccessEvent()
	self:RefreshFormationTerrain()
	self:RefreshTabState()
end

function m:OnClickSwitchMonsterTeam()
	local monsterTeams = self.mainUIObj.MonsterTeam
	local minWave = 1
	local maxWave = #monsterTeams

	if maxWave > self.currWave then
		self.forwardBtn:GetComponent("Button").interactable = true

		LuaUtility.SetImageColorWithGameObject(self.forwardImg, 1, 1, 1, 1)
	else
		self.forwardBtn:GetComponent("Button").interactable = false

		LuaUtility.SetImageColorWithGameObject(self.forwardImg, 0.68, 0.68, 0.68, 1)
	end

	if minWave < self.currWave then
		self.backBtn:GetComponent("Button").interactable = true

		LuaUtility.SetImageColorWithGameObject(self.backImg, 1, 1, 1, 1)
	else
		self.backBtn:GetComponent("Button").interactable = false

		LuaUtility.SetImageColorWithGameObject(self.backImg, 0.68, 0.68, 0.68, 1)
	end

	if maxWave <= 1 then
		self.changeItem:SetActive(false)
	else
		self.changeItem:SetActive(true)
		UGUIUtil.SetText(self.waveTipsText, FormationUIApi:GetMonsterTeamIndexText(self.currWave))
	end

	local monsterTeamCfg = CfgMonsterTeamTable[monsterTeams[self.currWave]]
	local backup = monsterTeamCfg.BackTeam
	local backupCount = #backup

	if backupCount > 0 then
		if maxWave <= 1 then
			self.reserveTextParent:SetActive(true)
			self.waveTextParent:SetActive(false)
			UGUIUtil.SetText(self.reserveMonsterNumText, backupCount)
		else
			self.reserveTextParent:SetActive(false)
			self.waveTextParent:SetActive(true)
			UGUIUtil.SetText(self.WaveLostMonsterNumText, backupCount)
			UGUIUtil.SetText(self.WaveText, self.currWave)
			UGUIUtil.SetText(self.MaxWaveText, maxWave)
		end

		self.ReserveWaveParent:SetActive(true)

		for i, v in pairs(self.BackupMonsterCell) do
			v.gameObject:SetActive(false)
		end

		for i, v in pairs(backup) do
			local monsterCfg = CfgMonsterTable[v]
			local cell = self.BackupMonsterCell[i]

			if not cell then
				cell = {}

				local gameObject = UnityEngine.Object.Instantiate(self.ReserveRolePrefab, self.ReserveRolePanel.transform)

				cell.gameObject = gameObject

				LuaCodeInterface.BindOutlet(gameObject, cell)

				self.BackupMonsterCell[i] = cell
			end

			AssetUtil.LoadImage(self, BattleApi:GetMonsterHeadIconPath(monsterCfg.HeadIcon), cell.gameObject:GetComponent("Image"))
			cell.gameObject:SetActive(true)
		end

		self.reserveScroll:SetActive(true)
	else
		self.ReserveWaveParent:SetActive(false)
	end
end

function m:RefreshEnemyDetailBtnState()
	if FormationModule.CfgDupStageOrStoryBattleCfg == nil and (FormationModule.FormationInTheMaze or FormationModule.FormationTypeIsMaze) then
		LuaUtility.SetGameObjectShow(self.enemyDetailBtn, false)
	else
		LuaUtility.SetGameObjectShow(self.enemyDetailBtn, true)
		LuaUtility.SetGameObjectShow(self.enemyDetailBtn.transform:Find("on").gameObject, self.isSeePlayerTeam)
		LuaUtility.SetGameObjectShow(self.enemyDetailBtn.transform:Find("off").gameObject, not self.isSeePlayerTeam)
	end
end

function m:OnClickClearHeroBtn()
	if FormationModule.TeamIndex > FormationModule.NormalFormationCount then
		return
	end

	self.isClearHero = true

	FormationModule.SaveFormation(FormationModule.TeamIndex, {}, {}, {}, {})
end

function m:Dispose()
	self.FormationFightOrderView:Dispose()
	self:RemoveListeners()

	for k, v in pairs(self.itemList) do
		v:Dispose()
	end

	for k, v in pairs(self.BoxTable) do
		v:Dispose()
	end

	self.FormationHelpBoxCell:Dispose()
	self.commonHeroScreenView:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function m:Update(elapseSeconds, realElapseSeconds)
	return
end

return m
