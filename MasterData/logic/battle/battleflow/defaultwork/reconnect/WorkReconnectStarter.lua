-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/defaultwork/reconnect/WorkReconnectStarter.lua

module("logic.battle.battleflow.defaultwork.reconnect.WorkReconnectStarter", package.seeall)

local WorkReconnectStarter = class("WorkReconnectStarter", WorkBase)

function WorkReconnectStarter:onEnter(context)
	if BattleLog.enableLog then
		BattleLog.log("WorkReconnectStarter start")
	end

	self:_startFromCurrentNode()
	self:onDone(WorkResult.Succeed)
end

function WorkReconnectStarter:_startFromCurrentNode()
	local model = BattleMgr.instance:getModel()
	local battleFieldInfo = model:getBattleFieldInfo()
	local stepCampId = battleFieldInfo.stepCampId
	local localLogic = BattleMgr.instance:getLocalLogic()

	localLogic:handlePlayerStarted(stepCampId)

	local cmdExecuter = BattleMgr.instance:getCmdExecuter()

	cmdExecuter:addCommand(BattlePostEventAnimationCommand:createInstance())
	cmdExecuter:submit()
end

return WorkReconnectStarter
