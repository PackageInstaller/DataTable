-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/clientonly/BattleChangeUndoViewStateCommand.lua

module("logic.battle.battleflow.component.command.impl.clientonly.BattleChangeUndoViewStateCommand", package.seeall)

local BattleChangeUndoViewStateCommand = class("BattleChangeUndoViewStateCommand", BattleCommandBase)

function BattleChangeUndoViewStateCommand:waitOrExecuteCommand(isRequestOpen)
	local model = BattleMgr.instance:getModel()

	if model:getResultMO():isValid() then
		local cmdExecuter = BattleMgr.instance:getCmdExecuter()

		cmdExecuter:addCommand(BattleChangeUndoViewStateCommand:create(isRequestOpen))
		cmdExecuter:submit()

		return
	end

	local localLogic = BattleMgr.instance:getLocalLogic()

	if not localLogic:isOperateCamp() then
		if BattleLog.enableLog then
			BattleLog.log("[waitOrExecuteCommand change undo view state, current is not operate camp, request ignored]")
		end

		return
	end

	local settingModel = BattleMgr.instance:getSettingModel()

	if settingModel:isAutoBattle() then
		return
	end

	local cmdExecuter = BattleMgr.instance:getCmdExecuter()

	cmdExecuter:addCommand(BattleChangeUndoViewStateCommand:create(isRequestOpen))
	cmdExecuter:submit()
end

function BattleChangeUndoViewStateCommand:checkAndOpenUndo()
	local localLogic = BattleMgr.instance:getLocalLogic()

	if not localLogic:isOperateCamp() then
		if BattleLog.enableLog then
			BattleLog.log("[checkAndOpenUndo change undo view state, current is not operate camp, request ignored]")
		end

		local model = BattleMgr.instance:getModel()

		if not model:getResultMO():isValid() then
			BattleDispatcher:dispatchEvent(BattleEventType.OnRequestCloseUndoView)
		end

		return
	end

	local cmdExecuter = BattleMgr.instance:getCmdExecuter()

	cmdExecuter:addCommand(BattleChangeUndoViewStateCommand:create(true))
	cmdExecuter:submit()
end

function BattleChangeUndoViewStateCommand:create(isRequestOpen)
	local cmd = BattleChangeUndoViewStateCommand:createInstance()

	cmd:setRequestOpen(isRequestOpen)

	return cmd
end

function BattleChangeUndoViewStateCommand:onInit()
	self._isRequestOpen = false
end

function BattleChangeUndoViewStateCommand:onClear()
	self._isRequestOpen = false
end

function BattleChangeUndoViewStateCommand:execute(battleFlow)
	if self._isRequestOpen then
		local undoMgr = BattleMgr.instance:getUndoMgr()

		undoMgr:setupUndoEnvironment()
		self:finish(true)
	else
		self:_closeUndoViewDirectly()
	end
end

function BattleChangeUndoViewStateCommand:_closeUndoViewDirectly()
	local undoMgr = BattleMgr.instance:getUndoMgr()

	undoMgr:resetUndoEnvironment()
	self:finish(true)
end

function BattleChangeUndoViewStateCommand:toString()
	return string.format("[change undo view state, isRequestOpen = %s]", self._isRequestOpen)
end

function BattleChangeUndoViewStateCommand:setRequestOpen(isRequestOpen)
	self._isRequestOpen = isRequestOpen

	return self
end

return BattleChangeUndoViewStateCommand
