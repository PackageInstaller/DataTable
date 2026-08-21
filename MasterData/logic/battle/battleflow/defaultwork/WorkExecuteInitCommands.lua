-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/defaultwork/WorkExecuteInitCommands.lua

module("logic.battle.battleflow.defaultwork.WorkExecuteInitCommands", package.seeall)

local WorkExecuteInitCommands = class("WorkExecuteInitCommands", WorkBase)

function WorkExecuteInitCommands:onEnter(context)
	context:handleBeforeInitCommands()
	WorkExecuteInitCommands:executeInitCommands()
	self:onDone(WorkResult.Succeed)
end

function WorkExecuteInitCommands:executeInitCommands()
	local model = BattleMgr.instance:getModel()
	local cmdExecuter = BattleMgr.instance:getCmdExecuter()
	local battleFieldInfo = model:getBattleFieldInfo()
	local initCommands = battleFieldInfo.initCommands

	for _, cmd in ipairs(initCommands) do
		cmdExecuter:addCommand(cmd)
	end

	cmdExecuter:submit()
	BattleTableUtil.clearTable(initCommands)
end

function WorkExecuteInitCommands:onExit(isInterrupt)
	return
end

return WorkExecuteInitCommands
