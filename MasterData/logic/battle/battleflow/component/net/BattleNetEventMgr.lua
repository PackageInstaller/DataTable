-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/net/BattleNetEventMgr.lua

module("logic.battle.battleflow.component.net.BattleNetEventMgr", package.seeall)

local BattleNetEventMgr = class("BattleNetEventMgr", IBattleFlowComp)

function BattleNetEventMgr:onInit()
	self._cmdParser = BattleCmdParser.New()
end

function BattleNetEventMgr:onStart()
	self:_setEvent(true)

	self._settingModel = self.flow.settingModel or false
	self._cmdExecuter = self.flow.cmdExecuter or false
	self._isInEventProgress = false
	self._eventNOList = {}
end

function BattleNetEventMgr:onClear()
	self:_setEvent(false)

	self._settingModel = false
	self._cmdExecuter = false
	self._isInEventProgress = false

	self._cmdParser:internal_clear()
	BattleTableUtil.clearTable(self._eventNOList)
end

function BattleNetEventMgr:setCommandClass(cmd, cmdClass)
	self._cmdParser:internal_setCommandClass(cmd, cmdClass)
end

function BattleNetEventMgr:clearCommandClass(cmd)
	self._cmdParser:internal_clearCommandClass(cmd)
end

function BattleNetEventMgr:_setEvent(add)
	if add then
		BattleDispatcher:addEventListener(BattleEventType.ON_RECEIVE_NET_EVENT, self._onReceiveNetEvent, self)
	else
		BattleDispatcher:removeEventListener(BattleEventType.ON_RECEIVE_NET_EVENT, self._onReceiveNetEvent, self)
	end
end

function BattleNetEventMgr:_onReceiveNetEvent(eventId, eventNOList)
	if not self._cmdExecuter then
		return
	end

	if eventNOList and #eventNOList > 0 then
		self._isInEventProgress = true

		for _, eventNO in ipairs(eventNOList) do
			table.insert(self._eventNOList, eventNO)
		end

		self._cmdParser:internal_begin()
		self._cmdParser:pushCmdContainer(self._cmdExecuter)
		self:tryNextEvent()
	end
end

function BattleNetEventMgr:tryNextEvent()
	if not self._isInEventProgress then
		return
	end

	if #self._eventNOList <= 0 then
		self._isInEventProgress = false

		self:_judgeLastCommand()

		if BattleLog.enableLog then
			BattleLog.log("BattleNetEventMgr::eventNOList is empty")
		end

		return
	end

	local eventNO = table.remove(self._eventNOList, 1)

	BattleCmdUtil.parseServerCommand(self._cmdParser, eventNO)
	self._cmdParser:submit()
end

function BattleNetEventMgr:clearNetEvents()
	self._isInEventProgress = false

	BattleTableUtil.clearTable(self._eventNOList)
end

function BattleNetEventMgr:_judgeLastCommand()
	if self._settingModel:isRequestUndo() then
		BattleChangeUndoViewStateCommand:checkAndOpenUndo()
	else
		self._cmdParser:addCommand(BattlePostEventAnimationCommand:createInstance())
		self._cmdParser:submit()
	end
end

return BattleNetEventMgr
