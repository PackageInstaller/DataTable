-- chunkname: @IQIGame\\UI\\Formation\\FormationInfoView.lua

local CommonGlobalBuffView = require("IQIGame/UI/Common/GlobalBuff/CommonGlobalBuffView")
local m = {
	IsPresetFormation = true,
	ProfessionImgList = {},
	ElementImgList = {},
	terrainItemList = {}
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.buffView = CommonGlobalBuffView.New(self.BuffParent)

	function self.DelegateNotifyFormationData()
		self:NotifyFormationChange()
	end

	function self.DelegateFormationToggleClickEvent()
		self:FormationToggleClickEvent()
	end

	function self.DelegateOnClickTerrainDetailsBtn()
		self:OnClickTerrainDetailsBtn()
	end

	function self.DelegateOnClickEnemyInfoBtnBtn()
		self:OnClickEnemyInfoBtn()
	end

	self:AddListeners()
end

function m:AddListeners()
	self.TerrainDetailsBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickTerrainDetailsBtn)
	self.enemyInfoBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickEnemyInfoBtnBtn)
	EventDispatcher.AddEventListener(EventID.NotifyFormationDataChangeEvent, self.DelegateNotifyFormationData)
	EventDispatcher.AddEventListener(EventID.FormationToggleClickEvent, self.DelegateFormationToggleClickEvent)
end

function m:RemoveListeners()
	self.TerrainDetailsBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickTerrainDetailsBtn)
	self.enemyInfoBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickEnemyInfoBtnBtn)
	EventDispatcher.RemoveEventListener(EventID.NotifyFormationDataChangeEvent, self.DelegateNotifyFormationData)
	EventDispatcher.RemoveEventListener(EventID.FormationToggleClickEvent, self.DelegateFormationToggleClickEvent)
end

function m:SetData()
	self.FormationData = FormationModule.CurFormationDataList

	local maxCount = CfgFormationTable[FormationModule.TeamIndex].MaxHeroCount
	local curCount = table.len(self.FormationData)

	UGUIUtil.SetText(self.MaxGointoCount, "/" .. maxCount)
	UGUIUtil.SetText(self.CurGointoCount, curCount)

	if not FormationModule.FormationInTheMaze and not FormationModule.FormationTypeIsMaze then
		UGUIUtil.SetText(self.ObjectiveDesc, FormationModule.CfgDupStageOrStoryBattleCfg.VictroyDesc)
	end

	local show = curCount < maxCount

	if show then
		local heroCount = WarlockModule.GetHeroTotalCount()

		show = curCount < heroCount
	end

	LuaCodeInterface.SetGameObjectShow(self.DragHeroEffectRoot, show)
end

function m:NotifyFormationChange()
	self:SetData()
end

function m:FormationToggleClickEvent()
	self:SetData()
end

function m:OnClickTerrainDetailsBtn()
	EventDispatcher.Dispatch(EventID.FormationOpenTerrainDetailsEvent)
end

function m:OnClickEnemyInfoBtn()
	EventDispatcher.Dispatch(EventID.FormationOpenMonsterDetailEvent)
end

function m:SetTerrainInfo()
	local map = FormationModule.GetFormationTerrainData(FormationModule.CfgDupStageOrStoryBattleCfg, self.showTroopTyp)
	local allTerrainTypes = FormationModule.GetAllTerrainType(map.MapType)

	for i = 1, #self.terrainItemList do
		self.terrainItemList[i].View:SetActive(i <= #allTerrainTypes)
	end

	for i = 1, #allTerrainTypes do
		local terrainItme = self:CreateTerrainItem(i)

		UGUIUtil.SetText(terrainItme.TerrainName, CfgTerrainTable[allTerrainTypes[i]].Name)
		AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(CfgTerrainTable[allTerrainTypes[i]].SmallTerrainImg), terrainItme.TerrainImg:GetComponent("Image"))
	end
end

function m:CreateTerrainItem(index)
	local item = self.terrainItemList[index]

	if item == nil then
		local obj = UnityEngine.Object.Instantiate(self.TerrainItemPrefab)

		obj.transform:SetParent(self.TerrainItemParent.transform, false)
		obj:SetActive(true)

		local bindlua = {}

		LuaCodeInterface.BindOutlet(obj, bindlua)

		self.terrainItemList[index] = bindlua
	end

	return self.terrainItemList[index]
end

function m:SetDefaultInfo(state)
	LuaUtility.SetGameObjectShow(self.ObjectiveParent, state)
	LuaUtility.SetGameObjectShow(self.TerrainParent, state)
	LuaUtility.SetGameObjectShow(self.EnemyParent, state)
end

function m:Show()
	self.View:SetActive(true)
	self:__RefreshGlobalBuffData()

	if not EventUtil.HasEventListener(self, EventID.NotifyGlobalBuffChange) then
		EventUtil.AddEventListener(self, EventID.NotifyGlobalBuffChange, self.__RefreshGlobalBuffData)
	end
end

function m:__RefreshGlobalBuffData()
	local buffCidList = GlobalBuffModule.GetBuffIDList(Constant.GlobalBuffEffectType.Battle)

	self.buffView:Show(buffCidList)
end

function m:Hide()
	EventUtil.RemoveEventListener(self, EventID.NotifyGlobalBuffChange)
	self.View:SetActive(false)
	self.buffView:Hide()
end

function m:Dispose()
	EventUtil.ClearEventListener(self)
	self.buffView:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
