-- chunkname: @modules/common/others/MultiView.lua

module("modules.common.others.MultiView", package.seeall)

local MultiView = class("MultiView", BaseView)

function MultiView:ctor(views)
	self.viewGO = nil
	self.viewContainer = nil
	self.viewParam = nil
	self.viewName = nil
	self.tabContainer = nil
	self.rootGO = nil
	self._views = views
end

function MultiView:onInitView()
	if self._views then
		for k, view in pairs(self._views) do
			view:__onInit()

			view.viewGO = self.viewGO
			view.viewContainer = self.viewContainer
			view.viewParam = self.viewParam
			view.viewName = self.viewName
			view.tabContainer = self.tabContainer
			view.rootGO = self.rootGO

			view:onInitView()
		end
	end
end

function MultiView:addEvents()
	if self._views then
		for k, view in pairs(self._views) do
			view:addEvents()
		end
	end
end

function MultiView:onOpen()
	if self._views then
		for k, view in pairs(self._views) do
			view:onOpen()
		end
	end
end

function MultiView:onTabSwitchOpen()
	if self._views then
		for k, view in pairs(self._views) do
			if view.onTabSwitchOpen then
				view:onTabSwitchOpen()
			end
		end
	end
end

function MultiView:onOpenFinish()
	if self._views then
		for k, view in pairs(self._views) do
			view:onOpenFinish()
		end
	end
end

function MultiView:onUpdateParam()
	if self._views then
		for k, view in pairs(self._views) do
			view:onUpdateParam()
		end
	end
end

function MultiView:onClickModalMask()
	if self._views then
		for k, view in pairs(self._views) do
			view:onClickModalMask()
		end
	end
end

function MultiView:onClose()
	if self._views then
		for k, view in pairs(self._views) do
			view:onClose()
		end
	end
end

function MultiView:onTabSwitchClose(isClosing)
	if self._views then
		for k, view in pairs(self._views) do
			if view.onTabSwitchClose then
				view:onTabSwitchClose(isClosing)
			end
		end
	end
end

function MultiView:onCloseFinish()
	if self._views then
		for k, view in pairs(self._views) do
			view:onCloseFinish()
		end
	end
end

function MultiView:removeEvents()
	if self._views then
		for k, view in pairs(self._views) do
			view:removeEvents()
		end
	end
end

function MultiView:onDestroyView()
	if self._views then
		for k, view in pairs(self._views) do
			view:onDestroyView()
			view:__onDispose()
		end
	end
end

function MultiView:callChildrenFunc(funcName, param)
	if self._views then
		local func

		for _, view in pairs(self._views) do
			if view[funcName] then
				view[funcName](view, param)
			end
		end
	end
end

return MultiView
