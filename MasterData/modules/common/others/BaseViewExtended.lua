-- chunkname: @modules/common/others/BaseViewExtended.lua

module("modules.common.others.BaseViewExtended", package.seeall)

local BaseViewExtended = class("BaseViewExtended", BaseView)

BaseViewExtended.ViewState = {
	Dead = 3,
	Close = 2,
	Open = 1
}

function BaseViewExtended:ctor(...)
	self:__onInit()
	BaseViewExtended.super.ctor(self, ...)
end

function BaseViewExtended:initViewGOInternal(parent_obj)
	self.viewGO_parent_obj = parent_obj
	self.VIEW_STATE = BaseViewExtended.ViewState.Open

	self:logicStartInternal()
end

function BaseViewExtended:logicStartInternal()
	if self.viewGO then
		self:viewLogicBootInternal()
	else
		self:definePrefabUrl()

		if self.internal_pre_url then
			self:com_loadAsset(self.internal_pre_url, self.viewGOLoadFinishCallbackInternal)
		else
			self:viewLogicBootInternal()
		end
	end
end

function BaseViewExtended:viewGOLoadFinishCallbackInternal(loader)
	if self.VIEW_STATE == BaseViewExtended.ViewState.Dead then
		return
	end

	local tarPrefab = loader:GetResource()

	self.viewGO = gohelper.clone(tarPrefab, self.viewGO_parent_obj)

	self:viewLogicBootInternal()
end

function BaseViewExtended:viewLogicBootInternal()
	self.INIT_FINISH_INTERNAL = true

	self:onInitViewInternal()
	self:addEventsInternal()

	if self.VIEW_STATE == BaseViewExtended.ViewState.Open then
		self:bootOnOpenInternal()
	else
		self:setViewVisibleInternal(false)
	end
end

function BaseViewExtended:openExclusiveView(sign, exclusive_id, view, viewGO, parent_obj, ...)
	if not self.exclusive_tab then
		self.exclusive_tab = {}
		self.exclusive_opening = {}
	end

	sign = sign or 1
	self.exclusive_tab[sign] = self.exclusive_tab[sign] or {}

	local cur_opening_view = self.exclusive_tab[sign][self.exclusive_opening[sign]]

	if cur_opening_view then
		if exclusive_id == self.exclusive_opening[sign] then
			return cur_opening_view
		end

		self:hideExclusiveView(cur_opening_view, sign, exclusive_id)
	end

	if self.exclusive_tab[sign][exclusive_id] then
		self:setExclusiveViewVisible(self.exclusive_tab[sign][exclusive_id], true)

		self.exclusive_opening[sign] = exclusive_id

		return self.exclusive_tab[sign][exclusive_id]
	end

	cur_opening_view = self:openSubView(view, viewGO, parent_obj, ...)
	cur_opening_view.internalExclusiveSign = sign
	cur_opening_view.internalExclusiveID = exclusive_id
	self.exclusive_tab[sign][exclusive_id] = cur_opening_view
	self.exclusive_opening[sign] = exclusive_id

	return cur_opening_view
end

function BaseViewExtended:hideExclusiveGroup(sign)
	sign = sign or 1

	if self.exclusive_opening and self.exclusive_opening[sign] then
		self:hideExclusiveView(self.exclusive_tab[sign][self.exclusive_opening[sign]])
	end
end

function BaseViewExtended:hideExclusiveView(handler, sign, exclusive_id)
	sign = sign or 1
	handler = handler or self.exclusive_tab[sign][exclusive_id]

	if self.exclusive_opening[handler.internalExclusiveSign] == handler.internalExclusiveID then
		self.exclusive_opening[handler.internalExclusiveSign] = nil
	end

	self:setExclusiveViewVisible(handler, false)
end

function BaseViewExtended:setExclusiveViewVisible(handler, state)
	if handler.onSetExclusiveViewVisible then
		handler:onSetExclusiveViewVisible(state)
	else
		handler:setViewVisibleInternal(state)
	end
end

function BaseViewExtended:openSubView(view, viewGO, parent_obj, ...)
	self._childViews = self._childViews or {}

	local target_view = view.New(...)

	if target_view.onRefreshViewParam then
		target_view:onRefreshViewParam(...)
	end

	if type(viewGO) == "string" then
		target_view.internal_pre_url = viewGO
		viewGO = nil
	end

	target_view.viewName = self.viewName
	target_view.viewContainer = self.viewContainer
	target_view.PARENT_VIEW = self

	if target_view.initViewGOInternal then
		target_view.viewGO = viewGO

		target_view:initViewGOInternal(parent_obj or self.viewGO, self)
	else
		target_view:__onInit()

		target_view.viewGO = viewGO

		if self._has_onInitView then
			target_view:onInitViewInternal()
		end

		if self._has_addEvents then
			target_view:addEventsInternal()
		end

		if self._has_onOpen then
			target_view:onOpenInternal()
		end

		if self._has_onOpenFinish then
			target_view:onOpenFinishInternal()
		end
	end

	table.insert(self._childViews, target_view)

	return target_view
end

function BaseViewExtended:bootOnOpenInternal()
	if self:viewIsReadyInternal() then
		self:onOpenInternal()
		self:onOpenFinishInternal()
	end
end

function BaseViewExtended:setViewVisible(state)
	self:setViewVisibleInternal(state)
end

function BaseViewExtended:onCloseInternal()
	self.VIEW_STATE = BaseViewExtended.ViewState.Close

	self:invokeChildFunc("onCloseInternal")
	self:releaseComponentsInternal()

	if self.viewGO then
		self:onClose()
	end
end

function BaseViewExtended:onCloseFinishInternal()
	self:invokeChildFunc("onCloseFinishInternal")

	if self.viewGO then
		self:onCloseFinish()
	end
end

function BaseViewExtended:removeEventsInternal()
	self:invokeChildFunc("removeEventsInternal")

	if self.viewGO then
		self:removeEvents()
	end
end

function BaseViewExtended:onDestroyViewInternal()
	self.VIEW_STATE = BaseViewExtended.ViewState.Dead

	self:invokeChildFunc("onDestroyViewInternal")

	if self.viewGO then
		self:onDestroyView()
		gohelper.destroy(self.viewGO)
	end

	self:__onDispose()
end

function BaseViewExtended:invokeChildFunc(funcName)
	if self._childViews then
		for k, v in ipairs(self._childViews) do
			if v[funcName] then
				v[funcName](v)
			end
		end
	end
end

function BaseViewExtended:destroySubView(handler)
	self:removeChildViewIndex(handler)
	self:playDestroyBehaviour(handler)
end

function BaseViewExtended:removeChildViewIndex(handler)
	for i = #self._childViews, 1, -1 do
		if self._childViews[i] == handler then
			table.remove(self._childViews, i)

			break
		end
	end
end

function BaseViewExtended:playDestroyBehaviour(handler)
	if handler.viewGO then
		handler:onCloseInternal()
		handler:onCloseFinishInternal()
		handler:removeEventsInternal()
		handler:onDestroyViewInternal()
	else
		handler.VIEW_STATE = BaseViewExtended.ViewState.Dead

		if handler.releaseComponentsInternal then
			handler:releaseComponentsInternal()
		end

		handler:__onDispose()
	end
end

function BaseViewExtended:DESTROYSELF()
	self:getParentView():destroySubView(self)
end

function BaseViewExtended:killAllChildView()
	if self._childViews then
		for i, v in ipairs(self._childViews) do
			self:playDestroyBehaviour(v)
		end
	end

	self._childViews = {}
end

function BaseViewExtended:setViewVisibleInternal(state)
	if self.visible_internal == state then
		return
	end

	self.visible_internal = state

	if not self:viewIsReadyInternal() then
		return
	end

	if self.viewGO then
		self.canvasGroup_internal = self.canvasGroup_internal or gohelper.onceAddComponent(self.viewGO, typeof(UnityEngine.CanvasGroup))
		self.canvasGroup_internal.alpha = state and 1 or 0
		self.canvasGroup_internal.interactable = state
		self.canvasGroup_internal.blocksRaycasts = state
	end
end

function BaseViewExtended:registComponent(clsDefine)
	self.components_internal = self.components_internal or {}

	if self.components_internal[clsDefine.__cname] then
		return self.components_internal[clsDefine.__cname]
	end

	local comp = clsDefine.New()

	comp.parentClass = self
	self.components_internal[clsDefine.__cname] = comp

	return self.components_internal[clsDefine.__cname]
end

function BaseViewExtended:releaseComponentsInternal()
	if self.components_internal then
		for k, v in pairs(self.components_internal) do
			if v.releaseSelf then
				v:releaseSelf()
			end
		end
	end

	self.components_internal = nil
end

function BaseViewExtended:getParentView()
	return self.PARENT_VIEW
end

function BaseViewExtended:getParentObj()
	return self.viewGO_parent_obj
end

function BaseViewExtended:getChildViews()
	return self._childViews
end

function BaseViewExtended:viewIsReadyInternal()
	return self.INIT_FINISH_INTERNAL
end

function BaseViewExtended:definePrefabUrl()
	return
end

function BaseViewExtended:setPrefabUrl(url)
	self.internal_pre_url = url
end

function BaseViewExtended:onRefreshViewParam(...)
	return
end

function BaseViewExtended:com_loadAsset(url, call_back, failedCallback, param)
	local comp = self:registComponent(LoaderComponent)

	comp:loadAsset(url, call_back, self, failedCallback, param)
end

function BaseViewExtended:com_loadListAsset(urlList, oneCallback, finishCallback, oneFailedCallback, listFailedCallback)
	local comp = self:registComponent(LoaderComponent)

	comp:loadListAsset(urlList, oneCallback, finishCallback, self, oneFailedCallback, listFailedCallback)
end

function BaseViewExtended:com_createObjList(callback, data, parent_obj, model_obj, component, delay_time, create_count)
	local comp = self:registComponent(UICloneComponent)

	comp:createObjList(self, callback, data, parent_obj, model_obj, component, delay_time, create_count)
end

function BaseViewExtended:com_registScrollView(obj_root, scroll_param)
	local comp = self:registComponent(UISimpleScrollViewComponent)

	return comp:registScrollView(obj_root, scroll_param)
end

function BaseViewExtended:com_registSimpleScrollView(obj_root, scrollDir, lineCount)
	local comp = self:registComponent(UISimpleScrollViewComponent)

	return comp:registSimpleScrollView(obj_root, scrollDir, lineCount)
end

return BaseViewExtended
