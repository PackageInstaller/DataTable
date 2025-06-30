-- chunkname: @IQIGame\\UI\\BattleMonsterInfoUI.lua

local BattleMonsterInfoUI = Base:Extend("BattleMonsterInfoUI", "IQIGame.Onigao.UI.BattleMonsterInfoUI", {
	UnitId = 0,
	IsBattleMode = false,
	MonsterCid = 0,
	Page = 0,
	EntityId = 0,
	MonsterUIDataList = {},
	SkillItems = {},
	BuffItems = {},
	WeakCells = {}
})
local BattleMonsterInfoSkillItem = require("IQIGame.UI.BattleMonsterInfo.BattleMonsterInfoSkillItem")
local BattleMonsterInfoBuffItem = require("IQIGame.UI.BattleMonsterInfo.BattleMonsterInfoBuffItem")
local BattleMonsterInfoWeakCell = require("IQIGame.UI.BattleMonsterInfo.BattleMonsterInfoWeakCell")
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")

function BattleMonsterInfoUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickPrevBtn()
		self:OnClickPrevBtn()
	end

	function self.DelegateOnClickNextBtn()
		self:OnClickNextBtn()
	end

	function self.DelegateOnShowElementEntitySuccess(sender, args)
		self:OnShowElementEntitySuccess(sender, args)
	end

	function self.DelegateOnShowElementEntityFailure(sender, args)
		self:OnShowElementEntityFailure(sender, args)
	end

	function self.DelegateOnClickBuffHelpBtn()
		self:OnClickBuffHelpBtn()
	end

	function self.DelegateOnClickWeakGrid()
		self:OnClickWeakGrid()
	end

	function self.DelegateOnModifySkill(unitId, oldSkillCid, newSkillCid)
		self:OnModifySkill(unitId, oldSkillCid, newSkillCid)
	end

	self.SkillItemPool = UIObjectPool.New(5, function()
		return BattleMonsterInfoSkillItem.New(UnityEngine.Object.Instantiate(self.SkillItemPrefab))
	end, function(item)
		local v = item.View

		item:Dispose()
		UnityEngine.Object.Destroy(v)
	end)

	for i = 1, 8 do
		local view = UnityEngine.Object.Instantiate(self.BuffItemPrefab)

		view.transform:SetParent(self.BuffGrid.transform, false)

		local item = BattleMonsterInfoBuffItem.New(view)

		self.BuffItems[i] = item
	end

	UGUIUtil.SetText(self.TitleText, BattleMonsterInfoUIApi:GetString("TitleText"))
	UGUIUtil.SetText(self.SkillLabel, BattleMonsterInfoUIApi:GetString("SkillLabel"))
	UGUIUtil.SetText(self.BuffLabel, BattleMonsterInfoUIApi:GetString("BuffLabel"))

	self.SkillShowTypes = BattleMonsterInfoUIApi:GetString("SkillShowTypes")
	self.SkillTypeOrder = BattleMonsterInfoUIApi:GetString("SkillTypeOrder")

	for i = 1, 6 do
		local weakCell = BattleMonsterInfoWeakCell.New(UnityEngine.Object.Instantiate(self.WeakCell))

		weakCell.View.transform:SetParent(self.WeakGrid.transform, false)

		self.WeakCells[i] = weakCell
	end

	self.BlockView:SetActive(false)
end

function BattleMonsterInfoUI:GetPreloadAssetPaths()
	return nil
end

function BattleMonsterInfoUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function BattleMonsterInfoUI:IsManualShowOnOpen(userData)
	return false
end

function BattleMonsterInfoUI:GetBGM(userData)
	return nil
end

function BattleMonsterInfoUI:OnOpen(userData)
	self.IsBattleMode = userData.monsterCid == nil

	if self.IsBattleMode and not BattleModule.Initialized then
		UIModule.CloseSelf(self)

		return
	end

	self.MonsterCidList = userData.monsterCidList

	self:UpdateView(userData.unitId, userData.monsterCid)
end

function BattleMonsterInfoUI:OnClose(userData)
	self:HideEntity()
	self:BlockInput(false)
end

function BattleMonsterInfoUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.CloseBtn2:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.PrevBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickPrevBtn)
	self.NextBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickNextBtn)
	self.BuffHelpBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBuffHelpBtn)
	self.WeakGrid:GetComponent("Button").onClick:AddListener(self.DelegateOnClickWeakGrid)
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntityFailureEventArgs.EventId, self.DelegateOnShowElementEntityFailure)
	EventDispatcher.AddEventListener(EventID.BattleModifySkill, self.DelegateOnModifySkill)
end

function BattleMonsterInfoUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.CloseBtn2:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.PrevBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickPrevBtn)
	self.NextBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickNextBtn)
	self.BuffHelpBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBuffHelpBtn)
	self.WeakGrid:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickWeakGrid)
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntityFailureEventArgs.EventId, self.DelegateOnShowElementEntityFailure)
	EventDispatcher.RemoveEventListener(EventID.BattleModifySkill, self.DelegateOnModifySkill)
end

function BattleMonsterInfoUI:OnPause()
	return
end

function BattleMonsterInfoUI:OnResume()
	return
end

function BattleMonsterInfoUI:OnCover()
	return
end

function BattleMonsterInfoUI:OnReveal()
	return
end

function BattleMonsterInfoUI:OnRefocus(userData)
	return
end

function BattleMonsterInfoUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function BattleMonsterInfoUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function BattleMonsterInfoUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function BattleMonsterInfoUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function BattleMonsterInfoUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self:ClearAllSkillItems(true)
	self.SkillItemPool:Dispose()

	for i = 1, #self.BuffItems do
		local item = self.BuffItems[i]

		item:Dispose()
	end

	self.BuffItems = nil

	for i = 1, #self.WeakCells do
		local weakCell = self.WeakCells[i]

		weakCell:Dispose()
	end

	self.WeakCells = nil
end

function BattleMonsterInfoUI:UpdateView(unitId, monsterCid)
	self.UnitId = unitId

	local hasData = self:RefreshDataList(unitId, monsterCid)

	if not hasData then
		logError("没有找到任何数据。unitId: " .. tostring(unitId) .. " monsterCid: " .. tostring(monsterCid))
		UIModule.CloseSelf(self)

		return
	end

	self:HideEntity()

	local cfgMonsterData
	local curHp = 0
	local maxHp = 0
	local battleUnitData

	if self.IsBattleMode then
		local battleUnitPOD = BattleModule.GetBattleUnitPOD(unitId)

		self.MonsterCid = battleUnitPOD.MonsterCfgId
		cfgMonsterData = CfgMonsterTable[self.MonsterCid]
		battleUnitData = BattleModule.GetBattleUnitData(unitId)
		curHp = battleUnitData.HP
		maxHp = battleUnitData.MaxHp
	else
		self.MonsterCid = monsterCid
		cfgMonsterData = CfgMonsterTable[self.MonsterCid]

		for i = 1, #cfgMonsterData.AttType do
			if cfgMonsterData.AttType[i] == Constant.Attribute.TYPE_HP_MAX then
				maxHp = cfgMonsterData.AttValue[i]

				break
			end
		end

		curHp = maxHp
	end

	self:ShowElement(cfgMonsterData)
	UGUIUtil.SetText(self.MonsterNameText, cfgMonsterData.Name)
	UGUIUtil.SetText(self.HpText, BattleMonsterInfoUIApi:GetString("HpText", curHp, maxHp))

	local shieldTypes = {}

	if unitId ~= nil then
		for i = 0, battleUnitData.WeakTypes.Length - 1 do
			shieldTypes[i + 1] = battleUnitData.WeakTypes[i]
		end
	else
		for i = 1, #cfgMonsterData.WeakType do
			shieldTypes[i] = cfgMonsterData.WeakType[i]
		end
	end

	table.sort(shieldTypes, function(elementType1, elementType2)
		return elementType1 < elementType2
	end)

	for i = 1, #self.WeakCells do
		local weakCell = self.WeakCells[i]
		local weakType = shieldTypes[i]

		weakCell:SetData(weakType)
	end

	self:RefreshSkills(cfgMonsterData)

	local buffCidStacks = cfgMonsterData.InitialBuff
	local resistantBuffs = BattleMonsterInfoUIApi:GetString("ResistantBuffs")
	local existingResistantBuffs = {}

	for i = 1, #buffCidStacks, 2 do
		local buffData = {
			CID = buffCidStacks[i],
			Stack = buffCidStacks[i + 1]
		}

		if table.indexOf(resistantBuffs, buffData.CID) ~= -1 then
			table.insert(existingResistantBuffs, buffData)
		end
	end

	table.sort(existingResistantBuffs, function(buffData1, buffData2)
		return buffData1.CID < buffData2.CID
	end)

	for i = 1, #self.BuffItems do
		local item = self.BuffItems[i]
		local buffData = existingResistantBuffs[i]

		if buffData ~= nil then
			item:SetData(buffData.CID, buffData.Stack)
		else
			item:SetData(nil)
		end
	end

	self.PrevBtn:SetActive(#self.MonsterUIDataList > 1)
	self.NextBtn:SetActive(#self.MonsterUIDataList > 1)
end

function BattleMonsterInfoUI:RefreshSkills(cfgMonsterData)
	self:ClearAllSkillItems()

	local typeOrderMap = {}

	for i = 1, #self.SkillTypeOrder do
		local showType = self.SkillTypeOrder[i]

		typeOrderMap[showType] = i
	end

	local sortedSkills = {}

	for i = 1, #cfgMonsterData.Skill do
		local skillCid = cfgMonsterData.Skill[i]
		local cfgSkillData = CfgSkillTable[skillCid]

		if table.indexOf(self.SkillShowTypes, cfgSkillData.ShowType) ~= -1 then
			table.insert(sortedSkills, cfgSkillData)
		end
	end

	table.sort(sortedSkills, function(cfgSkillData1, cfgSkillData2)
		local order1 = typeOrderMap[cfgSkillData1.ShowType]
		local order2 = typeOrderMap[cfgSkillData2.ShowType]

		if order1 == order2 then
			return cfgSkillData1.Id < cfgSkillData2.Id
		end

		return order1 < order2
	end)

	for i = 1, #sortedSkills do
		local cfgSkillData = sortedSkills[i]
		local item = self.SkillItemPool:Obtain()

		item.View:SetActive(true)
		item.View.transform:SetParent(self.SkillGrid.transform, false)
		item:SetData(cfgSkillData, i == #sortedSkills)
		table.insert(self.SkillItems, item)
	end
end

function BattleMonsterInfoUI:RefreshDataList(unitId, monsterCid)
	self.Page = 0

	for i = 1, #self.MonsterUIDataList do
		self.MonsterUIDataList[i] = nil
	end

	if self.IsBattleMode then
		local enemies = BattleModule.GetDefendTroopPodsTable()

		table.sort(enemies, function(unitPOD1, unitPOD2)
			return unitPOD1.BattlePos < unitPOD2.BattlePos
		end)

		for i = 1, #enemies do
			local battleUnitPOD = enemies[i]
			local battleUnitData = BattleModule.GetBattleUnitData(battleUnitPOD.ID)

			if not battleUnitData.IsDead then
				table.insert(self.MonsterUIDataList, {
					unitId = battleUnitPOD.ID
				})

				if battleUnitPOD.ID == unitId then
					self.Page = #self.MonsterUIDataList
				end
			end
		end
	else
		if self.MonsterCidList == nil then
			self.MonsterCidList = {
				monsterCid
			}
		end

		for i = 1, #self.MonsterCidList do
			local mCid = self.MonsterCidList[i]

			table.insert(self.MonsterUIDataList, {
				monsterCid = mCid
			})

			if mCid == monsterCid then
				self.Page = i
			end
		end
	end

	if self.Page == 0 then
		logError("BattleMonsterInfoUI.RefreshDataList Error. self.Page == 0. self.IsBattleMode: " .. tostring(self.IsBattleMode) .. " unitId = " .. tostring(unitId) .. " monsterCid = " .. tostring(monsterCid))
	end

	return #self.MonsterUIDataList > 0
end

function BattleMonsterInfoUI:ShowElement(cfgMonsterData)
	local cfgTownMonsterBookResData = CfgTownMonsterBookResTable[cfgMonsterData.ArchivesID]

	if cfgTownMonsterBookResData == nil then
		logError("找不到怪物图鉴信息。Monster.ArchivesID = " .. cfgMonsterData.ArchivesID)

		return
	end

	self:BlockInput(true)

	self.EntityId = GameEntry.Entity:GenerateEntityID()

	GameEntry.Entity:ShowUIElement(self.EntityId, cfgTownMonsterBookResData.EntityID, 0, self.SpinePoint.transform, Vector3.zero)
end

function BattleMonsterInfoUI:OnShowElementEntitySuccess(sender, args)
	if args.Entity.Id == self.EntityId then
		setGameObjectLayers(args.Entity.transform, "UI")

		local animation = args.Entity:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))

		if animation ~= nil then
			animation.state:SetAnimation(0, "idle", true)
		end

		local cfgMonsterData = CfgMonsterTable[self.MonsterCid]
		local cfgTownMonsterBookResData = CfgTownMonsterBookResTable[cfgMonsterData.ArchivesID]

		self.SpinePoint.transform.anchoredPosition3D = Vector3(unpack(cfgTownMonsterBookResData.EntityPosition))
		args.Entity.transform.localScale = Vector3(unpack(cfgTownMonsterBookResData.EntityScale))

		local canvas = self.UIController:GetComponent("Canvas")
		local renderers = args.Entity:GetComponentsInChildren(typeof(UnityEngine.Renderer))

		for i = 0, renderers.Length - 1 do
			renderers[i].sortingOrder = canvas.sortingOrder + 1
		end

		self:BlockInput(false)
	end
end

function BattleMonsterInfoUI:OnShowElementEntityFailure(sender, args)
	if args.EntityId == self.EntityId then
		self:BlockInput(false)
	end
end

function BattleMonsterInfoUI:BlockInput(value)
	self.BlockView:SetActive(value)
end

function BattleMonsterInfoUI:HideEntity()
	if self.EntityId ~= 0 then
		GameEntry.Entity:HideEntity(self.EntityId)

		self.EntityId = 0
	end
end

function BattleMonsterInfoUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function BattleMonsterInfoUI:OnClickPrevBtn()
	self.Page = self.Page - 1

	if self.Page <= 0 then
		self.Page = #self.MonsterUIDataList
	end

	local data = self.MonsterUIDataList[self.Page]

	self:UpdateView(data.unitId, data.monsterCid)
end

function BattleMonsterInfoUI:OnClickNextBtn()
	self.Page = self.Page + 1

	if self.Page >= #self.MonsterUIDataList + 1 then
		self.Page = 1
	end

	local data = self.MonsterUIDataList[self.Page]

	self:UpdateView(data.unitId, data.monsterCid)
end

function BattleMonsterInfoUI:ClearAllSkillItems(isDestroy)
	for i = 1, #self.SkillItems do
		local item = self.SkillItems[i]

		item.View:SetActive(false)

		if not isDestroy then
			item.View.transform:SetParent(self.UIController.transform, false)
		end

		self.SkillItemPool:Release(item)
	end

	self.SkillItems = {}
end

function BattleMonsterInfoUI:OnClickBuffHelpBtn()
	local iconPath = BattleMonsterInfoUIApi:GetString("ResistantHelperTipIcon")
	local name = BattleMonsterInfoUIApi:GetString("ResistantHelperName")
	local desc = BattleMonsterInfoUIApi:GetString("ResistantHelperDesc")

	UIModule.Open(Constant.UIControllerName.BattleMonsterResistanceTipUI, Constant.UILayer.UI, {
		customContent = {
			iconPath = iconPath,
			name = name,
			desc = desc
		},
		srcRefTrans = self.BuffHelpBtn.transform
	})
end

function BattleMonsterInfoUI:OnClickWeakGrid()
	UIModule.Open(Constant.UIControllerName.BattleWeakShieldTipsUI, Constant.UILayer.Tooltip, {
		unitId = self.UnitId,
		monsterCid = self.MonsterCid
	})
end

function BattleMonsterInfoUI:OnModifySkill(unitId, oldSkillCid, newSkillCid)
	if self.UnitId == unitId then
		local cfgMonsterData = CfgMonsterTable[self.MonsterCid]

		self:RefreshSkills(cfgMonsterData)
	end
end

return BattleMonsterInfoUI
