-- chunkname: @modules/logic/character/view/DecoratorSimpleItemBase.lua

module("modules.logic.character.view.DecoratorSimpleItemBase", package.seeall)

local DecoratorSimpleItemBase = class("DecoratorSimpleItemBase", RougeSimpleItemBase)

function DecoratorSimpleItemBase:ctor(...)
	DecoratorSimpleItemBase.super.ctor(self, ...)
end

function DecoratorSimpleItemBase:onDestroyView()
	DecoratorSimpleItemBase.super.onDestroyView(self)
end

function DecoratorSimpleItemBase:_bindObjImpl(assertCheckedClass, memName, optObj)
	if self[memName] == optObj then
		return
	end

	GameUtil.onDestroyViewMember(self, memName)

	if optObj == nil then
		return
	end

	assert(isTypeOf(optObj, assertCheckedClass), debug.traceback())

	self[memName] = optObj
end

function DecoratorSimpleItemBase.s_create(ThisClass, Self, srcGo, baseViewContainer)
	local item = ThisClass.New({
		parent = Self,
		baseViewContainer = baseViewContainer
	})

	item:init(srcGo)

	return item
end

function DecoratorSimpleItemBase.s_createByView(ThisClass, Self, srcGo)
	return (ThisClass.s_create(Self, srcGo, Self.viewContainer))
end

function DecoratorSimpleItemBase.s_createByListScrollCellExtend(ThisClass, Self, srcGo)
	local scrollView = Self._view

	if scrollView then
		return (ThisClass:s_create(srcGo, scrollView.viewContainer or Self.viewContainer))
	end
end

function DecoratorSimpleItemBase:setData(mo)
	DecoratorSimpleItemBase.super.setData(self, mo)

	return self
end

return DecoratorSimpleItemBase
