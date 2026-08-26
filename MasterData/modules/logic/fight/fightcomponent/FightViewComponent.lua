-- chunkname: @modules/logic/fight/fightcomponent/FightViewComponent.lua

module("modules.logic.fight.fightcomponent.FightViewComponent", package.seeall)

local FightViewComponent = class("FightViewComponent", FightBaseClass)

function FightViewComponent:onConstructor()
	self.inner_childViews = {}
end

function FightViewComponent:openSubView(view, viewGO, parent_obj, ...)
	if not view.IS_FIGHT_BASE_VIEW then
		return self:openSubViewForBaseView(view, viewGO, parent_obj, ...)
	end

	local parentRootClass = self.PARENT_ROOT_OBJECT
	local subView = self:newClass(view, ...)

	subView.viewName = parentRootClass.viewName
	subView.viewContainer = parentRootClass.viewContainer
	subView.PARENT_VIEW = parentRootClass

	if type(viewGO) == "string" then
		parent_obj = parent_obj or parentRootClass.viewGO

		self:com_loadAsset(viewGO, self._onViewGOLoadFinish, {
			handle = subView,
			parent_obj = parent_obj
		})
	else
		subView.viewGO = viewGO
		subView.GAMEOBJECT = viewGO

		subView:inner_startView()
	end

	table.insert(self.inner_childViews, subView)

	return subView
end

function FightViewComponent:_onViewGOLoadFinish(success, loader, param)
	if not success then
		return
	end

	local tarPrefab = loader:GetResource()
	local viewGO = gohelper.clone(tarPrefab, param.parent_obj)
	local subView = param.handle

	subView.viewGO = viewGO
	subView.GAMEOBJECT = viewGO

	subView:inner_startView()
end

function FightViewComponent:openSubViewForBaseView(view, viewGO, ...)
	self.inner_childForBaseView = self.inner_childForBaseView or {}

	local subView = view.New(...)

	subView.viewName = self.viewName
	subView.viewContainer = self.viewContainer
	subView.PARENT_VIEW = self

	subView:__onInit()

	subView.viewGO = viewGO

	subView:onInitViewInternal()
	subView:addEventsInternal()
	subView:onOpenInternal()
	subView:onOpenFinishInternal()
	table.insert(self.inner_childForBaseView, subView)

	return subView
end

function FightViewComponent:openExclusiveView(exclusive_id, view, viewGO, parent_obj, ...)
	return self:openSignExclusiveView(1, exclusive_id, view, viewGO, parent_obj, ...)
end

function FightViewComponent:openSignExclusiveView(sign, exclusive_id, view, viewGO, parent_obj, ...)
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

function FightViewComponent:hideExclusiveGroup(sign)
	sign = sign or 1

	if self.exclusive_opening and self.exclusive_opening[sign] then
		self:hideExclusiveView(self.exclusive_tab[sign][self.exclusive_opening[sign]])
	end
end

function FightViewComponent:hideExclusiveView(handler, sign, exclusive_id)
	sign = sign or 1
	handler = handler or self.exclusive_tab[sign][exclusive_id]

	if self.exclusive_opening[handler.internalExclusiveSign] == handler.internalExclusiveID then
		self.exclusive_opening[handler.internalExclusiveSign] = nil
	end

	self:setExclusiveViewVisible(handler, false)
end

function FightViewComponent:setExclusiveViewVisible(handler, state)
	if handler.onSetExclusiveViewVisible then
		handler:onSetExclusiveViewVisible(state)
	else
		handler:setViewVisibleInternal(state)
	end
end

function FightViewComponent:killAllSubView()
	if self.inner_childForBaseView then
		for i = #self.inner_childForBaseView, 1, -1 do
			local sub = self.inner_childForBaseView[i]

			sub:onCloseInternal()
			sub:onCloseFinishInternal()
			sub:removeEventsInternal()
			sub:onDestroyViewInternal()
			sub:__onDispose()
		end

		self.inner_childForBaseView = nil
	end

	for i = #self.inner_childViews, 1, -1 do
		local sub = self.inner_childViews[i]

		if not sub.IS_DISPOSED then
			sub:onCloseInternal()
			sub:onCloseFinishInternal()
			sub:removeEventsInternal()
			sub:onDestroyViewInternal()
			sub:disposeSelf()
		end
	end
end

function FightViewComponent:onDestructor()
	self:killAllSubView()
end

return FightViewComponent
