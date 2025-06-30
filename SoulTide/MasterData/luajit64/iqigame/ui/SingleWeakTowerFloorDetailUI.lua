-- chunkname: @IQIGame\\UI\\SingleWeakTowerFloorDetailUI.lua

local SingleWeakTowerFloorDetailUI = {
	EntityId = 0,
	isPassAll = false,
	isCurrentFloorPass = false,
	itemCells = {},
	monsterHeadCells = {}
}

SingleWeakTowerFloorDetailUI = Base:Extend("SingleWeakTowerFloorDetailUI", "IQIGame.Onigao.UI.SingleWeakTowerFloorDetailUI", SingleWeakTowerFloorDetailUI)

require("IQIGame.UIExternalApi.SingleWeakTowerFloorDetailUIApi")

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local FormationPanelController = require("IQIGame.UI.FormationUI.FormationPanelController")
local MazeRewardCell = require("IQIGame.UI.MazeDetail.MazeRewardCell")
local MonsterHeadCell = require("IQIGame.UI.Common.MonsterHeadCell")

function SingleWeakTowerFloorDetailUI:OnInit()
	function self.DelegateOnClickBtnRight()
		self:OnClickBtnRight()
	end

	function self.DelegateOnClickBtnLeft()
		self:OnClickBtnLeft()
	end

	function self.DelegateOnClickBtnForward()
		self:OnClickBtnForward()
	end

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnBtnAffix()
		self:OnBtnAffix()
	end

	function self.DelegateUpdateDailyDupEvent()
		self:OnUpdateDailyDupEvent()
	end

	function self.DelegateOnShowElementEntitySuccess(sender, args)
		self:OnShowElementEntitySuccess(sender, args)
	end

	function self.DelegateUpdateSingleWeakTowerEvent()
		self:OnUpdateSingleWeakTower()
	end

	self.formationPanelController = FormationPanelController.New(self.Formation, function()
		self:OnUpdateFormation()
	end)
	self.itemCellPool = UIObjectPool.New(10, function()
		return MazeRewardCell.New(UnityEngine.Object.Instantiate(self.Mould1))
	end, function(cell)
		cell:Dispose()
	end)
	self.monsterHeadCellPool = UIObjectPool.New(10, function()
		return MonsterHeadCell.__New(UnityEngine.Object.Instantiate(self.MouldMonster))
	end, function(cell)
		cell:Dispose()
	end)
end

function SingleWeakTowerFloorDetailUI:GetPreloadAssetPaths()
	return nil
end

function SingleWeakTowerFloorDetailUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function SingleWeakTowerFloorDetailUI:IsManualShowOnOpen(userData)
	return false
end

function SingleWeakTowerFloorDetailUI:GetBGM(userData)
	return nil
end

function SingleWeakTowerFloorDetailUI:OnOpen(userData)
	self.type = userData.Type

	self:RefreshSelectFloor()
	self:UpdateView()
end

function SingleWeakTowerFloorDetailUI:OnClose(userData)
	self:HideEntity()
end

function SingleWeakTowerFloorDetailUI:OnAddListeners()
	self.BtnRight:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnRight)
	self.BtnLeft:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnLeft)
	self.BtnForward:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnForward)
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.BtnAffix:GetComponent("Button").onClick:AddListener(self.DelegateOnBtnAffix)
	self.formationPanelController:AddEventListeners()
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
	EventDispatcher.AddEventListener(EventID.UpdateDailyDupEvent, self.DelegateUpdateDailyDupEvent)
	EventDispatcher.AddEventListener(EventID.UpdateSingleWeakTowerEvent, self.DelegateUpdateSingleWeakTowerEvent)
end

function SingleWeakTowerFloorDetailUI:OnRemoveListeners()
	self.BtnRight:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnRight)
	self.BtnLeft:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnLeft)
	self.BtnForward:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnForward)
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.BtnAffix:GetComponent("Button").onClick:RemoveListener(self.DelegateOnBtnAffix)
	self.formationPanelController:RemoveEventListeners()
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
	EventDispatcher.RemoveEventListener(EventID.UpdateDailyDupEvent, self.DelegateUpdateDailyDupEvent)
	EventDispatcher.RemoveEventListener(EventID.UpdateSingleWeakTowerEvent, self.DelegateUpdateSingleWeakTowerEvent)
end

function SingleWeakTowerFloorDetailUI:OnPause()
	return
end

function SingleWeakTowerFloorDetailUI:OnResume()
	return
end

function SingleWeakTowerFloorDetailUI:OnCover()
	return
end

function SingleWeakTowerFloorDetailUI:OnReveal()
	return
end

function SingleWeakTowerFloorDetailUI:OnRefocus(userData)
	return
end

function SingleWeakTowerFloorDetailUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function SingleWeakTowerFloorDetailUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function SingleWeakTowerFloorDetailUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function SingleWeakTowerFloorDetailUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function SingleWeakTowerFloorDetailUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.formationPanelController:Dispose()

	for i, v in pairs(self.itemCells) do
		self.itemCellPool:Release(v)
	end

	self.itemCells = {}

	self.itemCellPool:Dispose()

	for i, v in pairs(self.monsterHeadCells) do
		self.monsterHeadCellPool:Release(v)
	end

	self.monsterHeadCells = {}

	self.monsterHeadCellPool:Dispose()
end

function SingleWeakTowerFloorDetailUI:OnUpdateDailyDupEvent()
	if SingleWeakTowerMould.IsShow() then
		self:RefreshSelectFloor()
		self:UpdateView()
	end
end

function SingleWeakTowerFloorDetailUI:OnUpdateSingleWeakTower()
	if SingleWeakTowerMould.IsShow() then
		self:RefreshSelectFloor()
		self:UpdateView()
	end
end

function SingleWeakTowerFloorDetailUI:RefreshSelectFloor()
	local maxPassFloor = SingleWeakTowerMould.GetPassMaxFloorByType(self.type)
	local nextFloor = maxPassFloor + 1
	local cfgNextFloorData = SingleWeakTowerMould.cfgSingleWeakTowerDataTab[self.type][nextFloor]

	if cfgNextFloorData then
		self.floor = nextFloor
	else
		self.floor = maxPassFloor
	end

	self.cfgSingleWeakTowerFloorData = SingleWeakTowerMould.cfgSingleWeakTowerDataTab[self.type][self.floor]
	self.isCurrentFloorPass = self.floor <= SingleWeakTowerMould.GetPassMaxFloorByType(self.type)
end

function SingleWeakTowerFloorDetailUI:UpdateView()
	local cfgData = SingleWeakTowerMould.GetCfgDailyDupData()

	if cfgData then
		UGUIUtil.SetText(self.TitleName, cfgData.Name)
	end

	UGUIUtil.SetText(self.TextTitleType, SingleWeakTowerFloorDetailUIApi:GetString("TextTitleType", self.type))

	local weakPath = SingleWeakTowerFloorDetailUIApi:GetString("WeakImgPath", self.type)

	AssetUtil.LoadImage(self, weakPath, self.ImgWeak:GetComponent("Image"))
	self.formationPanelController:UpdateView()
	self:ShowCurrentFloor()
end

function SingleWeakTowerFloorDetailUI:ShowCurrentFloor()
	self:RefreshBtnState()
	self:ShowMonster(self.cfgSingleWeakTowerFloorData.EntityID)

	for i, v in pairs(self.itemCells) do
		self.itemCellPool:Release(v)
		v.View:SetActive(false)
		v.View.transform:SetParent(self.UIController.transform, false)
	end

	self.itemCells = {}

	for i = 1, #self.cfgSingleWeakTowerFloorData.ClearReward, 2 do
		local itemID = self.cfgSingleWeakTowerFloorData.ClearReward[i]
		local itemNum = self.cfgSingleWeakTowerFloorData.ClearReward[i + 1]
		local itemCell = self.itemCellPool:Obtain()

		itemCell.View:SetActive(true)
		itemCell.View.transform:SetParent(self.RewardGrid.transform, false)
		itemCell:SetData(itemID, itemNum)
		table.insert(self.itemCells, itemCell)
	end

	self:UpdateMonsterCells(self.cfgSingleWeakTowerFloorData.MonsterTeam)
	self.BtnAffix:SetActive(false)

	if #self.cfgSingleWeakTowerFloorData.AffixList > 0 then
		self.BtnAffix:SetActive(true)

		local id = self.cfgSingleWeakTowerFloorData.AffixList[1]
		local cfgData = CfgSkillSpecialEffectExplainTable[id]

		UGUIUtil.SetText(self.BtnAffixLabel, cfgData.EffectName)
	end

	self.TextTips:SetActive(self.isCurrentFloorPass)
	self.TextPassAll:SetActive(self.isPassAll)
	UGUIUtil.SetText(self.TextBossName, self.cfgSingleWeakTowerFloorData.MonsterName)
	UGUIUtil.SetText(self.TextMonster, self.cfgSingleWeakTowerFloorData.Name)
end

function SingleWeakTowerFloorDetailUI:RefreshBtnState()
	self.BtnLeft:SetActive(self.floor > 1)

	self.isCurrentFloorPass = self.floor <= SingleWeakTowerMould.GetPassMaxFloorByType(self.type)
	self.isPassAll = false

	local nextFloor = self.floor + 1
	local cfgNextFloorData = SingleWeakTowerMould.cfgSingleWeakTowerDataTab[self.type][nextFloor]

	if cfgNextFloorData and self.isCurrentFloorPass then
		self.BtnRight:SetActive(true)
	else
		self.BtnRight:SetActive(false)

		self.isPassAll = self.isCurrentFloorPass
	end
end

function SingleWeakTowerFloorDetailUI:UpdateMonsterCells(MonsterTeam)
	for i, v in pairs(self.monsterHeadCells) do
		self.monsterHeadCellPool:Release(v)
		v.goView:SetActive(false)
		v.goView.transform:SetParent(self.UIController.transform, false)
	end

	self.monsterHeadCells = {}

	local cfgMonsterTeam = CfgMonsterTeamTable[MonsterTeam]

	for i = 1, #cfgMonsterTeam.TeamUnit do
		local monsterID = cfgMonsterTeam.TeamUnit[i]
		local state = 0

		if monsterID > 0 and not CfgMonsterTable[monsterID].NotShowInUI then
			state = i < 6 and 1 or 2

			local monsterHeadCell = self.monsterHeadCellPool:Obtain()

			monsterHeadCell.goView:SetActive(true)
			monsterHeadCell.goView.transform:SetParent(self.MonsterGrid.transform, false)
			monsterHeadCell:SetData(monsterID, state)

			function monsterHeadCell.clickHandler(mId)
				self:OnClickMonsterCell(mId)
			end

			table.insert(self.monsterHeadCells, monsterHeadCell)
		end
	end
end

function SingleWeakTowerFloorDetailUI:OnClickMonsterCell(monsterID)
	UIModule.Open(Constant.UIControllerName.BattleMonsterInfoUI, Constant.UILayer.UI, {
		monsterCid = monsterID
	})
end

function SingleWeakTowerFloorDetailUI:ShowMonster(elementEntityCid)
	self:HideEntity()

	self.EntityId = GameEntry.Entity:GenerateEntityID()

	GameEntry.Entity:ShowUIElement(self.EntityId, elementEntityCid, 0, self.MonsterSpine.transform, Vector3.zero)
end

function SingleWeakTowerFloorDetailUI:HideEntity()
	if self.EntityId ~= 0 then
		GameEntry.Entity:HideEntity(self.EntityId)

		self.EntityId = 0
	end
end

function SingleWeakTowerFloorDetailUI:OnShowElementEntitySuccess(sender, args)
	if self.EntityId == args.Entity.Id then
		args.Entity.gameObject.transform.localScale = Vector3(self.cfgSingleWeakTowerFloorData.EntityScale[1], self.cfgSingleWeakTowerFloorData.EntityScale[2], self.cfgSingleWeakTowerFloorData.EntityScale[3])
		args.Entity.gameObject.transform.localPosition = Vector3(self.cfgSingleWeakTowerFloorData.EntityPosition[1], self.cfgSingleWeakTowerFloorData.EntityPosition[2], self.cfgSingleWeakTowerFloorData.EntityPosition[3])

		local SpineRenderers = args.Entity.gameObject:GetComponentsInChildren(typeof(UnityEngine.Renderer))
		local animation = args.Entity.gameObject:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))

		if animation ~= nil then
			animation.state:SetAnimation(0, "idle", true)
		end

		if SpineRenderers ~= nil then
			local canvas = self.UIController:GetComponent("Canvas")

			for i = 0, SpineRenderers.Length - 1 do
				SpineRenderers[i].sortingOrder = canvas.sortingOrder + 1
			end
		end

		setGameObjectLayers(args.Entity.gameObject.transform, "UI")
	end
end

function SingleWeakTowerFloorDetailUI:OnUpdateFormation()
	self:ShowPower(self.formationPanelController:GetPower(), self.cfgSingleWeakTowerFloorData.RecommendPowerId)
end

function SingleWeakTowerFloorDetailUI:ShowPower(power1, power2)
	UGUIUtil.SetText(self.TextPowerNum, SingleWeakTowerFloorDetailUIApi:GetString("RecommendPowerText", power2))
	UGUIUtil.SetText(self.TextCurrentNum, SingleWeakTowerFloorDetailUIApi:GetString("TextPower", power1, power2))
end

function SingleWeakTowerFloorDetailUI:OnClickBtnRight()
	local nextFloor = self.floor + 1
	local cfgNextFloorData = SingleWeakTowerMould.cfgSingleWeakTowerDataTab[self.type][nextFloor]

	if cfgNextFloorData then
		self.floor = nextFloor
		self.cfgSingleWeakTowerFloorData = cfgNextFloorData

		self:ShowCurrentFloor()
	end
end

function SingleWeakTowerFloorDetailUI:OnClickBtnLeft()
	if self.floor > 1 then
		self.floor = self.floor - 1
		self.cfgSingleWeakTowerFloorData = SingleWeakTowerMould.cfgSingleWeakTowerDataTab[self.type][self.floor]

		self:ShowCurrentFloor()
	end
end

function SingleWeakTowerFloorDetailUI:OnClickBtnForward()
	if MainCityBattleModule.Instance.FightStarted then
		return
	end

	if #PlayerModule.PlayerInfo.formations == 0 then
		return
	end

	local valid, formationPOD = self.formationPanelController:CheckValidation()

	if not valid then
		return
	end

	local formationID = formationPOD.id

	SingleWeakTowerMould.Fight(self.cfgSingleWeakTowerFloorData.Id, formationID)
end

function SingleWeakTowerFloorDetailUI:OnBtnAffix()
	if #self.cfgSingleWeakTowerFloorData.AffixList > 0 then
		local id = self.cfgSingleWeakTowerFloorData.AffixList[1]
		local cfgData = CfgSkillSpecialEffectExplainTable[id]
		local describeStr = LinkTipUIApi:GetString("goDesc", cfgData.Describe)

		UIModule.Open(Constant.UIControllerName.MagicWaxMuseumTipUI, Constant.UILayer.UI, {
			name = cfgData.EffectName,
			describe = describeStr,
			refTrans = self.BtnAffix.transform
		})
	end
end

function SingleWeakTowerFloorDetailUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

return SingleWeakTowerFloorDetailUI
