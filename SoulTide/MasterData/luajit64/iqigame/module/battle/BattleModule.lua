-- chunkname: @IQIGame\\Module\\Battle\\BattleModule.lua

BattleModule = {
	PlotId = 0,
	LogicStarted = false,
	__MonsterTeamCid = 0,
	Initialized = false,
	BattleIsOver = false,
	MaxRound = 0,
	Round = 0,
	__BattleAreaCid = 0,
	BattlePositions = {},
	SkillAreaEffectPlayIds = {},
	ActedUnitInRound = {},
	EnemyHpInitDataList = {},
	IsPlayingUltimateWarningEffect = {}
}

function BattleModule.AddEventListeners()
	GameEntry.LuaEvent:Subscribe(BattleCommandEventArgs.BattleStartCommandEventID, BattleModule.OnBattleStartCommand)
	GameEntry.LuaEvent:Subscribe(BattleCommandEventArgs.BattleTurnCommandEventID, BattleModule.OnBattleTurnCommand)
	GameEntry.LuaEvent:Subscribe(BattleCommandEventArgs.BattleRoundCommandEventID, BattleModule.OnBeginNewRound)
	GameEntry.LuaEvent:Subscribe(BattleCommandEventArgs.BattleRoundEndCommandEventID, BattleModule.OnBattleRoundEndCommand)
	GameEntry.LuaEvent:Subscribe(BattleCommandEventArgs.BattleOverCommandEventID, BattleModule.OnBattleOverCommand)
	GameEntry.LuaEvent:Subscribe(BattleCommandEventArgs.BattleChooseSkillCommandEventID, BattleModule.OnChooseSkillCommand)
	GameEntry.LuaEvent:Subscribe(BattleShowEndUIEventArgs.EventId, BattleModule.OnBattleOver)
	GameEntry.LuaEvent:Subscribe(BattleChangeUnitSpeedEventArgs.EventId, BattleModule.OnChangeUnitSpeed)
	GameEntry.LuaEvent:Subscribe(BattleUnitUpdateBuffEventArgs.EventId, BattleModule.OnUpdateBuff)
	GameEntry.LuaEvent:Subscribe(BattleUnitRemoveBuffEventArgs.EventId, BattleModule.OnRemoveBuff)
	GameEntry.LuaEvent:Subscribe(BattleTurnEndEventArgs.EventId, BattleModule.OnTurnEnd)
	GameEntry.LuaEvent:Subscribe(BattleUnitDeadEventArgs.EventId, BattleModule.OnBattleUnitDead)
	GameEntry.LuaEvent:Subscribe(BattleChangeUnitSkillCDEventArgs.EventId, BattleModule.OnUpdateUnitSkillCD)
	GameEntry.LuaEvent:Subscribe(BattleUpdateSkillEnergyEventArgs.EventId, BattleModule.OnUpdateSkillEnergy)
	GameEntry.LuaEvent:Subscribe(BattleStartFirstActionInRoundEventArgs.EventId, BattleModule.OnStartFirstActionInRound)
	GameEntry.LuaEvent:Subscribe(AddAdditiveSceneSuccessEventArgs.EventId, BattleModule.OnBattleSceneLoaded)
	GameEntry.LuaEvent:Subscribe(BattleChangeUnitStateEventArgs.EventId, BattleModule.OnChangeUnitState)
	GameEntry.LuaEvent:Subscribe(BattleUnitInitUIPosEventArgs.EventId, BattleModule.OnInitEnemyHp)
	GameEntry.LuaEvent:Subscribe(LoadSceneExtResEndEventArgs.EventId, BattleModule.OnLoadSceneExtResComplete)
	GameEntry.LuaEvent:Subscribe(BattleGestureOnElementEventArgs.EventId, BattleModule.OnGestureOnElement)
	GameEntry.LuaEvent:Subscribe(BattlePrepareCastSkillEventArgs.EventId, BattleModule.OnPrepareCastSkill)
	GameEntry.LuaEvent:Subscribe(BattleUpdateUnitSkillEnergyCostEventArgs.EventId, BattleModule.OnUpdateSkillCostEnergy)
	GameEntry.LuaEvent:Subscribe(BattleUpdateUnitSkillEnergyMaxEventArgs.EventId, BattleModule.OnUpdateSkillMaxEnergy)
	GameEntry.LuaEvent:Subscribe(BattleUpdateSkillEventArgs.EventId, BattleModule.OnUpdateSkill)
	GameEntry.LuaEvent:Subscribe(BattleShowPlotEventArgs.EventId, BattleModule.OnShowPlot)
end

function BattleModule.RemoveEventListeners()
	GameEntry.LuaEvent:Unsubscribe(BattleCommandEventArgs.BattleStartCommandEventID, BattleModule.OnBattleStartCommand)
	GameEntry.LuaEvent:Unsubscribe(BattleCommandEventArgs.BattleTurnCommandEventID, BattleModule.OnBattleTurnCommand)
	GameEntry.LuaEvent:Unsubscribe(BattleCommandEventArgs.BattleRoundCommandEventID, BattleModule.OnBeginNewRound)
	GameEntry.LuaEvent:Unsubscribe(BattleCommandEventArgs.BattleRoundEndCommandEventID, BattleModule.OnBattleRoundEndCommand)
	GameEntry.LuaEvent:Unsubscribe(BattleCommandEventArgs.BattleOverCommandEventID, BattleModule.OnBattleOverCommand)
	GameEntry.LuaEvent:Unsubscribe(BattleCommandEventArgs.BattleChooseSkillCommandEventID, BattleModule.OnChooseSkillCommand)
	GameEntry.LuaEvent:Unsubscribe(BattleShowEndUIEventArgs.EventId, BattleModule.OnBattleOver)
	GameEntry.LuaEvent:Unsubscribe(BattleChangeUnitSpeedEventArgs.EventId, BattleModule.OnChangeUnitSpeed)
	GameEntry.LuaEvent:Unsubscribe(BattleUnitUpdateBuffEventArgs.EventId, BattleModule.OnUpdateBuff)
	GameEntry.LuaEvent:Unsubscribe(BattleUnitRemoveBuffEventArgs.EventId, BattleModule.OnRemoveBuff)
	GameEntry.LuaEvent:Unsubscribe(BattleTurnEndEventArgs.EventId, BattleModule.OnTurnEnd)
	GameEntry.LuaEvent:Unsubscribe(BattleUnitDeadEventArgs.EventId, BattleModule.OnBattleUnitDead)
	GameEntry.LuaEvent:Unsubscribe(BattleChangeUnitSkillCDEventArgs.EventId, BattleModule.OnUpdateUnitSkillCD)
	GameEntry.LuaEvent:Unsubscribe(BattleUpdateSkillEnergyEventArgs.EventId, BattleModule.OnUpdateSkillEnergy)
	GameEntry.LuaEvent:Unsubscribe(BattleStartFirstActionInRoundEventArgs.EventId, BattleModule.OnStartFirstActionInRound)
	GameEntry.LuaEvent:Unsubscribe(AddAdditiveSceneSuccessEventArgs.EventId, BattleModule.OnBattleSceneLoaded)
	GameEntry.LuaEvent:Unsubscribe(BattleChangeUnitStateEventArgs.EventId, BattleModule.OnChangeUnitState)
	GameEntry.LuaEvent:Unsubscribe(BattleUnitInitUIPosEventArgs.EventId, BattleModule.OnInitEnemyHp)
	GameEntry.LuaEvent:Unsubscribe(LoadSceneExtResEndEventArgs.EventId, BattleModule.OnLoadSceneExtResComplete)
	GameEntry.LuaEvent:Unsubscribe(BattleGestureOnElementEventArgs.EventId, BattleModule.OnGestureOnElement)
	GameEntry.LuaEvent:Unsubscribe(BattlePrepareCastSkillEventArgs.EventId, BattleModule.OnPrepareCastSkill)
	GameEntry.LuaEvent:Unsubscribe(BattleUpdateUnitSkillEnergyCostEventArgs.EventId, BattleModule.OnUpdateSkillCostEnergy)
	GameEntry.LuaEvent:Unsubscribe(BattleUpdateUnitSkillEnergyMaxEventArgs.EventId, BattleModule.OnUpdateSkillMaxEnergy)
	GameEntry.LuaEvent:Unsubscribe(BattleUpdateSkillEventArgs.EventId, BattleModule.OnUpdateSkill)
	GameEntry.LuaEvent:Unsubscribe(BattleShowPlotEventArgs.EventId, BattleModule.OnShowPlot)
end

function BattleModule.Init(type)
	BattleModule.Initialized = true
	BattleModule.Type = type
	BattleModule.BattleIsOver = false

	BattleModule.AddEventListeners()
end

function BattleModule.StartFight(battleCommand)
	BattleModule.CSBattleModule = IQIGame.Onigao.Game.BattleModule()

	BattleModule.CSBattleModule:StartFight(battleCommand)
end

function BattleModule.OnLoadSceneExtResComplete(sender, args)
	if args.SceneID == SceneID.Battle then
		local speed = PlayerModule.GetBattleSpeed(BattleModule.Type)

		BattleModule.SetSpeed(speed)

		local backgroundRoot = UnityEngine.GameObject.Find("BattleRoot/Background")
		local canvases = backgroundRoot:GetComponentsInChildren(typeof(UnityEngine.Canvas), true)

		for i = 0, canvases.Length - 1 do
			local canvas = canvases[i]

			canvas.worldCamera = UnityEngine.GameObject.Find("UICamera"):GetComponent(typeof(UnityEngine.Camera))

			setGameObjectLayers(canvas.transform, "UI")
		end
	end
end

function BattleModule.SetSpeed(speed)
	UnityEngine.Time.timeScale = speed

	GameEntry.Sound:SetGroupPitch(Constant.SoundGroup.ENVIRONMENT, speed)
	EventDispatcher.Dispatch(EventID.BattleTimeScaleChanged)
end

function BattleModule.Clear()
	BattleModule.Round = 0
	BattleModule.Type = 0
	BattleModule.UnitSpeeds = nil
	BattleModule.UnitBuffs = nil
	BattleModule.RemovedUnitIds = nil
	BattleModule.SkillCDs = nil
	BattleModule.UnitIdSkillCostEnergyMap = nil
	BattleModule.TurnOrders = nil
	BattleModule.BattlePositions = nil
	BattleModule.UnitIdSkillEnergyMap = nil
	BattleModule.UnitIdMaxSkillEnergyMap = nil
	BattleModule.__MonsterTeamCid = 0
	BattleModule.__BattleAreaCid = 0
	BattleModule.MonsterFrontEffectNode = nil
	BattleModule.MonsterBackEffectNode = nil
	BattleModule.DollRowEffectNode = nil
	BattleModule.SkillTargetSceneEffectNode = nil
	BattleModule.FullScreenUIEffectNode = nil
	BattleModule.UnitStandbyIndexes = nil
	BattleModule.ActedUnitInRound = nil
	BattleModule.BattleCamera = nil
	BattleModule.EnemyHpInitDataList = nil
	BattleModule.IsPlayingUltimateWarningEffect = {}
end

function BattleModule.InitBattle(command)
	BattleModule.MaxRound = command.MaxRound
	BattleModule.UnitSpeeds = {}
	BattleModule.UnitBuffs = {}
	BattleModule.RemovedUnitIds = {}
	BattleModule.SkillCDs = {}
	BattleModule.UnitIdSkillCostEnergyMap = {}
	BattleModule.TurnOrders = {}
	BattleModule.BattlePositions = {}
	BattleModule.BattlePositions[Constant.BattleTroopType.Attack] = {}
	BattleModule.BattlePositions[Constant.BattleTroopType.Defend] = {}
	BattleModule.UnitIdSkillEnergyMap = {}
	BattleModule.UnitIdMaxSkillEnergyMap = {}
	BattleModule.EnemyHpInitDataList = {}

	for i = 1, #command.AttackUnitPODs do
		local battleUnitPOD = command.AttackUnitPODs[i]

		BattleModule.InitUnitData(battleUnitPOD, Constant.BattleTroopType.Attack)
	end

	for i = 1, #command.DefendUnitPODs do
		local battleUnitPOD = command.DefendUnitPODs[i]

		BattleModule.InitUnitData(battleUnitPOD, Constant.BattleTroopType.Defend)
	end
end

function BattleModule.InitUnitData(battleUnitPOD, troopType)
	BattleModule.UnitSpeeds[battleUnitPOD.ID] = battleUnitPOD.Speed
	BattleModule.BattlePositions[troopType][battleUnitPOD.ID] = battleUnitPOD.BattlePos

	if battleUnitPOD.HP == 0 then
		BattleModule.RemovedUnitIds[battleUnitPOD.ID] = battleUnitPOD.ID
	end

	local buffs = {}

	for j = 1, #battleUnitPOD.Buffs do
		local battleBuffPOD = battleUnitPOD.Buffs[j]

		buffs[j] = {
			CID = battleBuffPOD.Cid,
			Stack = battleBuffPOD.Stack,
			Count = battleBuffPOD.LeftTime,
			SkillParams = battleBuffPOD.SkillParams
		}
	end

	BattleModule.UnitBuffs[battleUnitPOD.ID] = buffs

	local skillCds = {}

	BattleModule.SkillCDs[battleUnitPOD.ID] = skillCds

	for skillCid, cd in pairs(battleUnitPOD.SkillCD) do
		skillCds[skillCid] = cd
	end

	local skillIdCostEnergyMap = {}

	BattleModule.UnitIdSkillCostEnergyMap[battleUnitPOD.ID] = skillIdCostEnergyMap

	for skillCid, costEnergy in pairs(battleUnitPOD.SkillCostEnergy) do
		skillIdCostEnergyMap[skillCid] = costEnergy
	end

	BattleModule.UnitIdSkillEnergyMap[battleUnitPOD.ID] = battleUnitPOD.SkillEnergy
	BattleModule.UnitIdMaxSkillEnergyMap[battleUnitPOD.ID] = battleUnitPOD.SkillEnergyMax
end

function BattleModule.OnBattleStartCommand(sender, args)
	BattleModule.LogicStarted = true
end

function BattleModule.OnBattleSceneLoaded(sender, args)
	if args.SceneID == SceneID.Battle then
		local cfgMonsterTeamData = CfgMonsterTeamTable[BattleModule.GetMonsterTeamCid()]

		BattleModule.BattleCamera = UnityEngine.GameObject.Find("BattleCamera")
		BattleModule.DollRowEffectNode = BattleModule.BattleCamera.transform:Find("HeroRoot/Front").gameObject
		BattleModule.SkillTargetSceneEffectNode = UnityEngine.GameObject.Find("BattleRoot/" .. cfgMonsterTeamData.FormationName)
		BattleModule.MonsterFrontEffectNode = BattleModule.SkillTargetSceneEffectNode.transform:Find("Front").gameObject
		BattleModule.MonsterBackEffectNode = BattleModule.SkillTargetSceneEffectNode.transform:Find("Back").gameObject
		BattleModule.FullScreenUIEffectNode = UnityEngine.GameObject.Find("UIMountPointCanvas")
	end
end

function BattleModule.OnBattleTurnCommand(sender, args)
	local command = args:ToLuaTable()

	EventDispatcher.Dispatch(EventID.BattleTurnStart, command.MoverID)
	BattleModule.CheckUltimateSkillShow(command.MoverID, true)
end

function BattleModule.OnTurnEnd(sender, args)
	BattleModule.TurnEnd(args.UnitId)
end

function BattleModule.TurnEnd(unitId)
	EventDispatcher.Dispatch(EventID.BattleTurnEnd, unitId)

	BattleModule.ActedUnitInRound[unitId] = unitId

	BattleModule.CheckUltimateSkillShow(unitId)

	local nextUnitId = BattleModule.GetNextTurnUnitAfter(unitId)

	if nextUnitId ~= 0 then
		BattleModule.PrepareNextTurn(nextUnitId)
	end
end

function BattleModule.OnChangeUnitState(sender, args)
	if args.Status == Constant.BattleBuffStatus.PLAY_DEAD or args.Status == Constant.BattleBuffStatus.SEAL_ULTIMATE then
		BattleModule.CheckUltimateSkillShow(args.UnitID)
	end

	EventDispatcher.Dispatch(EventID.BattleUnitChangeState, args.UnitID)
end

function BattleModule.CheckUltimateSkillShow(unitId, forceClear, changeCDSkillCId, ignoreError)
	local battleUnitPOD = BattleModule.GetBattleUnitPOD(unitId)

	if battleUnitPOD.TroopType == Constant.BattleTroopType.Attack then
		return
	end

	local cfgMonsterData = CfgMonsterTable[battleUnitPOD.MonsterCfgId]

	if not cfgMonsterData.IsWarning then
		return
	end

	local battleUnitData = BattleModule.GetBattleUnitData(unitId)

	if battleUnitData.IsDead then
		return
	end

	local ultimateSkillCid, costEnergy

	for i = 0, battleUnitPOD.Skills.Count - 1 do
		local cfgSkillData = CfgSkillTable[battleUnitPOD.Skills[i]]

		if cfgSkillData.Type == Constant.Skill.TYPE_ULTIMATE then
			ultimateSkillCid = cfgSkillData.Id
			costEnergy = BattleModule.GetSkillCostEnergy(battleUnitPOD.ID, ultimateSkillCid)
		end
	end

	if ultimateSkillCid == nil then
		if ignoreError then
			BattleModule._CheckUltimateSkillShow(unitId, false)
		else
			warning("找不到怪物：" .. BattleModule.__TestGetNameByUnitId(unitId) .. "的大招")
		end

		return
	end

	if changeCDSkillCId ~= nil and changeCDSkillCId ~= ultimateSkillCid then
		return
	end

	if forceClear then
		BattleModule._CheckUltimateSkillShow(unitId, false)

		return
	end

	local skillCd = BattleModule.GetSkillCD(unitId, ultimateSkillCid)
	local showUltimateCdDelta = 0

	if BattleModule.ActedUnitInRound[unitId] then
		showUltimateCdDelta = 1
	end

	local isSealUltimate = false

	for i = 0, battleUnitData.StatusList.Count - 1 do
		local status = battleUnitData.StatusList[i]

		if status == Constant.BattleBuffStatus.SEAL_ULTIMATE then
			isSealUltimate = true

			break
		end
	end

	local energy = BattleModule.UnitIdSkillEnergyMap[unitId]
	local isAboutToCastUltimateSkill = skillCd <= showUltimateCdDelta and not isSealUltimate and costEnergy <= energy and not battleUnitData.IsPlayingDead

	BattleModule._CheckUltimateSkillShow(unitId, isAboutToCastUltimateSkill)
end

function BattleModule._CheckUltimateSkillShow(pUnitId, isAboutToCastUltimateSkill)
	if BattleModule.IsPlayingUltimateWarningEffect[pUnitId] ~= nil and BattleModule.IsPlayingUltimateWarningEffect[pUnitId] == isAboutToCastUltimateSkill then
		return
	end

	BattleModule.IsPlayingUltimateWarningEffect[pUnitId] = isAboutToCastUltimateSkill

	BattleModule.CSBattleModule:CheckUltimateSkillShow(pUnitId, isAboutToCastUltimateSkill)
	EventDispatcher.Dispatch(EventID.BattleCheckUnitUltimateSkillState, pUnitId, isAboutToCastUltimateSkill)
end

function BattleModule.PrepareNextTurn(nextUnitId)
	local battleUnitData = BattleModule.GetBattleUnitData(nextUnitId)

	if battleUnitData.IsPlayingDead then
		BattleModule.TurnEnd(nextUnitId)
	end
end

function BattleModule.OnChooseSkillCommand(sender, args)
	local command = args:ToLuaTable()
	local autoFightMode = PlayerModule.GetAutoFightMode(BattleModule.Type)

	if autoFightMode ~= Constant.Battle.AutoFightModeManual then
		BattleModule.AIChooseSkill(command.MoverID, autoFightMode)
	else
		EventDispatcher.Dispatch(EventID.BattleSelectSkill, command.MoverID)

		local nextBattleUnitPOD = BattleModule.GetBattleUnitPOD(command.MoverID)

		EventDispatcher.Dispatch(EventID.CustomGuideTriggerEvent, "BattleSoulSelectSkill_" .. nextBattleUnitPOD.MonsterCfgId .. "_" .. BattleModule.Round .. "_" .. BattleModule.GetMonsterTeamCid())
	end
end

function BattleModule.AIChooseSkill(unitId, autoFightMode)
	local skillCid = 0

	if autoFightMode == Constant.Battle.AutoFightModeAutoNormal then
		local battleUnitPOD = BattleModule.GetBattleUnitPOD(unitId)

		for i = 0, battleUnitPOD.Skills.Count - 1 do
			local cfgSkillData = CfgSkillTable[battleUnitPOD.Skills[i]]

			if cfgSkillData.ShowType == Constant.Skill.SHOW_TYPE_NORMAL then
				skillCid = cfgSkillData.Id

				break
			end
		end
	end

	BattleLogicAdapter.Instance:AddBattleOrderFromLua(BattleLogicAdapter.ORDER_CAST_SKILL, {
		UnitID = unitId,
		SkillCid = skillCid
	})
end

function BattleModule.OnBattleRoundEndCommand(sender, args)
	return
end

function BattleModule.OnBattleOverCommand(sender, args)
	BattleModule.LogicStarted = false

	EventDispatcher.Dispatch(EventID.BattleLogicEnd)
end

function BattleModule.OnBattleOver(sender, args)
	BattleModule.BattleIsOver = true

	local tableArgs = args:ToLuaTable()

	BattleModule.SetSpeed(1)
	BattleModule.ClosePopUpUI()

	if tableArgs.BattleOverCommand.FightResult == Constant.BattleFightResult.TimeOut then
		UIModule.Open(Constant.UIControllerName.BattleTimeoutUI, Constant.UILayer.UI, {
			onClose = function()
				EventDispatcher.Dispatch(EventID.BattleEnd, tableArgs.BattleOverCommand)
			end
		})
	else
		EventDispatcher.Dispatch(EventID.BattleEnd, tableArgs.BattleOverCommand)
	end
end

function BattleModule.ClosePopUpUI()
	UIModule.Close(Constant.UIControllerName.BattleBuffTipsUI)
	UIModule.Close(Constant.UIControllerName.BattleMonsterInfoUI)
end

function BattleModule.OnBeginNewRound(sender, args)
	local command = args:ToLuaTable()

	BattleModule.Round = command.Round
	BattleModule.TurnOrders = {}

	for i = 1, #command.TurnOrders do
		local unitId = command.TurnOrders[i]
		local battleUnitData = BattleModule.GetBattleUnitData(unitId)

		if not battleUnitData.IsDead then
			table.insert(BattleModule.TurnOrders, unitId)
		end
	end

	BattleModule.UnitStandbyIndexes = {}
	BattleModule.ActedUnitInRound = {}

	EventDispatcher.Dispatch(EventID.BattleStartRound)
end

function BattleModule.OnStartFirstActionInRound(sender, args)
	local firstUnitId = 0

	for i = 1, #BattleModule.TurnOrders do
		local unitId = BattleModule.TurnOrders[i]
		local battleUnitData = BattleModule.GetBattleUnitData(unitId)

		if not battleUnitData.IsDead then
			firstUnitId = unitId

			break
		end
	end

	if args.Round == 1 then
		for i = 1, #BattleModule.TurnOrders do
			local unitId = BattleModule.TurnOrders[i]

			BattleModule.CheckUltimateSkillShow(unitId)
		end
	end

	BattleModule.PrepareNextTurn(firstUnitId)
end

function BattleModule.OnChangeUnitSpeed(sender, args)
	BattleModule.UnitSpeeds[args.UnitID] = args.Speed

	EventDispatcher.Dispatch(EventID.BattleChangeUnitSpeed, args.UnitID, args.Speed)
end

function BattleModule.GetAttackTroopPodsTable()
	return GameEntry.Data.Battle.BattleInitData:ToLuaTable().AttackUnitPODs
end

function BattleModule.GetDefendTroopPodsTable()
	return GameEntry.Data.Battle.BattleInitData:ToLuaTable().DefendUnitPODs
end

function BattleModule.GetMonsterTeamCid()
	if BattleModule.__MonsterTeamCid == 0 then
		BattleModule.__MonsterTeamCid = GameEntry.Data.Battle.BattleInitData:ToLuaTable().MonsterTeamID
	end

	return BattleModule.__MonsterTeamCid
end

function BattleModule.GetBattleAreaCid()
	if BattleModule.__BattleAreaCid == 0 then
		BattleModule.__BattleAreaCid = GameEntry.Data.Battle.BattleInitData:ToLuaTable().MapID
	end

	return BattleModule.__BattleAreaCid
end

function BattleModule.GetBattleUnitData(unitId)
	return GameEntry.Data.Battle:GetBattleUnitData(unitId)
end

function BattleModule.GetBattleUnitPOD(unitId)
	return GameEntry.Data.Battle:GetBattleUnitPOD(unitId)
end

function BattleModule.GetBattleTroopTotalHp(troop)
	return GameEntry.Data.Battle:GetBattleTroopTotalHp(troop)
end

function BattleModule.GetBattleTroopTotalMaxHp(troop)
	return GameEntry.Data.Battle:GetBattleTroopTotalMaxHp(troop)
end

function BattleModule.OnUpdateBuff(sender, args)
	local unitId = args.BattleUnitID
	local buffData = args.UnitAddBuffData

	if buffData == nil or buffData.SkillParams == nil then
		local buffDataStr = ""

		if buffData ~= nil then
			buffDataStr = "BuffId = " .. tostring(buffData.BuffId) .. ", BuffStack = " .. tostring(buffData.BuffStack) .. ", LeftCount = " .. tostring(buffData.LeftCount) .. ", IsAdd = " .. tostring(buffData.IsAdd) .. ", SkillParams = nil"
		end

		logError("Update Buff Error. unitId = " .. tostring(unitId) .. " TroopType = " .. tostring(args.TroopType) .. " BattleUnitPosIndex = " .. tostring(args.BattleUnitPosIndex) .. " UnitAddBuffData = " .. buffDataStr)

		return
	end

	local skillParams = {}

	for i = 0, buffData.SkillParams.Length - 1 do
		skillParams[i + 1] = math.round(buffData.SkillParams[i] * 10000) / 10000
	end

	local addOrAddStackBuffData = {
		CID = buffData.BuffId,
		Stack = buffData.BuffStack,
		Count = buffData.LeftCount,
		SkillParams = skillParams
	}
	local unitBuffs = BattleModule.UnitBuffs[unitId]

	if unitBuffs == nil then
		unitBuffs = {}
		BattleModule.UnitBuffs[unitId] = unitBuffs
	end

	local changeStackBuffs = {}
	local addStackBuffs = {}
	local foundBuff = false

	for i = 1, #unitBuffs do
		local oldBuffData = unitBuffs[i]

		if oldBuffData.CID == addOrAddStackBuffData.CID then
			if oldBuffData.Stack ~= addOrAddStackBuffData.Stack then
				table.insert(changeStackBuffs, oldBuffData)

				if oldBuffData.Stack < addOrAddStackBuffData.Stack then
					table.insert(addStackBuffs, oldBuffData)
				end
			end

			oldBuffData.Stack = addOrAddStackBuffData.Stack
			oldBuffData.Count = addOrAddStackBuffData.Count
			oldBuffData.SkillParams = addOrAddStackBuffData.SkillParams
			foundBuff = true

			break
		end
	end

	local addBuffData

	if buffData.IsAdd then
		table.insert(unitBuffs, addOrAddStackBuffData)

		addBuffData = addOrAddStackBuffData
	end

	if buffData.IsAdd or foundBuff then
		EventDispatcher.Dispatch(EventID.BattleAddBuff, unitId, unitBuffs, args.TroopType, addBuffData, changeStackBuffs, addStackBuffs)
	end
end

function BattleModule.OnRemoveBuff(sender, arg)
	local removeBuffCid = arg.BuffCid
	local unitId = arg.BattleUnitID
	local unitBuffs = BattleModule.UnitBuffs[unitId]

	if unitBuffs == nil then
		logError("尝试从\"" .. BattleModule.__TestGetNameByUnitId(unitId) .. "\"身上移除不存在的buff。Buff cid " .. removeBuffCid)

		return
	end

	for i = 1, #unitBuffs do
		local buffData = unitBuffs[i]

		if removeBuffCid == buffData.CID then
			table.remove(unitBuffs, i)

			break
		end
	end

	EventDispatcher.Dispatch(EventID.BattleRemoveBuff, unitId, removeBuffCid, arg.TroopType)
end

function BattleModule.OnBattleUnitDead(sender, args)
	BattleModule.RemovedUnitIds[args.UnitID] = args.UnitID

	local battleUnitPOD = BattleModule.GetBattleUnitPOD(args.UnitID)
	local cfgMonsterData = CfgMonsterTable[battleUnitPOD.MonsterCfgId]

	if cfgMonsterData.IsBoss then
		BattleModule.IsPlayingBulletTime = true

		BattleModule.SetSpeed(Constant.Battle.BulletTimeRatio)

		local timer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.Battle, function()
			if BattleModule.BattleIsOver then
				return
			end

			BattleModule.SetSpeed(PlayerModule.GetBattleSpeed(BattleModule.Type))

			BattleModule.IsPlayingBulletTime = false
		end, Constant.Battle.BulletTimeDuration, 1, false)

		timer:Start()
	end
end

function BattleModule.Shutdown(onBattleClear)
	if not BattleModule.Initialized then
		return false
	end

	BattleModule.Initialized = false

	ModuleTimerUtil.Stop(Constant.ModuleTimerName.Battle)

	BattleModule.IsPlayingBulletTime = false
	BattleModule.BattleIsOver = true

	BattleModule.SetSpeed(1)
	BattleModule.StopAllSkillAreaEffects()
	BattleModule.RemoveEventListeners()
	BattleModule.ClosePopUpUI()
	BattleModule.Clear()
	xpcall(function()
		BattleModule.CSBattleModule:ShutDown(onBattleClear)

		BattleModule.CSBattleModule = nil
	end, function(msg)
		logError("BattleModule.Shutdown error: " .. tostring(msg))

		if onBattleClear ~= nil then
			onBattleClear()
		end
	end)

	return true
end

function BattleModule.Float(v, n)
	if v > math.floor(v) then
		return tonumber(string.format("%." .. n .. "f", v))
	else
		return v
	end
end

function BattleModule.__TestGetNameByUnitId(unitId)
	local battleUnitPOD = BattleModule.GetBattleUnitPOD(unitId)

	if battleUnitPOD == nil then
		return "未知目标" .. unitId
	end

	local cfgMonsterData = CfgMonsterTable[battleUnitPOD.MonsterCfgId]

	return cfgMonsterData.Name
end

function BattleModule.__TestGetDollInfoText()
	local dollMonsterInfos = ""
	local battleUnitPODs = BattleModule.GetAttackTroopPodsTable()

	for i = 1, #battleUnitPODs do
		local battleUnitPOD = battleUnitPODs[i]
		local cfgMonsterData = CfgMonsterTable[battleUnitPOD.MonsterCfgId]

		dollMonsterInfos = dollMonsterInfos .. "[" .. cfgMonsterData.Name .. " Monster Id: " .. battleUnitPOD.MonsterCfgId .. ", level: " .. battleUnitPOD.Level .. ", power: " .. battleUnitPOD.Power .. "], "
	end

	return dollMonsterInfos
end

function BattleModule.CheckHasEnergyShield(unitId)
	local battleUnitData = BattleModule.GetBattleUnitData(unitId)

	return battleUnitData.WeakNum > 0
end

function BattleModule.SetUnitsSelectable(units, troopType, canSelectArea, attackArea, skillCid)
	if not BattleModule.Initialized then
		return
	end

	xpcall(function()
		EventDispatcher.Dispatch(EventID.BattleChangeSkillSelectTargets, skillCid, units)
	end, function(msg)
		logError("BattleModule.SetUnitsSelectable 发生错误.\nMessage: " .. tostring(msg))
	end)
	BattleModule.CSBattleModule:SetUnitsSelectable(unpack(units))
	BattleModule.StopAllSkillAreaEffects()

	if units == nil or #units == 0 then
		return
	end

	local effectCid

	if attackArea == Constant.SkillTargetArea.Single then
		effectCid = troopType == Constant.BattleTroopType.Attack and 9005009 or 9005006

		for i = 1, #units do
			local battleUnitData = BattleModule.GetBattleUnitData(units[i])
			local effectPlayId = BattleModule.CSBattleModule.PlayMountPointEffect(effectCid, 50000, battleUnitData.EntityID, battleUnitData.BattleUnitObject, 0, 0, UnityEngine.LayerMask.NameToLayer("BattleEffect"), 0, 0)

			table.insert(BattleModule.SkillAreaEffectPlayIds, effectPlayId)
		end

		return
	end

	local mountPoint, targetRoot

	if troopType == Constant.BattleTroopType.Attack then
		effectCid = 9005010
		mountPoint = 50000
		targetRoot = BattleModule.DollRowEffectNode
	elseif attackArea == Constant.SkillTargetArea.Row then
		if canSelectArea == Constant.BattlePositionArea.Front then
			effectCid = 9005007
			mountPoint = 50000
			targetRoot = BattleModule.MonsterFrontEffectNode
		elseif canSelectArea == Constant.BattlePositionArea.Back then
			effectCid = 9005007
			mountPoint = 50000
			targetRoot = BattleModule.MonsterBackEffectNode
		else
			effectCid = 9005007
			mountPoint = 40003
			targetRoot = BattleModule.SkillTargetSceneEffectNode
		end
	elseif attackArea == Constant.SkillTargetArea.All then
		effectCid = 9005008
		mountPoint = 40003
		targetRoot = BattleModule.SkillTargetSceneEffectNode
	end

	local effectPlayId = BattleModule.CSBattleModule.PlayMountPointEffect(effectCid, mountPoint, 0, targetRoot, 0, 0, UnityEngine.LayerMask.NameToLayer("BattleEffect"), 0, 0)

	table.insert(BattleModule.SkillAreaEffectPlayIds, effectPlayId)
end

function BattleModule.StopAllSkillAreaEffects()
	for i = 1, #BattleModule.SkillAreaEffectPlayIds do
		local playId = BattleModule.SkillAreaEffectPlayIds[i]

		GameEntry.Effect:StopEffect(playId)
	end

	BattleModule.SkillAreaEffectPlayIds = {}
end

function BattleModule.NoticeUnitCannotSelect(unitId)
	local battleUniData = BattleModule.GetBattleUnitData(unitId)

	BattleModule.CSBattleModule.PlayMountPointEffect(9005005, 10204, battleUniData.EntityID, battleUniData.BattleUnitObject, 0, 0, UnityEngine.LayerMask.NameToLayer("BattleEffect"), 0, 0)
end

function BattleModule.OnUpdateUnitSkillCD(sender, args)
	BattleModule.SkillCDs[args.UnitID][args.SkillCid] = args.CD

	BattleModule.CheckUltimateSkillShow(args.UnitID, false, args.SkillCid)
	EventDispatcher.Dispatch(EventID.BattleUpdateUnitSkillCD, args.UnitID)
end

function BattleModule.OnUpdateSkillCostEnergy(sender, args)
	BattleModule.UnitIdSkillCostEnergyMap[args.UnitId][args.SkillCid] = args.EnergyCost

	EventDispatcher.Dispatch(EventID.BattleUpdateSkillCostEnergy, args.UnitId, args.SkillCid)
end

function BattleModule.OnUpdateSkillEnergy(sender, args)
	BattleModule.UnitIdSkillEnergyMap[args.battleUnitId] = args.SkillEnergy

	EventDispatcher.Dispatch(EventID.BattleUpdateUnitSkillEnergy, args.battleUnitId, args.SkillEnergy)
end

function BattleModule.OnUpdateSkillMaxEnergy(sender, args)
	BattleModule.UnitIdMaxSkillEnergyMap[args.UnitId] = args.SkillEnergyMax

	EventDispatcher.Dispatch(EventID.BattleUpdateUnitMaxSkillEnergy, args.UnitId, args.SkillEnergyMax)
end

function BattleModule.OnUpdateSkill(sender, args)
	BattleModule.SkillCDs[args.unitId][args.oldSkillId] = nil
	BattleModule.SkillCDs[args.unitId][args.newSkillId] = args.newSkillCD
	BattleModule.UnitIdSkillCostEnergyMap[args.unitId][args.oldSkillId] = nil
	BattleModule.UnitIdSkillCostEnergyMap[args.unitId][args.newSkillId] = args.newSkillCostEnergy

	EventDispatcher.Dispatch(EventID.BattleModifySkill, args.unitId, args.oldSkillId, args.newSkillId)

	local cfgSkillData1 = CfgSkillTable[args.oldSkillId]
	local cfgSkillData2 = CfgSkillTable[args.newSkillId]

	if cfgSkillData1.Type == Constant.Skill.TYPE_ULTIMATE or cfgSkillData2.Type == Constant.Skill.TYPE_ULTIMATE then
		BattleModule.CheckUltimateSkillShow(args.unitId, false, nil, true)
	end
end

function BattleModule.GetNextTurnUnitAfter(curUnitId)
	local curIndex = table.indexOf(BattleModule.TurnOrders, curUnitId)

	if curIndex == -1 then
		logError("BattleModule.GetNextTurnUnitAfter找不到战斗单位: id = " .. curUnitId .. ", name = " .. BattleModule.__TestGetNameByUnitId(curUnitId))

		return 0
	end

	local nextUnitId = 0

	for i = curIndex + 1, #BattleModule.TurnOrders do
		local unitId = BattleModule.TurnOrders[i]
		local battleUnitData = BattleModule.GetBattleUnitData(unitId)

		if not battleUnitData.IsDead then
			nextUnitId = unitId

			break
		end
	end

	return nextUnitId
end

function BattleModule.GetAllUnitsInArea(troopType, area)
	local units = {}
	local unitsOfTroop = BattleModule.GetUnitPosMapOfTroop(troopType)

	for id, pos in pairs(unitsOfTroop) do
		if BattleModule.IsInArea(pos, area) then
			table.insert(units, id)
		end
	end

	return units
end

function BattleModule.GetCanHitUnitsInArea(troopType, area, cfgSearchTargetData)
	local units
	local unitsOfTroop = BattleModule.GetUnitPosMapOfTroop(troopType)

	units = BattleModule.GetCanHitUnitsIn(unitsOfTroop, area, cfgSearchTargetData)

	if #units == 0 and (area == Constant.BattlePositionArea.Front or area == Constant.BattlePositionArea.Back) then
		if area == Constant.BattlePositionArea.Front then
			area = Constant.BattlePositionArea.Back
		elseif area == Constant.BattlePositionArea.Back then
			area = Constant.BattlePositionArea.Front
		end

		units = BattleModule.GetCanHitUnitsIn(unitsOfTroop, area, cfgSearchTargetData)
	end

	return units, area
end

function BattleModule.GetUnitPosMapOfTroop(troopType)
	local unitPosMapOfTroop

	if troopType ~= nil then
		unitPosMapOfTroop = BattleModule.BattlePositions[troopType]
	else
		unitPosMapOfTroop = {}

		for id, battlePos in pairs(BattleModule.BattlePositions[Constant.BattleTroopType.Attack]) do
			unitPosMapOfTroop[id] = battlePos
		end

		for id, battlePos in pairs(BattleModule.BattlePositions[Constant.BattleTroopType.Defend]) do
			unitPosMapOfTroop[id] = battlePos
		end
	end

	return unitPosMapOfTroop
end

function BattleModule.GetCanHitUnitsIn(units, area, cfgSearchTargetData)
	local canHitUnits = {}
	local validTauntUnits = {}

	for id, pos in pairs(units) do
		if BattleModule.IsInArea(pos, area) then
			local battleUnitData = BattleModule.GetBattleUnitData(id)
			local isValidTaunt = battleUnitData:HasStatus(Constant.BattleBuffStatus.TAUNT) and not battleUnitData:HasStatus(Constant.BattleBuffStatus.STEALTH) and not battleUnitData:HasStatus(Constant.BattleBuffStatus.PLAY_DEAD) and not cfgSearchTargetData.IgnoreTaunt

			if isValidTaunt then
				table.insert(validTauntUnits, id)
			end

			local exclude = battleUnitData.IsDead or battleUnitData:HasStatus(Constant.BattleBuffStatus.STEALTH) and not cfgSearchTargetData.SelectStealth or battleUnitData:HasStatus(Constant.BattleBuffStatus.PLAY_DEAD) and not cfgSearchTargetData.SelectDeath

			if not exclude then
				table.insert(canHitUnits, id)
			end
		end
	end

	if #validTauntUnits > 0 then
		return validTauntUnits
	end

	return canHitUnits
end

function BattleModule.IsInArea(pos, area)
	if pos < 1 or pos > 10 then
		logError("站位错误：" .. pos)

		return false
	end

	if area == Constant.BattlePositionArea.All then
		return true
	elseif area == Constant.BattlePositionArea.Front then
		return pos <= 5
	elseif area == Constant.BattlePositionArea.Back then
		return pos > 5
	end

	logError("区域错误：" .. area)

	return false
end

function BattleModule.IsSkillSeal(unitId, cfgSkillData)
	if cfgSkillData == nil then
		return false
	end

	if cfgSkillData.IgnoreSeal then
		return false
	end

	local battleUnitData = BattleModule.GetBattleUnitData(unitId)

	for i = 0, battleUnitData.StatusList.Count - 1 do
		local status = battleUnitData.StatusList[i]

		if status == Constant.BattleBuffStatus.SEAL_NORMAL and cfgSkillData.Type == Constant.Skill.TYPE_NORMAL or status == Constant.BattleBuffStatus.SEAL_CORE and cfgSkillData.Type == Constant.Skill.TYPE_CORE or status == Constant.BattleBuffStatus.SEAL_CORE_2 and cfgSkillData.Type == Constant.Skill.TYPE_CORE2 or status == Constant.BattleBuffStatus.SEAL_ULTIMATE and cfgSkillData.Type == Constant.Skill.TYPE_ULTIMATE then
			return true
		end
	end

	return false
end

function BattleModule.GetSkillCD(unitId, skillCid)
	return BattleModule.SkillCDs[unitId][skillCid]
end

function BattleModule.GetSkillCostEnergy(unitId, skillCid)
	return BattleModule.UnitIdSkillCostEnergyMap[unitId][skillCid]
end

function BattleModule.GetUnitSkillEnergy(unitId)
	return BattleModule.UnitIdSkillEnergyMap[unitId]
end

function BattleModule.GetUnitMaxSkillEnergy(unitId)
	return BattleModule.UnitIdMaxSkillEnergyMap[unitId]
end

function BattleModule.Standby(unitId)
	if BattleModule.UnitStandbyIndexes[unitId] ~= nil then
		return
	end

	local standbyCount = 0

	for lUnitId, lStandbyIndex in pairs(BattleModule.UnitStandbyIndexes) do
		standbyCount = standbyCount + 1
	end

	BattleModule.UnitStandbyIndexes[unitId] = standbyCount + 1

	EventDispatcher.Dispatch(EventID.BattleChangeUnitSpeed, unitId, BattleModule.UnitSpeeds[unitId])
end

function BattleModule.OnInitEnemyHp(sender, args)
	local data = args:ToLuaTable()

	BattleModule.EnemyHpInitDataList[data.UnitID] = data

	EventDispatcher.Dispatch(EventID.BattleInitEnemyHp, data.UnitID)
end

function BattleModule.ObtainEnemyHpInitData(unitId)
	local enemyHpInitData = BattleModule.EnemyHpInitDataList[unitId]

	BattleModule.EnemyHpInitDataList[unitId] = nil

	return enemyHpInitData
end

function BattleModule.ClearEnemyHpInitDataList()
	BattleModule.EnemyHpInitDataList = {}
end

function BattleModule.OnGestureOnElement(sender, args)
	if args.GestureType == Constant.GestureType.LongPress then
		local battleUnitData = BattleModule.GetBattleUnitData(args.UnitId)

		if battleUnitData.IsDead then
			return
		end

		UIModule.Open(Constant.UIControllerName.BattleMonsterInfoUI, Constant.UILayer.UI, {
			unitId = args.UnitId
		})
	end
end

function BattleModule.SetIsSkipping()
	BattleModule.CSBattleModule:SetIsSkipping()
end

function BattleModule.OnPrepareCastSkill(sender, args)
	EventDispatcher.Dispatch(EventID.BattlePrepareCastSkill, args.BattleUnitID, args.MonsterCid, args.SkillCid, args.SkillActionCid, args.NeedPlayCG)
end

function BattleModule.OnSkillCGComplete()
	BattleModule.CSBattleModule:OnSkillCGComplete()
end

function BattleModule.OnShowPlot(sender, args)
	BattleModule.PlotId = args.plotId

	EventDispatcher.Dispatch(EventID.BattleShowOrEndPlot, true)
	EventDispatcher.AddEventListener(EventID.CloseDialogUI, BattleModule.OnCloseBattlePlotDialog)

	BattleModule.OldDialogIsFullScreen = LuaCodeInterface.SetUIIsFullScreen(Constant.UIControllerName.DialogUI, false)

	DialogModule.OpenDialog(BattleModule.PlotId, false, false)
	BattleModule.SetSpeed(1)
end

function BattleModule.OnCloseBattlePlotDialog(startDialogCid)
	if startDialogCid == BattleModule.PlotId then
		EventDispatcher.RemoveEventListener(EventID.CloseDialogUI, BattleModule.OnCloseBattlePlotDialog)
		BattleModule.EndPlot()
		BattleModule.SetSpeed(PlayerModule.GetBattleSpeed(BattleModule.Type))

		local timer = FrameTimer.New(function()
			LuaCodeInterface.SetUIIsFullScreen(Constant.UIControllerName.DialogUI, BattleModule.OldDialogIsFullScreen)
		end, 1)

		timer:Start()
	end
end

function BattleModule.EndPlot()
	if BattleModule.PlotId == nil or BattleModule.PlotId == 0 then
		return
	end

	EventDispatcher.Dispatch(EventID.BattleShowOrEndPlot, false)

	BattleModule.PlotId = 0

	BattleModule.CSBattleModule:EndPlot()
end

function BattleModule.HideAllUIExceptLoading(loadingUISid)
	BattleModule.UIsDisabledInBattle = GameEntry.UI:DisableAllLoadedUIForms(loadingUISid)
end

function BattleModule.RecoverAllHideUI()
	GameEntry.UI:EnableLoadedUIForms(BattleModule.UIsDisabledInBattle)

	BattleModule.UIsDisabledInBattle = nil
end
