-- chunkname: @IQIGame\\UI\\BattleDamageUI.lua

local BattleDamageUI = Base:Extend("BattleDamageUI", "IQIGame.Onigao.UI.BattleDamageUI", {
	ElementToDamageType = {
		[0] = Constant.BattleDamageType.Physic,
		Constant.BattleDamageType.Ice,
		Constant.BattleDamageType.Fire,
		Constant.BattleDamageType.Thunder,
		Constant.BattleDamageType.Poison,
		Constant.BattleDamageType.Physic,
		Constant.BattleDamageType.Magic
	},
	PrefabType = {
		BuffTrigger1 = 9,
		CritDamage = 5,
		Buff1 = 7,
		Miss = 6,
		Heal = 2,
		Damage = 4,
		Absorb = 1,
		ImmuneToBuff = 11,
		Buff2 = 8,
		BuffTrigger2 = 10,
		CritHeal = 3,
		WeakDamage = 12
	},
	WaitingFloatCells = {},
	FloatingCells = {},
	FloatCellTimes = {},
	Buffs = {},
	BuffEffectQueues = {},
	StartPlayBuffTimes = {},
	PlayBuffEffectIntervals = {}
})
local DamageCell = require("IQIGame.UI.Battle.DamageCell")
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local DamageData = {
	Value = 0,
	PrefabType = 0,
	IsOnCaster = false,
	Type = 0
}

function DamageData.New(type, value, prefabType, isOnCaster)
	local obj = Clone(DamageData)

	obj.Type = type
	obj.Value = value
	obj.PrefabType = prefabType
	obj.IsOnCaster = isOnCaster == true

	return obj
end

function BattleDamageUI:OnInit()
	function self.DelegateOnShowDamageHandler(sender, arg)
		self:OnShowDamageHandler(sender, arg)
	end

	function self.DelegateOnUpdateUnitHp(sender, arg)
		self:OnUpdateUnitHp(sender, arg)
	end

	function self.DelegateOnBattleUnitAddBuff(unitId, buffs, troopType, newBuff, changeStackBuffs, addStackBuffs)
		self:OnBattleUnitAddBuff(unitId, buffs, troopType, newBuff, changeStackBuffs, addStackBuffs)
	end

	function self.DelegateOnBattleUnitRemoveBuff(unitId, buffCid, troopType)
		self:OnBattleUnitRemoveBuff(unitId, buffCid)
	end

	function self.DelegateOnBuffTriggered(sender, args)
		self:OnBuffTriggered(sender, args)
	end

	function self.DelegateOnImmuneToBuff(sender, args)
		self:OnImmuneToBuff(sender, args)
	end

	function self.DelegateOnShowAddBuff(sender, args)
		self:OnShowAddBuff(sender, args)
	end

	self._UICanvas = self.UIController:GetComponent("Canvas")
	self.DamageCellPools = {}

	local assetPath = AssetPath.Get(GlobalKey.UIPrefabPath, "_Damage/AbsorbPrefab")
	local prefab = self.UIController:GetPreloadedAsset(assetPath)

	self.DamageCellPools[BattleDamageUI.PrefabType.Absorb] = self:CreatePool(BattleDamageUI.PrefabType.Absorb, prefab)
	assetPath = AssetPath.Get(GlobalKey.UIPrefabPath, "_Damage/AddHpPrefab")
	prefab = self.UIController:GetPreloadedAsset(assetPath)
	self.DamageCellPools[BattleDamageUI.PrefabType.Heal] = self:CreatePool(BattleDamageUI.PrefabType.Heal, prefab)
	assetPath = AssetPath.Get(GlobalKey.UIPrefabPath, "_Damage/AddHpCritPrefab")
	prefab = self.UIController:GetPreloadedAsset(assetPath)
	self.DamageCellPools[BattleDamageUI.PrefabType.CritHeal] = self:CreatePool(BattleDamageUI.PrefabType.CritHeal, prefab)
	assetPath = AssetPath.Get(GlobalKey.UIPrefabPath, "_Damage/DamagePrefab")
	prefab = self.UIController:GetPreloadedAsset(assetPath)
	self.DamageCellPools[BattleDamageUI.PrefabType.Damage] = self:CreatePool(BattleDamageUI.PrefabType.Damage, prefab)
	assetPath = AssetPath.Get(GlobalKey.UIPrefabPath, "_Damage/CritDamagePrefab")
	prefab = self.UIController:GetPreloadedAsset(assetPath)
	self.DamageCellPools[BattleDamageUI.PrefabType.CritDamage] = self:CreatePool(BattleDamageUI.PrefabType.CritDamage, prefab)
	assetPath = AssetPath.Get(GlobalKey.UIPrefabPath, "_Damage/MissPrefab")
	prefab = self.UIController:GetPreloadedAsset(assetPath)
	self.DamageCellPools[BattleDamageUI.PrefabType.Miss] = self:CreatePool(BattleDamageUI.PrefabType.Miss, prefab)
	assetPath = AssetPath.Get(GlobalKey.UIPrefabPath, "_Damage/StatePrefab01")
	prefab = self.UIController:GetPreloadedAsset(assetPath)
	self.DamageCellPools[BattleDamageUI.PrefabType.Buff1] = self:CreatePool(BattleDamageUI.PrefabType.Buff1, prefab)
	assetPath = AssetPath.Get(GlobalKey.UIPrefabPath, "_Damage/StatePrefab02")
	prefab = self.UIController:GetPreloadedAsset(assetPath)
	self.DamageCellPools[BattleDamageUI.PrefabType.Buff2] = self:CreatePool(BattleDamageUI.PrefabType.Buff2, prefab)
	assetPath = AssetPath.Get(GlobalKey.UIPrefabPath, "_Damage/BuffTrigger01")
	prefab = self.UIController:GetPreloadedAsset(assetPath)
	self.DamageCellPools[BattleDamageUI.PrefabType.BuffTrigger1] = self:CreatePool(BattleDamageUI.PrefabType.BuffTrigger1, prefab)
	assetPath = AssetPath.Get(GlobalKey.UIPrefabPath, "_Damage/BuffTrigger02")
	prefab = self.UIController:GetPreloadedAsset(assetPath)
	self.DamageCellPools[BattleDamageUI.PrefabType.BuffTrigger2] = self:CreatePool(BattleDamageUI.PrefabType.BuffTrigger2, prefab)
	assetPath = AssetPath.Get(GlobalKey.UIPrefabPath, "_Damage/ImmuneToBuff")
	prefab = self.UIController:GetPreloadedAsset(assetPath)
	self.DamageCellPools[BattleDamageUI.PrefabType.ImmuneToBuff] = self:CreatePool(BattleDamageUI.PrefabType.ImmuneToBuff, prefab)
	assetPath = AssetPath.Get(GlobalKey.UIPrefabPath, "_Damage/WeakDamagePrefab")
	prefab = self.UIController:GetPreloadedAsset(assetPath)
	self.DamageCellPools[BattleDamageUI.PrefabType.WeakDamage] = self:CreatePool(BattleDamageUI.PrefabType.WeakDamage, prefab)
end

function BattleDamageUI:GetPreloadAssetPaths()
	local preLoadAssetsTable = {}
	local assetPath = AssetPath.Get(GlobalKey.UIPrefabPath, "_Damage/AbsorbPrefab")

	table.insert(preLoadAssetsTable, assetPath)

	assetPath = AssetPath.Get(GlobalKey.UIPrefabPath, "_Damage/AddHpPrefab")

	table.insert(preLoadAssetsTable, assetPath)

	assetPath = AssetPath.Get(GlobalKey.UIPrefabPath, "_Damage/AddHpCritPrefab")

	table.insert(preLoadAssetsTable, assetPath)

	assetPath = AssetPath.Get(GlobalKey.UIPrefabPath, "_Damage/DamagePrefab")

	table.insert(preLoadAssetsTable, assetPath)

	assetPath = AssetPath.Get(GlobalKey.UIPrefabPath, "_Damage/CritDamagePrefab")

	table.insert(preLoadAssetsTable, assetPath)

	assetPath = AssetPath.Get(GlobalKey.UIPrefabPath, "_Damage/MissPrefab")

	table.insert(preLoadAssetsTable, assetPath)

	assetPath = AssetPath.Get(GlobalKey.UIPrefabPath, "_Damage/StatePrefab01")

	table.insert(preLoadAssetsTable, assetPath)

	assetPath = AssetPath.Get(GlobalKey.UIPrefabPath, "_Damage/StatePrefab02")

	table.insert(preLoadAssetsTable, assetPath)

	assetPath = AssetPath.Get(GlobalKey.UIPrefabPath, "_Damage/BuffTrigger01")

	table.insert(preLoadAssetsTable, assetPath)

	assetPath = AssetPath.Get(GlobalKey.UIPrefabPath, "_Damage/BuffTrigger02")

	table.insert(preLoadAssetsTable, assetPath)

	assetPath = AssetPath.Get(GlobalKey.UIPrefabPath, "_Damage/ImmuneToBuff")

	table.insert(preLoadAssetsTable, assetPath)

	assetPath = AssetPath.Get(GlobalKey.UIPrefabPath, "_Damage/WeakDamagePrefab")

	table.insert(preLoadAssetsTable, assetPath)

	return preLoadAssetsTable
end

function BattleDamageUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function BattleDamageUI:OnOpen(userData)
	self.FloatCellTimes = {}
	self.MainCamera = BattleModule.BattleCamera:GetComponent("Camera")
end

function BattleDamageUI:OnAddListeners()
	GameEntry.LuaEvent:Subscribe(BattleShowDamageToLuaEventArgs.EventId, self.DelegateOnShowDamageHandler)
	GameEntry.LuaEvent:Subscribe(BattleUnitUpdateHpToLuaEventArgs.EventId, self.DelegateOnUpdateUnitHp)
	GameEntry.LuaEvent:Subscribe(BattleBuffTriggeredEventArgs.EventId, self.DelegateOnBuffTriggered)
	GameEntry.LuaEvent:Subscribe(BattleImmuneToBuffNoticeEventArgs.EventId, self.DelegateOnImmuneToBuff)
	GameEntry.LuaEvent:Subscribe(BattleStartShowAddBuffEventArgs.EventId, self.DelegateOnShowAddBuff)
	EventDispatcher.AddEventListener(EventID.BattleAddBuff, self.DelegateOnBattleUnitAddBuff)
	EventDispatcher.AddEventListener(EventID.BattleRemoveBuff, self.DelegateOnBattleUnitRemoveBuff)
end

function BattleDamageUI:OnClose(userData)
	self:CheckRecycleCell(true)
	self:RecycleWaitingFloatCells()

	self.BuffEffectQueues = {}
	self.StartPlayBuffTimes = {}
	self.PlayBuffEffectIntervals = {}
end

function BattleDamageUI:OnRemoveListeners()
	GameEntry.LuaEvent:Unsubscribe(BattleShowDamageToLuaEventArgs.EventId, self.DelegateOnShowDamageHandler)
	GameEntry.LuaEvent:Unsubscribe(BattleUnitUpdateHpToLuaEventArgs.EventId, self.DelegateOnUpdateUnitHp)
	GameEntry.LuaEvent:Unsubscribe(BattleBuffTriggeredEventArgs.EventId, self.DelegateOnBuffTriggered)
	GameEntry.LuaEvent:Unsubscribe(BattleImmuneToBuffNoticeEventArgs.EventId, self.DelegateOnImmuneToBuff)
	GameEntry.LuaEvent:Unsubscribe(BattleStartShowAddBuffEventArgs.EventId, self.DelegateOnShowAddBuff)
	EventDispatcher.RemoveEventListener(EventID.BattleAddBuff, self.DelegateOnBattleUnitAddBuff)
	EventDispatcher.RemoveEventListener(EventID.BattleRemoveBuff, self.DelegateOnBattleUnitRemoveBuff)
end

function BattleDamageUI:OnPause()
	return
end

function BattleDamageUI:OnResume()
	return
end

function BattleDamageUI:OnCover()
	return
end

function BattleDamageUI:OnReveal()
	return
end

function BattleDamageUI:OnRefocus(userData)
	return
end

function BattleDamageUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self:CheckFloatCell()
	self:CheckRecycleCell(false)
	self:CheckShowBuffQueue()
end

function BattleDamageUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function BattleDamageUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function BattleDamageUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function BattleDamageUI:OnDestroy()
	self:CheckRecycleCell(true)

	for i = 1, #self.DamageCellPools do
		local pool = self.DamageCellPools[i]

		pool:Dispose()
	end

	self.DamageCellPools = nil
end

function BattleDamageUI:OnShowDamageHandler(sender, arg)
	local damageDataList = {}
	local battleSkillHitPOD = arg.BattleSkillHitPOD
	local elementType = battleSkillHitPOD.ElementType

	if not battleSkillHitPOD.Hit then
		if battleSkillHitPOD.DamageType == 1 then
			table.insert(damageDataList, DamageData.New(Constant.BattleDamageType.Miss, 0, BattleDamageUI.PrefabType.Miss))
		elseif battleSkillHitPOD.DamageType == 2 then
			table.insert(damageDataList, DamageData.New(Constant.BattleDamageType.Resist, 0, BattleDamageUI.PrefabType.Miss))
		end
	elseif battleSkillHitPOD.Immunity then
		table.insert(damageDataList, DamageData.New(Constant.BattleDamageType.Immune, 0, BattleDamageUI.PrefabType.Damage))
	else
		if battleSkillHitPOD.Crit then
			if battleSkillHitPOD.ActualDmg < 0 then
				table.insert(damageDataList, DamageData.New(Constant.BattleDamageType.Heal, -battleSkillHitPOD.ActualDmg, BattleDamageUI.PrefabType.CritHeal))
			elseif battleSkillHitPOD.ActualDmg > 0 then
				if battleSkillHitPOD.Block then
					if battleSkillHitPOD.DamageType == 1 then
						table.insert(damageDataList, DamageData.New(Constant.BattleDamageType.Parry, battleSkillHitPOD.ActualDmg, BattleDamageUI.PrefabType.Absorb))
					elseif battleSkillHitPOD.DamageType == 2 then
						table.insert(damageDataList, DamageData.New(Constant.BattleDamageType.Block, battleSkillHitPOD.ActualDmg, BattleDamageUI.PrefabType.Absorb))
					end
				else
					table.insert(damageDataList, DamageData.New(BattleDamageUI.ElementToDamageType[elementType], battleSkillHitPOD.ActualDmg, BattleDamageUI.PrefabType.CritDamage))
				end
			elseif battleSkillHitPOD.ShieldReduce > 0 then
				table.insert(damageDataList, DamageData.New(Constant.BattleDamageType.Shield, battleSkillHitPOD.ShieldReduce, BattleDamageUI.PrefabType.Absorb))
			end
		elseif battleSkillHitPOD.ActualDmg < 0 then
			table.insert(damageDataList, DamageData.New(Constant.BattleDamageType.Heal, -battleSkillHitPOD.ActualDmg, BattleDamageUI.PrefabType.Heal))
		elseif battleSkillHitPOD.ActualDmg > 0 then
			if battleSkillHitPOD.Block then
				if battleSkillHitPOD.DamageType == 1 then
					table.insert(damageDataList, DamageData.New(Constant.BattleDamageType.Parry, battleSkillHitPOD.ActualDmg, BattleDamageUI.PrefabType.Absorb))
				elseif battleSkillHitPOD.DamageType == 2 then
					table.insert(damageDataList, DamageData.New(Constant.BattleDamageType.Block, battleSkillHitPOD.ActualDmg, BattleDamageUI.PrefabType.Absorb))
				end
			else
				table.insert(damageDataList, DamageData.New(BattleDamageUI.ElementToDamageType[elementType], battleSkillHitPOD.ActualDmg, BattleDamageUI.PrefabType.Damage))
			end
		elseif battleSkillHitPOD.ShieldReduce > 0 then
			table.insert(damageDataList, DamageData.New(Constant.BattleDamageType.Shield, battleSkillHitPOD.ShieldReduce, BattleDamageUI.PrefabType.Absorb))
		end

		if battleSkillHitPOD.BloodSuck > 0 then
			table.insert(damageDataList, DamageData.New(Constant.BattleDamageType.SuckBlood, battleSkillHitPOD.BloodSuck, BattleDamageUI.PrefabType.Absorb, true))
		end

		if battleSkillHitPOD.ThornsDmg > 0 then
			table.insert(damageDataList, DamageData.New(Constant.BattleDamageType.Thorns, battleSkillHitPOD.ThornsDmg, BattleDamageUI.PrefabType.Heal, true))
		end
	end

	for i = 1, #damageDataList do
		local damageData = damageDataList[i]
		local battleUnitId = battleSkillHitPOD.UnitID

		if damageData.IsOnCaster then
			battleUnitId = arg.CasterUnitId
		end

		local cfgSkillData = CfgSkillTable[arg.SkillCid]
		local hasEnergyShield = BattleModule.CheckHasEnergyShield(battleUnitId)
		local battleUnitPOD = BattleModule.GetBattleUnitPOD(battleUnitId)
		local prefabType = damageData.PrefabType

		if battleUnitPOD.TroopType == Constant.BattleTroopType.Defend and damageData.Type <= 6 and not hasEnergyShield then
			prefabType = BattleDamageUI.PrefabType.WeakDamage
		end

		self:ShowDamage(battleUnitId, prefabType, cfgSkillData.Type, damageData.Type, damageData.Value, hasEnergyShield, battleUnitPOD.TroopType)
	end
end

function BattleDamageUI:ShowDamage(unitId, prefabType, skillType, damageType, value, hasEnergyShield, troopType)
	if unitId == 0 then
		logError("BattleDamageUI:ShowDamage unitId == 0")
	end

	local cfgElementPointData = CfgElementPointTable[Constant.MountPoint.PointText]
	local battleUnitData = BattleModule.GetBattleUnitData(unitId)
	local mountNodeTrans = findOnTransformByNameRecursively(battleUnitData.BattleUnitObject.transform, cfgElementPointData.PointName)
	local damageCell = self:GetDamageCell(prefabType, mountNodeTrans.position)

	damageCell:SetData(skillType, damageType, value, hasEnergyShield, troopType)
	self:AddCellAndCheckFloat(unitId, damageCell)
end

function BattleDamageUI:ShowBuffText(unitId, buffCid, isDebuff, value, stack, position, troopType)
	local prefabType = isDebuff and BattleDamageUI.PrefabType.Buff2 or BattleDamageUI.PrefabType.Buff1
	local damageCell = self:GetDamageCell(prefabType, position)

	damageCell:SetBuffText(buffCid, value, stack, troopType)
	self:AddCellAndCheckFloat(unitId, damageCell)
end

function BattleDamageUI:ShowText(unitId, prefabType, value)
	if unitId == 0 then
		logError("BattleDamageUI:ShowText unitId == 0")
	end

	local cfgElementPointData = CfgElementPointTable[Constant.MountPoint.PointText]
	local battleUnitData = BattleModule.GetBattleUnitData(unitId)
	local mountNodeTrans = findOnTransformByNameRecursively(battleUnitData.BattleUnitObject.transform, cfgElementPointData.PointName)
	local damageCell = self:GetDamageCell(prefabType, mountNodeTrans.position)

	damageCell:SetText(value)
	self:AddCellAndCheckFloat(unitId, damageCell)
end

function BattleDamageUI:GetDamageCell(prefabType, point)
	local pool = self.DamageCellPools[prefabType]
	local damageCell = pool:Obtain()

	damageCell.View.transform:SetParent(self.UIController.transform, false)

	damageCell.View.transform.position = self:ConvertPosToUI(point)

	return damageCell
end

function BattleDamageUI:OnUpdateUnitHp(sender, arg)
	if arg.ShowHpChangeNum == 0 then
		return
	end

	local damageType = arg.ElementType
	local value = arg.ShowHpChangeNum
	local prefabType = value > 0 and BattleDamageUI.PrefabType.Heal or BattleDamageUI.PrefabType.Damage

	if value > 0 then
		damageType = Constant.BattleDamageType.Heal
	else
		value = -value
	end

	local hasEnergyShield = BattleModule.CheckHasEnergyShield(arg.BattleUnitID)

	self:ShowDamage(arg.BattleUnitID, prefabType, 0, damageType, value, hasEnergyShield, arg.BattleUnitTroopType)
end

function BattleDamageUI:OnBattleUnitAddBuff(unitId, buffs, troopType, newBuff, changeStackBuffs, addStackBuffs)
	if unitId == 0 then
		logError("BattleDamageUI:OnBattleUnitAddBuff unitId == 0")
	end

	local cfgElementPointData = CfgElementPointTable[Constant.MountPoint.PointText]
	local battleUnitData = BattleModule.GetBattleUnitData(unitId)
	local pointTextTrans = findOnTransformByNameRecursively(battleUnitData.BattleUnitObject.transform, cfgElementPointData.PointName)
	local queue = self.BuffEffectQueues[unitId]

	if queue == nil then
		queue = Queue.New()
		self.BuffEffectQueues[unitId] = queue
	end

	if newBuff ~= nil then
		queue:Enqueue({
			newBuff.CID,
			1,
			newBuff.Stack,
			pointTextTrans.position,
			troopType
		})
	end

	for i = 1, #addStackBuffs do
		local buffData = addStackBuffs[i]

		queue:Enqueue({
			buffData.CID,
			2,
			buffData.Stack,
			pointTextTrans.position,
			troopType
		})
	end
end

function BattleDamageUI:OnBattleUnitRemoveBuff(unitId, buffCid)
	local queue = self.BuffEffectQueues[unitId]

	if queue == nil then
		queue = Queue.New()
		self.BuffEffectQueues[unitId] = queue
	end

	queue:Enqueue({
		buffCid,
		3
	})
end

function BattleDamageUI:CreatePool(prefabType, prefab)
	return UIObjectPool.New(10, function()
		local viewGo = UnityEngine.Object.Instantiate(prefab)
		local cell = DamageCell.New(viewGo, prefabType)

		viewGo:SetActive(false)

		return cell
	end, function(cell)
		local view = cell.View

		cell:Dispose()
		UnityEngine.Object.Destroy(view)
	end)
end

function BattleDamageUI:ConvertPosToUI(pos)
	local screenPos = self.MainCamera:WorldToScreenPoint(pos)
	local uiPos = self._UICanvas.worldCamera:ScreenToWorldPoint(screenPos)
	local newPos = Vector3(uiPos.x, uiPos.y, self.UIController.transform.position.z)

	return newPos
end

function BattleDamageUI:AddCellAndCheckFloat(unitId, damageCell)
	local cellsOfUnit = self.WaitingFloatCells[unitId]

	if cellsOfUnit == nil then
		cellsOfUnit = {}
		self.WaitingFloatCells[unitId] = cellsOfUnit
	end

	table.insert(cellsOfUnit, damageCell)
	self:CheckFloatCell()
end

function BattleDamageUI:CheckFloatCell()
	for unitId, cellsOfUnit in pairs(self.WaitingFloatCells) do
		if #cellsOfUnit > 0 then
			local cell = self:GetAvailableFloatCell(unitId)

			if cell ~= nil then
				cell.View:SetActive(true)
			end
		end
	end
end

function BattleDamageUI:GetAvailableFloatCell(unitId)
	local lastFloatCellTime = self.FloatCellTimes[unitId]

	if lastFloatCellTime == nil or UnityEngine.Time.time - lastFloatCellTime > 0.3 then
		local cells = self.WaitingFloatCells[unitId]
		local cell = cells[1]

		table.remove(cells, 1)
		table.insert(self.FloatingCells, cell)

		self.FloatCellTimes[unitId] = UnityEngine.Time.time

		return cell
	end

	return nil
end

function BattleDamageUI:RecycleWaitingFloatCells()
	for unitId, cells in pairs(self.WaitingFloatCells) do
		for i = 1, #cells do
			local cell = cells[i]

			cell.View:SetActive(false)

			local pool = self.DamageCellPools[cell.PrefabType]

			pool:Release(cell)
		end
	end

	self.WaitingFloatCells = {}
end

function BattleDamageUI:CheckRecycleCell(force)
	if #self.FloatingCells > 0 then
		for i = #self.FloatingCells, 1, -1 do
			local cell = self.FloatingCells[i]

			if cell:IsFinished() or force then
				cell.View:SetActive(false)

				local pool = self.DamageCellPools[cell.PrefabType]

				pool:Release(cell)
				table.remove(self.FloatingCells, i)
			end
		end
	end
end

function BattleDamageUI:OnBuffTriggered(sender, args)
	local cfgBuffData = CfgBuffTable[args.TriggeredBuffCid]

	if cfgBuffData.IsNeedText and cfgBuffData.BuffTriggerDescribe ~= "" then
		self:ShowText(args.UnitId, cfgBuffData.DebuffType == 2 and BattleDamageUI.PrefabType.BuffTrigger2 or BattleDamageUI.PrefabType.BuffTrigger1, cfgBuffData.BuffTriggerDescribe)
	end
end

function BattleDamageUI:OnImmuneToBuff(sender, args)
	if args.IsTrigger then
		self:ShowText(args.UnitId, BattleDamageUI.PrefabType.ImmuneToBuff, BattleDamageUIApi:GetString("ImmuneToBuffText", args.BuffCid, true))
	else
		self:ShowText(args.UnitId, BattleDamageUI.PrefabType.ImmuneToBuff, BattleDamageUIApi:GetString("ImmuneToBuffText", args.BuffCid, false))
	end
end

function BattleDamageUI:OnShowAddBuff(sender, args)
	self.PlayBuffEffectIntervals[args.UnitId] = args.BuffCount == 0 and 0 or args.AnimDuration / args.BuffCount
	self.StartPlayBuffTimes[args.UnitId] = UnityEngine.Time.time - self.PlayBuffEffectIntervals[args.UnitId]
end

function BattleDamageUI:CheckShowBuffQueue()
	for unitId, queue in pairs(self.BuffEffectQueues) do
		if queue.Size > 0 and self.StartPlayBuffTimes[unitId] ~= nil and UnityEngine.Time.time > self.StartPlayBuffTimes[unitId] + self.PlayBuffEffectIntervals[unitId] then
			local data = queue:Dequeue()
			local buffCid = data[1]
			local isRemove = data[2] == 3

			if not isRemove then
				local stack = data[3]
				local position = data[4]
				local troopType = data[5]

				self:PlayAddBuff(unitId, buffCid, stack, position, troopType)
			end

			if queue.Count == 0 then
				self.StartPlayBuffTimes[unitId] = nil
				self.PlayBuffEffectIntervals[unitId] = nil
			end
		end
	end
end

function BattleDamageUI:PlayAddBuff(unitId, buffCid, stack, position, troopType)
	local cfgBuffData = CfgBuffTable[buffCid]
	local needShow = cfgBuffData.IsNeedText and cfgBuffData.BuffDescribe ~= ""

	if needShow then
		self:ShowBuffText(unitId, cfgBuffData.Id, cfgBuffData.DebuffType == 2, cfgBuffData.BuffDescribe, stack, position, troopType)
	end

	if cfgBuffData.StartEffectID ~= 0 or cfgBuffData.StartUIExtraEffect ~= 0 or needShow then
		self.StartPlayBuffTimes[unitId] = self.StartPlayBuffTimes[unitId] + self.PlayBuffEffectIntervals[unitId]
	end
end

return BattleDamageUI
