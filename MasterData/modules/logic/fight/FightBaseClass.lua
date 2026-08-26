-- chunkname: @modules/logic/fight/FightBaseClass.lua

module("modules.logic.fight.FightBaseClass", package.seeall)

local FightBaseClass = class("FightBaseClass", FightObject)
local rawset = rawset
local pairs = pairs
local type = type
local table = table

function FightBaseClass:onConstructor()
	self.USER_DATA_LIST = nil
end

function FightBaseClass:onLogicEnter(...)
	return
end

function FightBaseClass:onLogicExit()
	return
end

function FightBaseClass:onDestructor()
	if self.USER_DATA_LIST then
		local list = self.USER_DATA_LIST

		for i = #list, 1, -1 do
			local tab = list[i]

			for key in pairs(tab) do
				rawset(tab, key, nil)
			end

			rawset(list, i, nil)
		end

		self.USER_DATA_LIST = nil
	end

	for k, v in pairs(self) do
		if type(v) == "userdata" then
			rawset(self, k, nil)
		end
	end
end

function FightBaseClass:onDestructorFinish()
	return
end

function FightBaseClass:newUserDataTable()
	if self.IS_DISPOSED then
		logError("生命周期已经结束了,但是又调用注册table的方法,请检查代码,类名:" .. self.__cname)
	end

	self.USER_DATA_LIST = self.USER_DATA_LIST or {}

	local tab = {}

	table.insert(self.USER_DATA_LIST, tab)

	return tab
end

function FightBaseClass:getUserDataTb_()
	return self:newUserDataTable()
end

function FightBaseClass:getComponent(clsDefine)
	if self.IS_DISPOSED then
		logError("生命周期已经结束了,但是又调用了获取组件的方法,请检查代码,类名:" .. self.__cname)
	end

	local className = clsDefine.__cname

	if self[className] then
		return self[className]
	end

	local comp = self:addComponent(clsDefine)

	self[className] = comp

	return comp
end

function FightBaseClass:killComponent(clsDefine)
	if not clsDefine then
		return
	end

	local className = clsDefine.__cname
	local myComp = self[className]

	if myComp then
		myComp:disposeSelf()

		self[className] = nil
	end
end

function FightBaseClass:com_loadAsset(url, call_back, param)
	local comp = self:getComponent(FightLoaderComponent)

	comp:loadAsset(url, call_back, self, param)
end

function FightBaseClass:com_loadListAsset(urlList, oneCallback, finishCallback, paramList)
	local comp = self:getComponent(FightLoaderComponent)

	comp:loadListAsset(urlList, oneCallback, finishCallback, self, paramList)
end

function FightBaseClass:com_registFlowSequence()
	return self:com_registCustomFlow(FightWorkFlowSequence)
end

function FightBaseClass:com_registFlowParallel()
	return self:com_registCustomFlow(FightWorkFlowParallel)
end

function FightBaseClass:com_registCustomFlow(customFlow)
	local comp = self:getComponent(FightFlowComponent)

	return comp:registCustomFlow(customFlow)
end

function FightBaseClass:com_registWork(class, ...)
	local comp = self:getComponent(FightWorkComponent)

	return comp:registWork(class, ...)
end

function FightBaseClass:com_playWork(class, ...)
	local comp = self:getComponent(FightWorkComponent)

	comp:playWork(class, ...)
end

function FightBaseClass:com_cancelTimer(timer)
	if not timer then
		return
	end

	timer.isDone = true
end

function FightBaseClass:com_registTimer(callback, time, param)
	return self:com_registRepeatTimer(callback, time, 1, param)
end

function FightBaseClass:com_registRepeatTimer(callback, time, repeatCount, param)
	local comp = self:getComponent(FightTimerComponent)

	return comp:registRepeatTimer(callback, self, time, repeatCount, param)
end

function FightBaseClass:com_registSingleTimer(callback, time, param)
	local comp = self:getComponent(FightTimerComponent)

	return comp:registSingleTimer(callback, self, time, 1, param)
end

function FightBaseClass:com_registSingleRepeatTimer(callback, time, repeatCount, param)
	local comp = self:getComponent(FightTimerComponent)

	return comp:registSingleTimer(callback, self, time, repeatCount, param)
end

function FightBaseClass:com_releaseSingleTimer(callback)
	local comp = self:getComponent(FightTimerComponent)

	return comp:releaseSingleTimer(callback)
end

function FightBaseClass:com_restartTimer(timerItem, time, param)
	return self:com_restartRepeatTimer(timerItem, time, 1, param)
end

function FightBaseClass:com_restartRepeatTimer(timerItem, time, repeatCount, param)
	if not timerItem.isDone then
		timerItem:restart(time, repeatCount, param)

		return
	end

	local comp = self:getComponent(FightTimerComponent)

	return comp:restartRepeatTimer(timerItem, time, repeatCount, param)
end

function FightBaseClass:com_registFightEvent(eventId, callback, priority)
	self:com_registEvent(FightController.instance, eventId, callback, priority)
end

function FightBaseClass:com_registEvent(ctrl, eventId, callback, priority)
	local comp = self:getComponent(FightEventComponent)

	comp:registEvent(ctrl, eventId, callback, self, priority)
end

function FightBaseClass:com_cancelFightEvent(eventId, callback)
	self:com_cancelEvent(FightController.instance, eventId, callback)
end

function FightBaseClass:com_cancelEvent(ctrl, eventId, callback)
	local comp = self:getComponent(FightEventComponent)

	comp:cancelEvent(ctrl, eventId, callback, self)
end

function FightBaseClass:com_sendFightEvent(eventId, ...)
	FightController.instance:dispatchEvent(eventId, ...)
end

function FightBaseClass:com_sendEvent(ctrl, eventId, ...)
	ctrl:dispatchEvent(eventId, ...)
end

function FightBaseClass:addEventCb(ctrlInstance, evtName, callback, cbObj, priority)
	local comp = self:getComponent(FightEventComponent)

	comp:registEvent(ctrlInstance, evtName, callback, cbObj, priority)
end

function FightBaseClass:removeEventCb(ctrlInstance, evtName, callback, cbObj)
	if not ctrlInstance or not evtName or not callback then
		logError("UserDataDispose:removeEventCb ctrlInstance or evtName or callback is null!")

		return
	end

	local comp = self:getComponent(FightEventComponent)

	comp:cancelEvent(ctrlInstance, evtName, callback, cbObj)
end

function FightBaseClass:com_registMsg(msgId, callback)
	local comp = self:getComponent(FightMsgComponent)

	return comp:registMsg(msgId, callback, self)
end

function FightBaseClass:com_removeMsg(msgItem)
	local comp = self:getComponent(FightMsgComponent)

	return comp:removeMsg(msgItem)
end

function FightBaseClass:com_sendMsg(msgId, ...)
	return FightMsgMgr.sendMsg(msgId, ...)
end

function FightBaseClass:com_replyMsg(msgId, reply)
	return FightMsgMgr.replyMsg(msgId, reply)
end

function FightBaseClass:com_registUpdate(func, param)
	local comp = self:getComponent(FightUpdateComponent)

	return comp:registUpdate(func, self, param)
end

function FightBaseClass:com_cancelUpdate(item)
	local comp = self:getComponent(FightUpdateComponent)

	return comp:cancelUpdate(item)
end

return FightBaseClass
