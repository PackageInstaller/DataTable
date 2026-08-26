-- chunkname: @modules/logic/versionactivity3_7/travelgo/battle/behavior/node/base/TravelGoBehaviorNode.lua

module("modules.logic.versionactivity3_7.travelgo.battle.behavior.node.base.TravelGoBehaviorNode", package.seeall)

local TravelGoBehaviorNode = class("TravelGoBehaviorNode", TravelGoBase)

function TravelGoBehaviorNode:ctor(data)
	TravelGoBehaviorNode.super.ctor(self, data)

	self.nextNodes = {}
	self.callBack = nil
	self.callBackContext = nil
end

function TravelGoBehaviorNode:setData(data)
	self._time = data._time

	TravelGoBehaviorNode.super.setData(self, data)
end

function TravelGoBehaviorNode:next(node)
	table.insert(self.nextNodes, node)
end

function TravelGoBehaviorNode:complete(callBack, callBackContext)
	self.callBack = callBack
	self.callBackContext = callBackContext
end

function TravelGoBehaviorNode:removeComplete(callBack, callBackContext)
	self.callBack = nil
	self.callBackContext = nil
end

function TravelGoBehaviorNode:setInterruptFunc(func, context)
	self.interruptFunc = func
	self.interruptFuncContext = context
end

function TravelGoBehaviorNode:enable()
	TravelGoBehaviorNode.super.enable(self)
end

function TravelGoBehaviorNode:disable()
	TaskDispatcher.cancelTask(self.onDone, self)
	TravelGoBehaviorNode.super.disable(self)
end

function TravelGoBehaviorNode:done(time)
	time = time or self._time

	if time then
		TaskDispatcher.runDelay(self.onDone, self, time)
	else
		self:onDone()
	end
end

function TravelGoBehaviorNode:onDone()
	logNormal(string.format("小瑞安依 Behavior 完成节点 %s", self.__cname))
	TaskDispatcher.cancelTask(self.onDone, self)
	self:disable()

	if self.callBack then
		self.callBack(self.callBackContext)
	end

	if self.interruptFunc and self.interruptFunc(self.interruptFuncContext) then
		return
	end

	for i, v in ipairs(self.nextNodes) do
		v:enable()
	end
end

function TravelGoBehaviorNode:trackback(msg)
	TravelGoBehaviorNode.super.trackback(self, msg)
	self:done()
end

return TravelGoBehaviorNode
