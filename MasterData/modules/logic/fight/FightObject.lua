-- chunkname: @modules/logic/fight/FightObject.lua

module("modules.logic.fight.FightObject", package.seeall)

local FightObject = class("FightObject")
local __G__TRACKBACK__ = __G__TRACKBACK__
local xpcall = xpcall
local rawget = rawget

FightObject.Counter = 0

function FightObject:onConstructor(...)
	FightObject.Counter = FightObject.Counter + 1
	self.INSTANTIATE_CLASS_LIST = nil
	self.COMPONENT_LIST = nil
	self.IS_RELEASING = nil
	self.IS_DISPOSED = nil
end

function FightObject:onLogicEnter(...)
	return
end

function FightObject:onLogicExit()
	return
end

function FightObject:onDestructor()
	if self.COMPONENT_LIST then
		local list = self.COMPONENT_LIST

		for i = self.COMP_COUNT, 1, -1 do
			local comp = list[i]

			if not comp.IS_DISPOSED then
				comp:disposeSelf()
			end
		end

		self.COMPONENT_LIST = nil
	end

	self.INSTANTIATE_CLASS_LIST = nil
end

function FightObject:onDestructorFinish()
	return
end

function FightObject:__isActive()
	return not self.IS_DISPOSED and not self.IS_RELEASING
end

function FightObject:newClass(class, ...)
	if self.IS_DISPOSED or self.IS_RELEASING then
		logError("生命周期已经结束了,但是又调用注册类的方法,请检查代码,类名:" .. self.__cname)
	end

	if not self.INSTANTIATE_CLASS_LIST then
		self.INSTANTIATE_CLASS_LIST = {}
		self.OBJ_COUNT = 0
	end

	local obj = setmetatable({}, class)

	obj.class = class
	obj.PARENT_ROOT_OBJECT = self
	self.OBJ_COUNT = self.OBJ_COUNT + 1
	self.INSTANTIATE_CLASS_LIST[self.OBJ_COUNT] = obj

	obj:ctor(...)

	return obj
end

function FightObject:addComponent(clsDefine, ...)
	if self.IS_DISPOSED then
		logError("生命周期已经结束了,但是又调用了添加组件的方法,请检查代码,类名:" .. self.__cname)
	end

	if not self.COMPONENT_LIST then
		self.COMPONENT_LIST = {}
		self.COMP_COUNT = 0
	end

	local comp = setmetatable({}, clsDefine)

	comp.class = clsDefine
	comp.PARENT_ROOT_OBJECT = self
	self.COMP_COUNT = self.COMP_COUNT + 1
	self.COMPONENT_LIST[self.COMP_COUNT] = comp

	comp:ctor(...)

	return comp
end

function FightObject:removeComponent(comp)
	if not comp then
		return
	end

	comp:disposeSelf()
end

function FightObject:disposeSelf()
	if self.IS_DISPOSED then
		return
	end

	self.IS_DISPOSED = true

	local gameObject = self.GAMEOBJECT

	xpcall(self.disposeSelfInternal, __G__TRACKBACK__, self)

	if gameObject then
		gohelper.destroy(gameObject)
	end
end

function FightObject:ctor(...)
	self.initializationInternal(self, self.class, self, ...)

	return self:onLogicEnter(...)
end

function FightObject:initializationInternal(class, handle, ...)
	local super = class.super

	if super then
		self:initializationInternal(super, handle, ...)
	end

	local func = rawget(class, "onConstructor")

	if func then
		return func(handle, ...)
	end
end

function FightObject:disposeSelfInternal()
	if not self.IS_RELEASING then
		if self.PARENT_ROOT_OBJECT then
			self.PARENT_ROOT_OBJECT:clearDeadInstantiatedClass()
		end

		self:markReleasing()
		self:releaseChildRoot()
	end

	xpcall(self.onLogicExit, __G__TRACKBACK__, self)
	self.destructorInternal(self, self.class, self)

	return xpcall(self.onDestructorFinish, __G__TRACKBACK__, self)
end

function FightObject:clearDeadInstantiatedClass()
	if self.IS_DISPOSED then
		return
	end

	if self.CLEARTIMER then
		return
	end

	self.CLEARTIMER = self:com_registRepeatTimer(self.internalClearDeadInstantiatedClass, 1, 1)
end

function FightObject:internalClearDeadInstantiatedClass()
	if self.IS_DISPOSED then
		logError("生命周期已经结束了,但是又调用了清除已经死亡的类的方法,请检查代码,类名:" .. self.__cname)
	end

	self.CLEARTIMER = nil

	local list = self.INSTANTIATE_CLASS_LIST

	if list then
		local j = 1

		for i = 1, self.OBJ_COUNT do
			local obj = list[i]

			if not obj.IS_DISPOSED then
				if i ~= j then
					list[j] = obj
					list[i] = nil
				end

				j = j + 1
			else
				list[i] = nil
			end
		end

		self.OBJ_COUNT = j - 1
	end
end

function FightObject:markReleasing()
	local root = self

	while root do
		local childList = root.INSTANTIATE_CLASS_LIST

		root.IS_RELEASING = root.IS_RELEASING or 0

		local markIndex = root.IS_RELEASING + 1
		local childRoot = childList and childList[markIndex]

		if not childRoot then
			if root == self then
				return
			end

			root = root.PARENT_ROOT_OBJECT
		else
			root.IS_RELEASING = markIndex

			if not childRoot.IS_RELEASING then
				root = childRoot
			end
		end
	end
end

function FightObject:releaseChildRoot()
	local root = self

	while root do
		local childList = root.INSTANTIATE_CLASS_LIST

		if not root.DISPOSEINDEX then
			if childList then
				root.DISPOSEINDEX = root.OBJ_COUNT + 1 or 1
			end
		end

		local disposeIndex = root.DISPOSEINDEX - 1
		local childRoot = childList and childList[disposeIndex]

		if not childRoot then
			if root == self then
				return
			end

			if not root.IS_DISPOSED then
				root:disposeSelf()
			end

			root = root.PARENT_ROOT_OBJECT
		else
			root.DISPOSEINDEX = disposeIndex

			if not childRoot.DISPOSEINDEX then
				root = childRoot
			end
		end
	end
end

function FightObject:destructorInternal(class, handle)
	local func = rawget(class, "onDestructor")

	if func then
		xpcall(func, __G__TRACKBACK__, handle)
	end

	local super = class.super

	if super then
		return self:destructorInternal(super, handle)
	end
end

return FightObject
