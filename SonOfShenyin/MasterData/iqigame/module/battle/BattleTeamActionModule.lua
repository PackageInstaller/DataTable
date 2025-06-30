-- chunkname: @IQIGame\\Module\\Battle\\BattleTeamActionModule.lua

local BattleOrderData = require("IQIGame.Module.Battle.BattleData.BattleOrderData")

BattleTeamActionModule = {
	battleRound = 0,
	isAuto = false,
	showSkillDetail = true,
	isPaused = false,
	isSkipRest = false,
	skillNeedConfirm = true,
	realActionUnitID = 0,
	selectTargetNeedScaleUnitView = false,
	isCutinOn = true,
	is_continue_fight = 1,
	isAttackTeamTurn = false
}
BattleTeamActionModule.EmptyTurnUnitID = -999

function BattleTeamActionModule.OnInit(turnOrders)
	BattleTeamActionModule.EmptyTurnUnitID = -999
	BattleTeamActionModule.__curState = BattleConstant.BattleTeamActionState.Free

	BattleTeamActionModule.InitTurnOrder(turnOrders)
end

function BattleTeamActionModule.InitTurnOrder(turnOrders)
	BattleTeamActionModule.battlePlayerTurnOrders = {}

	ForPairs(turnOrders, function(turnIndex, turnUnitID)
		if turnUnitID == BattleModule.attackTeamBattleUnitID then
			return
		end

		if turnUnitID == BattleModule.defendTeamBattleUnitID then
			return
		end

		local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(turnUnitID)

		if battleUnitData == nil then
			logError("初始化出手角色数据错误---->>{0}", turnUnitID)

			return
		end

		if battleUnitData.troopType == BattleModule.defineBattleTroopType then
			return
		end

		if LuaUtility.StrIsNullOrEmpty(battleUnitData.PODData.Pid) then
			return
		end

		table.insert(BattleTeamActionModule.battlePlayerTurnOrders, turnUnitID)
	end)
end

function BattleTeamActionModule.UpdatePlayerTurnOrders(playerTurnOrders)
	BattleTeamActionModule.battlePlayerTurnOrders = playerTurnOrders

	EventDispatcher.Dispatch(EventID.OnBattlePlayerUnitTurnNumChange)
end

function BattleTeamActionModule.UnTrustRound()
	BattleTeamActionModule.__StopStandbyTimer()
end

function BattleTeamActionModule.CheckUnitCanSetOrder(battleUnitID)
	local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(battleUnitID)

	return battleUnitData:CanSetTurnOrder()
end

function BattleTeamActionModule.__GetTurnUnitID()
	local turnUnitID = BattleTeamActionModule.EmptyTurnUnitID

	ForArray(BattleTeamActionModule.battlePlayerTurnOrders, function(index, battleUnitID)
		if BattleTeamActionModule.CheckUnitCanSetOrder(battleUnitID) then
			turnUnitID = battleUnitID

			return true
		end
	end)

	return turnUnitID
end

function BattleTeamActionModule.ChangeAuto()
	BattleTeamActionModule.isAuto = not BattleTeamActionModule.isAuto

	if SettingModule.MaintainAutoBattle() then
		SettingModule.SaveAutoBattle(BattleTeamActionModule.isAuto)
	end

	if BattleTeamActionModule.isAuto and BattleTeamActionModule.__curState == BattleConstant.BattleTeamActionState.ManualOperate then
		BattleTeamActionModule.__curState = BattleConstant.BattleTeamActionState.Free
	end
end

function BattleTeamActionModule.OnStartRound(roundAction)
	BattleTeamActionModule.battleRound = roundAction.roundCommand.Round
	BattleTeamActionModule.__manualOperateID = BattleTeamActionModule.EmptyTurnUnitID

	BattleTeamActionModule.__EnterPerformingState(BattleTeamActionModule.EmptyTurnUnitID)
	roundAction:StartRound(function()
		BattleTeamActionModule.__ExitPerformingState()
	end)
end

function BattleTeamActionModule.OnRoundActionUpdate(roundAction)
	if BattleTeamActionModule.isPaused then
		return
	end

	if BattleTeamActionModule.__IsPerforming then
		return
	end

	local chooseSkillCommand = roundAction:PeekChooseSkillCommand()

	if chooseSkillCommand ~= nil then
		local moverID = BattleModule.attackTeamBattleUnitID

		if chooseSkillCommand.TroopType == BattleModule.defineBattleTroopType then
			moverID = BattleModule.defineTeamBattleUnitID
		end

		BattleTeamActionModule.__EnterPerformingState(moverID)
		roundAction:PerformingChooseSkillCommand(BattleTeamActionModule.__OnRoundChooseSkillComplete)

		return
	end

	local turnAction = roundAction:PeekTurnAction()

	if turnAction ~= nil then
		BattleTeamActionModule.__EnterPerformingState(turnAction.moverID)
		roundAction:PerformingTurnAction(BattleTeamActionModule.__OnRoundTurnActionComplete)

		return
	end

	if roundAction:HasRoundEndCommand() then
		BattleTeamActionModule.__EnterPerformingState(BattleTeamActionModule.EmptyTurnUnitID)
		roundAction:OnRoundEnd()

		return
	end

	BattleTeamActionModule.__OnRoundPerformFree()
end

function BattleTeamActionModule.__OnRoundChooseSkillComplete()
	BattleTeamActionModule.__ExitPerformingState()
end

function BattleTeamActionModule.__OnRoundTurnActionComplete()
	BattleTeamActionModule.__ExitPerformingState()
end

function BattleTeamActionModule.__EnterPerformingState(moverID)
	BattleTeamActionModule.__IsPerforming = true
	BattleTeamActionModule.__moverID = moverID

	if BattleTeamActionModule.__curState ~= BattleConstant.BattleTeamActionState.ManualOperate then
		BattleTeamActionModule.__UpdateCurState(BattleConstant.BattleTeamActionState.Performing)
	end
end

function BattleTeamActionModule.__ExitPerformingState()
	BattleTeamActionModule.__IsPerforming = false

	if BattleTeamActionModule.__curState ~= BattleConstant.BattleTeamActionState.ManualOperate then
		BattleTeamActionModule.__UpdateCurState(BattleConstant.BattleTeamActionState.Free)
	end

	BattleTeamActionModule.__moverID = BattleTeamActionModule.EmptyTurnUnitID
end

function BattleTeamActionModule.__OnRoundPerformFree()
	if BattleModule.isPlayback then
		return
	end

	if not BattleTeamActionModule.isAttackTeamTurn then
		return
	end

	if BattleTeamActionModule.__curState ~= BattleConstant.BattleTeamActionState.Free then
		return
	end

	if BattleTeamActionModule.__manualOperateID == BattleTeamActionModule.EmptyTurnUnitID then
		BattleTeamActionModule.__manualOperateID = BattleTeamActionModule.__GetTurnUnitID()

		if BattleTeamActionModule.__manualOperateID == BattleTeamActionModule.EmptyTurnUnitID then
			return
		end
	end

	if BattleTeamActionModule.isAuto then
		BattleTeamActionModule.__SendAutoFightOrder(BattleTeamActionModule.__manualOperateID)

		return
	end

	BattleTeamActionModule.__UpdateCurState(BattleConstant.BattleTeamActionState.ManualOperate)

	BattleTeamActionModule.__enableOrderInput = true

	BattleTeamActionModule.SetManualMoverID(BattleTeamActionModule.__manualOperateID)
end

function BattleTeamActionModule.SetManualMoverID(battleUnitID)
	if not BattleTeamActionModule.CanManualOperateMover() then
		return
	end

	local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(battleUnitID)

	if battleUnitData.troopType == BattleModule.defineBattleTroopType then
		BattleTeamActionModule.__SetManualMover_Monster(battleUnitData)
	else
		BattleTeamActionModule.__SetManualMover_Player(battleUnitData)
	end
end

function BattleTeamActionModule.__SetManualMover_Player(battleUnitData)
	BattleTeamActionModule.__manualOperateID = battleUnitData.battleUnitID

	if not battleUnitData:CanSetTurnOrder() then
		return
	end

	EventDispatcher.Dispatch(EventID.OnBattleUnitSetTurnOrder, battleUnitData.battleUnitID)
	CVModule.PlayCV(Constant.CVActionType.FightRoleSelect, battleUnitData:GetHeroCid())
	BattleTeamActionModule.__StartStandbyTimer(battleUnitData.battleUnitID)

	local skillCid = battleUnitData.previewSkillData.skillCid
	local battleSkillData = battleUnitData:GetSkillData(skillCid)

	BattleTeamActionModule.__OnManualSkillSelected(battleUnitData.battleUnitID, battleSkillData.skillType, skillCid, false)
end

function BattleTeamActionModule.__SetManualMover_Monster(battleUnitData)
	BattleTeamActionModule.__manualOperateID = battleUnitData.battleUnitID

	EventDispatcher.Dispatch(EventID.RefreshBattleSkillTargetRolePreview)
end

function BattleTeamActionModule.SetManualSkill(battleUnitID, skillType, skillCid)
	if not BattleTeamActionModule.CanManualOperateMover() then
		return
	end

	if battleUnitID ~= BattleTeamActionModule.__manualOperateID then
		logError("【诡异Bug】当前选择技能的战斗单位非当前操作的战斗单位ID  \r\n 当前操作战斗单位ID:{0}----> 技能选择战斗单位ID：{1}", BattleTeamActionModule.__manualOperateID, battleUnitID)

		return
	end

	if BattleTeamActionModule.__CheckSkillDoubleSelected(battleUnitID, skillCid) then
		if GuideModule.IsGuiding then
			EventDispatcher.Dispatch(EventID.OnBattleUnitSelectedSkill, battleUnitID, skillType, skillCid)
		else
			BattleTeamActionModule.__SendCastSkillOrder()
		end

		return
	end

	BattleTeamActionModule.__StartStandbyTimer(battleUnitID)
	BattleTeamActionModule.__OnManualSkillSelected(battleUnitID, skillType, skillCid, true)
end

function BattleTeamActionModule.__CheckSkillDoubleSelected(battleUnitID, skillCid)
	local castSkillOrder = BattleTeamActionModule.__tempCastSkillOrder

	if castSkillOrder == nil then
		return false
	end

	if castSkillOrder.BattleUnitID ~= battleUnitID then
		return false
	end

	if castSkillOrder.SkillCid ~= skillCid then
		return false
	end

	return true
end

function BattleTeamActionModule.__OnManualSkillSelected(battleUnitID, skillType, skillCid, playCV)
	BattleTeamActionModule.__tempCastSkillOrder = BattleOrderData.CreateOrder(BattleConstant.BattleOrderType.CastSkill, battleUnitID, BattleTeamActionModule.battleRound)
	BattleTeamActionModule.__tempCastSkillOrder.SkillCid = skillCid

	EventDispatcher.Dispatch(EventID.OnBattleUnitSelectedSkill, battleUnitID, skillType, skillCid)
	BattleSkillModule.ShowManualChooseSkill(battleUnitID, skillCid)

	if not playCV then
		return
	end

	if skillType == Constant.SkillType.TYPE_NORMAL then
		CVModule.PlayCV(Constant.CVActionType.FightAttackSelect, BattleModule.GetBattleUnitDataByUnitID(battleUnitID):GetHeroCid())
	elseif skillType == Constant.SkillType.TYPE_ULTIMATE then
		CVModule.PlayCV(Constant.CVActionType.FightSkillSelect, BattleModule.GetBattleUnitDataByUnitID(battleUnitID):GetHeroCid())
	end
end

function BattleTeamActionModule.CanManualOperateMover()
	if not BattleTeamActionModule.__enableOrderInput then
		return false
	end

	return BattleTeamActionModule.__curState == BattleConstant.BattleTeamActionState.ManualOperate
end

function BattleTeamActionModule.InState(battleTeamActionState)
	return BattleTeamActionModule.__curState == battleTeamActionState
end

function BattleTeamActionModule.IsManualOperateMoverID(battleUnitID)
	return BattleTeamActionModule.__manualOperateID == battleUnitID
end

function BattleTeamActionModule.GetManualOperateID()
	return BattleTeamActionModule.__manualOperateID
end

function BattleTeamActionModule.CanDragMover(battleUnitID)
	if battleUnitID ~= BattleTeamActionModule.__manualOperateID then
		return false
	end

	local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(battleUnitID)

	if battleUnitData:IsDead() then
		return false
	end

	if battleUnitData.troopType ~= BattleModule.attackBattleTroopType then
		return false
	end

	return true
end

function BattleTeamActionModule.__UpdateCurState(state)
	BattleTeamActionModule.__curState = state

	if BattleTeamActionModule.__curState == BattleConstant.BattleTeamActionState.WaitPerform then
		BattleTeamActionModule.__manualOperateID = BattleTeamActionModule.EmptyTurnUnitID
		BattleTeamActionModule.__tempCastSkillOrder = nil

		EventDispatcher.Dispatch(EventID.OnBattleUnitOrderComplete)
	end
end

function BattleTeamActionModule.SendMoveOrder(battlePos)
	BattleTeamActionModule.__StopStandbyTimer()

	BattleTeamActionModule.__enableOrderInput = false

	local moveOrder = BattleOrderData.CreateOrder(BattleConstant.BattleOrderType.Move, BattleTeamActionModule.__manualOperateID, BattleTeamActionModule.battleRound)

	moveOrder.BattlePos = battlePos

	BattleLogicAdapter.Instance:AddBattleOrderFromLua(BattleLogicAdapter.ORDER_MOVE_POS, moveOrder:ToDic())
end

function BattleTeamActionModule.OnMoveOrderComplete()
	if BattleTeamActionModule.__curState ~= BattleConstant.BattleTeamActionState.ManualOperate then
		return
	end

	BattleTeamActionModule.__enableOrderInput = true

	BattleTeamActionModule.__StartStandbyTimer(BattleTeamActionModule.__manualOperateID)
	EventDispatcher.Dispatch(EventID.RefreshBattleTileMoveStateShow, BattleTeamActionModule.__manualOperateID)

	local skillCid = BattleTeamActionModule.__tempCastSkillOrder.SkillCid

	BattleSkillModule.ShowManualChooseSkill(BattleTeamActionModule.__manualOperateID, skillCid)
end

function BattleTeamActionModule.__SendAutoFightOrder(battleUnitID)
	BattleTeamActionModule.__StopStandbyTimer()
	BattleTeamActionModule.__UpdateCurState(BattleConstant.BattleTeamActionState.WaitPerform)

	local autoFightOrder = BattleOrderData.CreateAutoFightOrder(battleUnitID, BattleTeamActionModule.battleRound)

	BattleLogicAdapter.Instance:AddBattleOrderFromLua(BattleLogicAdapter.ORDER_CAST_SKILL, autoFightOrder)
end

function BattleTeamActionModule.OnSendCastSkillOrder()
	BattleTeamActionModule.__SendCastSkillOrder()
end

function BattleTeamActionModule.__SendCastSkillOrder()
	local castSkillOrder = BattleTeamActionModule.__tempCastSkillOrder

	if castSkillOrder == nil then
		return
	end

	local state = BattleSkillModule.CheckCanCastSkill(castSkillOrder.BattleUnitID, castSkillOrder.SkillCid)
	local noticeCid = 0

	if state == BattleConstant.CastSkillCheckResult.EnergyNotEnough then
		noticeCid = 31010004
	elseif state == BattleConstant.CastSkillCheckResult.EnergyNotEnough then
		noticeCid = 31010001
	elseif state == BattleConstant.CastSkillCheckResult.Sealed then
		noticeCid = 31010005
	elseif state == BattleConstant.CastSkillCheckResult.InCD then
		noticeCid = 31010006
	elseif state == BattleConstant.CastSkillCheckResult.InCommonCD then
		noticeCid = 31010006
	end

	if noticeCid ~= 0 then
		NoticeModule.ShowNotice(noticeCid)

		return
	end

	BattleTeamActionModule.__StopStandbyTimer()
	BattleTeamActionModule.__UpdateCurState(BattleConstant.BattleTeamActionState.WaitPerform)
	castSkillOrder:SetTarget(0)
	BattleLogicAdapter.Instance:AddBattleOrderFromLua(BattleLogicAdapter.ORDER_CAST_SKILL, castSkillOrder:ToDic())
end

function BattleTeamActionModule.SendPreviewSkillOrder(skillCid)
	local order = BattleOrderData.CreateOrder(BattleConstant.BattleOrderType.PreviewSkill, BattleTeamActionModule.__manualOperateID, BattleTeamActionModule.battleRound)

	order:SetSkillCid(skillCid)
	BattleLogicAdapter.Instance:AddBattleOrderFromLua(BattleLogicAdapter.ORDER_PREVIEW_SKILL, order:ToDic())
end

function BattleTeamActionModule.SendBattleUnitChangeAITypeOrder(battleUnitID, aiType)
	local order = BattleOrderData.CreateOrder(BattleConstant.BattleOrderType.StatusSwitch, battleUnitID, BattleTeamActionModule.battleRound)

	order:SetStatus(aiType)
	BattleLogicAdapter.Instance:AddBattleOrderFromLua(BattleLogicAdapter.ORDER_AI_SWITCH, order:ToDic())
end

function BattleTeamActionModule.__StartStandbyTimer(turnUnitID)
	if turnUnitID == 0 then
		return
	end

	BattleTeamActionModule.__StopStandbyTimer()

	BattleTeamActionModule.standbyTimer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.Battle, function()
		CVModule.PlayCV(Constant.CVActionType.FightRest, BattleModule.GetBattleUnitDataByUnitID(turnUnitID):GetHeroCid())
	end, BattleApi:BattleActorStandbyTimer(), -1, false)

	BattleTeamActionModule.standbyTimer:Start()
end

function BattleTeamActionModule.__StopStandbyTimer()
	if BattleTeamActionModule.standbyTimer == nil then
		return
	end

	BattleTeamActionModule.standbyTimer:Stop()

	BattleTeamActionModule.standbyTimer = nil
end
