-- chunkname: @modules/logic/qgameplay/behavior/base/BehaviorQNode.lua

module("modules.logic.qgameplay.behavior.base.BehaviorQNode", package.seeall)

local BehaviorQNode = class("BehaviorQNode", QObject)

function BehaviorQNode:onEnable()
	self.nextNodes = nil
	self.executeListen = nil
	self.executeEndListen = nil
	self.isBehaviorSuccess = nil
	self.behaviorTimeS = nil
	self.isManageGoToNext = nil
	self.index = nil
end

function BehaviorQNode:disable()
	if BehaviorQNode.super.disable(self) then
		self:endExecute()
	end
end

function BehaviorQNode:next(node)
	self.nextNodes = self.nextNodes or {}

	table.insert(self.nextNodes, node)
end

function BehaviorQNode:execute()
	if self.isExecute then
		return
	end

	if not self.isEnable then
		self:enable()
	end

	self.isExecute = true

	if self.executeListen then
		for i, v in ipairs(self.executeListen) do
			if v.callBack then
				v.callBack(v.callBackContext, self)
			end
		end
	end

	self:onExecute()

	return true
end

function BehaviorQNode:endExecute()
	if not self.isExecute then
		return
	end

	self.isExecute = false

	self:cleanEventsByPos(3)
	self:cleanTimersByPos(3)
	self:onExecuteEnd()

	return true
end

function BehaviorQNode:onExecute()
	return
end

function BehaviorQNode:onExecuteEnd()
	return
end

function BehaviorQNode:done(success)
	if success == nil then
		success = true
	end

	self.isBehaviorSuccess = success

	if self.behaviorTimeS and self.behaviorTimeS > 0 then
		self.runDelay(self, self._onDoneDelayed, self, self.behaviorTimeS)
	else
		self:onDone(success)
	end
end

function BehaviorQNode:_onDoneDelayed()
	self:onDone(self.isBehaviorSuccess)
end

function BehaviorQNode:onDone(success)
	self:disable()

	if self.executeEndListen then
		for i, v in ipairs(self.executeEndListen) do
			if v.callBack then
				v.callBack(v.callBackContext, success, self)
			end
		end
	end

	if not self.isManageGoToNext then
		if not success then
			return
		end

		self:goToNext()
	end
end

function BehaviorQNode:goToNext()
	if self.nextNodes then
		for i, v in ipairs(self.nextNodes) do
			v:execute()
		end
	end
end

function BehaviorQNode:addListenExecute(callBack, callBackContext)
	self.executeListen = self.executeListen or {}

	table.insert(self.executeListen, {
		callBack = callBack,
		callBackContext = callBackContext
	})
end

function BehaviorQNode:removeListenExecute(callBack, callBackContext)
	if not self.executeListen then
		return
	end

	for i, v in ipairs(self.executeListen) do
		if v.callBack == callBack and v.callBackContext == callBackContext then
			table.remove(self.executeListen, i)

			return
		end
	end
end

function BehaviorQNode:addListenExecuteEnd(callBack, callBackContext)
	self.executeEndListen = self.executeEndListen or {}

	table.insert(self.executeEndListen, {
		callBack = callBack,
		callBackContext = callBackContext
	})
end

function BehaviorQNode:removeListenExecuteEnd(callBack, callBackContext)
	if not self.executeEndListen then
		return
	end

	for i, v in ipairs(self.executeEndListen) do
		if v.callBack == callBack and v.callBackContext == callBackContext then
			table.remove(self.executeEndListen, i)

			return
		end
	end
end

function BehaviorQNode:getEventsTbsByState()
	local key = self.isExecute and 3 or self.isEnable and 1 or 2

	self._eventsDic[key] = self._eventsDic[key] or {}

	return self._eventsDic[key]
end

function BehaviorQNode:getTimersByState()
	local key = self.isExecute and 3 or self.isEnable and 1 or 2

	self._timersDic[key] = self._timersDic[key] or {}

	return self._timersDic[key]
end

function BehaviorQNode:trackback(msg)
	BehaviorQNode.super.trackback(self, msg)

	if self.isExecute then
		self:done()
	end
end

return BehaviorQNode
