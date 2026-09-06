-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tabbg/controller/TabbgController.lua

module("logic.extensions.tabbg.controller.TabbgController", package.seeall)

local TabbgController = class("TabbgController", BaseListModel)

function TabbgController:ctor()
	TabbgController.super.ctor(self)
end

function TabbgController:onInit()
	TabbgController.super.onInit(self)
end

function TabbgController:onReset()
	TabbgController.super.onReset(self)

	self._viewConfig = nil
end

function TabbgController:onOpenTabView(viewConfig)
	if not viewConfig then
		return
	end

	self._viewConfig = viewConfig

	UIStateManager.instance:push(ViewName.TabbgView)
end

function TabbgController:getViewConfig()
	return self._viewConfig
end

function TabbgController:getTabView(tab_index)
	if tab_index then
		local view_name = self._viewConfig.tabInfo[tab_index].view
		local presentor = ViewMgr.instance:getViewPresentor(view_name)
		local view = self:_getViewByViewName(presentor, view_name)

		return view, presentor
	else
		local presentor = ViewMgr.instance:getViewPresentor(ViewName.TabbgView)
		local view = self:_getViewByViewName(presentor, ViewName.TabbgView)

		return view, presentor
	end
end

function TabbgController:_getViewByViewName(presentor, viewName)
	if not presentor or not presentor._views or not viewName then
		return
	end

	for i = 1, #presentor._views do
		if presentor._views[i]._viewPresentor.viewName == viewName then
			return presentor._views[i]
		end
	end
end

TabbgController.instance = TabbgController.New()

return TabbgController
