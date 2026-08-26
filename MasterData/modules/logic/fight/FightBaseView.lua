-- chunkname: @modules/logic/fight/FightBaseView.lua

module("modules.logic.fight.FightBaseView", package.seeall)

local FightBaseView = class("FightBaseView", FightBaseClass)

FightBaseView.IS_FIGHT_BASE_VIEW = true

function FightBaseView:onConstructor(...)
	self.inner_visible = true
	self.viewGO = nil
	self.viewContainer = nil
	self.viewParam = nil
	self.viewName = nil
	self.PARENT_VIEW = nil
end

function FightBaseView:setViewVisible(state)
	self:setViewVisibleInternal(state)
end

function FightBaseView:setViewVisibleInternal(state)
	if self.inner_visible == state then
		return
	end

	self.inner_visible = state

	if not self.viewGO then
		return
	end

	self.canvasGroup_internal = self.canvasGroup_internal or gohelper.onceAddComponent(self.viewGO, typeof(UnityEngine.CanvasGroup))
	self.canvasGroup_internal.alpha = state and 1 or 0
	self.canvasGroup_internal.interactable = state
	self.canvasGroup_internal.blocksRaycasts = state
end

function FightBaseView:inner_startView()
	self:onInitViewInternal()
	self:addEventsInternal()
	self:onOpenInternal()
	self:onOpenFinishInternal()
end

function FightBaseView:onInitViewInternal()
	self.INVOKED_OPEN_VIEW = true

	self:onInitView()
end

function FightBaseView:addEventsInternal()
	self:addEvents()
end

function FightBaseView:onOpenInternal()
	self:onOpen()
end

function FightBaseView:onOpenFinishInternal()
	self:onOpenFinish()
end

function FightBaseView:onUpdateParamInternal()
	self:onUpdateParam()
end

function FightBaseView:onClickModalMaskInternal()
	self:onClickModalMask()
end

function FightBaseView:inner_destroyView()
	self:onCloseInternal()
	self:onCloseFinishInternal()
	self:removeEventsInternal()
	self:onDestroyViewInternal()
end

function FightBaseView:onCloseInternal()
	self:onClose()
end

function FightBaseView:onCloseFinishInternal()
	self:onCloseFinish()
end

function FightBaseView:removeEventsInternal()
	self:removeEvents()
end

function FightBaseView:onDestroyViewInternal()
	self:onDestroyView()

	self.INVOKED_DESTROY_VIEW = true
end

function FightBaseView:onDestructor()
	if self.INVOKED_OPEN_VIEW and not self.INVOKED_DESTROY_VIEW then
		self:killComponent(FightViewComponent)
		self:inner_destroyView()
	end
end

function FightBaseView:__onInit()
	return
end

function FightBaseView:__onDispose()
	self:disposeSelf()
end

function FightBaseView:onInitView()
	return
end

function FightBaseView:addEvents()
	return
end

function FightBaseView:onOpen()
	return
end

function FightBaseView:onOpenFinish()
	return
end

function FightBaseView:onUpdateParam()
	return
end

function FightBaseView:onClickModalMask()
	return
end

function FightBaseView:onClose()
	return
end

function FightBaseView:onCloseFinish()
	return
end

function FightBaseView:removeEvents()
	return
end

function FightBaseView:onDestroyView()
	return
end

function FightBaseView:getResInst(resPath, parentGO, name)
	return self.viewContainer:getResInst(resPath, parentGO, name)
end

function FightBaseView:closeThis()
	ViewMgr.instance:closeView(self.viewName, nil, true)
end

function FightBaseView:tryCallMethodName(name)
	if name == "__onDispose" then
		self:__onDispose()
	end
end

function FightBaseView:isHasTryCallFail()
	return false
end

function FightBaseView:com_createObjList(callback, dataList, parentObj, opItem)
	if type(dataList) == "number" then
		local num = dataList

		dataList = {}

		for i = 1, num do
			table.insert(dataList, i)
		end
	end

	gohelper.CreateObjList(self, callback, dataList, parentObj, opItem)
end

function FightBaseView:com_registViewItemList(gameObject, itemClass, parentObject)
	local comp = self:getComponent(FightObjItemListComponent)

	return comp:registViewItemList(gameObject, itemClass, parentObject)
end

function FightBaseView:com_openSubView(view, viewGO, parent_obj, ...)
	local comp = self:getComponent(FightViewComponent)

	return comp:openSubView(view, viewGO, parent_obj, ...)
end

function FightBaseView:com_openSubViewForBaseView(view, viewGO, ...)
	local comp = self:getComponent(FightViewComponent)

	return comp:openSubViewForBaseView(view, viewGO, ...)
end

function FightBaseView:com_openExclusiveView(exclusive_id, view, viewGO, parent_obj, ...)
	local comp = self:getComponent(FightViewComponent)

	return comp:openExclusiveView(exclusive_id, view, viewGO, parent_obj, ...)
end

function FightBaseView:com_hideExclusiveGroup(sign)
	local comp = self:getComponent(FightViewComponent)

	return comp:hideExclusiveGroup(sign)
end

function FightBaseView:com_hideExclusiveView(handler, sign, exclusive_id)
	local comp = self:getComponent(FightViewComponent)

	return comp:hideExclusiveView(handler, sign, exclusive_id)
end

function FightBaseView:com_setExclusiveViewVisible(handler, state)
	local comp = self:getComponent(FightViewComponent)

	return comp:setExclusiveViewVisible(handler, state)
end

function FightBaseView:com_registClick(click, callback, param)
	local comp = self:getComponent(FightClickComponent)

	return comp:registClick(click, callback, self, param)
end

function FightBaseView:com_removeClick(click)
	local comp = self:getComponent(FightClickComponent)

	return comp:removeClick(click)
end

function FightBaseView:com_registDragBegin(drag, callback, param)
	local comp = self:getComponent(FightDragComponent)

	return comp:registDragBegin(drag, callback, self, param)
end

function FightBaseView:com_registDrag(drag, callback, param)
	local comp = self:getComponent(FightDragComponent)

	return comp:registDrag(drag, callback, self, param)
end

function FightBaseView:com_registDragEnd(drag, callback, param)
	local comp = self:getComponent(FightDragComponent)

	return comp:registDragEnd(drag, callback, self, param)
end

function FightBaseView:com_registLongPress(longPress, callback, param)
	local comp = self:getComponent(FightLongPressComponent)

	return comp:registLongPress(longPress, callback, self, param)
end

function FightBaseView:com_registHover(longPress, callback)
	local comp = self:getComponent(FightLongPressComponent)

	return comp:registHover(longPress, callback, self)
end

function FightBaseView:com_killTween(tweenId)
	if not tweenId then
		return
	end

	local comp = self:getComponent(FightTweenComponent)

	return comp:killTween(tweenId)
end

function FightBaseView:com_KillTweenByObj(obj, complete)
	local comp = self:getComponent(FightTweenComponent)

	return comp:KillTweenByObj(obj, complete)
end

function FightBaseView:com_scrollNumTween(text, start, final, duration, ease)
	local comp = self:getComponent(FightTweenComponent)

	return comp:scrollNumTween(text, start, final, duration, ease)
end

return FightBaseView
