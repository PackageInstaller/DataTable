-- chunkname: @modules/ugui/dropdown/DropDownExtend.lua

module("modules.ugui.dropdown.DropDownExtend", package.seeall)

local DropDownExtend = class("DropDownExtend", UserDataDispose)

function DropDownExtend.Get(goDrop)
	return DropDownExtend.New(goDrop)
end

DropDownExtend.DropListName = "Dropdown List"

function DropDownExtend:ctor(goDrop)
	self:__onInit()

	self.goDrop = goDrop
end

function DropDownExtend:init(onDropShowCb, onDropHideCb, cbObj)
	self.onDropShowCb = onDropShowCb
	self.onDropHideCb = onDropHideCb
	self.cbObj = cbObj

	self.addEventCb(self, GameStateMgr.instance, GameStateEvent.OnTouchScreenUp, self._onTouchUp, self)
end

function DropDownExtend:addEventsListener()
	GameObjectLiveMgr.instance:registerCallback(GameObjectLiveEvent.OnStart, self.triggerShow, self)
	GameObjectLiveMgr.instance:registerCallback(GameObjectLiveEvent.OnDestroy, self.OnDropListDestroy, self)
end

function DropDownExtend:removeEventsListener()
	GameObjectLiveMgr.instance:unregisterCallback(GameObjectLiveEvent.OnStart, self.triggerShow, self)
	GameObjectLiveMgr.instance:unregisterCallback(GameObjectLiveEvent.OnDestroy, self.OnDropListDestroy, self)
end

function DropDownExtend:_onTouchUp()
	local dropList = gohelper.findChild(self.goDrop, DropDownExtend.DropListName)

	self:addLiveComp(dropList)
end

function DropDownExtend:addLiveComp(dropList)
	if dropList == self.dropList then
		return
	end

	self.dropList = dropList

	if not gohelper.isNil(self.dropList) then
		self:addEventsListener()

		self.liveComp = MonoHelper.addLuaComOnceToGo(self.dropList, GameObjectLiveEventComp)
	end
end

function DropDownExtend:OnDropListDestroy(go)
	if self.dropList ~= go then
		return
	end

	self.liveComp = nil

	self:removeEventsListener()
	TaskDispatcher.runDelay(self.afterDestroyDelay, self, 0.01)
end

function DropDownExtend:afterDestroyDelay()
	local dropList = gohelper.findChild(self.goDrop, DropDownExtend.DropListName)

	if gohelper.isNil(dropList) then
		self:triggerHide()

		return
	end

	self:addLiveComp(dropList)
end

function DropDownExtend:triggerHide()
	if self.onDropHideCb then
		self.onDropHideCb(self.cbObj)
	end
end

function DropDownExtend:triggerShow(go)
	if self.dropList ~= go then
		return
	end

	if self.onDropShowCb then
		self.onDropShowCb(self.cbObj)
	end
end

function DropDownExtend:dispose()
	TaskDispatcher.cancelTask(self.afterDestroyDelay, self)

	self.liveComp = nil

	self:removeEventsListener()
	self:__onDispose()
end

return DropDownExtend
